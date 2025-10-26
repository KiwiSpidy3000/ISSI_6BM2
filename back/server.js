import 'dotenv/config';
import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { Pool } from 'pg';
import { z } from 'zod';

const {
  PORT = 3000,
  DATABASE_URL,
  DB_SCHEMA = 'escom_aliz',
  USER_TABLE = 'usuario',
  JWT_SECRET,
  ACCESS_TTL = '15m',
  ALLOWED_ORIGIN,
  CAPTCHA_DISABLED = 'true',
  RECAPTCHA_SECRET
} = process.env;

if (!DATABASE_URL) throw new Error('Falta DATABASE_URL en .env');
if (!JWT_SECRET)   throw new Error('Falta JWT_SECRET en .env');

const app = express();
const pool = new Pool({ connectionString: DATABASE_URL });
const { AI_URL = 'http://localhost:8000' } = process.env;

app.use(helmet());
app.use(express.json());
app.use(cors({
  origin: ALLOWED_ORIGIN ? [ALLOWED_ORIGIN] : true,
  credentials: true
}));
app.use(rateLimit({ windowMs: 60_000, max: 30 }));

const loginBodySchema = z.object({
  login: z.string().min(3).max(120),
  password: z.string().min(6).max(100),
  captchaToken: z.string().optional()
});

async function verifyCaptcha(token) {
  if (CAPTCHA_DISABLED === 'true') return true;
  if (!RECAPTCHA_SECRET) return false;

  try {
    const res = await fetch('https://www.google.com/recaptcha/api/siteverify', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        secret: RECAPTCHA_SECRET,
        response: token || ''
      }).toString()
    });
    const data = await res.json();
    return !!data.success;
  } catch {
    return false;
  }
}

async function detectUserColumns() {
  const sql = `
    SELECT column_name
    FROM information_schema.columns
    WHERE table_schema = $1 AND table_name = $2;
  `;
  const { rows } = await pool.query(sql, [DB_SCHEMA, USER_TABLE]);
  const cols = rows.map(r => r.column_name);

  const pick = (cands) => cands.find(c => cols.includes(c));

  const idCol      = pick(['id_usuario', 'usuario_id', 'id']) || null;
  const loginCols  = ['email','correo','boleta','username','usuario'].filter(c => cols.includes(c));
  const passCol    = pick(['password_hash','pass_hash','pwd_hash','contrasena_hash']);
  const roleCol    = pick(['rol','role']);
  const activeCol  = pick(['activo','is_active','estado']);

  if (!idCol || !loginCols.length || !passCol) {
    throw new Error(
      `No pude mapear columnas críticas en ${DB_SCHEMA}.${USER_TABLE}.
       Necesito: id, (email/boleta/username), password_hash.`
    );
  }
  return { idCol, loginCols, passCol, roleCol, activeCol };
}

// --- Helpers ---
function requireAuth(req, res, next){
  const h = req.headers.authorization || ''
  const t = h.startsWith('Bearer ') ? h.slice(7) : null
  if(!t) return res.status(401).json({error:'No autorizado'})
  try{ req.user = jwt.verify(t, JWT_SECRET); next() }
  catch{ return res.status(401).json({error:'Token inválido'}) }
}

const userColsPromise = detectUserColumns();

async function findUserByLogin(login) {
  const { idCol, loginCols, passCol, roleCol, activeCol } = await userColsPromise;

  for (const lc of loginCols) {
    const q = `
      SELECT "${idCol}"    AS id,
             "${passCol}"  AS pwd,
             ${roleCol ? `"${roleCol}" AS rol,` : `NULL::text AS rol,`}
             ${activeCol ? `"${activeCol}" AS activo` : `NULL::text AS activo`}
      FROM "${DB_SCHEMA}"."${USER_TABLE}"
      WHERE "${lc}" = $1
      LIMIT 1;
    `;
    const { rows } = await pool.query(q, [login]);
    if (rows.length) {
      const u = rows[0];
      let isActive = true;
      if (u.activo === null || u.activo === undefined) {
        isActive = true;
      } else if (typeof u.activo === 'boolean') {
        isActive = u.activo;
      } else if (typeof u.activo === 'string') {
        isActive = ['1','true','t','activo','ACTIVO','HABILITADO'].includes(u.activo);
      } else if (typeof u.activo === 'number') {
        isActive = u.activo === 1;
      }
      return { id: u.id, pwd: u.pwd, rol: u.rol || 'ALUMNO', activo: isActive };
    }
  }
  return null;
}

function signAccessToken(payload) {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: ACCESS_TTL });
}

function authMiddleware(req, res, next) {
  const h = req.headers.authorization || '';
  const token = h.startsWith('Bearer ') ? h.slice(7) : null;
  if (!token) return res.status(401).json({ error: 'No autorizado' });
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload;
    next();
  } catch {
    return res.status(401).json({ error: 'Token inválido o expirado' });
  }
}

