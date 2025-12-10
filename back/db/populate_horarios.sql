BEGIN;

------------------------------------------------------------
-- 1. INSERT MISSING SUBJECTS (3rd Semester)
------------------------------------------------------------
-- Check if subjects exist, if not insert them.
-- We use a DO block or just INSERT ON CONFLICT DO NOTHING if we had unique constraints on name.
-- Assuming 'clave' is unique.

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA301', 'Analisis y Diseño de Algoritmos', 3, 8, 4, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA301');

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA302', 'Paradigmas de Programacion', 3, 8, 4, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA302');

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA306', 'Ecuaciones Diferenciales', 3, 8, 4, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA306');

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA307', 'Bases de Datos', 3, 8, 4, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA307');

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA308', 'Diseño de Sistemas Digitales', 3, 8, 4, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA308');

INSERT INTO escom_aliz.materia (clave, nombre, semestre, creditos, horas_semana, id_carrera)
SELECT 'IIA309', 'Liderazgo Personal', 3, 6, 3, (SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA')
WHERE NOT EXISTS (SELECT 1 FROM escom_aliz.materia WHERE clave = 'IIA309');

------------------------------------------------------------
-- 2. INSERT PROFESSORS (from fix_profesores_iia.sql)
------------------------------------------------------------
-- We use a CTE or just direct inserts with ON CONFLICT

INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('IDALIA', 'MALDONADO CASTILLO', 'idalia.maldonado@escom.ipn.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('EDUARDO', 'GUTIERREZ ALDANA', 'eduardo.gutierrez@escom.ipn.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('HORACIO', 'GARCIA SALAS', 'horacio.garcia@escom.ipn.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('SANDRA', 'DIAZ', 'sandra.diaz@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('MIGUEL', 'RODRIGUEZ', 'miguel.rodriguez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('JOSE', 'SANCHEZ', 'jose.sanchez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('ANDRES', 'CORTES', 'andres.cortes@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('JUAN', 'CARBALLO', 'juan.carballo@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('JORGE', 'PEREZ', 'jorge.perez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('ERIKA', 'HERNANDEZ', 'erika.hernandez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('ALEXIS', 'TESTA', 'alexis.testa@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('JOSE JUAN', 'PEREZ PEREZ', 'jose.perez.perez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('GISELA', 'GONZALEZ', 'gisela.gonzalez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;
INSERT INTO escom_aliz.usuario (nombre, apellido, email, pass_hash, rol, activo) VALUES 
('ELIA', 'RAMIREZ', 'elia.ramirez@ejemplo.mx', '$2b$10$Mg1ZIMWHV0C.xp9BRc2w2.S6GbRkR5EopSKq02e5KwofLQGKyWbIe', 'PROFESOR', true) ON CONFLICT (email) DO NOTHING;

-- Insert into Profesor table
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento)
SELECT id_usuario, 'EMP' || CAST(id_usuario AS TEXT), 'IIA'
FROM escom_aliz.usuario u
WHERE rol = 'PROFESOR'
AND NOT EXISTS (SELECT 1 FROM escom_aliz.profesor p WHERE p.id_profesor = u.id_usuario);

------------------------------------------------------------
-- 3. CREATE GROUPS AND SCHEDULES
------------------------------------------------------------
-- We will create 2 groups: 3BM1 and 3BM2 for each subject.
-- We assign professors randomly or specifically if we have mapping.
-- Mapping based on fix_profesores_iia.sql comments:
-- ADA: Sandra Diaz (3BM1), Miguel Rodriguez (3BM2)
-- Paradigmas: Jose Sanchez (3BM1), Andres Cortes (3BM2)
-- Ecuaciones: Juan Carballo (3BM1), Jorge Perez (3BM2)
-- BD: Erika Hernandez (3BM1), Idalia Maldonado (3BM2 - assigned arbitrarily)
-- DSD: Alexis Testa (3BM1), Jose Juan Perez (3BM2)
-- Liderazgo: Gisela Gonzalez (3BM1), Elia Ramirez (3BM2)

DO $$
DECLARE
    v_periodo VARCHAR := '2025-2';
    v_id_materia INT;
    v_id_prof INT;
    v_id_grupo INT;
BEGIN
    -- 1. Analisis y Diseño de Algoritmos (IIA301)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA301';
    
    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'sandra.diaz@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Mon/Wed 7:00-8:30, Fri 7:00-8:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 1, '07:00', '08:30', '1101');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 3, '07:00', '08:30', '1101');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '07:00', '08:00', '1101');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'miguel.rodriguez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Tue/Thu 7:00-8:30, Fri 8:00-9:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 2, '07:00', '08:30', '1102');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 4, '07:00', '08:30', '1102');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '08:00', '09:00', '1102');


    -- 2. Paradigmas de Programacion (IIA302)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA302';

    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'jose.sanchez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Mon/Wed 8:30-10:00, Fri 9:00-10:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 1, '08:30', '10:00', '1101');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 3, '08:30', '10:00', '1101');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '09:00', '10:00', '1101');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'andres.cortes@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Tue/Thu 8:30-10:00, Fri 10:00-11:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 2, '08:30', '10:00', '1102');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 4, '08:30', '10:00', '1102');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '10:00', '11:00', '1102');


    -- 3. Ecuaciones Diferenciales (IIA306)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA306';

    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'juan.carballo@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Mon/Wed 10:30-12:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 1, '10:30', '12:00', '1101');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 3, '10:30', '12:00', '1101');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'jorge.perez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Tue/Thu 10:30-12:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 2, '10:30', '12:00', '1102');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 4, '10:30', '12:00', '1102');


    -- 4. Bases de Datos (IIA307)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA307';

    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'erika.hernandez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Mon/Wed 12:00-13:30
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 1, '12:00', '13:30', 'LAB1');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 3, '12:00', '13:30', 'LAB1');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'idalia.maldonado@escom.ipn.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Tue/Thu 12:00-13:30
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 2, '12:00', '13:30', 'LAB2');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 4, '12:00', '13:30', 'LAB2');


    -- 5. Diseño de Sistemas Digitales (IIA308)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA308';

    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'alexis.testa@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Tue/Thu 13:30-15:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 2, '13:30', '15:00', 'LAB_DIG');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 4, '13:30', '15:00', 'LAB_DIG');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'jose.perez.perez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Mon/Wed 13:30-15:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 1, '13:30', '15:00', 'LAB_DIG');
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 3, '13:30', '15:00', 'LAB_DIG');


    -- 6. Liderazgo Personal (IIA309)
    SELECT id_materia INTO v_id_materia FROM escom_aliz.materia WHERE clave = 'IIA309';

    -- 3BM1
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'gisela.gonzalez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Fri 12:00-15:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '12:00', '15:00', '1101');

    -- 3BM2
    SELECT id_usuario INTO v_id_prof FROM escom_aliz.usuario WHERE email = 'elia.ramirez@ejemplo.mx';
    INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
    VALUES (v_id_materia, v_id_prof, v_periodo, 30, 'ABIERTO', 'M') RETURNING id_grupo INTO v_id_grupo;
    -- Schedule: Fri 09:00-12:00
    INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula) VALUES (v_id_grupo, 5, '09:00', '12:00', '1102');

END $$;

COMMIT;
