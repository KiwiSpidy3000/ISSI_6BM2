import pg from 'pg';
import 'dotenv/config';

const { Pool } = pg;

const {
    DATABASE_URL,
    DB_SCHEMA = 'escom_aliz'
} = process.env;

if (!DATABASE_URL) {
    throw new Error('DATABASE_URL environment variable is missing');
}

// Create a new pool instance with the connection string from env
const pool = new Pool({
    connectionString: DATABASE_URL,
});

// Optional: Log when a new client connects to the pool
pool.on('connect', () => {
    // console.log('New client connected to the pool');
});

pool.on('error', (err) => {
    console.error('Unexpected error on idle client', err);
    process.exit(-1);
});

export { pool, DB_SCHEMA };
