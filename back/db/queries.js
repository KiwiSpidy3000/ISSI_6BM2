import { pool, DB_SCHEMA } from './pool.js';
import bcrypt from 'bcrypt';

// =========================================================
// READ OPERATIONS
// =========================================================

export async function getTableCounts() {
  const tables = [
    'carrera', 'usuario', 'profesor', 'alumno', 'materia',
    'grupo', 'horario', 'inscripcion', 'calificacion',
    'evaluacion_docente', 'notificacion'
  ];

  // We use a series of UNION ALL queries to get counts for all tables efficiently
  // Note: Table names in the FROM clause cannot be parameterized directly in standard SQL 
  // without dynamic SQL, but since the list is hardcoded and safe, we can build the string.

  const queries = tables.map(t => `SELECT '${t}' as table_name, count(*) as total_rows FROM ${DB_SCHEMA}.${t}`);
  const finalQuery = queries.join(' UNION ALL ');

  const { rows } = await pool.query(finalQuery);
  return rows;
}

export async function getIIACurriculum() {
  const query = `
    SELECT m.id_materia, m.clave, m.nombre, m.semestre, m.creditos, m.horas_semana
    FROM ${DB_SCHEMA}.materia m
    JOIN ${DB_SCHEMA}.carrera c ON m.id_carrera = c.id_carrera
    WHERE c.clave = 'IIA'
    ORDER BY m.semestre, m.clave;
  `;
  const { rows } = await pool.query(query);
  return rows;
}

export async function getProfessorsWithUserData() {
  const query = `
    SELECT p.id_profesor, u.email, u.nombre, u.apellido, p.num_empleado, p.departamento
    FROM ${DB_SCHEMA}.profesor p
    JOIN ${DB_SCHEMA}.usuario u ON p.id_profesor = u.id_usuario;
  `;
  const { rows } = await pool.query(query);
  return rows;
}

export async function getGroupOfferIIA(periodo, semestre) {
  let query = `
    SELECT g.id_grupo, g.periodo, g.turno, m.semestre, m.clave as clave_materia, m.nombre as materia,
           CONCAT(u.nombre, ' ', u.apellido) as professor_full_name,
           g.cupo_max, g.estado
    FROM ${DB_SCHEMA}.grupo g
    JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
    JOIN ${DB_SCHEMA}.carrera c ON m.id_carrera = c.id_carrera
    JOIN ${DB_SCHEMA}.profesor p ON g.id_profesor = p.id_profesor
    JOIN ${DB_SCHEMA}.usuario u ON p.id_profesor = u.id_usuario
    WHERE c.clave = 'IIA'
  `;

  const params = [];
  let paramIdx = 1;

  if (periodo) {
    query += ` AND g.periodo = $${paramIdx++}`;
    params.push(periodo);
  }

  if (semestre) {
    query += ` AND m.semestre = $${paramIdx++}`;
    params.push(semestre);
  }

  query += ` ORDER BY g.periodo, m.semestre, m.clave`;

  const { rows } = await pool.query(query, params);
  return rows;
}

export async function getSchedulesByGroup(id_grupo) {
  const query = `
    SELECT h.id_horario, h.id_grupo, m.clave as clave_materia, m.nombre as materia,
           h.dia_semana, h.hora_ini, h.hora_fin, h.aula
    FROM ${DB_SCHEMA}.horario h
    JOIN ${DB_SCHEMA}.grupo g ON h.id_grupo = g.id_grupo
    JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
    WHERE h.id_grupo = $1
    ORDER BY h.dia_semana, h.hora_ini;
  `;
  const { rows } = await pool.query(query, [id_grupo]);
  return rows;
}

export async function getStudents() {
  const query = `
    SELECT a.id_alumno, a.boleta, u.nombre, u.apellido, c.clave as carrera_clave, a.semestre
    FROM ${DB_SCHEMA}.alumno a
    JOIN ${DB_SCHEMA}.usuario u ON a.id_alumno = u.id_usuario
    JOIN ${DB_SCHEMA}.carrera c ON a.id_carrera = c.id_carrera;
  `;
  const { rows } = await pool.query(query);
  return rows;
}

export async function getEnrollmentsByStudent(id_alumno) {
  const query = `
    SELECT a.boleta, CONCAT(u.nombre, ' ', u.apellido) as alumno_nombre_completo,
           i.id_grupo, m.clave as clave_materia, m.nombre as materia,
           g.periodo, i.estado as estado_inscripcion, i.fecha
    FROM ${DB_SCHEMA}.inscripcion i
    JOIN ${DB_SCHEMA}.alumno a ON i.id_alumno = a.id_alumno
    JOIN ${DB_SCHEMA}.usuario u ON a.id_alumno = u.id_usuario
    JOIN ${DB_SCHEMA}.grupo g ON i.id_grupo = g.id_grupo
    JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
    WHERE i.id_alumno = $1
    ORDER BY g.periodo, m.clave;
  `;
  const { rows } = await pool.query(query, [id_alumno]);
  return rows;
}

