
// back/routes/admin.routes.js
import { Router } from 'express';
const router = Router();

// Helper para obtener pool
const q = (req) => req.pool;

// ---- USUARIOS ----
router.post('/usuarios', async (req, res) => {
  const { email, boleta, username, tipo, password_hash } = req.body;
  try {
    const r = await q(req).query(
      `INSERT INTO usuario (email, boleta, username, tipo, password_hash)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING id, tipo, COALESCE(boleta, email, username) AS identificador, activo, creado_en`,
      [email || null, boleta || null, username || null, tipo, password_hash]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.patch('/usuarios/:id', async (req, res) => {
  const { id } = req.params;
  const { email, boleta, username, tipo, activo } = req.body;
  try {
    const r = await q(req).query(
      `UPDATE usuario
       SET email = COALESCE($1, email),
           boleta = COALESCE($2, boleta),
           username = COALESCE($3, username),
           tipo = COALESCE($4, tipo),
           activo = COALESCE($5, activo)
       WHERE id = $6
       RETURNING id, email, boleta, username, tipo, activo`,
      [email, boleta, username, tipo, activo, id]
    );
    if (!r.rowCount) return res.status(404).json({ error: 'Usuario no encontrado' });
    res.json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.delete('/usuarios/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const r = await q(req).query('DELETE FROM usuario WHERE id = $1', [id]);
    if (!r.rowCount) return res.status(404).json({ error: 'Usuario no encontrado' });
    res.status(204).send();
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- CARRERAS ----
router.post('/carreras', async (req, res) => {
  const { clave, nombre } = req.body;
  try {
    const r = await q(req).query(
      'INSERT INTO carrera (clave, nombre) VALUES ($1, $2) RETURNING *',
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
      `UPDATE carrera SET clave = COALESCE($1, clave), nombre = COALESCE($2, nombre)
       WHERE id = $3 RETURNING *`,
      [clave, nombre, id]
    );
    if (!r.rowCount) return res.status(404).json({ error: 'Carrera no encontrada' });
    res.json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.delete('/carreras/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const r = await q(req).query('DELETE FROM carrera WHERE id = $1', [id]);
    if (!r.rowCount) return res.status(404).json({ error: 'Carrera no encontrada' });
    res.status(204).send();
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- MATERIAS ----
router.post('/materias', async (req, res) => {
  const { carrera_id, clave, nombre, creditos } = req.body;
  try {
    const r = await q(req).query(
      `INSERT INTO materia (carrera_id, clave, nombre, creditos)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [carrera_id, clave, nombre, creditos]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// ---- GRUPOS ----
router.post('/grupos', async (req, res) => {
  const { materia_id, clave, cupo_maximo } = req.body;
  try {
    const r = await q(req).query(
      `INSERT INTO grupo (materia_id, clave, cupo_maximo)
       VALUES ($1, $2, $3) RETURNING *`,
      [materia_id, clave, cupo_maximo]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

router.post('/grupos/:grupoId/profesores', async (req, res) => {
  const { grupoId } = req.params;
  const { profesor_usuario_id } = req.body;
  try {
    const v = await q(req).query('SELECT 1 FROM usuario WHERE id = $1 AND tipo = \'PROFESOR\'', [profesor_usuario_id]);
    if (!v.rowCount) return res.status(400).json({ error: 'El usuario no es profesor' });

    const r = await q(req).query(
      `INSERT INTO grupo_profesor (grupo_id, profesor_usuario_id)
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
      `SELECT 1 FROM horario
       WHERE grupo_id = $1 AND dia = $2
         AND NOT ($4 <= hora_inicio OR $3 >= hora_fin)`,
      [grupoId, dia, hora_inicio, hora_fin]
    );
    if (overlap.rowCount) return res.status(400).json({ error: 'Traslape de horario' });

    const r = await q(req).query(
      `INSERT INTO horario (grupo_id, dia, hora_inicio, hora_fin, aula)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [grupoId, dia, hora_inicio, hora_fin, aula]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(400).json({ error: e.message }); }
});

export default router;