// modelo de ia para comunicacion con front 
app.post('/ai/chat', async (req, res) => {
  try {
    const r = await fetch(`${AI_URL}/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message: req.body.message || '' })
    });
    const data = await r.json();
    res.json(data);
  } catch (e) {
    console.error('AI proxy error:', e.message);
    res.status(502).json({ error: 'AI service unavailable' });
  }
});

app.get('/health', (req, res) => res.json({ ok: true }));

app.post('/auth/login', async (req, res) => {
  try {
    const { login, password, captchaToken } = loginBodySchema.parse(req.body);

    const captchaOK = await verifyCaptcha(captchaToken);
    if (!captchaOK) return res.status(400).json({ error: 'Captcha inválido' });

    const user = await findUserByLogin(login);
    if (!user) return res.status(401).json({ error: 'Credenciales inválidas' });

    if (!user.activo) return res.status(403).json({ error: 'Usuario inactivo' });

    const ok = await bcrypt.compare(password, user.pwd || '');
    if (!ok) return res.status(401).json({ error: 'Credenciales inválidas' });

    const access_token = signAccessToken({ sub: String(user.id), rol: user.rol });
    return res.json({ access_token, token_type: 'Bearer', expires_in: ACCESS_TTL });
  } catch (err) {
    if (err?.issues) {
      return res.status(400).json({ error: 'Payload inválido', details: err.issues });
    }
    console.error(err);
    return res.status(500).json({ error: 'Error interno' });
  }
});

app.get('/auth/me', authMiddleware, async (req, res) => {
  return res.json({ user: req.user });
});

app.listen(PORT, () => {
  console.log(`Auth API escuchando en http://localhost:${PORT}`);
});


// --- Datos personales ---
app.get('/alumno/profile', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const q = `
    SELECT a.id_alumno,
           a.boleta,
           (u.nombre || ' ' || u.apellido) AS nombre_completo,
           u.email,
           c.nombre AS carrera,
           c.clave  AS carrera_clave,
           a.semestre
    FROM ${DB_SCHEMA}.alumno a
    JOIN ${DB_SCHEMA}.usuario u ON u.id_usuario = a.id_alumno
    JOIN ${DB_SCHEMA}.carrera c ON c.id_carrera = a.id_carrera
    WHERE a.id_alumno = $1
    LIMIT 1;
  `;
  try {
    const { rows } = await pool.query(q, [userId]);
    if (!rows.length) return res.status(404).json({ error: 'Alumno no encontrado' });
    res.json(rows[0]);
  } catch (e) {
    console.error('DB profile:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});

// --- Kardex ---
app.get('/alumno/kardex', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const q = `
    SELECT k.periodo,
           k.materia_clave,
           k.materia_nombre,
           m.creditos,
           k.calificacion_final AS calificacion,
           k.estatus
    FROM ${DB_SCHEMA}.vw_kardex k
    JOIN ${DB_SCHEMA}.materia m ON m.clave = k.materia_clave
    WHERE k.id_alumno = $1
    ORDER BY k.periodo, k.materia_clave;
  `;
  try {
    const { rows } = await pool.query(q, [userId]);
    res.json(rows);
  } catch (e) {
    console.error('DB kardex:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});


// --- Horario (periodo opcional ?periodo=2025-1) ---
app.get('/alumno/horario', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { periodo = null } = req.query;

  const q = `
    SELECT h.dia_semana, h.hora_ini, h.hora_fin, h.aula,
           m.clave AS materia_clave,
           m.nombre AS materia_nombre,
           (upu.nombre || ' ' || upu.apellido) AS profesor
    FROM ${DB_SCHEMA}.alumno a
    JOIN ${DB_SCHEMA}.inscripcion i ON i.id_alumno = a.id_alumno
    JOIN ${DB_SCHEMA}.grupo g       ON g.id_grupo  = i.id_grupo
    JOIN ${DB_SCHEMA}.horario h     ON h.id_grupo  = g.id_grupo
    JOIN ${DB_SCHEMA}.materia m     ON m.id_materia= g.id_materia
    LEFT JOIN ${DB_SCHEMA}.profesor p  ON p.id_profesor = g.id_profesor
    LEFT JOIN ${DB_SCHEMA}.usuario  upu ON upu.id_usuario = p.id_profesor
    WHERE a.id_alumno = $1
      AND ($2::text IS NULL OR g.periodo = $2)
    ORDER BY h.dia_semana, h.hora_ini;
  `;
  try {
    const { rows } = await pool.query(q, [userId, periodo]);
    res.json(rows);
  } catch (e) {
    console.error('DB horario:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});
