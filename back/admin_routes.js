
// back/routes/admin.routes.js
import { Router } from 'express';
import { pool, DB_SCHEMA } from './db/pool.js';
import bcrypt from 'bcrypt';
const router = Router();

// Helper para obtener pool
const q = (req) => pool;

// ---- USUARIOS ----
router.get('/usuarios', async (req, res) => {
  try {
    const r = await pool.query(`
      SELECT u.id_usuario AS id,
             u.nombre,
             u.apellido,
             u.nombre || ' ' || u.apellido AS nombre_completo,
             u.email,
             u.rol AS tipo,
             CASE WHEN u.activo THEN 'Activo' ELSE 'Inactivo' END AS estado,
             a.semestre,
             c.id_carrera,
             c.clave AS carrera,
             -- Grupo logic might be complex if they have multiple, taking one for now or leaving null
             (SELECT g.periodo || ' ' || mm.clave 
              FROM ${DB_SCHEMA}.inscripcion i 
              JOIN ${DB_SCHEMA}.grupo g ON g.id_grupo = i.id_grupo
              JOIN ${DB_SCHEMA}.materia mm ON mm.id_materia = g.id_materia
              WHERE i.id_alumno = u.id_usuario LIMIT 1) as grupo
      FROM ${DB_SCHEMA}.usuario u
      LEFT JOIN ${DB_SCHEMA}.alumno a ON a.id_alumno = u.id_usuario
      LEFT JOIN ${DB_SCHEMA}.carrera c ON c.id_carrera = a.id_carrera
      ORDER BY u.id_usuario DESC
    `);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/usuarios', async (req, res) => {
  const {
    email, password, nombre, apellido, rol,
    // Alumno specifics
    boleta, carrera_id, semestre,
    // Profesor specifics
    num_empleado, departamento
  } = req.body;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 1. Insert Usuario
    // Hash password if needed (assuming plain text for now or simple hash, normally bcrypt)
    // For this exercise I'll assume usage of existing bcrypt import if available or plain text if not critical
    // Server.js has bcrypt, let's use a placeholder hash or plain if we can't import bcrypt here easily.
    // I'll stick to string for now to avoid import issues, or just import bcrypt.

    const hash = await bcrypt.hash(password || 'default123', 10);
    const uRes = await client.query(
      `INSERT INTO ${DB_SCHEMA}.usuario (email, pass_hash, nombre, apellido, rol, activo)
       VALUES ($1, $2, $3, $4, $5, true)
       RETURNING id_usuario`,
      [email, hash, nombre, apellido, rol]
    );
    const userId = uRes.rows[0].id_usuario;

    // 2. Insert Subtype
    if (rol === 'ALUMNO') {
      await client.query(
        `INSERT INTO ${DB_SCHEMA}.alumno (id_alumno, boleta, id_carrera, semestre)
         VALUES ($1, $2, $3, $4)`,
        [userId, boleta || 'SIN_BOLETA', carrera_id || 1, semestre || 1]
      );
    } else if (rol === 'PROFESOR') {
      await client.query(
        `INSERT INTO ${DB_SCHEMA}.profesor (id_profesor, num_empleado, departamento)
         VALUES ($1, $2, $3)`,
        [userId, num_empleado || 'SIN_NUM', departamento || 'General']
      );
    }

    await client.query('COMMIT');
    res.status(201).json({ id: userId, message: 'Usuario creado' });
  } catch (e) {
    await client.query('ROLLBACK');
    await client.query('ROLLBACK');
    console.error(e);
    res.status(400).json({ error: friendlyError(e) });
  } finally {
    client.release();
  }
});

router.patch('/usuarios/:id', async (req, res) => {
  const { id } = req.params;
  const { email, nombre, apellido, rol, activo, boleta, semestre, num_empleado, departamento } = req.body;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Update Usuario
    await client.query(
      `UPDATE ${DB_SCHEMA}.usuario
       SET email = COALESCE($1, email),
           nombre = COALESCE($2, nombre),
           apellido = COALESCE($3, apellido),
           rol = COALESCE($4, rol),
           activo = COALESCE($5, activo)
       WHERE id_usuario = $6`,
      [email, nombre, apellido, rol, activo, id]
    );

    // Update Subtables if exists
    if (rol === 'ALUMNO' || (!rol)) {
      // Try update alumno if exists
      await client.query(
        `UPDATE ${DB_SCHEMA}.alumno SET boleta=COALESCE($1, boleta), semestre=COALESCE($2, semestre) 
          WHERE id_alumno=$3`,
        [boleta, semestre, id]
      );
    }
    if (rol === 'PROFESOR' || (!rol)) {
      await client.query(
        `UPDATE ${DB_SCHEMA}.profesor SET num_empleado=COALESCE($1, num_empleado), departamento=COALESCE($2, departamento)
          WHERE id_profesor=$3`,
        [num_empleado, departamento, id]
      );
    }

    await client.query('COMMIT');
    res.json({ ok: true });
  } catch (e) {
    await client.query('ROLLBACK');
    await client.query('ROLLBACK');
    res.status(400).json({ error: friendlyError(e) });
  } finally {
    client.release();
  }
});

