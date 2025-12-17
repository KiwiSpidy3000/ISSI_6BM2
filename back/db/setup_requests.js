import { pool, DB_SCHEMA } from './pool.js';

async function createTable() {
    const client = await pool.connect();
    try {
        console.log('Creating table solicitud_pass...');
        await client.query(`
      CREATE TABLE IF NOT EXISTS ${DB_SCHEMA}.solicitud_pass (
        id SERIAL PRIMARY KEY,
        nombre TEXT NOT NULL,
        email TEXT NOT NULL,
        rol TEXT NOT NULL,
        new_password TEXT NOT NULL,
        fecha TIMESTAMP DEFAULT NOW()
      );
    `);
        console.log('Table created successfully.');
    } catch (err) {
        console.error('Error creating table:', err);
    } finally {
        client.release();
        pool.end();
    }
}

createTable();
