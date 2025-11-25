-- =========================================================
-- DB INSPECTION QUERIES
-- =========================================================
-- This file contains read-only queries to inspect the data in the 'escom_aliz' schema.
-- These queries are safe to run in pgAdmin or any SQL client.

-- a) Table counts
-- Count rows in key tables to get an overview of the data volume.
SELECT 'carrera' as table_name, count(*) as total_rows FROM escom_aliz.carrera
UNION ALL
SELECT 'usuario', count(*) FROM escom_aliz.usuario
UNION ALL
SELECT 'profesor', count(*) FROM escom_aliz.profesor
UNION ALL
SELECT 'alumno', count(*) FROM escom_aliz.alumno
UNION ALL
SELECT 'materia', count(*) FROM escom_aliz.materia
UNION ALL
SELECT 'grupo', count(*) FROM escom_aliz.grupo
UNION ALL
SELECT 'horario', count(*) FROM escom_aliz.horario
UNION ALL
SELECT 'inscripcion', count(*) FROM escom_aliz.inscripcion
UNION ALL
SELECT 'calificacion', count(*) FROM escom_aliz.calificacion
UNION ALL
SELECT 'evaluacion_docente', count(*) FROM escom_aliz.evaluacion_docente
UNION ALL
SELECT 'notificacion', count(*) FROM escom_aliz.notificacion;

-- b) IIA curriculum
-- List all subjects for the 'IIA' career (Ingeniería en Inteligencia Artificial).
SELECT m.id_materia, m.clave, m.nombre, m.semestre, m.creditos, m.horas_semana
FROM escom_aliz.materia m
JOIN escom_aliz.carrera c ON m.id_carrera = c.id_carrera
WHERE c.clave = 'IIA'
ORDER BY m.semestre, m.clave;

-- c) Professors (joined with usuario)
-- Show professor details including their user account information.
SELECT p.id_profesor, u.email, u.nombre, u.apellido, p.num_empleado, p.departamento
FROM escom_aliz.profesor p
JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario;

-- d) Group offer
-- Show available groups for 'IIA', including schedule info (period, shift) and professor.
SELECT g.id_grupo, g.periodo, g.turno, m.semestre, m.clave as clave_materia, m.nombre as materia,
       CONCAT(u.nombre, ' ', u.apellido) as professor_full_name,
       g.cupo_max, g.estado
FROM escom_aliz.grupo g
JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
JOIN escom_aliz.carrera c ON m.id_carrera = c.id_carrera
JOIN escom_aliz.profesor p ON g.id_profesor = p.id_profesor
JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
WHERE c.clave = 'IIA'
ORDER BY g.periodo, m.semestre, m.clave;

-- e) Schedules
-- Show weekly schedules for each group.
SELECT h.id_horario, h.id_grupo, m.clave as clave_materia, m.nombre as materia,
       h.dia_semana, h.hora_ini, h.hora_fin, h.aula
FROM escom_aliz.horario h
JOIN escom_aliz.grupo g ON h.id_grupo = g.id_grupo
JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
ORDER BY h.id_grupo, h.dia_semana, h.hora_ini;

-- f) Students
-- List students with their career and semester.
SELECT a.id_alumno, a.boleta, u.nombre, u.apellido, c.clave as carrera_clave, a.semestre
FROM escom_aliz.alumno a
JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
JOIN escom_aliz.carrera c ON a.id_carrera = c.id_carrera;

-- g) Enrollments (basic kardex view)
-- Show student enrollments and their status.
SELECT a.boleta, CONCAT(u.nombre, ' ', u.apellido) as alumno_nombre_completo,
       i.id_grupo, m.clave as clave_materia, m.nombre as materia,
       g.periodo, i.estado as estado_inscripcion, i.fecha
FROM escom_aliz.inscripcion i
JOIN escom_aliz.alumno a ON i.id_alumno = a.id_alumno
JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
JOIN escom_aliz.grupo g ON i.id_grupo = g.id_grupo
JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
ORDER BY a.boleta, g.periodo, m.clave;

-- h) Grades
-- Show grades for students.
SELECT a.boleta, u.nombre as alumno_nombre, m.clave as clave_materia, m.nombre as materia,
       g.periodo, c.p1, c.p2, c.ordinario
FROM escom_aliz.calificacion c
JOIN escom_aliz.alumno a ON c.id_alumno = a.id_alumno
JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
JOIN escom_aliz.grupo g ON c.id_grupo = g.id_grupo
JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
ORDER BY a.boleta, g.periodo, m.clave;
