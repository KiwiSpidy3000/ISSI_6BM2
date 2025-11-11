// back/scripts/create_admin.js
require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');

(async () => {
  const pool = new Pool({ connectionString: process.env.DATABASE_URL });
  const email = process.argv[2] || 'admin@escom.mx';
  const nombre = process.argv[3] || 'Admin';
  const apellido = process.argv[4] || 'ESCOM';
  const pass = process.argv[5] || 'admin123';

  const hash = await bcrypt.hash(pass, 12);
  const q = `
    INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, estado)
    VALUES ($1,$2,$3,$4,'ADMIN','Activo')
    ON CONFLICT (email) DO NOTHING
    RETURNING id, email, rol`;
  const { rows } = await pool.query(q, [email, hash, nombre, apellido]);
  console.log(rows[0] ? 'Admin creado:' : 'Admin ya existía:', rows[0] || email);
  await pool.end();
})().catch(e => { console.error(e); process.exit(1); });
