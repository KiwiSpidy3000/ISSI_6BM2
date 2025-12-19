import { pool } from '../db/pool.js'; // fixed import casing

async function main() {
    console.log('Cleaning historical data...');
    const client = await pool.connect();
    try {
        await client.query('BEGIN');

        // Delete calificaciones for past periods
        await client.query(`
            DELETE FROM escom_aliz.calificacion 
            WHERE id_grupo IN (
                SELECT id_grupo FROM escom_aliz.grupo WHERE periodo != '2025-2'
            )
        `);

        // Delete inscriptions for past periods
        await client.query(`
            DELETE FROM escom_aliz.inscripcion 
            WHERE id_grupo IN (
                SELECT id_grupo FROM escom_aliz.grupo WHERE periodo != '2025-2'
            )
        `);

        // Delete empty groups for past periods
        await client.query(`
            DELETE FROM escom_aliz.grupo 
            WHERE periodo != '2025-2'
        `);

        await client.query('COMMIT');
        console.log('History cleaned.');
    } catch (e) {
        await client.query('ROLLBACK');
        console.error(e);
    } finally {
        client.release();
        process.exit(0);
    }
}

main();
