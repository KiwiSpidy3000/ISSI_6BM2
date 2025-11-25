-- Fix data for Miguel (Kardex) and Idalia (Groups)

DO $$
DECLARE
    v_id_alumno INT;
    v_id_profesor_idalia INT;
    v_materia RECORD;
    v_id_grupo INT;
    v_periodo_passed VARCHAR := '2023-2'; -- Past period for passed subjects
    v_periodo_current VARCHAR := '2024-1'; -- Current period
BEGIN
    -- 0. Reset sequences to avoid conflicts
    PERFORM setval('escom_aliz.grupo_id_grupo_seq', (SELECT MAX(id_grupo) FROM escom_aliz.grupo));
    PERFORM setval('escom_aliz.inscripcion_id_inscripcion_seq', (SELECT MAX(id_inscripcion) FROM escom_aliz.inscripcion));
    -- PERFORM setval('escom_aliz.calificacion_id_calificacion_seq', (SELECT MAX(id_calificacion) FROM escom_aliz.calificacion)); -- Assuming it exists

    -- 1. Get IDs
    SELECT id_usuario INTO v_id_alumno FROM escom_aliz.usuario WHERE email = '2021301170@alumno.ipn.mx';
    SELECT id_profesor INTO v_id_profesor_idalia FROM escom_aliz.profesor p JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario WHERE u.email = 'idalia.maldonado@escom.ipn.mx';
    
    -- Get a fallback professor if Idalia is not found or for other groups
    IF v_id_profesor_idalia IS NULL THEN
         SELECT id_profesor INTO v_id_profesor_idalia FROM escom_aliz.profesor LIMIT 1;
    END IF;

    IF v_id_alumno IS NULL THEN
        RAISE NOTICE 'Miguel not found';
        RETURN;
    END IF;

    -- 2. Populate Miguel's Kardex (Semesters 1-5)
    FOR v_materia IN 
        SELECT m.id_materia, m.semestre 
        FROM escom_aliz.materia m 
        JOIN escom_aliz.carrera c ON m.id_carrera = c.id_carrera 
        WHERE c.clave = 'IIA' AND m.semestre BETWEEN 1 AND 5
    LOOP
        -- Ensure group exists for past period
        SELECT id_grupo INTO v_id_grupo FROM escom_aliz.grupo WHERE id_materia = v_materia.id_materia AND periodo = v_periodo_passed LIMIT 1;
        
        IF v_id_grupo IS NULL THEN
            INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
            VALUES (v_materia.id_materia, v_id_profesor_idalia, v_periodo_passed, 30, 'CERRADO', 'M')
            RETURNING id_grupo INTO v_id_grupo;
        END IF;

        -- Insert Inscripcion (INSCRITO) if not exists
        IF NOT EXISTS (SELECT 1 FROM escom_aliz.inscripcion WHERE id_alumno = v_id_alumno AND id_grupo = v_id_grupo) THEN
            INSERT INTO escom_aliz.inscripcion (id_alumno, id_grupo, estado, fecha)
            VALUES (v_id_alumno, v_id_grupo, 'INSCRITO', NOW() - INTERVAL '6 months');
            
            -- Insert Calificacion
            INSERT INTO escom_aliz.calificacion (id_alumno, id_grupo, p1, p2, ordinario)
            VALUES (v_id_alumno, v_id_grupo, 8.0, 9.0, 9.0);
        END IF;
    END LOOP;

    -- 3. Populate Miguel's Current Semester (Semester 6)
    FOR v_materia IN 
        SELECT m.id_materia 
        FROM escom_aliz.materia m 
        JOIN escom_aliz.carrera c ON m.id_carrera = c.id_carrera 
        WHERE c.clave = 'IIA' AND m.semestre = 6
    LOOP
        -- Ensure group exists for current period
        SELECT id_grupo INTO v_id_grupo FROM escom_aliz.grupo WHERE id_materia = v_materia.id_materia AND periodo = v_periodo_current LIMIT 1;
        
        IF v_id_grupo IS NULL THEN
            INSERT INTO escom_aliz.grupo (id_materia, id_profesor, periodo, cupo_max, estado, turno)
            VALUES (v_materia.id_materia, v_id_profesor_idalia, v_periodo_current, 30, 'ABIERTO', 'V')
            RETURNING id_grupo INTO v_id_grupo;
        END IF;

        -- Insert Inscripcion (INSCRITO) if not exists
        IF NOT EXISTS (SELECT 1 FROM escom_aliz.inscripcion WHERE id_alumno = v_id_alumno AND id_grupo = v_id_grupo) THEN
            INSERT INTO escom_aliz.inscripcion (id_alumno, id_grupo, estado, fecha)
            VALUES (v_id_alumno, v_id_grupo, 'INSCRITO', NOW());
        END IF;
    END LOOP;

    -- 4. Assign Idalia to specific subjects
    IF v_id_profesor_idalia IS NOT NULL THEN
        -- Fundamentos de Inteligencia Artificial
        UPDATE escom_aliz.grupo SET id_profesor = v_id_profesor_idalia 
        WHERE id_materia IN (SELECT id_materia FROM escom_aliz.materia WHERE nombre ILIKE '%Fundamentos de Inteligencia Artificial%');

        -- Aprendizaje de Máquina
        UPDATE escom_aliz.grupo SET id_profesor = v_id_profesor_idalia 
        WHERE id_materia IN (SELECT id_materia FROM escom_aliz.materia WHERE nombre ILIKE '%Aprendizaje de Máquina%');

        -- Visión Artificial
        UPDATE escom_aliz.grupo SET id_profesor = v_id_profesor_idalia 
        WHERE id_materia IN (SELECT id_materia FROM escom_aliz.materia WHERE nombre ILIKE '%Visión Artificial%');

        -- Ingeniería de Software para Sistemas Inteligentes
        UPDATE escom_aliz.grupo SET id_profesor = v_id_profesor_idalia 
        WHERE id_materia IN (SELECT id_materia FROM escom_aliz.materia WHERE nombre ILIKE '%Ingeniería de Software para Sistemas Inteligentes%');
    END IF;

END $$;
