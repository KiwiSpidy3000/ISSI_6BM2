import 'dotenv/config';
import { pool } from './pool.js';

const DB_SCHEMA = process.env.DB_SCHEMA || 'escom_aliz';

async function run() {
    try {
        console.log('Cerrando grupos HIST-... por favor espere...');
        const res = await pool.query(`
      UPDATE ${DB_SCHEMA}.grupo
      SET estado = 'CERRADO'
      WHERE nombreG LIKE 'HIST-%' AND estado <> 'CERRADO'
    `);
        console.log(`Hecho. ${res.rowCount} grupos actualizados a CERRADO.`);
    } catch (e) {
        console.error('Error:', e);
    } finally {
        await pool.end();
    }
}

run();
