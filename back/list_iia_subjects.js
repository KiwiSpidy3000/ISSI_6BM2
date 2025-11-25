import { pool } from './db/pool.js';

async function listSubjects() {
    const res = await pool.query(`
    SELECT m.id_materia, m.clave, m.nombre, m.semestre 
    FROM escom_aliz.materia m 
    JOIN escom_aliz.carrera c ON m.id_carrera = c.id_carrera 
    WHERE c.clave = 'IIA' 
    ORDER BY m.semestre, m.clave
  `);
    console.log(JSON.stringify(res.rows, null, 2));
    pool.end();
}

listSubjects();
