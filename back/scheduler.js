import { pool } from './db/pool.js';

const DB_SCHEMA = process.env.DB_SCHEMA || 'escom_aliz';

export function initScheduler() {
    console.log('Scheduler initialized');
    // Run immediately on startup
    checkInscriptions();

    // Run every minute
    setInterval(checkInscriptions, 60 * 1000);
}

async function checkInscriptions() {
    try {
        // Get config
        const resConfig = await pool.query(`SELECT clave, valor FROM ${DB_SCHEMA}.configuracion WHERE clave IN ('INICIO_INSCRIPCION', 'FIN_INSCRIPCION')`);
        const config = {};
        resConfig.rows.forEach(row => { config[row.clave] = row.valor; });

        const inicioStr = config['INICIO_INSCRIPCION'];
        const finStr = config['FIN_INSCRIPCION'];

        if (!inicioStr || !finStr) return; // Not configured

        const now = new Date();
        const inicio = new Date(inicioStr);
        const fin = new Date(finStr);

        // Determine desired state
        let desiredState = 'CERRADO';
        if (now >= inicio && now < fin) {
            desiredState = 'ABIERTO';
        }

        // Update groups if they are not in the desired state
        const resUpdate = await pool.query(
            `UPDATE ${DB_SCHEMA}.grupo SET estado = $1 WHERE estado != $1`,
            [desiredState]
        );

        if (resUpdate.rowCount > 0) {
            console.log(`Scheduler: Updated ${resUpdate.rowCount} groups to ${desiredState} based on schedule (${inicioStr} - ${finStr})`);
        }

    } catch (err) {
        console.error('Scheduler error:', err);
    }
}
