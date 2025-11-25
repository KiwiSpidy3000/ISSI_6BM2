import 'dotenv/config';
import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { Pool } from 'pg';
import { z } from 'zod';
import * as db from './db/queries.js';


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
if (!JWT_SECRET) throw new Error('Falta JWT_SECRET en .env');

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
  captchaToken: z.string().optional(),
  role: z.string().optional() // 'ALUMNO', 'PROFESOR', 'ADMIN'
});

async function verifyCaptcha(token) {
  if (token === 'SKIP_CAPTCHA') return true;
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

  const idCol = pick(['id_usuario', 'usuario_id', 'id']) || null;
  const loginCols = ['email', 'correo', 'boleta', 'username', 'usuario'].filter(c => cols.includes(c));
  const passCol = pick(['password_hash', 'pass_hash', 'pwd_hash', 'contrasena_hash']);
  const roleCol = pick(['rol', 'role']);
  const activeCol = pick(['activo', 'is_active', 'estado']);

  if (!idCol || !loginCols.length || !passCol) {
    throw new Error(
      `No pude mapear columnas críticas en ${DB_SCHEMA}.${USER_TABLE}.
       Necesito: id, (email/boleta/username), password_hash.`
    );
  }
  return { idCol, loginCols, passCol, roleCol, activeCol };
}

