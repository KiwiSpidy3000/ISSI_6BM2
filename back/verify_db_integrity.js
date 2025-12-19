import { pool, DB_SCHEMA } from './db/pool.js';
import fs from 'fs';

async function verifyIntegrity() {
    let report = `DB Verification Report - ${new Date().toISOString()}\nSchema: ${DB_SCHEMA}\n\n`;

    function log(msg) {
        report += msg + '\n';
        // console.log(msg); // Optional: still log to console if needed
    }

    log('Starting DB Verification...');
    const client = await pool.connect();

    try {
        // 1. Check Tables Existence
        log('--- 1. Checking Tables ---');
        const tables = ['usuario', 'alumno', 'profesor', 'carrera', 'materia', 'grupo', 'horario', 'inscripcion', 'calificacion'];
        for (const table of tables) {
            const res = await client.query(`
                SELECT EXISTS (
                    SELECT FROM information_schema.tables 
                    WHERE table_schema = $1 
                    AND table_name = $2
                );
            `, [DB_SCHEMA, table]);

            if (res.rows[0].exists) {
                const countRes = await client.query(`SELECT COUNT(*) FROM ${DB_SCHEMA}.${table}`);
                log(`[OK] Table '${table}' exists. Rows: ${countRes.rows[0].count}`);
            } else {
                log(`[ERROR] Table '${table}' DOES NOT EXIST!`);
            }
        }

        // 2. Check for Orphan Users
        log('\n--- 2. Checking User Consistency ---');
        const orphanAlumnos = await client.query(`
            SELECT u.id_usuario, u.email, u.nombre 
            FROM ${DB_SCHEMA}.usuario u
            LEFT JOIN ${DB_SCHEMA}.alumno a ON u.id_usuario = a.id_alumno
            WHERE u.rol = 'ALUMNO' AND a.id_alumno IS NULL
        `);
        if (orphanAlumnos.rowCount > 0) {
            log(`[WARN] Found ${orphanAlumnos.rowCount} orphan ALUMNO users:`);
            orphanAlumnos.rows.forEach(r => log(`   - ID: ${r.id_usuario}, Email: ${r.email}`));
        } else {
            log('[OK] No orphan ALUMNO users found.');
        }

        const orphanProfes = await client.query(`
            SELECT u.id_usuario, u.email, u.nombre 
            FROM ${DB_SCHEMA}.usuario u
            LEFT JOIN ${DB_SCHEMA}.profesor p ON u.id_usuario = p.id_profesor
            WHERE u.rol = 'PROFESOR' AND p.id_profesor IS NULL
        `);
        if (orphanProfes.rowCount > 0) {
            log(`[WARN] Found ${orphanProfes.rowCount} orphan PROFESOR users:`);
            orphanProfes.rows.forEach(r => log(`   - ID: ${r.id_usuario}, Email: ${r.email}`));
        } else {
            log('[OK] No orphan PROFESOR users found.');
        }

        // 3. Check for Schedule Clashes (Room Conflicts)
        log('\n--- 3. Checking Schedule Clashes (Same Room, Overlapping Time) ---');
        const roomClashes = await client.query(`
            SELECT 
                h1.id_horario as h1_id, h1.aula, h1.dia_semana, h1.hora_ini as h1_start, h1.hora_fin as h1_end,
                h2.id_horario as h2_id, h2.hora_ini as h2_start, h2.hora_fin as h2_end,
                g1.id_grupo as g1_id, g2.id_grupo as g2_id
            FROM ${DB_SCHEMA}.horario h1
            JOIN ${DB_SCHEMA}.horario h2 ON h1.aula = h2.aula 
                AND h1.dia_semana = h2.dia_semana 
                AND h1.id_horario < h2.id_horario
            JOIN ${DB_SCHEMA}.grupo g1 ON h1.id_grupo = g1.id_grupo
            JOIN ${DB_SCHEMA}.grupo g2 ON h2.id_grupo = g2.id_grupo
            WHERE 
                (h1.hora_ini < h2.hora_fin) AND (h1.hora_fin > h2.hora_ini)
                AND g1.periodo = g2.periodo
        `);

        if (roomClashes.rowCount > 0) {
            log(`[WARN] Found ${roomClashes.rowCount} room clashes:`);
            roomClashes.rows.forEach(r => {
                log(`   - Aula ${r.aula}, Day ${r.dia_semana}: Group ${r.g1_id} (${r.h1_start}-${r.h1_end}) vs Group ${r.g2_id} (${r.h2_start}-${r.h2_end})`);
            });
        } else {
            log('[OK] No room clashes found.');
        }

        // 4. Check for Professor Clashes
        log('\n--- 4. Checking Professor Schedule Clashes ---');
        const profClashes = await client.query(`
            SELECT 
                u.nombre, u.apellido,
                h1.dia_semana, h1.hora_ini as h1_start, h1.hora_fin as h1_end,
                h2.hora_ini as h2_start, h2.hora_fin as h2_end,
                g1.id_grupo as g1_id, g2.id_grupo as g2_id
            FROM ${DB_SCHEMA}.horario h1
            JOIN ${DB_SCHEMA}.grupo g1 ON h1.id_grupo = g1.id_grupo
            JOIN ${DB_SCHEMA}.grupo g2 ON g1.id_profesor = g2.id_profesor 
                AND g1.id_grupo < g2.id_grupo 
            JOIN ${DB_SCHEMA}.horario h2 ON g2.id_grupo = h2.id_grupo 
                AND h1.dia_semana = h2.dia_semana
            JOIN ${DB_SCHEMA}.profesor p ON g1.id_profesor = p.id_profesor
            JOIN ${DB_SCHEMA}.usuario u ON p.id_profesor = u.id_usuario
            WHERE 
                (h1.hora_ini < h2.hora_fin) AND (h1.hora_fin > h2.hora_ini)
                AND g1.periodo = g2.periodo
        `);

        if (profClashes.rowCount > 0) {
            log(`[WARN] Found ${profClashes.rowCount} professor schedule clashes:`);
            profClashes.rows.forEach(r => {
                log(`   - Prof ${r.nombre} ${r.apellido}, Day ${r.dia_semana}: Group ${r.g1_id} vs Group ${r.g2_id}`);
            });
        } else {
            log('[OK] No professor schedule clashes found.');
        }

        // 5. Check for Empty/Dirty Data
        log('\n--- 5. Checking for Empty/Dirty Data ---');
        const emptySubjects = await client.query(`SELECT * FROM ${DB_SCHEMA}.materia WHERE nombre IS NULL OR nombre = ''`);
        if (emptySubjects.rowCount > 0) log(`[WARN] Found ${emptySubjects.rowCount} subjects with empty names.`);

        const emptyUsers = await client.query(`SELECT * FROM ${DB_SCHEMA}.usuario WHERE (nombre IS NULL OR nombre = '') AND rol IN ('PROFESOR', 'ALUMNO')`);
        if (emptyUsers.rowCount > 0) log(`[WARN] Found ${emptyUsers.rowCount} users (Prof/Alumno) with empty names.`);

        // 6. Group Status Stats
        log('\n--- 6. Group Status Stats ---');
        const groupStats = await client.query(`SELECT estado, COUNT(*) FROM ${DB_SCHEMA}.grupo GROUP BY estado`);
        groupStats.rows.forEach(r => log(`   - ${r.estado}: ${r.count}`));

        // Check groups without schedule
        const groupsNoSchedule = await client.query(`
            SELECT COUNT(*) FROM ${DB_SCHEMA}.grupo g
            LEFT JOIN ${DB_SCHEMA}.horario h ON g.id_grupo = h.id_grupo
            WHERE h.id_horario IS NULL AND g.estado = 'ABIERTO'
        `);
        log(`   - Open Groups without schedule: ${groupsNoSchedule.rows[0].count}`);

        log('\n[DONE] Data cleanliness check complete.');

    } catch (err) {
        log('[ERROR] Verification Failed!');
        log('Error Name: ' + err.name);
        log('Error Message: ' + err.message);
        log('Error Stack: ' + err.stack);
    } finally {
        client.release();
        await pool.end();
        fs.writeFileSync('db_report.txt', report);
        console.log('Report written to db_report.txt');
    }
}

verifyIntegrity();
