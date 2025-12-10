
import { pool } from './back/db/pool.js';

async function listMaterias() {
    try {
        const res = await pool.query('SELECT * FROM escom_aliz.materia ORDER BY semestre, clave');
        console.log('Materias found:', res.rows.length);
        res.rows.forEach(m => {
            console.log(`${m.semestre} - ${m.clave}: ${m.nombre} (ID: ${m.id_materia})`);
        });
    } catch (err) {
        console.error('Error querying materias:', err);
    } finally {
        await pool.end();
    }
}

listMaterias();