export async function getGradesByStudent(id_alumno) {
  const query = `
    SELECT a.boleta, u.nombre as alumno_nombre, m.clave as clave_materia, m.nombre as materia,
           g.periodo, c.p1, c.p2, c.ordinario
    FROM ${DB_SCHEMA}.calificacion c
    JOIN ${DB_SCHEMA}.alumno a ON c.id_alumno = a.id_alumno
    JOIN ${DB_SCHEMA}.usuario u ON a.id_alumno = u.id_usuario
    JOIN ${DB_SCHEMA}.grupo g ON c.id_grupo = g.id_grupo
    JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
    WHERE c.id_alumno = $1
    ORDER BY g.periodo, m.clave;
  `;
  const { rows } = await pool.query(query, [id_alumno]);
  return rows;
}

// =========================================================
// WRITE OPERATIONS (INSERTIONS)
// =========================================================

export async function insertProfessor({ email, password, nombre, apellido, num_empleado, departamento }) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 1. Insert into usuario
    const pass_hash = await bcrypt.hash(password, 10);
    const userQuery = `
      INSERT INTO ${DB_SCHEMA}.usuario (email, pass_hash, nombre, apellido, rol, activo)
      VALUES ($1, $2, $3, $4, 'PROFESOR', true)
      RETURNING id_usuario;
    `;
    const userRes = await client.query(userQuery, [email, pass_hash, nombre, apellido]);
    const id_usuario = userRes.rows[0].id_usuario;

    // 2. Insert into profesor
    const profQuery = `
      INSERT INTO ${DB_SCHEMA}.profesor (id_profesor, num_empleado, departamento, nombre, apellido)
      VALUES ($1, $2, $3, $4, $5);
    `;
    // Note: We duplicate nombre/apellido in profesor table as per schema definition (it has those columns)
    await client.query(profQuery, [id_usuario, num_empleado, departamento, nombre, apellido]);

    await client.query('COMMIT');
    return { id_profesor: id_usuario };
  } catch (e) {
    await client.query('ROLLBACK');
    throw e;
  } finally {
    client.release();
  }
}

export async function insertStudent({ email, password, nombre, apellido, boleta, id_carrera, semestre }) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 1. Insert into usuario
    const pass_hash = await bcrypt.hash(password, 10);
    const userQuery = `
      INSERT INTO ${DB_SCHEMA}.usuario (email, pass_hash, nombre, apellido, rol, activo)
      VALUES ($1, $2, $3, $4, 'ALUMNO', true)
      RETURNING id_usuario;
    `;
    const userRes = await client.query(userQuery, [email, pass_hash, nombre, apellido]);
    const id_usuario = userRes.rows[0].id_usuario;

    // 2. Insert into alumno
    const studentQuery = `
      INSERT INTO ${DB_SCHEMA}.alumno (id_alumno, boleta, id_carrera, semestre)
      VALUES ($1, $2, $3, $4);
    `;
    await client.query(studentQuery, [id_usuario, boleta, id_carrera, semestre]);

    await client.query('COMMIT');
    return { id_alumno: id_usuario };
  } catch (e) {
    await client.query('ROLLBACK');
    throw e;
  } finally {
    client.release();
  }
}

export async function insertGroup({ id_materia, id_profesor, periodo, cupo_max, estado, turno }) {
  const query = `
    INSERT INTO ${DB_SCHEMA}.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING id_grupo;
  `;
  const { rows } = await pool.query(query, [id_materia, id_profesor, periodo, cupo_max, estado || 'ABIERTO', turno || 'M']);
  return rows[0];
}

export async function insertSchedule({ id_grupo, dia_semana, hora_ini, hora_fin, aula }) {
  const query = `
    INSERT INTO ${DB_SCHEMA}.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id_horario;
  `;
  const { rows } = await pool.query(query, [id_grupo, dia_semana, hora_ini, hora_fin, aula]);
  return rows[0];
}

export async function insertEnrollment({ id_alumno, id_grupo }) {
  // This relies on DB triggers for capacity checks
  const query = `
    INSERT INTO ${DB_SCHEMA}.inscripcion (id_alumno, id_grupo, estado)
    VALUES ($1, $2, 'INSCRITO')
    RETURNING id_inscripcion;
           (u.nombre || ' ' || u.apellido) as nombre_completo,
           p.num_empleado, p.departamento, 'ESCOM' as plantel,
           'RFC' || p.num_empleado as rfc -- Mock RFC based on employee number
    FROM ${DB_SCHEMA}.usuario u
    JOIN ${DB_SCHEMA}.profesor p ON u.id_usuario = p.id_profesor
    WHERE u.id_usuario = $1
  `;
  const { rows } = await pool.query(query, [id_usuario]);
  return rows[0];
}

export async function getProfessorGroups(id_profesor, periodo) {
  const query = `
    SELECT g.id_grupo, m.nombre as materia_nombre, m.clave as materia_clave, 
           m.semestre, g.turno, g.periodo,
           (SELECT COUNT(*) FROM ${DB_SCHEMA}.inscripcion i WHERE i.id_grupo = g.id_grupo AND i.estado IN ('INSCRITO', 'PREINSCRITO')) as inscritos
    FROM ${DB_SCHEMA}.grupo g
    JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
    WHERE g.id_profesor = $1
      AND ($2::text IS NULL OR g.periodo = $2)
    ORDER BY g.periodo DESC, m.nombre;
  `;
  const { rows } = await pool.query(query, [id_profesor, periodo]);
  return rows;
}

