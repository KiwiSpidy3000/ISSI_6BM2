
import { pool } from './db/pool.js';

process.env.DATABASE_URL = 'postgresql://postgres:postgres@localhost:5432/postgres'; // Guessing default

async function inspect() {
  const query = `
    SELECT * FROM escom_aliz.profesor LIMIT 1;
    `;

  try {
    const res = await pool.query(query);
    console.log(JSON.stringify(res.rows, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await pool.end();
  }
}

inspect();
