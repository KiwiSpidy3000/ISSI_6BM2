import { pool } from '../db/pool.js';
import crypto from 'crypto';

// Configuration
const IIA_CAREER_CLAVE = 'IIA';
const PERIOD_HISTORY = ['2023-1', '2023-2', '2024-1', '2024-2']; // Past periods
const DB_SCHEMA = 'escom_aliz';

// Helper to get random number
const rand = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
const randFloat = (min, max) => parseFloat((Math.random() * (max - min) + min).toFixed(1));

async function main() {
    console.log('🚀 Starting Kardex Population...');

    const client = await pool.connect();

    try {
        // 1. Get IIA Career ID
        const careerRes = await client.query(`SELECT id_carrera FROM ${DB_SCHEMA}.carrera WHERE clave = $1`, [IIA_CAREER_CLAVE]);
        if (careerRes.rows.length === 0) throw new Error('Carrera IIA not found');
        const id_carrera = careerRes.rows[0].id_carrera;

        // 2. Get all subjects for IIA sorted by semester
        const subjectsRes = await client.query(`
      SELECT id_materia, clave, nombre, semestre, creditos
      FROM ${DB_SCHEMA}.materia 
      WHERE id_carrera = $1 
      ORDER BY semestre ASC, clave ASC
    `, [id_carrera]);

        // Group subjects by semester
        const subjectsBySem = {};
        subjectsRes.rows.forEach(s => {
            const sem = s.semestre;
            if (!subjectsBySem[sem]) subjectsBySem[sem] = [];
            subjectsBySem[sem].push(s);
        });

        // 3. Get all students
        const studentsRes = await client.query(`
      SELECT a.id_alumno, a.semestre, u.email 
      FROM ${DB_SCHEMA}.alumno a
      JOIN ${DB_SCHEMA}.usuario u ON a.id_alumno = u.id_usuario
      WHERE a.id_carrera = $1
    `, [id_carrera]);
        const students = studentsRes.rows;
        console.log(`Found ${students.length} students to process.`);

        // 4. Get a dummy professor ID for past groups (to avoid constraints)
        // We'll pick the first available professor or create a dummy one if needed.
        // For realism, let's just pick one.
        const profRes = await client.query(`SELECT id_profesor FROM ${DB_SCHEMA}.profesor LIMIT 1`);
        if (profRes.rows.length === 0) throw new Error('No professors found to assign to past groups');
        const dummyProfId = profRes.rows[0].id_profesor;

        await client.query('BEGIN');

        // Cache: key -> { id: number, count: number }
        const pastGroupsCache = {};

        // PRE-FETCH
        console.log('Pre-fetching existing groups...');
        const allGroups = await client.query(`
            SELECT g.id_grupo, g.id_materia, g.periodo, 
                   (SELECT count(*) FROM ${DB_SCHEMA}.inscripcion i WHERE i.id_grupo = g.id_grupo) as enrolled
            FROM ${DB_SCHEMA}.grupo g
            WHERE g.estado = 'CERRADO'
        `);
        for (const g of allGroups.rows) {
            const key = `${g.periodo}_${g.id_materia}`;
            const count = parseInt(g.enrolled || '0');
            if (count < 40) {
                pastGroupsCache[key] = { id: g.id_grupo, count: count };
            }
        }
        console.log(`Cached ${Object.keys(pastGroupsCache).length} existing groups with space.`);

        async function getOrCreatePastGroup(id_materia, periodo) {
            const key = `${periodo}_${id_materia}`;
            let current = pastGroupsCache[key];

            // If we have a cached group and it has space
            if (current && current.count < 40) {
                current.count++;
                return current.id;
            }

            // Create new Group
            // console.log(`Creating NEW group for ${id_materia} ${periodo}...`);
            const createG = await client.query(`
                INSERT INTO ${DB_SCHEMA}.grupo (id_materia, id_profesor, periodo, cupo_max, turno, estado, nombreG)
                VALUES ($1, $2, $3, 40, 'M', 'CERRADO', $4)
                RETURNING id_grupo
            `, [id_materia, dummyProfId, periodo, `HIST-${rand(100, 999)}`]);

            const newId = createG.rows[0].id_grupo;
            pastGroupsCache[key] = { id: newId, count: 1 };
            return newId;
        }


        // Batch Arrays
        let inscripcionesBatch = [];
        let calificacionesBatch = [];

        const FLUSH_SIZE = 1500;

        async function flushBatches() {
            if (inscripcionesBatch.length > 0) {
                console.log(`Flushing batch of ${inscripcionesBatch.length} records (Bulk Insert)...`);

                // --- INSERT INSCRIPCIONES ---
                let valStr = [];
                let params = [];
                let idx = 1;

                for (const d of inscripcionesBatch) {
                    valStr.push(`($${idx}, $${idx + 1}, 'INSCRITO', NOW())`);
                    params.push(d.id_alumno, d.id_grupo);
                    idx += 2;
                }

                // Execute in one GO
                await client.query(`
                    INSERT INTO ${DB_SCHEMA}.inscripcion (id_alumno, id_grupo, estado, fecha)
                    VALUES ${valStr.join(', ')}
                    ON CONFLICT DO NOTHING
                `, params);

                // --- INSERT CALIFICACIONES ---
                valStr = [];
                params = [];
                idx = 1;

                for (const d of calificacionesBatch) {
                    valStr.push(`($${idx}, $${idx + 1}, $${idx + 2}, $${idx + 3}, $${idx + 4})`);
                    params.push(d.id_alumno, d.id_grupo, d.p1, d.p2, d.ord);
                    idx += 5;
                }

                await client.query(`
                    INSERT INTO ${DB_SCHEMA}.calificacion (id_alumno, id_grupo, p1, p2, ordinario)
                    VALUES ${valStr.join(', ')}
                    ON CONFLICT (id_alumno, id_grupo) DO NOTHING
                `, params);

                // Partial Commit
                await client.query('COMMIT');
                await client.query('BEGIN');

                inscripcionesBatch = [];
                calificacionesBatch = [];
            }
        }

        let enrollmentsCount = 0;

        for (let i = 0; i < students.length; i++) {
            if (i % 10 === 0) console.log(`Processing student ${i}...`);
            const student = students[i];
            const currentSem = student.semestre;
            // We assign them to PERIOD_HISTORY based on the semester.
            // E.g. if current is 2025-2 (implied), then:
            // Sem N-1 was in 2025-1
            // Sem N-2 was in 2024-2 ...
            // We'll map semesters to periods roughly.

            // Simplified Logic: Just iterate s from 1 to currentSem-1
            for (let s = 1; s < currentSem; s++) {
                const subjects = subjectsBySem[s] || [];
                if (subjects.length === 0) continue;

                // Pick a period index. Higher semester = more recent period.
                // This is just for dummy data consistency.
                // Assuming current is index 0 (2025-1 approx, though server says 2025-2).
                // Let's just pick from our list cyclically or randomly but consistent for the sem.
                const periodIdx = (s - 1) % PERIOD_HISTORY.length;
                const period = PERIOD_HISTORY[periodIdx];

                // How many subjects did they pass?
                // "Regular" students pass everything. "Irregular" fail some.
                // 85% chance they passed everything in that semester.
                const isRegularSem = Math.random() < 0.85;

                for (const subj of subjects) {
                    let passed = true;
                    let finalGrade = randFloat(6.0, 10.0);

                    if (!isRegularSem) {
                        // 30% chance to fail/not take this specific subject if the semester was bad
                        if (Math.random() < 0.3) {
                            // Either they failed it (grade < 6) or didn't take it.
                            // Let's say they took it and failed.
                            finalGrade = randFloat(0.0, 5.9);
                            passed = false;
                        }
                    }

                    if (passed || (!passed && finalGrade > 0)) {
                        // Create enrollment
                        const id_grupo = await getOrCreatePastGroup(subj.id_materia, period);

                        // PUSH TO BATCH
                        inscripcionesBatch.push({
                            id_alumno: student.id_alumno,
                            id_grupo: id_grupo
                        });

                        // Calificacion
                        // Distribute grade into partials logically
                        const p1 = Math.min(10, Math.max(0, finalGrade + randFloat(-1, 1)));
                        const p2 = Math.min(10, Math.max(0, finalGrade + randFloat(-1, 1)));
                        const ord = finalGrade; // Simplify: ordinario *is* final for now or avg

                        calificacionesBatch.push({
                            id_alumno: student.id_alumno,
                            id_grupo: id_grupo,
                            p1: p1.toFixed(1),
                            p2: p2.toFixed(1),
                            ord: ord.toFixed(1)
                        });

                        enrollmentsCount++;
                    }
                }
            }
            if (i % 50 === 0) console.log(`Processed ${i} / ${students.length} students...`);

            // Flush every FLUSH_SIZE
            if (inscripcionesBatch.length >= FLUSH_SIZE) {
                await flushBatches();
            }
        }

        // Final flush
        await flushBatches();

        await client.query('COMMIT');
        console.log(`✅ Success! Processed ${students.length} students.`);
        console.log(`Created ${enrollmentsCount} historical records.`);

    } catch (e) {
        console.error('❌ Error JSON:', JSON.stringify(e, Object.getOwnPropertyNames(e), 2));
        await client.query('ROLLBACK');
    } finally {
        client.release();
        // pool.end(); // Don't close pool if used by other scripts/server
    }
}

main();
