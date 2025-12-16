import pg from 'pg';
import 'dotenv/config';

const { Pool } = pg;

const {
    DATABASE_URL = 'postgresql://lyteuser:Mi6ftLAB8WcTnfwMzNksICgYGcRu97Rv@dpg-d4s1t124d50c73b6noag-a.virginia-postgres.render.com/lytebd1',
    DB_SCHEMA = 'escom_aliz'
} = process.env;

if (!DATABASE_URL) {
    console.warn('DATABASE_URL missing, using default');
}

// 🔹 AQUÍ ES DONDE FALTABA SSL
const pool = new Pool({
    connectionString: DATABASE_URL,
    ssl: { rejectUnauthorized: false }  // <- esto obliga HTTPS con Render
});

// Optional: Log when a new client connects to the pool
pool.on('connect', (client) => {
    // console.log('New client connected to the pool');
    client.query(`SET search_path TO ${DB_SCHEMA}, public`).catch(e => console.error('Error setting search_path', e));
});

pool.on('error', (err) => {
    console.error('Unexpected error on idle client', err);
    process.exit(-1);
});

export { pool, DB_SCHEMA };
