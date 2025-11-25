-- Fix schedule data for Miguel's current groups (2024-1)

DO $$
DECLARE
    v_id_alumno INT;
    v_periodo VARCHAR := '2024-1';
    v_grupo RECORD;
    v_day_idx INT;
BEGIN
    -- Get Miguel's ID
    SELECT id_usuario INTO v_id_alumno FROM escom_aliz.usuario WHERE email = '2021301170@alumno.ipn.mx';

    IF v_id_alumno IS NULL THEN
        RAISE NOTICE 'Miguel not found';
        RETURN;
    END IF;

    -- Iterate over Miguel's enrolled groups for the current period
    FOR v_grupo IN 
        SELECT g.id_grupo, m.nombre as materia
        FROM escom_aliz.inscripcion i
        JOIN escom_aliz.grupo g ON i.id_grupo = g.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE i.id_alumno = v_id_alumno AND g.periodo = v_periodo
    LOOP
        -- Check if schedule already exists
        IF NOT EXISTS (SELECT 1 FROM escom_aliz.horario WHERE id_grupo = v_grupo.id_grupo) THEN
            -- Assign a random schedule
            -- Pick 2 days per subject (1=Lunes, ..., 5=Viernes)
            v_day_idx := floor(random() * 4) + 1; -- 1 to 4
            
            -- Day 1
            INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula)
            VALUES (v_grupo.id_grupo, v_day_idx, '07:00:00', '08:30:00', 'Edif 1 - 10' || floor(random()*9+1));

            -- Day 2 (skip one day)
            INSERT INTO escom_aliz.horario (id_grupo, dia_semana, hora_ini, hora_fin, aula)
            VALUES (v_grupo.id_grupo, v_day_idx + 2, '07:00:00', '08:30:00', 'Edif 1 - 10' || floor(random()*9+1));
            
            RAISE NOTICE 'Inserted schedule for group % (%)', v_grupo.id_grupo, v_grupo.materia;
        ELSE
            RAISE NOTICE 'Schedule already exists for group % (%)', v_grupo.id_grupo, v_grupo.materia;
        END IF;
    END LOOP;
END $$;