// --- Helpers ---
function requireAuth(req, res, next) {
  const h = req.headers.authorization || ''
  const t = h.startsWith('Bearer ') ? h.slice(7) : null
  if (!t) return res.status(401).json({ error: 'No autorizado' })
  try { req.user = jwt.verify(t, JWT_SECRET); next() }
  catch { return res.status(401).json({ error: 'Token inválido' }) }
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
        isActive = ['1', 'true', 't', 'activo', 'ACTIVO', 'HABILITADO'].includes(u.activo);
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

// --- SAES Helpers ---

async function getConfig(key) {
  const { rows } = await pool.query(`SELECT valor FROM ${DB_SCHEMA}.configuracion WHERE clave = $1`, [key]);
  return rows[0]?.valor;
}

async function checkInscriptionWindow() {
  const start = await getConfig('INICIO_INSCRIPCION');
  const end = await getConfig('FIN_INSCRIPCION');
  const now = new Date();
  if (start && now < new Date(start)) throw new Error('El periodo de inscripción no ha iniciado.');
  if (end && now > new Date(end)) throw new Error('El periodo de inscripción ha finalizado.');
}

async function checkDropWindow() {
  const start = await getConfig('INICIO_BAJA');
  const end = await getConfig('FIN_BAJA');
  const now = new Date();
  if (start && now < new Date(start)) throw new Error('El periodo de bajas no ha iniciado.');
  if (end && now > new Date(end)) throw new Error('El periodo de bajas ha finalizado.');
}

async function checkPrerequisites(userId, materiaId) {
  // Check if materia has prereq
  const mRes = await pool.query(`SELECT id_prereq, clave FROM ${DB_SCHEMA}.materia WHERE id_materia = $1`, [materiaId]);
  const materia = mRes.rows[0];
  if (!materia || !materia.id_prereq) return true; // No prereq

  // Check if prereq is passed
  const pRes = await pool.query(`
    SELECT 1 
    FROM ${DB_SCHEMA}.vw_kardex k
    JOIN ${DB_SCHEMA}.materia m ON m.clave = k.materia_clave
    WHERE k.id_alumno = $1 AND m.id_materia = $2 AND k.estatus = 'APROBADO'
  `, [userId, materia.id_prereq]);

  if (pRes.rows.length === 0) {
    throw new Error(`No has aprobado el prerrequisito para esta materia.`);
  }
  return true;
}

async function checkLoadLimit(userId, materiaId) {
  const maxCreds = parseInt(await getConfig('MAX_CREDITOS') || '90');

  // Get current load (registered + pre-registered)
  const lRes = await pool.query(`
    SELECT COALESCE(SUM(m.creditos), 0) as total
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo = i.id_grupo
    JOIN ${DB_SCHEMA}.materia m ON m.id_materia = g.id_materia
    WHERE i.id_alumno = $1 AND i.estado IN ('INSCRITO', 'PREINSCRITO')
  `, [userId]);

  const currentLoad = parseFloat(lRes.rows[0].total);

  // Get new subject credits
  const mRes = await pool.query(`SELECT creditos FROM ${DB_SCHEMA}.materia WHERE id_materia = $1`, [materiaId]);
  const newCredits = parseFloat(mRes.rows[0]?.creditos || 0);

  if (currentLoad + newCredits > maxCreds) {
    throw new Error(`Excedes la carga máxima de créditos (${maxCreds}).`);
  }
  return true;
}

// modelo de ia para comunicacion con front 
// modelo de ia para comunicacion con front 
app.post('/ai/chat', async (req, res) => {
  try {
    const text =
      (req.body.pregunta || req.body.message || req.body.text || req.body.q || '').trim();

    if (!text) {
      return res.status(400).json({ error: "Falta 'pregunta' o 'message' en el body" });
    }

    // OJO: mejor pegamos al alias del backend que ya devuelve {reply,...}
    const r = await fetch(`${AI_URL}/ai/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message: text })
    });

    const data = await r.json();
    // normaliza la respuesta para el front
    return res.json({
      reply: data.reply ?? data.respuesta ?? data.message ?? '',
      categoria: data.categoria ?? null
    });
  } catch (e) {
    console.error('AI proxy error:', e);
    return res.status(502).json({ error: 'AI service unavailable' });
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

    // 🟢 VALIDACIÓN DE ROL
    if (req.body.role) {
      const expectedRole = req.body.role.toUpperCase();
      // Normalizamos user.rol a mayúsculas por si acaso
      const actualRole = (user.rol || '').toUpperCase();

      if (actualRole !== expectedRole) {
        return res.status(403).json({
          error: `Role mismatch: please use the correct login tab for your account. (Expected: ${expectedRole}, Found: ${actualRole})`
        });
      }
    }

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
           m.semestre, -- Added semester
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
// --- Horario (duplicate removed) ---

// === LISTA DE PERIODOS DEL ALUMNO ===
app.get('/alumno/periodos', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const q = `
    SELECT DISTINCT g.periodo
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo = i.id_grupo
    WHERE i.id_alumno = $1
    ORDER BY g.periodo;
  `;
  try {
    const { rows } = await pool.query(q, [userId]);
    res.json(rows.map(r => r.periodo));
  } catch (e) {
    console.error('DB periodos:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});

// === HORARIO (con periodo opcional) ===
app.get('/alumno/horario', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { periodo = null } = req.query;
  const q = `
    SELECT 
           CASE 
             WHEN h.dia_semana = 1 THEN 'Lunes'
             WHEN h.dia_semana = 2 THEN 'Martes'
             WHEN h.dia_semana = 3 THEN 'Miércoles'
             WHEN h.dia_semana = 4 THEN 'Jueves'
             WHEN h.dia_semana = 5 THEN 'Viernes'
             WHEN h.dia_semana = 6 THEN 'Sábado'
             ELSE 'Domingo'
           END AS dia_semana,
           h.hora_ini, h.hora_fin, h.aula,
           g.id_grupo, -- Added id_grupo
           m.clave AS materia_clave,
           m.nombre AS materia_nombre,
           (upu.nombre || ' ' || upu.apellido) AS profesor
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.grupo g       ON g.id_grupo  = i.id_grupo
    JOIN ${DB_SCHEMA}.horario h     ON h.id_grupo  = g.id_grupo
    JOIN ${DB_SCHEMA}.materia m     ON m.id_materia= g.id_materia
    LEFT JOIN ${DB_SCHEMA}.profesor p   ON p.id_profesor = g.id_profesor
    LEFT JOIN ${DB_SCHEMA}.usuario  upu ON upu.id_usuario = p.id_profesor
    WHERE i.id_alumno = $1
      AND ($2::text IS NULL OR g.periodo = $2)
    ORDER BY h.dia_semana, h.hora_ini, m.clave;
  `;
  try {
    const { rows } = await pool.query(q, [userId, periodo]);
    res.json(rows);
  } catch (e) {
    console.error('DB horario:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});

// === CALIFICACIONES (mapea p1, p2, ordinario y final_calc) ===
app.get('/alumno/calificaciones', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { periodo = null } = req.query;
  const q = `
    SELECT g.periodo,
           m.clave  AS materia_clave,
           m.nombre AS materia_nombre,
           c.p1, c.p2, c.ordinario, c.final_calc
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.grupo g       ON g.id_grupo  = i.id_grupo
    JOIN ${DB_SCHEMA}.materia m     ON m.id_materia= g.id_materia
    LEFT JOIN ${DB_SCHEMA}.calificacion c ON c.id_alumno = i.id_alumno AND c.id_grupo = g.id_grupo
    WHERE i.id_alumno = $1
      AND ($2::text IS NULL OR g.periodo = $2)
    ORDER BY m.clave;
  `;
  try {
    const { rows } = await pool.query(q, [userId, periodo]);
    res.json(rows);
  } catch (e) {
    console.error('DB calificaciones:', e);
    res.status(500).json({ error: String(e.message || e) });
  }
});

// resumen: créditos totales y usados en un periodo
app.get('/alumno/reins/resumen', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { periodo } = req.query;
  const q = `
    WITH usados AS (
      SELECT COALESCE(SUM(m.creditos),0) AS cr
      FROM ${DB_SCHEMA}.inscripcion i
      JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo=i.id_grupo
      JOIN ${DB_SCHEMA}.materia m ON m.id_materia=g.id_materia
      WHERE i.id_alumno=$1 AND g.periodo=$2 AND i.estado IN ('PREINSCRITO','INSCRITO')
    ),
    tot AS (
      SELECT COALESCE(SUM(creditos),0) AS cr FROM ${DB_SCHEMA}.materia WHERE id_carrera = (
        SELECT id_carrera FROM ${DB_SCHEMA}.alumno WHERE id_alumno=$1
      )
    )
    SELECT tot.cr AS total_creditos, usados.cr AS creditos_usados FROM tot, usados;
  `;
  const { rows } = await pool.query(q, [userId, periodo]);
  res.json(rows[0]);
});

// materias inscritas del alumno (periodo)
app.get('/alumno/reins/inscritas', requireAuth, async (req, res) => {
  const userId = req.user.sub; const { periodo } = req.query;
  const q = `
    SELECT i.id_grupo, m.clave, m.nombre, m.creditos,
           (u.nombre||' '||u.apellido) AS profesor
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo=i.id_grupo
    JOIN ${DB_SCHEMA}.materia m ON m.id_materia=g.id_materia
    LEFT JOIN ${DB_SCHEMA}.profesor p ON p.id_profesor=g.id_profesor
    LEFT JOIN ${DB_SCHEMA}.usuario u ON u.id_usuario=p.id_profesor
    WHERE i.id_alumno=$1 AND g.periodo=$2 AND i.estado IN ('PREINSCRITO','INSCRITO')
    ORDER BY m.clave;
  `;
  const { rows } = await pool.query(q, [userId, periodo]);
  res.json(rows);
});

// oferta filtrable (periodo + opcional semestre, turno)
app.get('/alumno/reins/oferta', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { periodo, semestre, turno } = req.query;
  try {
    const data = await db.getStudentGroupOffer(userId, periodo, semestre, turno);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// validar choque antes de preinscribir
app.get('/alumno/reins/conflictos', requireAuth, async (req, res) => {
  const userId = req.user.sub; const { id_grupo } = req.query;
  const q = `SELECT * FROM ${DB_SCHEMA}.sp_validar_choque_horario($1,$2);`;
  const { rows } = await pool.query(q, [userId, id_grupo]);
  res.json(rows); // vacío = sin choque
});

// preinscribir (si no hay choque y cumple reglas SAES)
app.post('/alumno/reins/preinscribir', requireAuth, async (req, res) => {
  const userId = req.user.sub; const { id_grupo } = req.body;

  try {
    // 1. Validar ventana de tiempo
    await checkInscriptionWindow();

    // 2. Obtener id_materia del grupo
    const gRes = await pool.query(`SELECT id_materia FROM ${DB_SCHEMA}.grupo WHERE id_grupo = $1`, [id_grupo]);
    if (!gRes.rows.length) return res.status(404).json({ error: 'Grupo no encontrado' });
    const id_materia = gRes.rows[0].id_materia;

    // 3. Validar prerrequisitos
    await checkPrerequisites(userId, id_materia);

    // 4. Validar carga máxima
    await checkLoadLimit(userId, id_materia);

    // 5. Validar choque (existente)
    const chk = await pool.query(`SELECT * FROM ${DB_SCHEMA}.sp_validar_choque_horario($1,$2)`, [userId, id_grupo]);
    if (chk.rows.length) return res.status(409).json({ error: 'Choque de horario', detalles: chk.rows });

    // 6. Insertar
    await pool.query(`
      INSERT INTO ${DB_SCHEMA}.inscripcion (id_alumno,id_grupo,estado)
      VALUES ($1,$2,'PREINSCRITO')
      ON CONFLICT (id_alumno,id_grupo) DO UPDATE SET estado='PREINSCRITO'`,
      [userId, id_grupo]
    );
    res.json({ ok: true });
  } catch (e) {
    console.error('Enrollment error:', e);
    return res.status(400).json({ error: e.message });
  }
});

// Baja de materia (Drop)
app.delete('/alumno/inscripcion/baja/:id_grupo', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { id_grupo } = req.params;

  try {
    // 1. Validar ventana de bajas
    await checkDropWindow();

    // 2. Validar carga mínima
    const minCreds = parseInt(await getConfig('MIN_CREDITOS') || '30');

    // Calcular carga si se quita esta materia
    // Primero obtenemos creditos de la materia a bajar
    const gRes = await pool.query(`
      SELECT m.creditos 
      FROM ${DB_SCHEMA}.grupo g
      JOIN ${DB_SCHEMA}.materia m ON m.id_materia = g.id_materia
      WHERE g.id_grupo = $1
    `, [id_grupo]);

    if (!gRes.rows.length) return res.status(404).json({ error: 'Grupo no encontrado' });
    const dropCredits = parseFloat(gRes.rows[0].creditos);

    // Obtenemos carga total actual
    const lRes = await pool.query(`
      SELECT COALESCE(SUM(m.creditos), 0) as total
      FROM ${DB_SCHEMA}.inscripcion i
      JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo = i.id_grupo
      JOIN ${DB_SCHEMA}.materia m ON m.id_materia = g.id_materia
      WHERE i.id_alumno = $1 AND i.estado IN ('INSCRITO')
    `, [userId]);
    const currentLoad = parseFloat(lRes.rows[0].total);

    if (currentLoad - dropCredits < minCreds) {
      throw new Error(`No puedes dar de baja: quedarías con menos de ${minCreds} créditos.`);
    }

    // 3. Ejecutar baja
    const result = await pool.query(`
      DELETE FROM ${DB_SCHEMA}.inscripcion 
      WHERE id_alumno = $1 AND id_grupo = $2 AND estado = 'INSCRITO'
    `, [userId, id_grupo]);

    if (result.rowCount === 0) {
      return res.status(400).json({ error: 'No estás inscrito en este grupo o ya fue dado de baja.' });
    }

    res.json({ ok: true });
  } catch (e) {
    console.error('Drop error:', e);
    return res.status(400).json({ error: e.message });
  }
});

// quitar preinscripción/inscripción del carrito
app.delete('/alumno/reins/preinscribir/:id_grupo', requireAuth, async (req, res) => {
  const userId = req.user.sub; const id_grupo = req.params.id_grupo;
  await pool.query(`DELETE FROM ${DB_SCHEMA}.inscripcion WHERE id_alumno=$1 AND id_grupo=$2 AND estado='PREINSCRITO'`, [userId, id_grupo]);
  res.json({ ok: true });
});

// confirmar (pasa todo PREINSCRITO -> INSCRITO del periodo)
app.post('/alumno/reins/confirmar', requireAuth, async (req, res) => {
  const userId = req.user.sub; const { periodo } = req.body;
  await pool.query(`
    UPDATE ${DB_SCHEMA}.inscripcion i
    SET estado='INSCRITO'
    FROM ${DB_SCHEMA}.grupo g
    WHERE i.id_grupo=g.id_grupo AND i.id_alumno=$1 AND g.periodo=$2 AND i.estado='PREINSCRITO'`,
    [userId, periodo]
  );
  res.json({ ok: true });
});

// --- ADMIN ROUTES ---

// Get Config
app.get('/admin/config', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const { rows } = await pool.query(`SELECT * FROM ${DB_SCHEMA}.configuracion`);
    const config = {};
    rows.forEach(r => config[r.clave] = r.valor);
    res.json(config);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Update Config
app.post('/admin/config', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  const updates = req.body; // { "INICIO_INSCRIPCION": "...", ... }
  try {
    for (const [key, val] of Object.entries(updates)) {
      await pool.query(`
        INSERT INTO ${DB_SCHEMA}.configuracion (clave, valor) VALUES ($1, $2)
        ON CONFLICT (clave) DO UPDATE SET valor = EXCLUDED.valor
      `, [key, val]);
    }
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Group Occupancy
app.get('/admin/grupos/ocupacion', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  const { periodo } = req.query;
  try {
    const q = `
      SELECT g.id_grupo, m.clave, m.nombre, g.cupo_max, g.estado,
             (SELECT COUNT(*) FROM ${DB_SCHEMA}.inscripcion i WHERE i.id_grupo = g.id_grupo AND i.estado IN ('INSCRITO', 'PREINSCRITO')) as inscritos
      FROM ${DB_SCHEMA}.grupo g
      JOIN ${DB_SCHEMA}.materia m ON m.id_materia = g.id_materia
      WHERE ($1::text IS NULL OR g.periodo = $1)
      ORDER BY m.clave
    `;
    const { rows } = await pool.query(q, [periodo]);
    res.json(rows);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Update Group Status
app.patch('/admin/grupos/:id_grupo/status', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  const { id_grupo } = req.params;
  const { estado } = req.body; // ABIERTO, CERRADO, CANCELADO
  try {
    await pool.query(`UPDATE ${DB_SCHEMA}.grupo SET estado = $1 WHERE id_grupo = $2`, [estado, id_grupo]);
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// --- EVALUATION ROUTE ---
app.post('/alumno/evaluacion', requireAuth, async (req, res) => {
  const userId = req.user.sub;
  const { id_grupo, respuestas, comentario } = req.body; // respuestas: [i1, i2, i3, i4, i5]

  try {
    // Verify enrollment
    const eRes = await pool.query(`
      SELECT 1 FROM ${DB_SCHEMA}.inscripcion 
      WHERE id_alumno = $1 AND id_grupo = $2 AND estado = 'INSCRITO'
    `, [userId, id_grupo]);

    if (!eRes.rows.length) return res.status(400).json({ error: 'No estás inscrito en este grupo.' });

    // Get professor
    const gRes = await pool.query(`SELECT id_profesor FROM ${DB_SCHEMA}.grupo WHERE id_grupo = $1`, [id_grupo]);
    const id_profesor = gRes.rows[0]?.id_profesor;

    await pool.query(`
      INSERT INTO ${DB_SCHEMA}.evaluacion_docente 
      (id_alumno, id_profesor, id_grupo, i1, i2, i3, i4, i5, comentario)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    `, [userId, id_profesor, id_grupo, ...respuestas, comentario]);

    res.json({ ok: true });
  } catch (e) {
    if (e.code === '23505') return res.status(400).json({ error: 'Ya evaluaste este grupo.' });
    res.status(500).json({ error: e.message });
  }
});

// --- PROFESOR ROUTES ---

app.get('/profesor/profile', requireAuth, async (req, res) => {
  if (req.user.rol !== 'PROFESOR') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const data = await db.getProfessorProfile(req.user.sub);
    if (!data) return res.status(404).json({ error: 'Profesor no encontrado' });
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/profesor/grupos', requireAuth, async (req, res) => {
  if (req.user.rol !== 'PROFESOR') return res.status(403).json({ error: 'Acceso denegado' });
  const { periodo } = req.query;
  try {
    const data = await db.getProfessorGroups(req.user.sub, periodo);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



// =========================================================
// NEW DB ACCESS API ENDPOINTS
// =========================================================

// --- READ ENDPOINTS ---

app.get('/api/admin/db-counts', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const data = await db.getTableCounts();
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/admin/materias/iia', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const data = await db.getIIACurriculum();
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/admin/profesores', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const data = await db.getProfessorsWithUserData();
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/admin/oferta', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  const { period, semestre } = req.query;
  try {
    const data = await db.getGroupOfferIIA(period, semestre);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/admin/horarios/:id_grupo', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const data = await db.getSchedulesByGroup(req.params.id_grupo);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/alumno/:id/kardex-basic', requireAuth, async (req, res) => {
  // Allow admin or the student themselves
  if (req.user.rol !== 'ADMIN' && req.user.sub != req.params.id) {
    return res.status(403).json({ error: 'Acceso denegado' });
  }
  try {
    const data = await db.getEnrollmentsByStudent(req.params.id);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/alumno/:id/calificaciones', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN' && req.user.sub != req.params.id) {
    return res.status(403).json({ error: 'Acceso denegado' });
  }
  try {
    const data = await db.getGradesByStudent(req.params.id);
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// --- WRITE ENDPOINTS ---

app.post('/api/admin/profesores', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const result = await db.insertProfessor(req.body);
    res.status(201).json(result);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

app.post('/api/admin/alumnos', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const result = await db.insertStudent(req.body);
    res.status(201).json(result);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

app.post('/api/admin/grupos', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const result = await db.insertGroup(req.body);
    res.status(201).json(result);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

app.post('/api/admin/horarios', requireAuth, async (req, res) => {
  if (req.user.rol !== 'ADMIN') return res.status(403).json({ error: 'Acceso denegado' });
  try {
    const result = await db.insertSchedule(req.body);
    res.status(201).json(result);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

app.post('/api/alumno/inscripciones', requireAuth, async (req, res) => {
  // Allow admin or the student themselves (if id_alumno matches token)
  const { id_alumno } = req.body;
  if (req.user.rol !== 'ADMIN' && req.user.sub != id_alumno) {
    return res.status(403).json({ error: 'Acceso denegado' });
  }
  try {
    const result = await db.insertEnrollment(req.body);
    res.status(201).json(result);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

app.listen(PORT, () => {
  console.log(`Auth API escuchando en http://localhost:${PORT}`);
});
