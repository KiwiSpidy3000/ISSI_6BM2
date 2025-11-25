import pg from 'pg';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.join(__dirname, '.env') });

const { Pool } = pg;
const { DATABASE_URL } = process.env;

const pool = new Pool({
    connectionString: DATABASE_URL,
});

async function debugUpdate() {
    try {
        console.log('Debugging Sandra Diaz update...');

        // 1. Check User
        const userRes = await pool.query("SELECT id_usuario, rol FROM escom_aliz.usuario WHERE email = 'sandra.diaz@ejemplo.mx'");
        console.log('User:', userRes.rows);

        // 2. Check Career
        const careerRes = await pool.query("SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'");
        console.log('Career:', careerRes.rows);
        const id_carrera = careerRes.rows[0]?.id_carrera;

        // 3. Check Subject (Fuzzy)
        const subjectRes = await pool.query("SELECT id_materia, nombre FROM escom_aliz.materia WHERE nombre ILIKE '%Algoritmos%' AND id_carrera = $1", [id_carrera]);
        console.log('Subjects found:', subjectRes.rows);

        // 5. Check Column Types
        const schemaRes = await pool.query(`
            SELECT table_name, column_name, data_type, udt_name
            FROM information_schema.columns 
            WHERE table_schema = 'escom_aliz' 
            AND table_name IN ('usuario', 'grupo', 'materia', 'carrera')
            AND column_name IN ('id_usuario', 'id_profesor', 'id_materia', 'id_carrera')
        `);
        console.log('Schema:', schemaRes.rows);

    } catch (e) {
        console.error('Error:', e);
    } finally {
        pool.end();
    }
}

debugUpdate();
