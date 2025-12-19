
import { pool, DB_SCHEMA } from '../db/pool.js';

async function distributeEnrollment() {
    try {
        console.log('--- Resetting 2025-2 enrollment ---');
        await pool.query(`DELETE FROM ${DB_SCHEMA}.inscripcion WHERE id_grupo IN (SELECT id_grupo FROM ${DB_SCHEMA}.grupo WHERE periodo = '2025-2')`);

        console.log('--- Fetching all groups for 2025-2 ---');
        const groupsRes = await pool.query(`SELECT id_grupo, nombreG, turno FROM ${DB_SCHEMA}.grupo WHERE periodo = '2025-2'`);
        const allGroups = groupsRes.rows;

        // Map groups by name for fast lookup
        const groupsByName = {};
        allGroups.forEach(g => {
            if (!groupsByName[g.nombreg]) groupsByName[g.nombreg] = [];
            groupsByName[g.nombreg].push(g.id_grupo);
        });

        console.log('--- Fetching students ---');
        const studentsRes = await pool.query(`SELECT id_alumno, semestre FROM ${DB_SCHEMA}.alumno ORDER BY id_alumno`);
        const students = studentsRes.rows;

        console.log(`Processing ${students.length} students...`);

        const enrollmentData = [];

        for (let i = 0; i < students.length; i++) {
            const student = students[i];
            const category = i % 3;

            let groupTarget = '';
            if (category === 0) groupTarget = `${student.semestre}BM1`;
            else if (category === 1) groupTarget = `${student.semestre}BM2`;
            else groupTarget = `${student.semestre}BV1`;

            let ids = groupsByName[groupTarget];

            // Fallback if specific group doesn't exist
            if (!ids || ids.length === 0) {
                // Find first available group for this semester
                const fallbackName = Object.keys(groupsByName).find(name => name.startsWith(`${student.semestre}`));
                if (fallbackName) {
                    ids = groupsByName[fallbackName];
                }
            }

            if (ids && ids.length > 0) {
                ids.forEach(id => {
                    enrollmentData.push([id, student.id_alumno, 'INSCRITO']);
                });
            }
        }

        console.log(`Total enrollments to insert: ${enrollmentData.length}`);

        // Batch insert
        const BATCH_SIZE = 100; // Smaller batches for more stability and per-batch logging
        for (let i = 0; i < enrollmentData.length; i += BATCH_SIZE) {
            const batch = enrollmentData.slice(i, i + BATCH_SIZE);
            const values = batch.map((row, idx) => `($${idx * 3 + 1}, $${idx * 3 + 2}, $${idx * 3 + 3}, NOW())`).join(',');
            const flatValues = batch.flat();

            await pool.query(
                `INSERT INTO ${DB_SCHEMA}.inscripcion (id_grupo, id_alumno, estado, fecha) VALUES ${values}`,
                flatValues
            );
            if (i % 1000 === 0) console.log(`Inserted ${i} / ${enrollmentData.length}...`);
        }

        console.log('--- Distribution completed successfully! ---');

    } catch (error) {
        console.error('Error distributing enrollment:');
        console.error(JSON.stringify(error, null, 2));
    } finally {
        pool.end();
    }
}

distributeEnrollment();
