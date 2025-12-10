
import { pool } from './back/db/pool.js';
import fs from 'fs';
import path from 'path';

async function runPopulate() {
    try {
        const sqlPath = path.join(process.cwd(), 'back', 'db', 'populate_horarios.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        console.log('Executing SQL script...');
        await pool.query(sql);
        console.log('Population complete!');
    } catch (err) {
        console.error('Error executing script:', err);
    } finally {
        await pool.end();
    }
}

runPopulate();