router.delete('/usuarios/:id', async (req, res) => {
  const { id } = req.params;
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    // Pre-delete cleanup (Safeguard if no CASCADE)
    await client.query(`DELETE FROM ${DB_SCHEMA}.inscripcion WHERE id_alumno = $1`, [id]);
    await client.query(`DELETE FROM ${DB_SCHEMA}.evaluacion_docente WHERE id_alumno = $1 OR id_profesor = $1`, [id]);
    await client.query(`DELETE FROM ${DB_SCHEMA}.calificacion WHERE id_alumno = $1`, [id]);
    // Subtypes
    await client.query(`DELETE FROM ${DB_SCHEMA}.alumno WHERE id_alumno = $1`, [id]);
    await client.query(`DELETE FROM ${DB_SCHEMA}.profesor WHERE id_profesor = $1`, [id]);

    const r = await client.query(`DELETE FROM ${DB_SCHEMA}.usuario WHERE id_usuario = $1`, [id]);
    if (!r.rowCount) {
      await client.query('ROLLBACK');
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }
    await client.query('COMMIT');
    res.status(204).send();
  } catch (e) {
    await client.query('ROLLBACK');
    res.status(400).json({ error: e.message });
  } finally {
    client.release();
  }
});

// Helper for friendly DB errors
const friendlyError = (e) => {
  if (e.code === '23505') { // unique_violation
    if (e.detail.includes('email')) return 'El correo ya está registrado';
    if (e.detail.includes('boleta')) return 'La boleta ya está registrada';
    if (e.detail.includes('num_empleado')) return 'El número de empleado ya está registrado';
  }
  return e.message;
};

