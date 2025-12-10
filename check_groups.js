
import { pool } from './back/db/pool.js';

async function listGroups() {
    try {
        const query = `
      SELECT g.id_grupo, m.nombre as materia, g.grupo, g.turno, 
             u.nombre || ' ' || u.apellido as profesor
      FROM escom_aliz.grupo g
      JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
      JOIN escom_aliz.profesor p ON g.id_profesor = p.id_profesor
      JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
      ORDER BY m.nombre, g.id_grupo
    `;
        const res = await pool.query(query);
        console.log('Groups created:', res.rows.length);
        res.rows.forEach(r => {
            console.log(`${r.materia} - Group ID: ${r.id_grupo} - Prof: ${r.profesor}`);
        });
    } catch (err) {
        console.error('Error listing groups:', err);
    } finally {
        await pool.end();
    }
}

listGroups();
