import { pool } from '../db/pool.js';
import crypto from 'crypto';

// Configuration
const IIA_CAREER_CLAVE = 'IIA';
const CURRENT_PERIOD = '2025-2'; // As per server.js default
const DB_SCHEMA = 'escom_aliz';

// Helper to get random number
const rand = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
const shuffle = (array) => array.sort(() => Math.random() - 0.5);

async function main() {
    console.log('🚀 Starting Current Semester Enrollment Population...');

    const client = await pool.connect();

    try {
        // 1. Get IIA Career ID
        const careerRes = await client.query(`SELECT id_carrera FROM ${DB_SCHEMA}.carrera WHERE clave = $1`, [IIA_CAREER_CLAVE]);
        if (careerRes.rows.length === 0) throw new Error('Carrera IIA not found');
        const id_carrera = careerRes.rows[0].id_carrera;

        // 2. Get all subjects for IIA sorted by semester
        const subjectsRes = await client.query(`
      SELECT id_materia, clave, nombre, semester, creditos
      FROM ${DB_SCHEMA}.materia 
      WHERE id_carrera = $1 
      ORDER BY semester ASC, clave ASC
    `, [id_carrera]);

        // Group subjects by semester RE-MAPPED to 'semestre' column if needed (English 'semester' vs Spanish 'semestre')
        // Checking schema: likely 'semestre' based on previous files.

        const subjectsBySem = {};
        subjectsRes.rows.forEach(s => {
            const sem = s.semester || s.semestre;
            if (!subjectsBySem[sem]) subjectsBySem[sem] = [];
            subjectsBySem[sem].push(s);
        });

        // 3. Get all OPEN groups for the current period
        const groupsRes = await client.query(`
      SELECT g.id_grupo, g.id_materia, g.cupo_max, m.semestre, g.turno, g.periodo
      FROM ${DB_SCHEMA}.grupo g
      JOIN ${DB_SCHEMA}.materia m ON g.id_materia = m.id_materia
      WHERE g.periodo = $1 AND g.estado = 'ABIERTO'
    `, [CURRENT_PERIOD]);

        const groups = groupsRes.rows;
        // Map: semester -> list of groups
        const groupsBySem = {};
        groups.forEach(g => {
            const sem = g.semestre;
            if (!groupsBySem[sem]) groupsBySem[sem] = [];
            groupsBySem[sem].push(g);
        });

        console.log(`Found ${groups.length} open groups for period ${CURRENT_PERIOD}`);

        // 4. Get all students
        const studentsRes = await client.query(`
      SELECT a.id_alumno, a.semestre, u.email 
      FROM ${DB_SCHEMA}.alumno a
      JOIN ${DB_SCHEMA}.usuario u ON a.id_alumno = u.id_usuario
      WHERE a.id_carrera = $1
    `, [id_carrera]);
        const students = studentsRes.rows;
        console.log(`Found ${students.length} students to enroll.`);

        await client.query('BEGIN');

        let enrollmentsCount = 0;

        // Track group capacity in memory to avoid constant DB hits
        const groupOccupancy = {};
        groups.forEach(g => groupOccupancy[g.id_grupo] = 0);

        // Also perform a quick DB check for existing occupancies if running on top of existing data
        const existingOccRes = await client.query(`
        SELECT id_grupo, count(*) as c FROM ${DB_SCHEMA}.inscripcion 
        WHERE id_grupo = ANY($1) AND estado IN ('INSCRITO', 'PREINSCRITO')
        GROUP BY id_grupo
    `, [groups.map(g => g.id_grupo)]);

        existingOccRes.rows.forEach(r => {
            groupOccupancy[r.id_grupo] = parseInt(r.c, 10);
        });

        for (const student of students) {
            const currentSem = student.semestre;

            // Strategy: Enroll in subjects of their current semester.
            // Limit: 6 subjects.
            // Also: Check overlap? (Complex, let's assume strict groups don't overlap much within same sem/turno).
            // Let's just pick one group per subject for their semester.

            const availableGroups = groupsBySem[currentSem] || [];
            if (availableGroups.length === 0) continue; // No groups opened for this semester yet

            // Group by Subject to ensure we don't pick 2 groups of same subject
            const groupsBySubject = {};
            availableGroups.forEach(g => {
                if (!groupsBySubject[g.id_materia]) groupsBySubject[g.id_materia] = [];
                groupsBySubject[g.id_materia].push(g);
            });

            const subjects = Object.keys(groupsBySubject);
            // Shuffle subjects to pick random 6 if there are more (rare)
            const subjectsToTake = shuffle(subjects).slice(0, 6);

            for (const subjId of subjectsToTake) {
                // Pick a group for this subject that has space
                const potentialGroups = groupsBySubject[subjId];

                // Try to stick to one shift (Turno) if possible? 
                // Let's just random for now or pick first with space.
                let selectedGroup = null;

                // Simple sort by occupancy to balance
                potentialGroups.sort((a, b) => groupOccupancy[a.id_grupo] - groupOccupancy[b.id_grupo]);

                for (const g of potentialGroups) {
                    if (groupOccupancy[g.id_grupo] < g.cupo_max) {
                        selectedGroup = g;
                        break;
                    }
                }

                if (selectedGroup) {
                    // Enroll
                    await client.query(`
                        INSERT INTO ${DB_SCHEMA}.inscripcion (id_alumno, id_grupo, estado, fecha)
                        VALUES ($1, $2, 'INSCRITO', NOW())
                        ON CONFLICT (id_alumno, id_grupo) DO NOTHING
                    `, [student.id_alumno, selectedGroup.id_grupo]);

                    groupOccupancy[selectedGroup.id_grupo]++;
                    enrollmentsCount++;
                }
            }
        }

        await client.query('COMMIT');
        console.log(`✅ Enrollment complete! Registered ${enrollmentsCount} new enrollments.`);

    } catch (e) {
        await client.query('ROLLBACK');
        console.error('❌ Error:', e);
    } finally {
        client.release();
        process.exit(0);
    }
}

main();