// ---- CARRERAS ----
router.get('/carreras', async (req, res) => {
  try {
    const r = await pool.query(`SELECT id_carrera AS id, nombre FROM ${DB_SCHEMA}.carrera ORDER BY nombre`);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/carreras', async (req, res) => {
  const { clave, nombre } = req.body;
  try {
    const r = await q(req).query(
      `INSERT INTO ${DB_SCHEMA}.carrera (clave, nombre) VALUES ($1, $2) RETURNING *`,
      [clave, nombre]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.patch('/carreras/:id', async (req, res) => {
  const { id } = req.params;
  const { clave, nombre } = req.body;
  try {
    const r = await q(req).query(
      `UPDATE ${DB_SCHEMA}.carrera SET clave = COALESCE($1, clave), nombre = COALESCE($2, nombre)
       WHERE id_carrera = $3 RETURNING *`,
      [clave, nombre, id]
    );
    if (!r.rowCount) return res.status(404).json({ error: 'Carrera no encontrada' });
    res.json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.delete('/carreras/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const r = await q(req).query(`DELETE FROM ${DB_SCHEMA}.carrera WHERE id_carrera = $1`, [id]);
    if (!r.rowCount) return res.status(404).json({ error: 'Carrera no encontrada' });
    res.status(204).send();
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- MATERIAS ----
router.get('/materias', async (req, res) => {
  try {
    const r = await pool.query(`SELECT * FROM ${DB_SCHEMA}.materia ORDER BY nombre`);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/materias', async (req, res) => {
  const { carrera_id, clave, nombre, creditos } = req.body;
  try {
    const r = await q(req).query(
      `INSERT INTO ${DB_SCHEMA}.materia (carrera_id, clave, nombre, creditos)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [carrera_id, clave, nombre, creditos]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- GRUPOS ----
router.get('/grupos', async (req, res) => {
  try {
    const r = await pool.query(`
      SELECT g.id_grupo AS id,
             g.id_materia,
             g.id_profesor,
             g.periodo || ' - ' || m.nombre AS materia,
             m.nombre as materia_nombre,
             g.periodo as grupo, -- mapping to 'grupo' field in front for display
             (u.nombre || ' ' || u.apellido) AS profesor,
             c.clave AS carrera,
             m.semestre,
             -- Horario formatting
             (SELECT string_agg(
                 CASE dia_semana 
                   WHEN 1 THEN 'Lun' WHEN 2 THEN 'Mar' WHEN 3 THEN 'Mié' 
                   WHEN 4 THEN 'Jue' WHEN 5 THEN 'Vie' WHEN 6 THEN 'Sáb' 
                 END || ' ' || to_char(hora_ini, 'HH24:MI') || '-' || to_char(hora_fin, 'HH24:MI'), 
                 ', ') 
              FROM ${DB_SCHEMA}.horario h WHERE h.id_grupo = g.id_grupo
             ) as horario,
             g.cupo_max AS cupo,
             (SELECT count(*) FROM ${DB_SCHEMA}.inscripcion i WHERE i.id_grupo = g.id_grupo AND i.estado IN ('INSCRITO','PREINSCRITO')) as inscritos,
             g.estado
      FROM ${DB_SCHEMA}.grupo g
      JOIN ${DB_SCHEMA}.materia m ON m.id_materia = g.id_materia
      JOIN ${DB_SCHEMA}.carrera c ON c.id_carrera = m.id_carrera
      LEFT JOIN ${DB_SCHEMA}.profesor p ON p.id_profesor = g.id_profesor
      LEFT JOIN ${DB_SCHEMA}.usuario u ON u.id_usuario = p.id_profesor
      ORDER BY g.id_grupo DESC
    `);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/grupos', async (req, res) => {
  const { id_materia, id_profesor, periodo, cupo_max, turno } = req.body;
  try {
    const r = await pool.query(
      `INSERT INTO ${DB_SCHEMA}.grupo (id_materia, id_profesor, periodo, cupo_max, turno)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [id_materia, id_profesor, periodo, cupo_max, turno || 'M']
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.patch('/grupos/:id', async (req, res) => {
  const { id } = req.params;
  const { id_materia, id_profesor, periodo, cupo_max, turno, estado } = req.body;
  try {
    const r = await pool.query(
      `UPDATE ${DB_SCHEMA}.grupo
       SET id_materia = COALESCE($1, id_materia),
           id_profesor = COALESCE($2, id_profesor),
           periodo = COALESCE($3, periodo),
           cupo_max = COALESCE($4, cupo_max),
           turno = COALESCE($5, turno),
           estado = COALESCE($6, estado)
       WHERE id_grupo = $7
       RETURNING *`,
      [id_materia, id_profesor, periodo, cupo_max, turno, estado, id]
    );
    if (!r.rowCount) return res.status(404).json({ error: 'Grupo no encontrado' });
    res.json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.delete('/grupos/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const r = await pool.query(`DELETE FROM ${DB_SCHEMA}.grupo WHERE id_grupo = $1`, [id]);
    if (!r.rowCount) return res.status(404).json({ error: 'Grupo no encontrado' });
    res.status(204).send();
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- PROFESORES (Helper) ----
router.get('/profesores', async (req, res) => {
  try {
    const r = await pool.query(`
      SELECT p.id_profesor, u.nombre || ' ' || u.apellido as nombre, p.departamento
      FROM ${DB_SCHEMA}.profesor p
      JOIN ${DB_SCHEMA}.usuario u ON u.id_usuario = p.id_profesor
      ORDER BY u.nombre
    `);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/grupos/:grupoId/profesores', async (req, res) => {
  const { grupoId } = req.params;
  const { profesor_usuario_id } = req.body;
  try {
    const v = await q(req).query(`SELECT 1 FROM ${DB_SCHEMA}.usuario WHERE id_usuario = $1 AND rol = 'PROFESOR'`, [profesor_usuario_id]);
    if (!v.rowCount) return res.status(400).json({ error: 'El usuario no es profesor' });

    const r = await q(req).query(
      `INSERT INTO ${DB_SCHEMA}.grupo_profesor (grupo_id, profesor_usuario_id)
       VALUES ($1, $2) ON CONFLICT (grupo_id, profesor_usuario_id) DO NOTHING
       RETURNING *`,
      [grupoId, profesor_usuario_id]
    );
    res.status(201).json(r.rows[0] || { ok: true, message: 'Asignación ya existía' });
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.post('/grupos/:grupoId/horarios', async (req, res) => {
  const { grupoId } = req.params;
  const { dia, hora_inicio, hora_fin, aula } = req.body;
  try {

    const overlap = await q(req).query(
      `SELECT 1 FROM ${DB_SCHEMA}.horario
       WHERE id_grupo = $1 AND dia_semana = $2
         AND NOT ($4 <= hora_ini OR $3 >= hora_fin)`,
      [grupoId, dia, hora_inicio, hora_fin]
    );
    if (overlap.rowCount) return res.status(400).json({ error: 'Traslape de horario' });

    const r = await q(req).query(
      `INSERT INTO ${DB_SCHEMA}.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [grupoId, dia, hora_inicio, hora_fin, aula]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

export default router;
