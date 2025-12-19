import { pool } from '../db/pool.js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function run() {
    try {
        const sql = fs.readFileSync(path.join(__dirname, 'create_view.sql'), 'utf8');
        await pool.query(sql);
        console.log('View created successfully');
    } catch (e) {
        console.error(e);
    } finally {
        // Force exit to close pool
        process.exit(0);
    }
}

run();
