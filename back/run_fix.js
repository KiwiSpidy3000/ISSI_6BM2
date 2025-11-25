import { pool } from './db/pool.js';
import fs from 'fs';
import path from 'path';

import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function runFix() {
    try {
        const sqlPath = path.join(__dirname, '../bd backup/fix_schedule.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        console.log('Executing fix_schedule.sql...');
        await pool.query(sql);
        console.log('Schedule fix applied successfully.');

        const sqlPath2 = path.join(__dirname, 'db/fix_profesores_iia.sql');
        const sql2 = fs.readFileSync(sqlPath2, 'utf8');
        console.log('Executing fix_profesores_iia.sql...');
        await pool.query(sql2);
        console.log('Professor fix applied successfully.');
    } catch (e) {
        console.error('Error applying schedule fix:', e);
    } finally {
        pool.end();
    }
}

runFix();
