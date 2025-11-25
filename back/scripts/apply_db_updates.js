import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { Pool } from 'pg';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const { DATABASE_URL } = process.env;

if (!DATABASE_URL) {
    console.error('Error: DATABASE_URL not found in environment');
    process.exit(1);
}

const pool = new Pool({ connectionString: DATABASE_URL });

async function run() {
    try {
        const sqlPath = path.join(__dirname, '../../bd backup/saes_updates.sql');
        console.log(`Reading SQL from ${sqlPath}...`);
        const sql = fs.readFileSync(sqlPath, 'utf8');

        console.log('Applying updates...');
        await pool.query(sql);
        console.log('✅ Database updates applied successfully.');
    } catch (err) {
        console.error('❌ Error applying updates:', err);
    } finally {
        await pool.end();
    }
}

run();
