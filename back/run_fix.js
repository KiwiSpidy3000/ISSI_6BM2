import { pool } from './db/pool.js';
import fs from 'fs';
import path from 'path';

async function runFix() {
    try {
        const sqlPath = path.resolve('../bd backup/fix_data.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        console.log('Executing SQL...');
        await pool.query(sql);
        console.log('Data fix applied successfully.');
    } catch (e) {
        console.error('Error applying data fix:', e);
    } finally {
        pool.end();
    }
}

runFix();
