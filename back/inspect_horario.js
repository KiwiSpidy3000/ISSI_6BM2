import { pool } from './db/pool.js';

async function inspect() {
    try {
        const res = await pool.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_schema = 'escom_aliz' AND table_name = 'horario';
    `);
        console.log('Columns in horario:', res.rows);
    } catch (e) {
        console.error(e);
    } finally {
        pool.end();
    }
}

inspect();
