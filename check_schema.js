
import { pool } from './back/db/pool.js';

async function checkSchema() {
    try {
        const res = await pool.query("SELECT column_name FROM information_schema.columns WHERE table_schema = 'escom_aliz' AND table_name = 'grupo'");
        console.log('Columns in grupo:', res.rows.map(r => r.column_name));
    } catch (err) {
        console.error(err);
    } finally {
        await pool.end();
    }
}

checkSchema();
