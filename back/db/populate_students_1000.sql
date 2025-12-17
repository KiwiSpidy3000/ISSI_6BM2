BEGIN;

-- Batch 0 to 50
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_0 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640000@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Carmen',
    'Ramirez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_0 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640000', (SELECT id_carrera FROM iia), 5
  FROM u_0
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_1 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640001@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Aguilar Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_1 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640001', (SELECT id_carrera FROM iia), 8
  FROM u_1
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_2 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640002@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Roberto',
    'Torres Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_2 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640002', (SELECT id_carrera FROM iia), 5
  FROM u_2
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_3 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640003@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Natalia',
    'Velazquez Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_3 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640003', (SELECT id_carrera FROM iia), 5
  FROM u_3
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_4 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640004@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Gonzalez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_4 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640004', (SELECT id_carrera FROM iia), 3
  FROM u_4
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_5 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640005@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Tellez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_5 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640005', (SELECT id_carrera FROM iia), 3
  FROM u_5
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_6 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640006@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Victoria',
    'Gomez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_6 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640006', (SELECT id_carrera FROM iia), 10
  FROM u_6
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_7 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640007@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Ortiz Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_7 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640007', (SELECT id_carrera FROM iia), 3
  FROM u_7
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_8 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640008@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Miguel',
    'Diaz Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_8 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640008', (SELECT id_carrera FROM iia), 1
  FROM u_8
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_9 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640009@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria David',
    'Munoz Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_9 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640009', (SELECT id_carrera FROM iia), 10
  FROM u_9
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_10 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640010@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Flores Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_10 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640010', (SELECT id_carrera FROM iia), 3
  FROM u_10
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_11 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640011@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Fernanda',
    'Reyes Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_11 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640011', (SELECT id_carrera FROM iia), 9
  FROM u_11
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_12 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640012@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Diego',
    'Soto Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_12 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640012', (SELECT id_carrera FROM iia), 7
  FROM u_12
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_13 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640013@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Gonzalez Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_13 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640013', (SELECT id_carrera FROM iia), 9
  FROM u_13
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_14 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640014@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Ricardo',
    'Chavez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_14 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640014', (SELECT id_carrera FROM iia), 8
  FROM u_14
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_15 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640015@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Estrada Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_15 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640015', (SELECT id_carrera FROM iia), 6
  FROM u_15
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_16 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640016@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Daniela',
    'Silva Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_16 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640016', (SELECT id_carrera FROM iia), 9
  FROM u_16
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_17 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640017@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara David',
    'Gomez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_17 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640017', (SELECT id_carrera FROM iia), 5
  FROM u_17
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_18 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640018@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Ortiz Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_18 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640018', (SELECT id_carrera FROM iia), 4
  FROM u_18
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_19 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640019@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Sergio',
    'Alvarez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_19 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640019', (SELECT id_carrera FROM iia), 5
  FROM u_19
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_20 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640020@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Ramirez Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_20 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640020', (SELECT id_carrera FROM iia), 8
  FROM u_20
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_21 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640021@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Luis',
    'Perez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_21 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640021', (SELECT id_carrera FROM iia), 5
  FROM u_21
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_22 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640022@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Ramirez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_22 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640022', (SELECT id_carrera FROM iia), 2
  FROM u_22
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_23 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640023@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Elena',
    'Soto Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_23 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640023', (SELECT id_carrera FROM iia), 5
  FROM u_23
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_24 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640024@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Soto Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_24 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640024', (SELECT id_carrera FROM iia), 9
  FROM u_24
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_25 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640025@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Garcia Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_25 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640025', (SELECT id_carrera FROM iia), 1
  FROM u_25
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_26 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640026@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Rojas Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_26 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640026', (SELECT id_carrera FROM iia), 2
  FROM u_26
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_27 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640027@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Eduardo',
    'Alvarez Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_27 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640027', (SELECT id_carrera FROM iia), 1
  FROM u_27
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_28 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640028@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Reyes Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_28 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640028', (SELECT id_carrera FROM iia), 2
  FROM u_28
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_29 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640029@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Gutierrez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_29 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640029', (SELECT id_carrera FROM iia), 1
  FROM u_29
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_30 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640030@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Carlos',
    'Guzman Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_30 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640030', (SELECT id_carrera FROM iia), 3
  FROM u_30
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_31 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640031@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Daniel',
    'Martinez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_31 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640031', (SELECT id_carrera FROM iia), 4
  FROM u_31
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_32 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640032@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Luis',
    'Sanchez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_32 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640032', (SELECT id_carrera FROM iia), 1
  FROM u_32
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_33 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640033@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Andres',
    'Ruiz Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_33 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640033', (SELECT id_carrera FROM iia), 5
  FROM u_33
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_34 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640034@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Andrea',
    'Chavez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_34 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640034', (SELECT id_carrera FROM iia), 10
  FROM u_34
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_35 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640035@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Lucia',
    'Gutierrez Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_35 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640035', (SELECT id_carrera FROM iia), 9
  FROM u_35
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_36 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640036@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Tellez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_36 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640036', (SELECT id_carrera FROM iia), 9
  FROM u_36
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_37 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640037@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Dominguez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_37 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640037', (SELECT id_carrera FROM iia), 6
  FROM u_37
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_38 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640038@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Avila Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_38 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640038', (SELECT id_carrera FROM iia), 8
  FROM u_38
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_39 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640039@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Mendoza Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_39 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640039', (SELECT id_carrera FROM iia), 3
  FROM u_39
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_40 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640040@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Ortiz Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_40 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640040', (SELECT id_carrera FROM iia), 1
  FROM u_40
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_41 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640041@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Santiago Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_41 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640041', (SELECT id_carrera FROM iia), 6
  FROM u_41
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_42 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640042@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Rojas Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_42 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640042', (SELECT id_carrera FROM iia), 5
  FROM u_42
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_43 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640043@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Fernanda',
    'De La Cruz Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_43 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640043', (SELECT id_carrera FROM iia), 1
  FROM u_43
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_44 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640044@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Gutierrez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_44 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640044', (SELECT id_carrera FROM iia), 9
  FROM u_44
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_45 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640045@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Fernanda',
    'Salazar Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_45 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640045', (SELECT id_carrera FROM iia), 4
  FROM u_45
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_46 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640046@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Estrada Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_46 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640046', (SELECT id_carrera FROM iia), 5
  FROM u_46
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_47 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640047@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Perez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_47 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640047', (SELECT id_carrera FROM iia), 2
  FROM u_47
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_48 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640048@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Oscar',
    'Vargas Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_48 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640048', (SELECT id_carrera FROM iia), 4
  FROM u_48
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_49 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640049@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Ramos Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_49 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640049', (SELECT id_carrera FROM iia), 1
  FROM u_49
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_0, a_1, a_2, a_3, a_4, a_5, a_6, a_7, a_8, a_9, a_10, a_11, a_12, a_13, a_14, a_15, a_16, a_17, a_18, a_19, a_20, a_21, a_22, a_23, a_24, a_25, a_26, a_27, a_28, a_29, a_30, a_31, a_32, a_33, a_34, a_35, a_36, a_37, a_38, a_39, a_40, a_41, a_42, a_43, a_44, a_45, a_46, a_47, a_48, a_49;

-- Batch 50 to 100
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_50 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640050@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Chavez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_50 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640050', (SELECT id_carrera FROM iia), 10
  FROM u_50
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_51 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640051@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Gomez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_51 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640051', (SELECT id_carrera FROM iia), 10
  FROM u_51
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_52 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640052@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Maria',
    'Aguilar Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_52 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640052', (SELECT id_carrera FROM iia), 4
  FROM u_52
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_53 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640053@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Eduardo',
    'Jimenez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_53 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640053', (SELECT id_carrera FROM iia), 8
  FROM u_53
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_54 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640054@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Vazquez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_54 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640054', (SELECT id_carrera FROM iia), 9
  FROM u_54
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_55 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640055@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Cruz Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_55 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640055', (SELECT id_carrera FROM iia), 2
  FROM u_55
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_56 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640056@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Ramirez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_56 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640056', (SELECT id_carrera FROM iia), 8
  FROM u_56
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_57 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640057@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Julia',
    'Solis Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_57 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640057', (SELECT id_carrera FROM iia), 3
  FROM u_57
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_58 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640058@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Vargas Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_58 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640058', (SELECT id_carrera FROM iia), 4
  FROM u_58
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_59 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640059@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Diaz Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_59 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640059', (SELECT id_carrera FROM iia), 3
  FROM u_59
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_60 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640060@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Francisco',
    'De La Cruz Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_60 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640060', (SELECT id_carrera FROM iia), 8
  FROM u_60
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_61 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640061@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Moreno Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_61 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640061', (SELECT id_carrera FROM iia), 7
  FROM u_61
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_62 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640062@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Santiago Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_62 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640062', (SELECT id_carrera FROM iia), 1
  FROM u_62
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_63 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640063@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Rivera Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_63 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640063', (SELECT id_carrera FROM iia), 9
  FROM u_63
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_64 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640064@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Lopez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_64 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640064', (SELECT id_carrera FROM iia), 2
  FROM u_64
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_65 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640065@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Alejandro',
    'Hernandez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_65 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640065', (SELECT id_carrera FROM iia), 1
  FROM u_65
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_66 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640066@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Sara',
    'Ramos Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_66 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640066', (SELECT id_carrera FROM iia), 6
  FROM u_66
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_67 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640067@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Maria',
    'Sandoval Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_67 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640067', (SELECT id_carrera FROM iia), 2
  FROM u_67
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_68 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640068@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Ortiz Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_68 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640068', (SELECT id_carrera FROM iia), 10
  FROM u_68
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_69 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640069@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Juan',
    'Munoz Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_69 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640069', (SELECT id_carrera FROM iia), 2
  FROM u_69
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_70 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640070@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Pedro',
    'Cruz Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_70 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640070', (SELECT id_carrera FROM iia), 5
  FROM u_70
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_71 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640071@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Soto Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_71 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640071', (SELECT id_carrera FROM iia), 1
  FROM u_71
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_72 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640072@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Jesus',
    'Morales Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_72 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640072', (SELECT id_carrera FROM iia), 4
  FROM u_72
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_73 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640073@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Alejandro',
    'De La Cruz Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_73 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640073', (SELECT id_carrera FROM iia), 3
  FROM u_73
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_74 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640074@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Renata',
    'Soto Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_74 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640074', (SELECT id_carrera FROM iia), 10
  FROM u_74
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_75 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640075@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Sergio',
    'Mendoza Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_75 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640075', (SELECT id_carrera FROM iia), 9
  FROM u_75
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_76 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640076@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Valentina',
    'Lopez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_76 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640076', (SELECT id_carrera FROM iia), 1
  FROM u_76
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_77 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640077@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Julia',
    'Torres Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_77 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640077', (SELECT id_carrera FROM iia), 9
  FROM u_77
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_78 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640078@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Castillo Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_78 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640078', (SELECT id_carrera FROM iia), 6
  FROM u_78
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_79 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640079@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Camila',
    'Romero Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_79 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640079', (SELECT id_carrera FROM iia), 7
  FROM u_79
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_80 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640080@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Roberto',
    'Garcia Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_80 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640080', (SELECT id_carrera FROM iia), 7
  FROM u_80
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_81 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640081@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Pedro',
    'Gutierrez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_81 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640081', (SELECT id_carrera FROM iia), 3
  FROM u_81
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_82 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640082@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Rodriguez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_82 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640082', (SELECT id_carrera FROM iia), 5
  FROM u_82
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_83 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640083@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Antonio',
    'Guzman Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_83 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640083', (SELECT id_carrera FROM iia), 9
  FROM u_83
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_84 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640084@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Ramos Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_84 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640084', (SELECT id_carrera FROM iia), 7
  FROM u_84
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_85 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640085@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Sandoval Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_85 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640085', (SELECT id_carrera FROM iia), 3
  FROM u_85
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_86 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640086@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Juan',
    'Santiago Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_86 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640086', (SELECT id_carrera FROM iia), 6
  FROM u_86
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_87 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640087@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Vargas Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_87 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640087', (SELECT id_carrera FROM iia), 1
  FROM u_87
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_88 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640088@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'De La Cruz Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_88 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640088', (SELECT id_carrera FROM iia), 6
  FROM u_88
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_89 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640089@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Camila',
    'Morales Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_89 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640089', (SELECT id_carrera FROM iia), 2
  FROM u_89
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_90 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640090@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Sara',
    'Romero Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_90 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640090', (SELECT id_carrera FROM iia), 4
  FROM u_90
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_91 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640091@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Camila',
    'De La Cruz Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_91 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640091', (SELECT id_carrera FROM iia), 2
  FROM u_91
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_92 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640092@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Regina',
    'Velazquez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_92 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640092', (SELECT id_carrera FROM iia), 10
  FROM u_92
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_93 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640093@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Fernando',
    'Perez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_93 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640093', (SELECT id_carrera FROM iia), 2
  FROM u_93
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_94 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640094@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Estrada Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_94 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640094', (SELECT id_carrera FROM iia), 6
  FROM u_94
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_95 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640095@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Diaz Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_95 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640095', (SELECT id_carrera FROM iia), 8
  FROM u_95
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_96 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640096@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Valentina',
    'Alvarez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_96 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640096', (SELECT id_carrera FROM iia), 6
  FROM u_96
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_97 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640097@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Fernanda',
    'Alvarez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_97 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640097', (SELECT id_carrera FROM iia), 9
  FROM u_97
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_98 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640098@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Delgado Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_98 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640098', (SELECT id_carrera FROM iia), 1
  FROM u_98
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_99 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640099@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Sergio',
    'Contreras Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_99 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640099', (SELECT id_carrera FROM iia), 10
  FROM u_99
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_50, a_51, a_52, a_53, a_54, a_55, a_56, a_57, a_58, a_59, a_60, a_61, a_62, a_63, a_64, a_65, a_66, a_67, a_68, a_69, a_70, a_71, a_72, a_73, a_74, a_75, a_76, a_77, a_78, a_79, a_80, a_81, a_82, a_83, a_84, a_85, a_86, a_87, a_88, a_89, a_90, a_91, a_92, a_93, a_94, a_95, a_96, a_97, a_98, a_99;

-- Batch 100 to 150
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_100 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640100@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Diego',
    'Moreno Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_100 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640100', (SELECT id_carrera FROM iia), 1
  FROM u_100
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_101 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640101@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Renata',
    'Alvarez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_101 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640101', (SELECT id_carrera FROM iia), 9
  FROM u_101
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_102 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640102@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Gutierrez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_102 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640102', (SELECT id_carrera FROM iia), 8
  FROM u_102
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_103 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640103@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Torres Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_103 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640103', (SELECT id_carrera FROM iia), 4
  FROM u_103
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_104 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640104@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Guerrero Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_104 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640104', (SELECT id_carrera FROM iia), 6
  FROM u_104
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_105 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640105@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Daniela',
    'Estrada Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_105 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640105', (SELECT id_carrera FROM iia), 2
  FROM u_105
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_106 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640106@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Delgado Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_106 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640106', (SELECT id_carrera FROM iia), 8
  FROM u_106
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_107 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640107@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Gomez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_107 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640107', (SELECT id_carrera FROM iia), 5
  FROM u_107
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_108 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640108@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Elena',
    'Silva Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_108 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640108', (SELECT id_carrera FROM iia), 2
  FROM u_108
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_109 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640109@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Fernanda',
    'Ruiz Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_109 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640109', (SELECT id_carrera FROM iia), 7
  FROM u_109
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_110 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640110@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Ortiz Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_110 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640110', (SELECT id_carrera FROM iia), 8
  FROM u_110
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_111 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640111@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Juan',
    'Reyes Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_111 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640111', (SELECT id_carrera FROM iia), 5
  FROM u_111
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_112 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640112@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'De La Cruz Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_112 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640112', (SELECT id_carrera FROM iia), 8
  FROM u_112
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_113 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640113@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Andrea',
    'Moreno Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_113 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640113', (SELECT id_carrera FROM iia), 4
  FROM u_113
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_114 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640114@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Mariana',
    'Gutierrez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_114 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640114', (SELECT id_carrera FROM iia), 6
  FROM u_114
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_115 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640115@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Antonio',
    'Santiago Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_115 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640115', (SELECT id_carrera FROM iia), 6
  FROM u_115
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_116 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640116@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Jose',
    'Lopez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_116 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640116', (SELECT id_carrera FROM iia), 7
  FROM u_116
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_117 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640117@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Ruiz Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_117 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640117', (SELECT id_carrera FROM iia), 10
  FROM u_117
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_118 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640118@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Daniela',
    'Delgado Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_118 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640118', (SELECT id_carrera FROM iia), 3
  FROM u_118
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_119 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640119@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Jimenez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_119 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640119', (SELECT id_carrera FROM iia), 2
  FROM u_119
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_120 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640120@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Aguilar Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_120 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640120', (SELECT id_carrera FROM iia), 10
  FROM u_120
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_121 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640121@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Vazquez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_121 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640121', (SELECT id_carrera FROM iia), 10
  FROM u_121
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_122 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640122@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Marquez Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_122 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640122', (SELECT id_carrera FROM iia), 5
  FROM u_122
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_123 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640123@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Estrada Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_123 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640123', (SELECT id_carrera FROM iia), 3
  FROM u_123
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_124 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640124@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia David',
    'Flores Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_124 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640124', (SELECT id_carrera FROM iia), 8
  FROM u_124
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_125 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640125@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Ruiz Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_125 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640125', (SELECT id_carrera FROM iia), 1
  FROM u_125
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_126 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640126@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Javier',
    'Gomez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_126 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640126', (SELECT id_carrera FROM iia), 3
  FROM u_126
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_127 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640127@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Flores Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_127 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640127', (SELECT id_carrera FROM iia), 5
  FROM u_127
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_128 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640128@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Natalia',
    'Vazquez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_128 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640128', (SELECT id_carrera FROM iia), 3
  FROM u_128
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_129 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640129@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Rodriguez Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_129 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640129', (SELECT id_carrera FROM iia), 10
  FROM u_129
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_130 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640130@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Ruiz Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_130 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640130', (SELECT id_carrera FROM iia), 10
  FROM u_130
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_131 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640131@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Pedro',
    'Martinez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_131 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640131', (SELECT id_carrera FROM iia), 2
  FROM u_131
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_132 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640132@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Jesus',
    'Dominguez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_132 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640132', (SELECT id_carrera FROM iia), 3
  FROM u_132
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_133 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640133@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Natalia',
    'Martinez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_133 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640133', (SELECT id_carrera FROM iia), 7
  FROM u_133
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_134 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640134@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Vargas Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_134 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640134', (SELECT id_carrera FROM iia), 2
  FROM u_134
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_135 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640135@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Daniela',
    'Chavez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_135 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640135', (SELECT id_carrera FROM iia), 6
  FROM u_135
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_136 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640136@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Ramirez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_136 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640136', (SELECT id_carrera FROM iia), 4
  FROM u_136
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_137 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640137@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Marquez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_137 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640137', (SELECT id_carrera FROM iia), 1
  FROM u_137
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_138 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640138@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Ana',
    'Flores De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_138 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640138', (SELECT id_carrera FROM iia), 7
  FROM u_138
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_139 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640139@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Sandoval Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_139 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640139', (SELECT id_carrera FROM iia), 8
  FROM u_139
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_140 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640140@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Eduardo',
    'Lopez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_140 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640140', (SELECT id_carrera FROM iia), 6
  FROM u_140
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_141 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640141@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Maria',
    'Dominguez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_141 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640141', (SELECT id_carrera FROM iia), 1
  FROM u_141
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_142 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640142@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Ruiz Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_142 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640142', (SELECT id_carrera FROM iia), 6
  FROM u_142
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_143 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640143@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'De La Cruz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_143 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640143', (SELECT id_carrera FROM iia), 9
  FROM u_143
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_144 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640144@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Adrian',
    'Gomez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_144 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640144', (SELECT id_carrera FROM iia), 3
  FROM u_144
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_145 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640145@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan',
    'Martinez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_145 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640145', (SELECT id_carrera FROM iia), 10
  FROM u_145
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_146 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640146@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Vargas Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_146 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640146', (SELECT id_carrera FROM iia), 8
  FROM u_146
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_147 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640147@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Marquez Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_147 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640147', (SELECT id_carrera FROM iia), 1
  FROM u_147
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_148 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640148@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Salazar Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_148 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640148', (SELECT id_carrera FROM iia), 1
  FROM u_148
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_149 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640149@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Solis Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_149 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640149', (SELECT id_carrera FROM iia), 10
  FROM u_149
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_100, a_101, a_102, a_103, a_104, a_105, a_106, a_107, a_108, a_109, a_110, a_111, a_112, a_113, a_114, a_115, a_116, a_117, a_118, a_119, a_120, a_121, a_122, a_123, a_124, a_125, a_126, a_127, a_128, a_129, a_130, a_131, a_132, a_133, a_134, a_135, a_136, a_137, a_138, a_139, a_140, a_141, a_142, a_143, a_144, a_145, a_146, a_147, a_148, a_149;

-- Batch 150 to 200
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_150 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640150@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Aguilar Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_150 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640150', (SELECT id_carrera FROM iia), 2
  FROM u_150
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_151 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640151@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Rojas Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_151 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640151', (SELECT id_carrera FROM iia), 8
  FROM u_151
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_152 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640152@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Gabriela',
    'Romero Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_152 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640152', (SELECT id_carrera FROM iia), 7
  FROM u_152
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_153 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640153@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier David',
    'Vargas Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_153 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640153', (SELECT id_carrera FROM iia), 3
  FROM u_153
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_154 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640154@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Renata',
    'Lopez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_154 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640154', (SELECT id_carrera FROM iia), 1
  FROM u_154
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_155 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640155@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Fernando',
    'Avila Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_155 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640155', (SELECT id_carrera FROM iia), 8
  FROM u_155
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_156 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640156@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Cruz Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_156 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640156', (SELECT id_carrera FROM iia), 10
  FROM u_156
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_157 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640157@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Manuel',
    'Marquez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_157 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640157', (SELECT id_carrera FROM iia), 1
  FROM u_157
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_158 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640158@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Ramirez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_158 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640158', (SELECT id_carrera FROM iia), 10
  FROM u_158
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_159 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640159@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Sergio',
    'Flores Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_159 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640159', (SELECT id_carrera FROM iia), 6
  FROM u_159
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_160 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640160@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Tellez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_160 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640160', (SELECT id_carrera FROM iia), 9
  FROM u_160
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_161 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640161@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Oscar',
    'Cruz Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_161 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640161', (SELECT id_carrera FROM iia), 5
  FROM u_161
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_162 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640162@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Martinez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_162 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640162', (SELECT id_carrera FROM iia), 6
  FROM u_162
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_163 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640163@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Solis Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_163 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640163', (SELECT id_carrera FROM iia), 7
  FROM u_163
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_164 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640164@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Ramos Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_164 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640164', (SELECT id_carrera FROM iia), 5
  FROM u_164
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_165 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640165@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Fernando',
    'Vazquez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_165 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640165', (SELECT id_carrera FROM iia), 9
  FROM u_165
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_166 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640166@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Soto Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_166 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640166', (SELECT id_carrera FROM iia), 1
  FROM u_166
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_167 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640167@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Ortiz Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_167 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640167', (SELECT id_carrera FROM iia), 9
  FROM u_167
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_168 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640168@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Natalia',
    'Avila Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_168 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640168', (SELECT id_carrera FROM iia), 6
  FROM u_168
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_169 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640169@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Diaz Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_169 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640169', (SELECT id_carrera FROM iia), 1
  FROM u_169
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_170 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640170@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Sara',
    'Jimenez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_170 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640170', (SELECT id_carrera FROM iia), 3
  FROM u_170
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_171 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640171@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Roberto',
    'Reyes Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_171 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640171', (SELECT id_carrera FROM iia), 10
  FROM u_171
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_172 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640172@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Avila Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_172 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640172', (SELECT id_carrera FROM iia), 3
  FROM u_172
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_173 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640173@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Romero Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_173 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640173', (SELECT id_carrera FROM iia), 4
  FROM u_173
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_174 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640174@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Andrea',
    'Torres Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_174 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640174', (SELECT id_carrera FROM iia), 10
  FROM u_174
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_175 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640175@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Hernandez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_175 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640175', (SELECT id_carrera FROM iia), 7
  FROM u_175
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_176 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640176@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Dominguez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_176 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640176', (SELECT id_carrera FROM iia), 3
  FROM u_176
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_177 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640177@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Renata',
    'Santiago Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_177 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640177', (SELECT id_carrera FROM iia), 9
  FROM u_177
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_178 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640178@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Sofia',
    'Lopez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_178 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640178', (SELECT id_carrera FROM iia), 8
  FROM u_178
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_179 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640179@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Guzman Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_179 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640179', (SELECT id_carrera FROM iia), 5
  FROM u_179
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_180 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640180@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Alvarez Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_180 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640180', (SELECT id_carrera FROM iia), 3
  FROM u_180
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_181 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640181@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Sara',
    'De La Cruz Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_181 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640181', (SELECT id_carrera FROM iia), 7
  FROM u_181
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_182 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640182@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Ana',
    'Santiago Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_182 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640182', (SELECT id_carrera FROM iia), 4
  FROM u_182
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_183 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640183@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Fernanda',
    'Ruiz Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_183 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640183', (SELECT id_carrera FROM iia), 9
  FROM u_183
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_184 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640184@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Gomez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_184 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640184', (SELECT id_carrera FROM iia), 5
  FROM u_184
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_185 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640185@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Diana',
    'Ortiz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_185 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640185', (SELECT id_carrera FROM iia), 8
  FROM u_185
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_186 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640186@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Mendoza Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_186 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640186', (SELECT id_carrera FROM iia), 9
  FROM u_186
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_187 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640187@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Ramos Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_187 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640187', (SELECT id_carrera FROM iia), 2
  FROM u_187
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_188 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640188@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Jorge',
    'Martinez Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_188 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640188', (SELECT id_carrera FROM iia), 4
  FROM u_188
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_189 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640189@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Daniel',
    'Rojas Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_189 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640189', (SELECT id_carrera FROM iia), 10
  FROM u_189
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_190 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640190@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Natalia',
    'Delgado Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_190 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640190', (SELECT id_carrera FROM iia), 4
  FROM u_190
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_191 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640191@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Manuel',
    'Flores Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_191 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640191', (SELECT id_carrera FROM iia), 6
  FROM u_191
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_192 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640192@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Martinez Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_192 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640192', (SELECT id_carrera FROM iia), 7
  FROM u_192
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_193 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640193@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Soto Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_193 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640193', (SELECT id_carrera FROM iia), 1
  FROM u_193
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_194 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640194@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'De La Cruz Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_194 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640194', (SELECT id_carrera FROM iia), 9
  FROM u_194
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_195 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640195@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Valentina',
    'Torres Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_195 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640195', (SELECT id_carrera FROM iia), 10
  FROM u_195
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_196 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640196@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Sofia',
    'Rojas Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_196 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640196', (SELECT id_carrera FROM iia), 9
  FROM u_196
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_197 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640197@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Aguilar Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_197 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640197', (SELECT id_carrera FROM iia), 1
  FROM u_197
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_198 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640198@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Sanchez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_198 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640198', (SELECT id_carrera FROM iia), 7
  FROM u_198
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_199 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640199@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Jose',
    'Velazquez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_199 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640199', (SELECT id_carrera FROM iia), 4
  FROM u_199
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_150, a_151, a_152, a_153, a_154, a_155, a_156, a_157, a_158, a_159, a_160, a_161, a_162, a_163, a_164, a_165, a_166, a_167, a_168, a_169, a_170, a_171, a_172, a_173, a_174, a_175, a_176, a_177, a_178, a_179, a_180, a_181, a_182, a_183, a_184, a_185, a_186, a_187, a_188, a_189, a_190, a_191, a_192, a_193, a_194, a_195, a_196, a_197, a_198, a_199;

-- Batch 200 to 250
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_200 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640200@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Soto Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_200 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640200', (SELECT id_carrera FROM iia), 4
  FROM u_200
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_201 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640201@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Salazar Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_201 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640201', (SELECT id_carrera FROM iia), 1
  FROM u_201
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_202 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640202@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Adrian',
    'Castillo Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_202 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640202', (SELECT id_carrera FROM iia), 10
  FROM u_202
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_203 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640203@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Javier',
    'Hernandez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_203 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640203', (SELECT id_carrera FROM iia), 4
  FROM u_203
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_204 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640204@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres Mariana',
    'Ruiz Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_204 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640204', (SELECT id_carrera FROM iia), 1
  FROM u_204
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_205 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640205@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Valeria',
    'Ortiz Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_205 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640205', (SELECT id_carrera FROM iia), 6
  FROM u_205
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_206 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640206@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Gonzalez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_206 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640206', (SELECT id_carrera FROM iia), 1
  FROM u_206
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_207 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640207@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Cruz Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_207 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640207', (SELECT id_carrera FROM iia), 7
  FROM u_207
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_208 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640208@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Marquez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_208 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640208', (SELECT id_carrera FROM iia), 3
  FROM u_208
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_209 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640209@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Andres',
    'Sanchez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_209 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640209', (SELECT id_carrera FROM iia), 10
  FROM u_209
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_210 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640210@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Paula',
    'Martinez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_210 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640210', (SELECT id_carrera FROM iia), 1
  FROM u_210
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_211 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640211@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Daniela',
    'Marquez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_211 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640211', (SELECT id_carrera FROM iia), 5
  FROM u_211
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_212 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640212@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Perez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_212 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640212', (SELECT id_carrera FROM iia), 2
  FROM u_212
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_213 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640213@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Perez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_213 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640213', (SELECT id_carrera FROM iia), 6
  FROM u_213
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_214 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640214@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Ramos Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_214 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640214', (SELECT id_carrera FROM iia), 10
  FROM u_214
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_215 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640215@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Diaz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_215 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640215', (SELECT id_carrera FROM iia), 9
  FROM u_215
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_216 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640216@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Hernandez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_216 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640216', (SELECT id_carrera FROM iia), 1
  FROM u_216
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_217 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640217@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'De La Cruz Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_217 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640217', (SELECT id_carrera FROM iia), 6
  FROM u_217
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_218 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640218@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Oscar',
    'Ruiz Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_218 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640218', (SELECT id_carrera FROM iia), 10
  FROM u_218
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_219 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640219@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Garcia Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_219 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640219', (SELECT id_carrera FROM iia), 6
  FROM u_219
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_220 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640220@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Garcia Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_220 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640220', (SELECT id_carrera FROM iia), 4
  FROM u_220
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_221 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640221@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Avila Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_221 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640221', (SELECT id_carrera FROM iia), 6
  FROM u_221
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_222 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640222@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Francisco',
    'Diaz Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_222 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640222', (SELECT id_carrera FROM iia), 8
  FROM u_222
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_223 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640223@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Cruz Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_223 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640223', (SELECT id_carrera FROM iia), 6
  FROM u_223
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_224 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640224@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Munoz Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_224 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640224', (SELECT id_carrera FROM iia), 10
  FROM u_224
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_225 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640225@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Rodriguez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_225 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640225', (SELECT id_carrera FROM iia), 5
  FROM u_225
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_226 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640226@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Ricardo',
    'Delgado Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_226 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640226', (SELECT id_carrera FROM iia), 6
  FROM u_226
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_227 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640227@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Chavez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_227 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640227', (SELECT id_carrera FROM iia), 5
  FROM u_227
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_228 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640228@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Fernando',
    'Guerrero Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_228 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640228', (SELECT id_carrera FROM iia), 9
  FROM u_228
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_229 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640229@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Juan',
    'Ruiz Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_229 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640229', (SELECT id_carrera FROM iia), 2
  FROM u_229
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_230 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640230@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Valentina',
    'Jimenez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_230 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640230', (SELECT id_carrera FROM iia), 9
  FROM u_230
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_231 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640231@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Gabriela',
    'Sanchez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_231 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640231', (SELECT id_carrera FROM iia), 4
  FROM u_231
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_232 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640232@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Jesus',
    'Mendoza Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_232 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640232', (SELECT id_carrera FROM iia), 6
  FROM u_232
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_233 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640233@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Daniel',
    'Alvarez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_233 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640233', (SELECT id_carrera FROM iia), 8
  FROM u_233
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_234 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640234@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Fernanda',
    'Mendoza Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_234 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640234', (SELECT id_carrera FROM iia), 4
  FROM u_234
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_235 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640235@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Maria',
    'Rodriguez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_235 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640235', (SELECT id_carrera FROM iia), 9
  FROM u_235
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_236 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640236@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Alexis',
    'Morales Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_236 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640236', (SELECT id_carrera FROM iia), 8
  FROM u_236
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_237 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640237@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Contreras Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_237 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640237', (SELECT id_carrera FROM iia), 5
  FROM u_237
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_238 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640238@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Castillo Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_238 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640238', (SELECT id_carrera FROM iia), 3
  FROM u_238
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_239 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640239@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Morales Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_239 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640239', (SELECT id_carrera FROM iia), 6
  FROM u_239
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_240 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640240@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Antonio',
    'Rodriguez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_240 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640240', (SELECT id_carrera FROM iia), 8
  FROM u_240
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_241 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640241@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Alvarez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_241 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640241', (SELECT id_carrera FROM iia), 4
  FROM u_241
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_242 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640242@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Victoria',
    'Jimenez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_242 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640242', (SELECT id_carrera FROM iia), 4
  FROM u_242
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_243 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640243@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Salazar Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_243 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640243', (SELECT id_carrera FROM iia), 3
  FROM u_243
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_244 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640244@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Pedro',
    'Ruiz Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_244 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640244', (SELECT id_carrera FROM iia), 4
  FROM u_244
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_245 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640245@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Jorge',
    'Castillo Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_245 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640245', (SELECT id_carrera FROM iia), 2
  FROM u_245
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_246 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640246@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Chavez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_246 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640246', (SELECT id_carrera FROM iia), 10
  FROM u_246
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_247 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640247@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Victoria',
    'Delgado Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_247 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640247', (SELECT id_carrera FROM iia), 2
  FROM u_247
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_248 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640248@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Velazquez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_248 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640248', (SELECT id_carrera FROM iia), 9
  FROM u_248
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_249 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640249@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Tellez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_249 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640249', (SELECT id_carrera FROM iia), 4
  FROM u_249
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_200, a_201, a_202, a_203, a_204, a_205, a_206, a_207, a_208, a_209, a_210, a_211, a_212, a_213, a_214, a_215, a_216, a_217, a_218, a_219, a_220, a_221, a_222, a_223, a_224, a_225, a_226, a_227, a_228, a_229, a_230, a_231, a_232, a_233, a_234, a_235, a_236, a_237, a_238, a_239, a_240, a_241, a_242, a_243, a_244, a_245, a_246, a_247, a_248, a_249;

-- Batch 250 to 300
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_250 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640250@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Rojas Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_250 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640250', (SELECT id_carrera FROM iia), 7
  FROM u_250
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_251 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640251@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Cruz Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_251 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640251', (SELECT id_carrera FROM iia), 2
  FROM u_251
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_252 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640252@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Sara',
    'Mendoza Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_252 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640252', (SELECT id_carrera FROM iia), 4
  FROM u_252
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_253 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640253@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Sofia',
    'Sandoval Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_253 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640253', (SELECT id_carrera FROM iia), 5
  FROM u_253
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_254 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640254@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Pedro',
    'Chavez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_254 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640254', (SELECT id_carrera FROM iia), 5
  FROM u_254
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_255 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640255@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Gabriela',
    'Sandoval Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_255 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640255', (SELECT id_carrera FROM iia), 9
  FROM u_255
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_256 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640256@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Jorge',
    'Ruiz Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_256 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640256', (SELECT id_carrera FROM iia), 1
  FROM u_256
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_257 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640257@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Perez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_257 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640257', (SELECT id_carrera FROM iia), 4
  FROM u_257
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_258 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640258@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Alvarez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_258 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640258', (SELECT id_carrera FROM iia), 2
  FROM u_258
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_259 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640259@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Rodriguez Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_259 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640259', (SELECT id_carrera FROM iia), 10
  FROM u_259
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_260 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640260@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Delgado Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_260 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640260', (SELECT id_carrera FROM iia), 2
  FROM u_260
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_261 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640261@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Ximena',
    'Chavez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_261 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640261', (SELECT id_carrera FROM iia), 10
  FROM u_261
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_262 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640262@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Guerrero Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_262 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640262', (SELECT id_carrera FROM iia), 1
  FROM u_262
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_263 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640263@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Gutierrez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_263 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640263', (SELECT id_carrera FROM iia), 5
  FROM u_263
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_264 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640264@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Javier',
    'Santiago Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_264 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640264', (SELECT id_carrera FROM iia), 4
  FROM u_264
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_265 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640265@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Luis',
    'Velazquez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_265 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640265', (SELECT id_carrera FROM iia), 8
  FROM u_265
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_266 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640266@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula Eduardo',
    'Morales Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_266 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640266', (SELECT id_carrera FROM iia), 9
  FROM u_266
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_267 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640267@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Munoz Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_267 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640267', (SELECT id_carrera FROM iia), 6
  FROM u_267
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_268 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640268@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Mariana',
    'Flores Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_268 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640268', (SELECT id_carrera FROM iia), 7
  FROM u_268
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_269 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640269@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Romero Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_269 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640269', (SELECT id_carrera FROM iia), 7
  FROM u_269
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_270 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640270@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Hector',
    'Munoz Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_270 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640270', (SELECT id_carrera FROM iia), 4
  FROM u_270
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_271 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640271@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Torres Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_271 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640271', (SELECT id_carrera FROM iia), 8
  FROM u_271
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_272 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640272@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Javier',
    'De La Cruz Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_272 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640272', (SELECT id_carrera FROM iia), 9
  FROM u_272
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_273 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640273@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Valeria',
    'Mendoza Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_273 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640273', (SELECT id_carrera FROM iia), 1
  FROM u_273
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_274 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640274@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Juan',
    'Ramos Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_274 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640274', (SELECT id_carrera FROM iia), 7
  FROM u_274
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_275 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640275@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Fernanda',
    'Romero Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_275 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640275', (SELECT id_carrera FROM iia), 9
  FROM u_275
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_276 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640276@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Morales Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_276 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640276', (SELECT id_carrera FROM iia), 3
  FROM u_276
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_277 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640277@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Romero Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_277 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640277', (SELECT id_carrera FROM iia), 8
  FROM u_277
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_278 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640278@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Camila',
    'Gomez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_278 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640278', (SELECT id_carrera FROM iia), 1
  FROM u_278
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_279 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640279@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Camila',
    'Silva Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_279 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640279', (SELECT id_carrera FROM iia), 1
  FROM u_279
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_280 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640280@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Manuel',
    'Perez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_280 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640280', (SELECT id_carrera FROM iia), 2
  FROM u_280
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_281 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640281@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Javier',
    'Lopez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_281 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640281', (SELECT id_carrera FROM iia), 10
  FROM u_281
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_282 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640282@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Andrea',
    'Hernandez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_282 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640282', (SELECT id_carrera FROM iia), 5
  FROM u_282
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_283 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640283@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Dominguez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_283 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640283', (SELECT id_carrera FROM iia), 8
  FROM u_283
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_284 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640284@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Velazquez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_284 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640284', (SELECT id_carrera FROM iia), 4
  FROM u_284
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_285 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640285@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Ana',
    'Velazquez Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_285 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640285', (SELECT id_carrera FROM iia), 7
  FROM u_285
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_286 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640286@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Solis Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_286 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640286', (SELECT id_carrera FROM iia), 4
  FROM u_286
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_287 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640287@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Pedro',
    'Sanchez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_287 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640287', (SELECT id_carrera FROM iia), 6
  FROM u_287
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_288 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640288@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Francisco',
    'Sanchez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_288 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640288', (SELECT id_carrera FROM iia), 9
  FROM u_288
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_289 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640289@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Rodriguez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_289 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640289', (SELECT id_carrera FROM iia), 1
  FROM u_289
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_290 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640290@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Garcia Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_290 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640290', (SELECT id_carrera FROM iia), 3
  FROM u_290
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_291 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640291@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Valentina',
    'Gomez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_291 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640291', (SELECT id_carrera FROM iia), 7
  FROM u_291
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_292 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640292@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Estrada Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_292 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640292', (SELECT id_carrera FROM iia), 3
  FROM u_292
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_293 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640293@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Regina',
    'Martinez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_293 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640293', (SELECT id_carrera FROM iia), 8
  FROM u_293
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_294 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640294@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Sofia',
    'Contreras Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_294 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640294', (SELECT id_carrera FROM iia), 7
  FROM u_294
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_295 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640295@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Valeria',
    'De La Cruz Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_295 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640295', (SELECT id_carrera FROM iia), 6
  FROM u_295
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_296 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640296@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Isabella',
    'Tellez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_296 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640296', (SELECT id_carrera FROM iia), 9
  FROM u_296
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_297 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640297@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Rodriguez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_297 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640297', (SELECT id_carrera FROM iia), 9
  FROM u_297
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_298 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640298@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Marquez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_298 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640298', (SELECT id_carrera FROM iia), 6
  FROM u_298
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_299 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640299@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Julia',
    'Cruz Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_299 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640299', (SELECT id_carrera FROM iia), 3
  FROM u_299
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_250, a_251, a_252, a_253, a_254, a_255, a_256, a_257, a_258, a_259, a_260, a_261, a_262, a_263, a_264, a_265, a_266, a_267, a_268, a_269, a_270, a_271, a_272, a_273, a_274, a_275, a_276, a_277, a_278, a_279, a_280, a_281, a_282, a_283, a_284, a_285, a_286, a_287, a_288, a_289, a_290, a_291, a_292, a_293, a_294, a_295, a_296, a_297, a_298, a_299;

-- Batch 300 to 350
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_300 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640300@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Perez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_300 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640300', (SELECT id_carrera FROM iia), 10
  FROM u_300
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_301 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640301@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Mariana',
    'Torres Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_301 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640301', (SELECT id_carrera FROM iia), 9
  FROM u_301
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_302 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640302@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Diego',
    'Contreras Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_302 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640302', (SELECT id_carrera FROM iia), 5
  FROM u_302
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_303 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640303@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Ana',
    'Solis Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_303 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640303', (SELECT id_carrera FROM iia), 6
  FROM u_303
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_304 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640304@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Guerrero Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_304 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640304', (SELECT id_carrera FROM iia), 2
  FROM u_304
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_305 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640305@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Mariana',
    'Ruiz Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_305 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640305', (SELECT id_carrera FROM iia), 1
  FROM u_305
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_306 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640306@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Daniel',
    'Moreno Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_306 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640306', (SELECT id_carrera FROM iia), 5
  FROM u_306
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_307 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640307@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Solis Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_307 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640307', (SELECT id_carrera FROM iia), 6
  FROM u_307
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_308 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640308@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Manuel',
    'Flores Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_308 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640308', (SELECT id_carrera FROM iia), 5
  FROM u_308
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_309 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640309@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Natalia',
    'Reyes Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_309 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640309', (SELECT id_carrera FROM iia), 2
  FROM u_309
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_310 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640310@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Flores Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_310 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640310', (SELECT id_carrera FROM iia), 1
  FROM u_310
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_311 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640311@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Fernando',
    'Vazquez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_311 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640311', (SELECT id_carrera FROM iia), 6
  FROM u_311
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_312 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640312@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Sara',
    'Martinez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_312 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640312', (SELECT id_carrera FROM iia), 4
  FROM u_312
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_313 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640313@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Ximena',
    'Contreras Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_313 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640313', (SELECT id_carrera FROM iia), 10
  FROM u_313
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_314 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640314@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Garcia Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_314 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640314', (SELECT id_carrera FROM iia), 7
  FROM u_314
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_315 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640315@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Sofia',
    'Ramirez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_315 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640315', (SELECT id_carrera FROM iia), 6
  FROM u_315
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_316 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640316@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Ramirez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_316 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640316', (SELECT id_carrera FROM iia), 5
  FROM u_316
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_317 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640317@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Javier',
    'Sandoval Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_317 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640317', (SELECT id_carrera FROM iia), 4
  FROM u_317
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_318 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640318@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Diana',
    'Ramos Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_318 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640318', (SELECT id_carrera FROM iia), 9
  FROM u_318
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_319 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640319@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Gutierrez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_319 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640319', (SELECT id_carrera FROM iia), 10
  FROM u_319
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_320 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640320@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena Roberto',
    'Estrada Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_320 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640320', (SELECT id_carrera FROM iia), 7
  FROM u_320
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_321 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640321@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Rodriguez Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_321 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640321', (SELECT id_carrera FROM iia), 9
  FROM u_321
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_322 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640322@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Rojas Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_322 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640322', (SELECT id_carrera FROM iia), 6
  FROM u_322
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_323 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640323@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Miguel',
    'Rojas Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_323 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640323', (SELECT id_carrera FROM iia), 7
  FROM u_323
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_324 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640324@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Natalia',
    'Perez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_324 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640324', (SELECT id_carrera FROM iia), 2
  FROM u_324
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_325 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640325@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Romero Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_325 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640325', (SELECT id_carrera FROM iia), 6
  FROM u_325
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_326 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640326@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Maria',
    'Estrada Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_326 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640326', (SELECT id_carrera FROM iia), 10
  FROM u_326
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_327 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640327@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Javier',
    'Velazquez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_327 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640327', (SELECT id_carrera FROM iia), 7
  FROM u_327
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_328 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640328@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Andrea',
    'Ruiz Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_328 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640328', (SELECT id_carrera FROM iia), 6
  FROM u_328
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_329 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640329@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Adrian',
    'Estrada Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_329 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640329', (SELECT id_carrera FROM iia), 7
  FROM u_329
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_330 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640330@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Estrada Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_330 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640330', (SELECT id_carrera FROM iia), 4
  FROM u_330
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_331 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640331@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Pedro',
    'De La Cruz Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_331 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640331', (SELECT id_carrera FROM iia), 3
  FROM u_331
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_332 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640332@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Gomez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_332 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640332', (SELECT id_carrera FROM iia), 5
  FROM u_332
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_333 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640333@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Regina',
    'Ortiz Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_333 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640333', (SELECT id_carrera FROM iia), 8
  FROM u_333
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_334 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640334@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Torres Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_334 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640334', (SELECT id_carrera FROM iia), 7
  FROM u_334
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_335 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640335@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Velazquez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_335 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640335', (SELECT id_carrera FROM iia), 5
  FROM u_335
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_336 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640336@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Carlos',
    'Santiago Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_336 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640336', (SELECT id_carrera FROM iia), 4
  FROM u_336
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_337 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640337@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Salazar Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_337 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640337', (SELECT id_carrera FROM iia), 8
  FROM u_337
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_338 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640338@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Sanchez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_338 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640338', (SELECT id_carrera FROM iia), 7
  FROM u_338
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_339 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640339@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Avila Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_339 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640339', (SELECT id_carrera FROM iia), 9
  FROM u_339
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_340 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640340@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Lopez Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_340 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640340', (SELECT id_carrera FROM iia), 8
  FROM u_340
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_341 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640341@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis David',
    'Aguilar Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_341 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640341', (SELECT id_carrera FROM iia), 2
  FROM u_341
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_342 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640342@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Hector',
    'Mendoza Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_342 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640342', (SELECT id_carrera FROM iia), 8
  FROM u_342
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_343 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640343@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Martinez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_343 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640343', (SELECT id_carrera FROM iia), 1
  FROM u_343
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_344 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640344@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Velazquez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_344 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640344', (SELECT id_carrera FROM iia), 2
  FROM u_344
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_345 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640345@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Alexis',
    'Soto Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_345 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640345', (SELECT id_carrera FROM iia), 3
  FROM u_345
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_346 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640346@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Jose',
    'Lopez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_346 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640346', (SELECT id_carrera FROM iia), 4
  FROM u_346
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_347 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640347@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Andrea',
    'Contreras Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_347 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640347', (SELECT id_carrera FROM iia), 10
  FROM u_347
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_348 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640348@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Munoz Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_348 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640348', (SELECT id_carrera FROM iia), 6
  FROM u_348
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_349 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640349@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Mendoza Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_349 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640349', (SELECT id_carrera FROM iia), 6
  FROM u_349
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_300, a_301, a_302, a_303, a_304, a_305, a_306, a_307, a_308, a_309, a_310, a_311, a_312, a_313, a_314, a_315, a_316, a_317, a_318, a_319, a_320, a_321, a_322, a_323, a_324, a_325, a_326, a_327, a_328, a_329, a_330, a_331, a_332, a_333, a_334, a_335, a_336, a_337, a_338, a_339, a_340, a_341, a_342, a_343, a_344, a_345, a_346, a_347, a_348, a_349;

-- Batch 350 to 400
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_350 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640350@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Jorge',
    'Estrada Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_350 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640350', (SELECT id_carrera FROM iia), 1
  FROM u_350
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_351 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640351@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Valentina',
    'Avila Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_351 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640351', (SELECT id_carrera FROM iia), 2
  FROM u_351
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_352 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640352@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Martinez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_352 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640352', (SELECT id_carrera FROM iia), 3
  FROM u_352
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_353 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640353@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Jorge',
    'Vazquez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_353 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640353', (SELECT id_carrera FROM iia), 8
  FROM u_353
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_354 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640354@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Vazquez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_354 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640354', (SELECT id_carrera FROM iia), 8
  FROM u_354
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_355 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640355@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Diego',
    'Jimenez Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_355 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640355', (SELECT id_carrera FROM iia), 10
  FROM u_355
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_356 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640356@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Adrian',
    'Ruiz Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_356 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640356', (SELECT id_carrera FROM iia), 2
  FROM u_356
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_357 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640357@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Rivera Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_357 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640357', (SELECT id_carrera FROM iia), 4
  FROM u_357
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_358 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640358@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Camila',
    'Munoz Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_358 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640358', (SELECT id_carrera FROM iia), 10
  FROM u_358
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_359 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640359@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Gonzalez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_359 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640359', (SELECT id_carrera FROM iia), 2
  FROM u_359
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_360 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640360@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Avila Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_360 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640360', (SELECT id_carrera FROM iia), 1
  FROM u_360
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_361 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640361@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Carmen',
    'Guerrero Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_361 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640361', (SELECT id_carrera FROM iia), 5
  FROM u_361
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_362 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640362@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Gomez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_362 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640362', (SELECT id_carrera FROM iia), 6
  FROM u_362
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_363 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640363@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Marquez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_363 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640363', (SELECT id_carrera FROM iia), 5
  FROM u_363
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_364 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640364@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Adrian',
    'Guzman Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_364 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640364', (SELECT id_carrera FROM iia), 6
  FROM u_364
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_365 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640365@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Hernandez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_365 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640365', (SELECT id_carrera FROM iia), 7
  FROM u_365
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_366 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640366@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Chavez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_366 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640366', (SELECT id_carrera FROM iia), 5
  FROM u_366
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_367 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640367@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Jose',
    'Guzman Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_367 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640367', (SELECT id_carrera FROM iia), 3
  FROM u_367
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_368 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640368@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Ramos Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_368 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640368', (SELECT id_carrera FROM iia), 1
  FROM u_368
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_369 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640369@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Sofia',
    'Vazquez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_369 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640369', (SELECT id_carrera FROM iia), 1
  FROM u_369
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_370 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640370@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena Sofia',
    'Velazquez Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_370 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640370', (SELECT id_carrera FROM iia), 2
  FROM u_370
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_371 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640371@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Daniel',
    'Martinez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_371 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640371', (SELECT id_carrera FROM iia), 2
  FROM u_371
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_372 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640372@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Manuel',
    'Rojas Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_372 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640372', (SELECT id_carrera FROM iia), 7
  FROM u_372
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_373 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640373@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Miguel',
    'Vazquez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_373 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640373', (SELECT id_carrera FROM iia), 1
  FROM u_373
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_374 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640374@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Adrian',
    'Gomez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_374 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640374', (SELECT id_carrera FROM iia), 6
  FROM u_374
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_375 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640375@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Ramirez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_375 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640375', (SELECT id_carrera FROM iia), 4
  FROM u_375
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_376 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640376@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Julia',
    'Cruz Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_376 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640376', (SELECT id_carrera FROM iia), 9
  FROM u_376
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_377 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640377@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Rivera Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_377 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640377', (SELECT id_carrera FROM iia), 7
  FROM u_377
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_378 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640378@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Perez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_378 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640378', (SELECT id_carrera FROM iia), 2
  FROM u_378
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_379 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640379@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Fernanda',
    'Delgado Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_379 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640379', (SELECT id_carrera FROM iia), 3
  FROM u_379
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_380 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640380@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Santiago Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_380 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640380', (SELECT id_carrera FROM iia), 7
  FROM u_380
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_381 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640381@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Carlos',
    'Contreras Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_381 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640381', (SELECT id_carrera FROM iia), 9
  FROM u_381
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_382 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640382@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Ruiz Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_382 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640382', (SELECT id_carrera FROM iia), 3
  FROM u_382
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_383 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640383@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Francisco',
    'Avila Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_383 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640383', (SELECT id_carrera FROM iia), 6
  FROM u_383
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_384 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640384@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Sandoval Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_384 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640384', (SELECT id_carrera FROM iia), 10
  FROM u_384
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_385 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640385@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Miguel',
    'Rojas Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_385 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640385', (SELECT id_carrera FROM iia), 8
  FROM u_385
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_386 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640386@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Velazquez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_386 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640386', (SELECT id_carrera FROM iia), 1
  FROM u_386
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_387 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640387@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Gomez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_387 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640387', (SELECT id_carrera FROM iia), 7
  FROM u_387
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_388 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640388@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Luis',
    'Silva Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_388 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640388', (SELECT id_carrera FROM iia), 6
  FROM u_388
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_389 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640389@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Fernando',
    'Reyes Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_389 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640389', (SELECT id_carrera FROM iia), 3
  FROM u_389
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_390 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640390@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Solis Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_390 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640390', (SELECT id_carrera FROM iia), 4
  FROM u_390
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_391 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640391@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Lopez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_391 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640391', (SELECT id_carrera FROM iia), 4
  FROM u_391
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_392 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640392@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena David',
    'Soto Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_392 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640392', (SELECT id_carrera FROM iia), 6
  FROM u_392
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_393 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640393@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Manuel',
    'Morales Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_393 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640393', (SELECT id_carrera FROM iia), 10
  FROM u_393
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_394 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640394@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Rojas Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_394 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640394', (SELECT id_carrera FROM iia), 3
  FROM u_394
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_395 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640395@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Garcia Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_395 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640395', (SELECT id_carrera FROM iia), 8
  FROM u_395
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_396 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640396@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Valentina',
    'Guzman Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_396 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640396', (SELECT id_carrera FROM iia), 8
  FROM u_396
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_397 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640397@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Paula',
    'Castillo Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_397 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640397', (SELECT id_carrera FROM iia), 6
  FROM u_397
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_398 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640398@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Roberto',
    'Martinez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_398 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640398', (SELECT id_carrera FROM iia), 4
  FROM u_398
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_399 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640399@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Valeria',
    'Ruiz Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_399 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640399', (SELECT id_carrera FROM iia), 9
  FROM u_399
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_350, a_351, a_352, a_353, a_354, a_355, a_356, a_357, a_358, a_359, a_360, a_361, a_362, a_363, a_364, a_365, a_366, a_367, a_368, a_369, a_370, a_371, a_372, a_373, a_374, a_375, a_376, a_377, a_378, a_379, a_380, a_381, a_382, a_383, a_384, a_385, a_386, a_387, a_388, a_389, a_390, a_391, a_392, a_393, a_394, a_395, a_396, a_397, a_398, a_399;

-- Batch 400 to 450
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_400 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640400@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Gonzalez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_400 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640400', (SELECT id_carrera FROM iia), 8
  FROM u_400
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_401 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640401@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Juan',
    'Delgado Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_401 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640401', (SELECT id_carrera FROM iia), 9
  FROM u_401
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_402 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640402@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Lopez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_402 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640402', (SELECT id_carrera FROM iia), 3
  FROM u_402
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_403 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640403@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Daniela',
    'Silva Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_403 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640403', (SELECT id_carrera FROM iia), 4
  FROM u_403
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_404 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640404@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Tellez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_404 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640404', (SELECT id_carrera FROM iia), 1
  FROM u_404
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_405 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640405@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Jorge',
    'Garcia Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_405 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640405', (SELECT id_carrera FROM iia), 7
  FROM u_405
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_406 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640406@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Jesus',
    'Santiago Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_406 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640406', (SELECT id_carrera FROM iia), 1
  FROM u_406
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_407 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640407@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Eduardo',
    'Garcia Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_407 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640407', (SELECT id_carrera FROM iia), 2
  FROM u_407
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_408 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640408@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Ximena',
    'Aguilar Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_408 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640408', (SELECT id_carrera FROM iia), 2
  FROM u_408
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_409 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640409@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Sergio',
    'Jimenez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_409 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640409', (SELECT id_carrera FROM iia), 1
  FROM u_409
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_410 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640410@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Contreras Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_410 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640410', (SELECT id_carrera FROM iia), 3
  FROM u_410
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_411 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640411@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Maria',
    'Avila Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_411 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640411', (SELECT id_carrera FROM iia), 10
  FROM u_411
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_412 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640412@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Roberto',
    'Chavez Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_412 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640412', (SELECT id_carrera FROM iia), 8
  FROM u_412
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_413 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640413@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Alejandro',
    'Soto Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_413 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640413', (SELECT id_carrera FROM iia), 7
  FROM u_413
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_414 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640414@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Adrian',
    'Rodriguez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_414 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640414', (SELECT id_carrera FROM iia), 8
  FROM u_414
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_415 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640415@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Jorge',
    'Romero Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_415 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640415', (SELECT id_carrera FROM iia), 10
  FROM u_415
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_416 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640416@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Alvarez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_416 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640416', (SELECT id_carrera FROM iia), 5
  FROM u_416
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_417 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640417@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena Julia',
    'Garcia Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_417 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640417', (SELECT id_carrera FROM iia), 8
  FROM u_417
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_418 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640418@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Castillo Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_418 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640418', (SELECT id_carrera FROM iia), 6
  FROM u_418
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_419 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640419@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Ramirez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_419 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640419', (SELECT id_carrera FROM iia), 5
  FROM u_419
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_420 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640420@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Jesus',
    'Hernandez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_420 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640420', (SELECT id_carrera FROM iia), 6
  FROM u_420
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_421 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640421@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres Jorge',
    'Cruz Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_421 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640421', (SELECT id_carrera FROM iia), 10
  FROM u_421
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_422 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640422@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Renata',
    'Guzman Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_422 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640422', (SELECT id_carrera FROM iia), 7
  FROM u_422
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_423 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640423@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Javier',
    'De La Cruz Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_423 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640423', (SELECT id_carrera FROM iia), 4
  FROM u_423
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_424 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640424@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Rivera Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_424 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640424', (SELECT id_carrera FROM iia), 10
  FROM u_424
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_425 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640425@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Ana',
    'Ruiz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_425 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640425', (SELECT id_carrera FROM iia), 6
  FROM u_425
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_426 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640426@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Oscar',
    'Alvarez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_426 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640426', (SELECT id_carrera FROM iia), 6
  FROM u_426
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_427 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640427@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Francisco',
    'Estrada Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_427 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640427', (SELECT id_carrera FROM iia), 3
  FROM u_427
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_428 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640428@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Delgado Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_428 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640428', (SELECT id_carrera FROM iia), 1
  FROM u_428
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_429 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640429@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Miguel',
    'Silva Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_429 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640429', (SELECT id_carrera FROM iia), 4
  FROM u_429
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_430 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640430@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Dominguez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_430 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640430', (SELECT id_carrera FROM iia), 7
  FROM u_430
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_431 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640431@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Guerrero Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_431 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640431', (SELECT id_carrera FROM iia), 7
  FROM u_431
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_432 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640432@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Martinez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_432 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640432', (SELECT id_carrera FROM iia), 4
  FROM u_432
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_433 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640433@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Renata',
    'Tellez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_433 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640433', (SELECT id_carrera FROM iia), 4
  FROM u_433
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_434 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640434@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Roberto',
    'Morales Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_434 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640434', (SELECT id_carrera FROM iia), 6
  FROM u_434
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_435 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640435@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Jorge',
    'Marquez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_435 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640435', (SELECT id_carrera FROM iia), 4
  FROM u_435
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_436 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640436@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Paula',
    'Guzman Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_436 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640436', (SELECT id_carrera FROM iia), 6
  FROM u_436
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_437 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640437@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Garcia Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_437 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640437', (SELECT id_carrera FROM iia), 7
  FROM u_437
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_438 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640438@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Gutierrez Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_438 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640438', (SELECT id_carrera FROM iia), 8
  FROM u_438
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_439 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640439@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Natalia',
    'Santiago Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_439 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640439', (SELECT id_carrera FROM iia), 10
  FROM u_439
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_440 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640440@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Sergio',
    'Romero Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_440 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640440', (SELECT id_carrera FROM iia), 10
  FROM u_440
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_441 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640441@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Carlos',
    'Hernandez Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_441 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640441', (SELECT id_carrera FROM iia), 8
  FROM u_441
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_442 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640442@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Velazquez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_442 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640442', (SELECT id_carrera FROM iia), 5
  FROM u_442
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_443 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640443@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Regina',
    'Martinez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_443 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640443', (SELECT id_carrera FROM iia), 2
  FROM u_443
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_444 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640444@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Adrian',
    'Velazquez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_444 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640444', (SELECT id_carrera FROM iia), 5
  FROM u_444
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_445 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640445@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Guerrero Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_445 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640445', (SELECT id_carrera FROM iia), 5
  FROM u_445
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_446 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640446@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Garcia Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_446 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640446', (SELECT id_carrera FROM iia), 2
  FROM u_446
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_447 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640447@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Lucia',
    'Mendoza Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_447 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640447', (SELECT id_carrera FROM iia), 5
  FROM u_447
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_448 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640448@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Alvarez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_448 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640448', (SELECT id_carrera FROM iia), 3
  FROM u_448
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_449 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640449@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Alejandro',
    'Aguilar Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_449 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640449', (SELECT id_carrera FROM iia), 2
  FROM u_449
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_400, a_401, a_402, a_403, a_404, a_405, a_406, a_407, a_408, a_409, a_410, a_411, a_412, a_413, a_414, a_415, a_416, a_417, a_418, a_419, a_420, a_421, a_422, a_423, a_424, a_425, a_426, a_427, a_428, a_429, a_430, a_431, a_432, a_433, a_434, a_435, a_436, a_437, a_438, a_439, a_440, a_441, a_442, a_443, a_444, a_445, a_446, a_447, a_448, a_449;

-- Batch 450 to 500
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_450 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640450@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Soto Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_450 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640450', (SELECT id_carrera FROM iia), 5
  FROM u_450
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_451 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640451@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan',
    'Hernandez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_451 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640451', (SELECT id_carrera FROM iia), 5
  FROM u_451
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_452 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640452@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena Daniela',
    'Contreras Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_452 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640452', (SELECT id_carrera FROM iia), 2
  FROM u_452
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_453 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640453@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Sofia',
    'Torres Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_453 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640453', (SELECT id_carrera FROM iia), 8
  FROM u_453
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_454 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640454@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Sofia',
    'Ramirez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_454 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640454', (SELECT id_carrera FROM iia), 1
  FROM u_454
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_455 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640455@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Sergio',
    'Rojas Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_455 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640455', (SELECT id_carrera FROM iia), 7
  FROM u_455
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_456 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640456@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Delgado Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_456 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640456', (SELECT id_carrera FROM iia), 1
  FROM u_456
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_457 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640457@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Andres',
    'Hernandez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_457 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640457', (SELECT id_carrera FROM iia), 1
  FROM u_457
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_458 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640458@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Reyes Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_458 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640458', (SELECT id_carrera FROM iia), 7
  FROM u_458
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_459 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640459@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Daniel',
    'Perez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_459 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640459', (SELECT id_carrera FROM iia), 6
  FROM u_459
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_460 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640460@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Jimenez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_460 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640460', (SELECT id_carrera FROM iia), 5
  FROM u_460
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_461 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640461@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Perez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_461 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640461', (SELECT id_carrera FROM iia), 5
  FROM u_461
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_462 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640462@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula Camila',
    'Reyes Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_462 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640462', (SELECT id_carrera FROM iia), 9
  FROM u_462
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_463 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640463@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Rivera Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_463 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640463', (SELECT id_carrera FROM iia), 8
  FROM u_463
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_464 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640464@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Francisco',
    'Moreno Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_464 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640464', (SELECT id_carrera FROM iia), 10
  FROM u_464
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_465 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640465@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Paula',
    'Rivera Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_465 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640465', (SELECT id_carrera FROM iia), 5
  FROM u_465
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_466 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640466@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Munoz Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_466 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640466', (SELECT id_carrera FROM iia), 5
  FROM u_466
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_467 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640467@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula Carlos',
    'Contreras Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_467 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640467', (SELECT id_carrera FROM iia), 1
  FROM u_467
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_468 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640468@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Vargas Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_468 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640468', (SELECT id_carrera FROM iia), 7
  FROM u_468
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_469 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640469@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Eduardo',
    'Hernandez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_469 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640469', (SELECT id_carrera FROM iia), 6
  FROM u_469
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_470 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640470@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Rojas Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_470 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640470', (SELECT id_carrera FROM iia), 9
  FROM u_470
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_471 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640471@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Torres Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_471 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640471', (SELECT id_carrera FROM iia), 1
  FROM u_471
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_472 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640472@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Castillo Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_472 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640472', (SELECT id_carrera FROM iia), 10
  FROM u_472
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_473 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640473@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Lopez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_473 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640473', (SELECT id_carrera FROM iia), 3
  FROM u_473
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_474 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640474@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Fernando',
    'Alvarez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_474 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640474', (SELECT id_carrera FROM iia), 3
  FROM u_474
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_475 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640475@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Ana',
    'Flores Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_475 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640475', (SELECT id_carrera FROM iia), 2
  FROM u_475
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_476 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640476@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Salazar Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_476 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640476', (SELECT id_carrera FROM iia), 3
  FROM u_476
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_477 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640477@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Jorge',
    'Sandoval De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_477 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640477', (SELECT id_carrera FROM iia), 5
  FROM u_477
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_478 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640478@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Ramirez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_478 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640478', (SELECT id_carrera FROM iia), 10
  FROM u_478
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_479 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640479@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Javier',
    'Reyes Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_479 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640479', (SELECT id_carrera FROM iia), 1
  FROM u_479
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_480 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640480@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Maria',
    'Soto Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_480 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640480', (SELECT id_carrera FROM iia), 5
  FROM u_480
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_481 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640481@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Natalia',
    'Diaz Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_481 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640481', (SELECT id_carrera FROM iia), 10
  FROM u_481
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_482 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640482@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Julia',
    'Estrada Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_482 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640482', (SELECT id_carrera FROM iia), 6
  FROM u_482
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_483 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640483@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Elena',
    'Gonzalez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_483 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640483', (SELECT id_carrera FROM iia), 8
  FROM u_483
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_484 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640484@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Antonio',
    'Sanchez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_484 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640484', (SELECT id_carrera FROM iia), 8
  FROM u_484
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_485 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640485@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Diana',
    'Perez Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_485 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640485', (SELECT id_carrera FROM iia), 5
  FROM u_485
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_486 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640486@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Juan',
    'Rivera Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_486 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640486', (SELECT id_carrera FROM iia), 7
  FROM u_486
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_487 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640487@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Lucia',
    'Delgado Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_487 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640487', (SELECT id_carrera FROM iia), 4
  FROM u_487
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_488 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640488@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Romero Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_488 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640488', (SELECT id_carrera FROM iia), 7
  FROM u_488
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_489 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640489@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Soto Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_489 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640489', (SELECT id_carrera FROM iia), 2
  FROM u_489
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_490 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640490@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Silva Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_490 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640490', (SELECT id_carrera FROM iia), 8
  FROM u_490
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_491 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640491@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Valeria',
    'Vazquez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_491 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640491', (SELECT id_carrera FROM iia), 10
  FROM u_491
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_492 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640492@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Mariana',
    'Castillo Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_492 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640492', (SELECT id_carrera FROM iia), 3
  FROM u_492
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_493 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640493@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Adrian',
    'Silva Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_493 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640493', (SELECT id_carrera FROM iia), 4
  FROM u_493
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_494 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640494@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Javier',
    'Solis Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_494 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640494', (SELECT id_carrera FROM iia), 2
  FROM u_494
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_495 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640495@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Hernandez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_495 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640495', (SELECT id_carrera FROM iia), 3
  FROM u_495
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_496 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640496@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Hernandez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_496 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640496', (SELECT id_carrera FROM iia), 9
  FROM u_496
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_497 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640497@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Regina',
    'Velazquez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_497 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640497', (SELECT id_carrera FROM iia), 5
  FROM u_497
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_498 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640498@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Gabriela',
    'Castillo Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_498 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640498', (SELECT id_carrera FROM iia), 3
  FROM u_498
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_499 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640499@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Lucia',
    'Romero Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_499 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640499', (SELECT id_carrera FROM iia), 8
  FROM u_499
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_450, a_451, a_452, a_453, a_454, a_455, a_456, a_457, a_458, a_459, a_460, a_461, a_462, a_463, a_464, a_465, a_466, a_467, a_468, a_469, a_470, a_471, a_472, a_473, a_474, a_475, a_476, a_477, a_478, a_479, a_480, a_481, a_482, a_483, a_484, a_485, a_486, a_487, a_488, a_489, a_490, a_491, a_492, a_493, a_494, a_495, a_496, a_497, a_498, a_499;

-- Batch 500 to 550
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_500 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640500@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Gutierrez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_500 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640500', (SELECT id_carrera FROM iia), 8
  FROM u_500
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_501 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640501@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Victoria',
    'Morales Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_501 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640501', (SELECT id_carrera FROM iia), 2
  FROM u_501
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_502 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640502@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Camila',
    'Estrada Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_502 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640502', (SELECT id_carrera FROM iia), 6
  FROM u_502
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_503 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640503@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Natalia',
    'Cruz Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_503 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640503', (SELECT id_carrera FROM iia), 6
  FROM u_503
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_504 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640504@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Solis Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_504 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640504', (SELECT id_carrera FROM iia), 6
  FROM u_504
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_505 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640505@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Eduardo',
    'Tellez Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_505 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640505', (SELECT id_carrera FROM iia), 7
  FROM u_505
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_506 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640506@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Ramos Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_506 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640506', (SELECT id_carrera FROM iia), 3
  FROM u_506
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_507 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640507@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Romero Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_507 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640507', (SELECT id_carrera FROM iia), 6
  FROM u_507
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_508 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640508@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Javier',
    'Velazquez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_508 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640508', (SELECT id_carrera FROM iia), 4
  FROM u_508
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_509 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640509@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Ortiz Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_509 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640509', (SELECT id_carrera FROM iia), 5
  FROM u_509
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_510 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640510@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia David',
    'Hernandez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_510 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640510', (SELECT id_carrera FROM iia), 7
  FROM u_510
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_511 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640511@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Ricardo',
    'Vazquez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_511 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640511', (SELECT id_carrera FROM iia), 6
  FROM u_511
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_512 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640512@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Fernando',
    'Sanchez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_512 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640512', (SELECT id_carrera FROM iia), 2
  FROM u_512
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_513 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640513@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Paula',
    'De La Cruz Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_513 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640513', (SELECT id_carrera FROM iia), 4
  FROM u_513
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_514 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640514@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Jesus',
    'Soto Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_514 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640514', (SELECT id_carrera FROM iia), 4
  FROM u_514
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_515 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640515@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Mariana',
    'Martinez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_515 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640515', (SELECT id_carrera FROM iia), 9
  FROM u_515
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_516 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640516@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Regina',
    'Contreras Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_516 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640516', (SELECT id_carrera FROM iia), 3
  FROM u_516
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_517 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640517@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Estrada Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_517 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640517', (SELECT id_carrera FROM iia), 7
  FROM u_517
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_518 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640518@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Salazar Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_518 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640518', (SELECT id_carrera FROM iia), 5
  FROM u_518
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_519 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640519@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Alexis',
    'Silva Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_519 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640519', (SELECT id_carrera FROM iia), 2
  FROM u_519
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_520 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640520@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Isabella',
    'Ruiz Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_520 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640520', (SELECT id_carrera FROM iia), 4
  FROM u_520
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_521 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640521@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Ruiz Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_521 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640521', (SELECT id_carrera FROM iia), 9
  FROM u_521
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_522 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640522@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Gabriela',
    'Rodriguez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_522 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640522', (SELECT id_carrera FROM iia), 10
  FROM u_522
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_523 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640523@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Munoz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_523 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640523', (SELECT id_carrera FROM iia), 9
  FROM u_523
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_524 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640524@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Daniela',
    'Velazquez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_524 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640524', (SELECT id_carrera FROM iia), 9
  FROM u_524
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_525 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640525@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Diego',
    'Ramirez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_525 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640525', (SELECT id_carrera FROM iia), 1
  FROM u_525
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_526 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640526@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Alvarez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_526 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640526', (SELECT id_carrera FROM iia), 2
  FROM u_526
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_527 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640527@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Ramirez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_527 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640527', (SELECT id_carrera FROM iia), 6
  FROM u_527
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_528 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640528@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Dominguez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_528 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640528', (SELECT id_carrera FROM iia), 9
  FROM u_528
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_529 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640529@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Javier',
    'Lopez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_529 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640529', (SELECT id_carrera FROM iia), 6
  FROM u_529
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_530 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640530@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Daniel',
    'Sandoval Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_530 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640530', (SELECT id_carrera FROM iia), 8
  FROM u_530
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_531 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640531@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Alvarez Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_531 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640531', (SELECT id_carrera FROM iia), 3
  FROM u_531
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_532 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640532@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Moreno Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_532 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640532', (SELECT id_carrera FROM iia), 9
  FROM u_532
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_533 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640533@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Renata',
    'Mendoza Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_533 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640533', (SELECT id_carrera FROM iia), 9
  FROM u_533
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_534 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640534@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Maria',
    'Dominguez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_534 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640534', (SELECT id_carrera FROM iia), 2
  FROM u_534
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_535 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640535@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Sanchez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_535 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640535', (SELECT id_carrera FROM iia), 9
  FROM u_535
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_536 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640536@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Guzman Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_536 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640536', (SELECT id_carrera FROM iia), 7
  FROM u_536
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_537 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640537@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Victoria',
    'Silva Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_537 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640537', (SELECT id_carrera FROM iia), 10
  FROM u_537
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_538 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640538@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Camila',
    'Sandoval Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_538 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640538', (SELECT id_carrera FROM iia), 1
  FROM u_538
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_539 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640539@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Hernandez Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_539 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640539', (SELECT id_carrera FROM iia), 5
  FROM u_539
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_540 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640540@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Elena',
    'Gomez Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_540 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640540', (SELECT id_carrera FROM iia), 4
  FROM u_540
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_541 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640541@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Salazar Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_541 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640541', (SELECT id_carrera FROM iia), 6
  FROM u_541
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_542 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640542@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Javier',
    'Ramirez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_542 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640542', (SELECT id_carrera FROM iia), 6
  FROM u_542
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_543 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640543@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Torres Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_543 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640543', (SELECT id_carrera FROM iia), 3
  FROM u_543
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_544 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640544@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan',
    'Hernandez Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_544 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640544', (SELECT id_carrera FROM iia), 6
  FROM u_544
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_545 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640545@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Valentina',
    'Salazar Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_545 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640545', (SELECT id_carrera FROM iia), 2
  FROM u_545
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_546 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640546@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena Andres',
    'Alvarez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_546 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640546', (SELECT id_carrera FROM iia), 7
  FROM u_546
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_547 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640547@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Garcia Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_547 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640547', (SELECT id_carrera FROM iia), 10
  FROM u_547
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_548 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640548@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Martinez Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_548 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640548', (SELECT id_carrera FROM iia), 1
  FROM u_548
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_549 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640549@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Vazquez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_549 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640549', (SELECT id_carrera FROM iia), 6
  FROM u_549
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_500, a_501, a_502, a_503, a_504, a_505, a_506, a_507, a_508, a_509, a_510, a_511, a_512, a_513, a_514, a_515, a_516, a_517, a_518, a_519, a_520, a_521, a_522, a_523, a_524, a_525, a_526, a_527, a_528, a_529, a_530, a_531, a_532, a_533, a_534, a_535, a_536, a_537, a_538, a_539, a_540, a_541, a_542, a_543, a_544, a_545, a_546, a_547, a_548, a_549;

-- Batch 550 to 600
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_550 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640550@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Jimenez Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_550 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640550', (SELECT id_carrera FROM iia), 10
  FROM u_550
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_551 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640551@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Adrian',
    'De La Cruz Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_551 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640551', (SELECT id_carrera FROM iia), 9
  FROM u_551
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_552 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640552@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina David',
    'Contreras Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_552 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640552', (SELECT id_carrera FROM iia), 7
  FROM u_552
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_553 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640553@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Lucia',
    'Gutierrez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_553 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640553', (SELECT id_carrera FROM iia), 4
  FROM u_553
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_554 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640554@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Alvarez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_554 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640554', (SELECT id_carrera FROM iia), 9
  FROM u_554
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_555 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640555@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Perez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_555 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640555', (SELECT id_carrera FROM iia), 3
  FROM u_555
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_556 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640556@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Guzman Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_556 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640556', (SELECT id_carrera FROM iia), 5
  FROM u_556
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_557 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640557@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Guerrero Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_557 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640557', (SELECT id_carrera FROM iia), 5
  FROM u_557
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_558 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640558@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Vargas Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_558 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640558', (SELECT id_carrera FROM iia), 10
  FROM u_558
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_559 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640559@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Velazquez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_559 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640559', (SELECT id_carrera FROM iia), 1
  FROM u_559
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_560 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640560@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Elena',
    'Vargas Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_560 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640560', (SELECT id_carrera FROM iia), 6
  FROM u_560
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_561 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640561@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula Jorge',
    'Rojas Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_561 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640561', (SELECT id_carrera FROM iia), 3
  FROM u_561
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_562 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640562@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Paula',
    'Vazquez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_562 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640562', (SELECT id_carrera FROM iia), 3
  FROM u_562
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_563 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640563@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Sandoval Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_563 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640563', (SELECT id_carrera FROM iia), 5
  FROM u_563
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_564 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640564@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Francisco',
    'Dominguez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_564 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640564', (SELECT id_carrera FROM iia), 1
  FROM u_564
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_565 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640565@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Guerrero Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_565 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640565', (SELECT id_carrera FROM iia), 1
  FROM u_565
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_566 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640566@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Camila',
    'Cruz Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_566 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640566', (SELECT id_carrera FROM iia), 7
  FROM u_566
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_567 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640567@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Ricardo',
    'Ortiz Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_567 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640567', (SELECT id_carrera FROM iia), 10
  FROM u_567
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_568 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640568@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Vazquez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_568 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640568', (SELECT id_carrera FROM iia), 3
  FROM u_568
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_569 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640569@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Tellez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_569 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640569', (SELECT id_carrera FROM iia), 6
  FROM u_569
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_570 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640570@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Moreno Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_570 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640570', (SELECT id_carrera FROM iia), 8
  FROM u_570
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_571 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640571@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Juan',
    'Salazar Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_571 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640571', (SELECT id_carrera FROM iia), 7
  FROM u_571
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_572 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640572@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Fernando',
    'Cruz Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_572 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640572', (SELECT id_carrera FROM iia), 7
  FROM u_572
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_573 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640573@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Pedro',
    'Santiago Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_573 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640573', (SELECT id_carrera FROM iia), 6
  FROM u_573
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_574 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640574@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Guerrero Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_574 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640574', (SELECT id_carrera FROM iia), 3
  FROM u_574
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_575 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640575@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Solis Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_575 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640575', (SELECT id_carrera FROM iia), 3
  FROM u_575
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_576 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640576@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Oscar',
    'Velazquez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_576 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640576', (SELECT id_carrera FROM iia), 7
  FROM u_576
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_577 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640577@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Antonio',
    'Perez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_577 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640577', (SELECT id_carrera FROM iia), 10
  FROM u_577
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_578 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640578@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Juan',
    'Torres Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_578 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640578', (SELECT id_carrera FROM iia), 7
  FROM u_578
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_579 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640579@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Valeria',
    'Chavez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_579 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640579', (SELECT id_carrera FROM iia), 8
  FROM u_579
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_580 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640580@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Jimenez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_580 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640580', (SELECT id_carrera FROM iia), 7
  FROM u_580
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_581 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640581@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Diaz Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_581 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640581', (SELECT id_carrera FROM iia), 2
  FROM u_581
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_582 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640582@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Valentina',
    'Rodriguez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_582 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640582', (SELECT id_carrera FROM iia), 10
  FROM u_582
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_583 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640583@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Silva Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_583 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640583', (SELECT id_carrera FROM iia), 6
  FROM u_583
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_584 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640584@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Marquez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_584 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640584', (SELECT id_carrera FROM iia), 4
  FROM u_584
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_585 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640585@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan',
    'Alvarez Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_585 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640585', (SELECT id_carrera FROM iia), 9
  FROM u_585
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_586 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640586@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Paula',
    'Rivera Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_586 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640586', (SELECT id_carrera FROM iia), 1
  FROM u_586
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_587 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640587@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Munoz Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_587 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640587', (SELECT id_carrera FROM iia), 4
  FROM u_587
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_588 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640588@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Victoria',
    'Cruz Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_588 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640588', (SELECT id_carrera FROM iia), 2
  FROM u_588
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_589 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640589@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Fernando',
    'Rodriguez Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_589 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640589', (SELECT id_carrera FROM iia), 2
  FROM u_589
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_590 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640590@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Valentina',
    'Rodriguez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_590 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640590', (SELECT id_carrera FROM iia), 5
  FROM u_590
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_591 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640591@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Elena',
    'Castillo Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_591 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640591', (SELECT id_carrera FROM iia), 5
  FROM u_591
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_592 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640592@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Oscar',
    'Tellez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_592 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640592', (SELECT id_carrera FROM iia), 1
  FROM u_592
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_593 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640593@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Daniel',
    'Tellez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_593 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640593', (SELECT id_carrera FROM iia), 3
  FROM u_593
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_594 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640594@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Vazquez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_594 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640594', (SELECT id_carrera FROM iia), 8
  FROM u_594
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_595 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640595@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Jimenez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_595 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640595', (SELECT id_carrera FROM iia), 7
  FROM u_595
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_596 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640596@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Torres Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_596 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640596', (SELECT id_carrera FROM iia), 9
  FROM u_596
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_597 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640597@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Rodriguez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_597 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640597', (SELECT id_carrera FROM iia), 6
  FROM u_597
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_598 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640598@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Juan',
    'Perez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_598 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640598', (SELECT id_carrera FROM iia), 4
  FROM u_598
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_599 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640599@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Estrada Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_599 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640599', (SELECT id_carrera FROM iia), 8
  FROM u_599
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_550, a_551, a_552, a_553, a_554, a_555, a_556, a_557, a_558, a_559, a_560, a_561, a_562, a_563, a_564, a_565, a_566, a_567, a_568, a_569, a_570, a_571, a_572, a_573, a_574, a_575, a_576, a_577, a_578, a_579, a_580, a_581, a_582, a_583, a_584, a_585, a_586, a_587, a_588, a_589, a_590, a_591, a_592, a_593, a_594, a_595, a_596, a_597, a_598, a_599;

-- Batch 600 to 650
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_600 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640600@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Castillo Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_600 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640600', (SELECT id_carrera FROM iia), 6
  FROM u_600
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_601 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640601@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Jose',
    'Flores Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_601 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640601', (SELECT id_carrera FROM iia), 7
  FROM u_601
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_602 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640602@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Delgado Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_602 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640602', (SELECT id_carrera FROM iia), 7
  FROM u_602
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_603 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640603@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Aguilar Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_603 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640603', (SELECT id_carrera FROM iia), 4
  FROM u_603
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_604 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640604@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Victoria',
    'Diaz Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_604 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640604', (SELECT id_carrera FROM iia), 4
  FROM u_604
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_605 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640605@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Moreno Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_605 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640605', (SELECT id_carrera FROM iia), 9
  FROM u_605
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_606 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640606@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Jorge',
    'Contreras Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_606 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640606', (SELECT id_carrera FROM iia), 9
  FROM u_606
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_607 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640607@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Diaz Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_607 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640607', (SELECT id_carrera FROM iia), 6
  FROM u_607
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_608 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640608@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Solis Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_608 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640608', (SELECT id_carrera FROM iia), 6
  FROM u_608
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_609 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640609@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Guerrero Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_609 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640609', (SELECT id_carrera FROM iia), 6
  FROM u_609
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_610 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640610@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Moreno Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_610 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640610', (SELECT id_carrera FROM iia), 9
  FROM u_610
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_611 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640611@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Velazquez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_611 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640611', (SELECT id_carrera FROM iia), 3
  FROM u_611
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_612 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640612@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Camila',
    'Flores Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_612 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640612', (SELECT id_carrera FROM iia), 9
  FROM u_612
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_613 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640613@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Sandoval Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_613 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640613', (SELECT id_carrera FROM iia), 6
  FROM u_613
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_614 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640614@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Gabriela',
    'Avila Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_614 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640614', (SELECT id_carrera FROM iia), 3
  FROM u_614
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_615 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640615@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Alejandro',
    'Solis Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_615 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640615', (SELECT id_carrera FROM iia), 7
  FROM u_615
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_616 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640616@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Adrian',
    'Solis Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_616 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640616', (SELECT id_carrera FROM iia), 5
  FROM u_616
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_617 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640617@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Soto Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_617 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640617', (SELECT id_carrera FROM iia), 3
  FROM u_617
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_618 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640618@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Salazar Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_618 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640618', (SELECT id_carrera FROM iia), 3
  FROM u_618
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_619 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640619@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Perez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_619 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640619', (SELECT id_carrera FROM iia), 9
  FROM u_619
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_620 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640620@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Silva Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_620 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640620', (SELECT id_carrera FROM iia), 8
  FROM u_620
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_621 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640621@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Estrada Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_621 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640621', (SELECT id_carrera FROM iia), 1
  FROM u_621
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_622 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640622@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Morales Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_622 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640622', (SELECT id_carrera FROM iia), 7
  FROM u_622
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_623 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640623@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Mariana',
    'Gomez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_623 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640623', (SELECT id_carrera FROM iia), 7
  FROM u_623
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_624 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640624@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Elena',
    'Diaz Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_624 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640624', (SELECT id_carrera FROM iia), 8
  FROM u_624
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_625 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640625@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Salazar Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_625 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640625', (SELECT id_carrera FROM iia), 1
  FROM u_625
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_626 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640626@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Estrada Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_626 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640626', (SELECT id_carrera FROM iia), 3
  FROM u_626
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_627 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640627@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Oscar',
    'Vargas Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_627 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640627', (SELECT id_carrera FROM iia), 7
  FROM u_627
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_628 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640628@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres Roberto',
    'Santiago Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_628 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640628', (SELECT id_carrera FROM iia), 6
  FROM u_628
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_629 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640629@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Gomez Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_629 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640629', (SELECT id_carrera FROM iia), 1
  FROM u_629
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_630 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640630@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Carmen',
    'Ramirez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_630 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640630', (SELECT id_carrera FROM iia), 4
  FROM u_630
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_631 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640631@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Javier',
    'Tellez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_631 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640631', (SELECT id_carrera FROM iia), 8
  FROM u_631
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_632 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640632@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Avila Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_632 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640632', (SELECT id_carrera FROM iia), 3
  FROM u_632
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_633 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640633@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Ramirez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_633 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640633', (SELECT id_carrera FROM iia), 1
  FROM u_633
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_634 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640634@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Diego',
    'Tellez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_634 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640634', (SELECT id_carrera FROM iia), 7
  FROM u_634
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_635 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640635@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Valentina',
    'Munoz Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_635 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640635', (SELECT id_carrera FROM iia), 7
  FROM u_635
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_636 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640636@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Vargas Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_636 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640636', (SELECT id_carrera FROM iia), 5
  FROM u_636
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_637 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640637@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Velazquez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_637 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640637', (SELECT id_carrera FROM iia), 1
  FROM u_637
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_638 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640638@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Victoria',
    'De La Cruz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_638 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640638', (SELECT id_carrera FROM iia), 10
  FROM u_638
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_639 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640639@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Ricardo',
    'Sandoval Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_639 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640639', (SELECT id_carrera FROM iia), 4
  FROM u_639
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_640 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640640@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Contreras Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_640 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640640', (SELECT id_carrera FROM iia), 7
  FROM u_640
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_641 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640641@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Romero Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_641 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640641', (SELECT id_carrera FROM iia), 3
  FROM u_641
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_642 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640642@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Tellez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_642 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640642', (SELECT id_carrera FROM iia), 6
  FROM u_642
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_643 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640643@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Daniel',
    'Hernandez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_643 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640643', (SELECT id_carrera FROM iia), 9
  FROM u_643
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_644 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640644@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio',
    'Ruiz Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_644 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640644', (SELECT id_carrera FROM iia), 4
  FROM u_644
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_645 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640645@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Rivera Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_645 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640645', (SELECT id_carrera FROM iia), 1
  FROM u_645
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_646 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640646@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Silva Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_646 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640646', (SELECT id_carrera FROM iia), 2
  FROM u_646
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_647 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640647@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Diego',
    'Dominguez Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_647 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640647', (SELECT id_carrera FROM iia), 2
  FROM u_647
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_648 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640648@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Maria',
    'Reyes Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_648 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640648', (SELECT id_carrera FROM iia), 5
  FROM u_648
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_649 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640649@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Oscar',
    'Solis Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_649 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640649', (SELECT id_carrera FROM iia), 6
  FROM u_649
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_600, a_601, a_602, a_603, a_604, a_605, a_606, a_607, a_608, a_609, a_610, a_611, a_612, a_613, a_614, a_615, a_616, a_617, a_618, a_619, a_620, a_621, a_622, a_623, a_624, a_625, a_626, a_627, a_628, a_629, a_630, a_631, a_632, a_633, a_634, a_635, a_636, a_637, a_638, a_639, a_640, a_641, a_642, a_643, a_644, a_645, a_646, a_647, a_648, a_649;

-- Batch 650 to 700
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_650 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640650@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Elena',
    'Mendoza Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_650 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640650', (SELECT id_carrera FROM iia), 3
  FROM u_650
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_651 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640651@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Moreno Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_651 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640651', (SELECT id_carrera FROM iia), 1
  FROM u_651
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_652 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640652@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Morales Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_652 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640652', (SELECT id_carrera FROM iia), 1
  FROM u_652
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_653 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640653@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Valentina',
    'Tellez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_653 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640653', (SELECT id_carrera FROM iia), 9
  FROM u_653
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_654 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640654@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Carlos',
    'Perez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_654 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640654', (SELECT id_carrera FROM iia), 3
  FROM u_654
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_655 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640655@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Tellez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_655 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640655', (SELECT id_carrera FROM iia), 7
  FROM u_655
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_656 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640656@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Alexis',
    'Rojas Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_656 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640656', (SELECT id_carrera FROM iia), 4
  FROM u_656
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_657 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640657@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Ramos Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_657 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640657', (SELECT id_carrera FROM iia), 7
  FROM u_657
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_658 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640658@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Torres Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_658 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640658', (SELECT id_carrera FROM iia), 8
  FROM u_658
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_659 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640659@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Adrian',
    'Santiago Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_659 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640659', (SELECT id_carrera FROM iia), 7
  FROM u_659
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_660 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640660@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Estrada Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_660 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640660', (SELECT id_carrera FROM iia), 5
  FROM u_660
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_661 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640661@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Martinez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_661 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640661', (SELECT id_carrera FROM iia), 5
  FROM u_661
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_662 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640662@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Fernando',
    'Alvarez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_662 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640662', (SELECT id_carrera FROM iia), 1
  FROM u_662
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_663 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640663@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Solis Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_663 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640663', (SELECT id_carrera FROM iia), 4
  FROM u_663
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_664 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640664@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Ricardo',
    'Rodriguez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_664 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640664', (SELECT id_carrera FROM iia), 1
  FROM u_664
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_665 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640665@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Valentina',
    'Marquez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_665 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640665', (SELECT id_carrera FROM iia), 10
  FROM u_665
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_666 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640666@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Hernandez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_666 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640666', (SELECT id_carrera FROM iia), 2
  FROM u_666
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_667 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640667@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Contreras Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_667 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640667', (SELECT id_carrera FROM iia), 1
  FROM u_667
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_668 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640668@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara Maria',
    'Marquez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_668 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640668', (SELECT id_carrera FROM iia), 9
  FROM u_668
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_669 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640669@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Daniela',
    'Ramirez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_669 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640669', (SELECT id_carrera FROM iia), 2
  FROM u_669
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_670 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640670@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Contreras Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_670 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640670', (SELECT id_carrera FROM iia), 7
  FROM u_670
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_671 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640671@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Javier',
    'Rojas Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_671 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640671', (SELECT id_carrera FROM iia), 6
  FROM u_671
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_672 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640672@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Martinez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_672 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640672', (SELECT id_carrera FROM iia), 7
  FROM u_672
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_673 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640673@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Guzman Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_673 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640673', (SELECT id_carrera FROM iia), 9
  FROM u_673
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_674 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640674@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Jesus',
    'Salazar Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_674 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640674', (SELECT id_carrera FROM iia), 10
  FROM u_674
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_675 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640675@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Gabriela',
    'Vazquez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_675 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640675', (SELECT id_carrera FROM iia), 2
  FROM u_675
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_676 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640676@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Aguilar Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_676 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640676', (SELECT id_carrera FROM iia), 8
  FROM u_676
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_677 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640677@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Eduardo',
    'Lopez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_677 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640677', (SELECT id_carrera FROM iia), 5
  FROM u_677
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_678 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640678@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Julia',
    'Gomez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_678 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640678', (SELECT id_carrera FROM iia), 6
  FROM u_678
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_679 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640679@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Jorge',
    'Sanchez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_679 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640679', (SELECT id_carrera FROM iia), 2
  FROM u_679
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_680 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640680@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Valeria',
    'De La Cruz Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_680 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640680', (SELECT id_carrera FROM iia), 7
  FROM u_680
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_681 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640681@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Salazar Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_681 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640681', (SELECT id_carrera FROM iia), 7
  FROM u_681
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_682 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640682@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Andres',
    'Chavez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_682 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640682', (SELECT id_carrera FROM iia), 10
  FROM u_682
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_683 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640683@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Eduardo',
    'Vazquez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_683 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640683', (SELECT id_carrera FROM iia), 9
  FROM u_683
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_684 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640684@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Lucia',
    'Salazar Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_684 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640684', (SELECT id_carrera FROM iia), 8
  FROM u_684
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_685 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640685@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Natalia',
    'Torres Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_685 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640685', (SELECT id_carrera FROM iia), 7
  FROM u_685
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_686 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640686@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Victoria',
    'Dominguez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_686 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640686', (SELECT id_carrera FROM iia), 2
  FROM u_686
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_687 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640687@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Torres Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_687 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640687', (SELECT id_carrera FROM iia), 5
  FROM u_687
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_688 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640688@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Julia',
    'Velazquez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_688 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640688', (SELECT id_carrera FROM iia), 6
  FROM u_688
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_689 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640689@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio',
    'Salazar Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_689 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640689', (SELECT id_carrera FROM iia), 9
  FROM u_689
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_690 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640690@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sara',
    'Morales Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_690 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640690', (SELECT id_carrera FROM iia), 3
  FROM u_690
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_691 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640691@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres Victoria',
    'Martinez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_691 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640691', (SELECT id_carrera FROM iia), 9
  FROM u_691
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_692 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640692@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Rodriguez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_692 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640692', (SELECT id_carrera FROM iia), 6
  FROM u_692
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_693 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640693@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Sanchez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_693 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640693', (SELECT id_carrera FROM iia), 7
  FROM u_693
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_694 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640694@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Gabriela',
    'Alvarez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_694 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640694', (SELECT id_carrera FROM iia), 9
  FROM u_694
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_695 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640695@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Alexis',
    'Ramirez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_695 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640695', (SELECT id_carrera FROM iia), 2
  FROM u_695
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_696 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640696@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Guerrero Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_696 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640696', (SELECT id_carrera FROM iia), 7
  FROM u_696
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_697 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640697@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Francisco',
    'Marquez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_697 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640697', (SELECT id_carrera FROM iia), 2
  FROM u_697
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_698 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640698@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Rojas Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_698 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640698', (SELECT id_carrera FROM iia), 3
  FROM u_698
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_699 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640699@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Javier',
    'Ortiz Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_699 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640699', (SELECT id_carrera FROM iia), 5
  FROM u_699
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_650, a_651, a_652, a_653, a_654, a_655, a_656, a_657, a_658, a_659, a_660, a_661, a_662, a_663, a_664, a_665, a_666, a_667, a_668, a_669, a_670, a_671, a_672, a_673, a_674, a_675, a_676, a_677, a_678, a_679, a_680, a_681, a_682, a_683, a_684, a_685, a_686, a_687, a_688, a_689, a_690, a_691, a_692, a_693, a_694, a_695, a_696, a_697, a_698, a_699;

-- Batch 700 to 750
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_700 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640700@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Cruz Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_700 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640700', (SELECT id_carrera FROM iia), 9
  FROM u_700
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_701 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640701@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Soto Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_701 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640701', (SELECT id_carrera FROM iia), 4
  FROM u_701
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_702 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640702@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Natalia',
    'Contreras De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_702 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640702', (SELECT id_carrera FROM iia), 4
  FROM u_702
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_703 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640703@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'De La Cruz Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_703 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640703', (SELECT id_carrera FROM iia), 6
  FROM u_703
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_704 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640704@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Velazquez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_704 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640704', (SELECT id_carrera FROM iia), 1
  FROM u_704
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_705 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640705@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Sergio',
    'Flores Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_705 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640705', (SELECT id_carrera FROM iia), 9
  FROM u_705
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_706 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640706@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Renata',
    'Morales Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_706 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640706', (SELECT id_carrera FROM iia), 9
  FROM u_706
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_707 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640707@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Morales Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_707 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640707', (SELECT id_carrera FROM iia), 2
  FROM u_707
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_708 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640708@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Diana',
    'Velazquez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_708 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640708', (SELECT id_carrera FROM iia), 3
  FROM u_708
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_709 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640709@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Lucia',
    'Estrada Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_709 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640709', (SELECT id_carrera FROM iia), 2
  FROM u_709
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_710 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640710@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Francisco',
    'Solis Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_710 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640710', (SELECT id_carrera FROM iia), 2
  FROM u_710
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_711 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640711@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Ricardo',
    'Morales Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_711 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640711', (SELECT id_carrera FROM iia), 7
  FROM u_711
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_712 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640712@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Jimenez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_712 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640712', (SELECT id_carrera FROM iia), 9
  FROM u_712
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_713 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640713@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Carlos',
    'Tellez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_713 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640713', (SELECT id_carrera FROM iia), 9
  FROM u_713
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_714 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640714@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Jesus',
    'Vargas Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_714 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640714', (SELECT id_carrera FROM iia), 10
  FROM u_714
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_715 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640715@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Rivera Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_715 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640715', (SELECT id_carrera FROM iia), 3
  FROM u_715
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_716 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640716@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Guzman Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_716 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640716', (SELECT id_carrera FROM iia), 9
  FROM u_716
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_717 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640717@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Elena',
    'Estrada Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_717 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640717', (SELECT id_carrera FROM iia), 3
  FROM u_717
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_718 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640718@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Aguilar Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_718 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640718', (SELECT id_carrera FROM iia), 6
  FROM u_718
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_719 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640719@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina David',
    'Rojas Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_719 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640719', (SELECT id_carrera FROM iia), 6
  FROM u_719
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_720 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640720@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan',
    'Martinez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_720 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640720', (SELECT id_carrera FROM iia), 9
  FROM u_720
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_721 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640721@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Diego',
    'De La Cruz Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_721 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640721', (SELECT id_carrera FROM iia), 8
  FROM u_721
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_722 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640722@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Cruz Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_722 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640722', (SELECT id_carrera FROM iia), 5
  FROM u_722
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_723 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640723@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Flores Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_723 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640723', (SELECT id_carrera FROM iia), 4
  FROM u_723
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_724 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640724@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Cruz Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_724 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640724', (SELECT id_carrera FROM iia), 4
  FROM u_724
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_725 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640725@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Flores Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_725 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640725', (SELECT id_carrera FROM iia), 10
  FROM u_725
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_726 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640726@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Martinez Aguilar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_726 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640726', (SELECT id_carrera FROM iia), 1
  FROM u_726
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_727 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640727@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Jimenez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_727 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640727', (SELECT id_carrera FROM iia), 4
  FROM u_727
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_728 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640728@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Torres Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_728 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640728', (SELECT id_carrera FROM iia), 4
  FROM u_728
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_729 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640729@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Castillo Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_729 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640729', (SELECT id_carrera FROM iia), 6
  FROM u_729
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_730 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640730@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Munoz Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_730 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640730', (SELECT id_carrera FROM iia), 9
  FROM u_730
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_731 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640731@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula Adrian',
    'Contreras Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_731 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640731', (SELECT id_carrera FROM iia), 1
  FROM u_731
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_732 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640732@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Gomez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_732 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640732', (SELECT id_carrera FROM iia), 1
  FROM u_732
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_733 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640733@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Maria',
    'Ramirez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_733 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640733', (SELECT id_carrera FROM iia), 4
  FROM u_733
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_734 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640734@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Antonio',
    'Sandoval Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_734 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640734', (SELECT id_carrera FROM iia), 10
  FROM u_734
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_735 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640735@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Francisco',
    'Marquez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_735 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640735', (SELECT id_carrera FROM iia), 4
  FROM u_735
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_736 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640736@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Sandoval Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_736 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640736', (SELECT id_carrera FROM iia), 1
  FROM u_736
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_737 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640737@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Sofia',
    'Rojas Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_737 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640737', (SELECT id_carrera FROM iia), 10
  FROM u_737
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_738 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640738@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Victoria',
    'Morales Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_738 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640738', (SELECT id_carrera FROM iia), 9
  FROM u_738
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_739 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640739@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'De La Cruz Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_739 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640739', (SELECT id_carrera FROM iia), 8
  FROM u_739
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_740 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640740@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Jorge',
    'Garcia Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_740 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640740', (SELECT id_carrera FROM iia), 1
  FROM u_740
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_741 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640741@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Salazar Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_741 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640741', (SELECT id_carrera FROM iia), 1
  FROM u_741
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_742 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640742@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Jimenez Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_742 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640742', (SELECT id_carrera FROM iia), 7
  FROM u_742
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_743 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640743@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Regina',
    'Flores Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_743 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640743', (SELECT id_carrera FROM iia), 4
  FROM u_743
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_744 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640744@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Contreras Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_744 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640744', (SELECT id_carrera FROM iia), 2
  FROM u_744
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_745 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640745@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Garcia Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_745 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640745', (SELECT id_carrera FROM iia), 9
  FROM u_745
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_746 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640746@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Elena',
    'Rivera Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_746 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640746', (SELECT id_carrera FROM iia), 8
  FROM u_746
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_747 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640747@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Manuel',
    'Ruiz Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_747 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640747', (SELECT id_carrera FROM iia), 10
  FROM u_747
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_748 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640748@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Daniela',
    'Munoz Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_748 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640748', (SELECT id_carrera FROM iia), 5
  FROM u_748
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_749 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640749@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Salazar Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_749 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640749', (SELECT id_carrera FROM iia), 6
  FROM u_749
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_700, a_701, a_702, a_703, a_704, a_705, a_706, a_707, a_708, a_709, a_710, a_711, a_712, a_713, a_714, a_715, a_716, a_717, a_718, a_719, a_720, a_721, a_722, a_723, a_724, a_725, a_726, a_727, a_728, a_729, a_730, a_731, a_732, a_733, a_734, a_735, a_736, a_737, a_738, a_739, a_740, a_741, a_742, a_743, a_744, a_745, a_746, a_747, a_748, a_749;

-- Batch 750 to 800
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_750 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640750@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Soto Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_750 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640750', (SELECT id_carrera FROM iia), 7
  FROM u_750
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_751 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640751@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro David',
    'Garcia Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_751 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640751', (SELECT id_carrera FROM iia), 7
  FROM u_751
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_752 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640752@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio',
    'Ramirez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_752 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640752', (SELECT id_carrera FROM iia), 5
  FROM u_752
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_753 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640753@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Aguilar Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_753 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640753', (SELECT id_carrera FROM iia), 3
  FROM u_753
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_754 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640754@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Mendoza Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_754 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640754', (SELECT id_carrera FROM iia), 8
  FROM u_754
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_755 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640755@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Maria',
    'Martinez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_755 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640755', (SELECT id_carrera FROM iia), 10
  FROM u_755
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_756 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640756@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Guzman Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_756 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640756', (SELECT id_carrera FROM iia), 2
  FROM u_756
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_757 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640757@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Antonio',
    'Rodriguez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_757 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640757', (SELECT id_carrera FROM iia), 4
  FROM u_757
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_758 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640758@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana Sergio',
    'Rodriguez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_758 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640758', (SELECT id_carrera FROM iia), 2
  FROM u_758
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_759 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640759@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres Roberto',
    'Rivera Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_759 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640759', (SELECT id_carrera FROM iia), 6
  FROM u_759
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_760 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640760@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Ramirez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_760 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640760', (SELECT id_carrera FROM iia), 1
  FROM u_760
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_761 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640761@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Francisco',
    'Jimenez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_761 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640761', (SELECT id_carrera FROM iia), 4
  FROM u_761
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_762 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640762@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Lucia',
    'Morales Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_762 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640762', (SELECT id_carrera FROM iia), 10
  FROM u_762
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_763 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640763@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Munoz Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_763 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640763', (SELECT id_carrera FROM iia), 7
  FROM u_763
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_764 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640764@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Dominguez Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_764 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640764', (SELECT id_carrera FROM iia), 8
  FROM u_764
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_765 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640765@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Lopez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_765 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640765', (SELECT id_carrera FROM iia), 4
  FROM u_765
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_766 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640766@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Camila',
    'Rojas De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_766 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640766', (SELECT id_carrera FROM iia), 1
  FROM u_766
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_767 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640767@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Ricardo',
    'Guerrero Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_767 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640767', (SELECT id_carrera FROM iia), 8
  FROM u_767
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_768 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640768@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Oscar',
    'Ramirez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_768 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640768', (SELECT id_carrera FROM iia), 10
  FROM u_768
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_769 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640769@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Salazar Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_769 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640769', (SELECT id_carrera FROM iia), 10
  FROM u_769
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_770 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640770@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Castillo Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_770 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640770', (SELECT id_carrera FROM iia), 1
  FROM u_770
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_771 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640771@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Lopez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_771 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640771', (SELECT id_carrera FROM iia), 6
  FROM u_771
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_772 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640772@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Roberto',
    'Rodriguez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_772 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640772', (SELECT id_carrera FROM iia), 1
  FROM u_772
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_773 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640773@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Daniel',
    'Torres Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_773 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640773', (SELECT id_carrera FROM iia), 8
  FROM u_773
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_774 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640774@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Silva Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_774 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640774', (SELECT id_carrera FROM iia), 6
  FROM u_774
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_775 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640775@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Guerrero Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_775 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640775', (SELECT id_carrera FROM iia), 5
  FROM u_775
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_776 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640776@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Flores Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_776 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640776', (SELECT id_carrera FROM iia), 4
  FROM u_776
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_777 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640777@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Contreras Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_777 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640777', (SELECT id_carrera FROM iia), 1
  FROM u_777
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_778 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640778@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Maria',
    'Diaz Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_778 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640778', (SELECT id_carrera FROM iia), 6
  FROM u_778
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_779 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640779@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Victoria',
    'Jimenez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_779 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640779', (SELECT id_carrera FROM iia), 6
  FROM u_779
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_780 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640780@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Manuel',
    'Alvarez Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_780 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640780', (SELECT id_carrera FROM iia), 3
  FROM u_780
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_781 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640781@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Sanchez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_781 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640781', (SELECT id_carrera FROM iia), 7
  FROM u_781
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_782 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640782@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Javier',
    'Sandoval Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_782 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640782', (SELECT id_carrera FROM iia), 8
  FROM u_782
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_783 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640783@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Oscar',
    'Vazquez Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_783 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640783', (SELECT id_carrera FROM iia), 9
  FROM u_783
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_784 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640784@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Diego',
    'Ramos Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_784 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640784', (SELECT id_carrera FROM iia), 7
  FROM u_784
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_785 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640785@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Miguel',
    'Gonzalez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_785 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640785', (SELECT id_carrera FROM iia), 2
  FROM u_785
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_786 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640786@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Vargas Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_786 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640786', (SELECT id_carrera FROM iia), 6
  FROM u_786
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_787 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640787@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Rodriguez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_787 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640787', (SELECT id_carrera FROM iia), 10
  FROM u_787
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_788 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640788@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria',
    'Salazar Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_788 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640788', (SELECT id_carrera FROM iia), 7
  FROM u_788
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_789 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640789@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'Tellez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_789 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640789', (SELECT id_carrera FROM iia), 3
  FROM u_789
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_790 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640790@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Gabriela',
    'Ruiz Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_790 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640790', (SELECT id_carrera FROM iia), 6
  FROM u_790
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_791 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640791@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Pedro',
    'Reyes Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_791 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640791', (SELECT id_carrera FROM iia), 7
  FROM u_791
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_792 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640792@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Eduardo',
    'Castillo Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_792 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640792', (SELECT id_carrera FROM iia), 4
  FROM u_792
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_793 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640793@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'De La Cruz Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_793 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640793', (SELECT id_carrera FROM iia), 3
  FROM u_793
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_794 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640794@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Sofia',
    'Perez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_794 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640794', (SELECT id_carrera FROM iia), 6
  FROM u_794
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_795 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640795@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo Pedro',
    'Salazar Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_795 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640795', (SELECT id_carrera FROM iia), 7
  FROM u_795
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_796 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640796@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Daniel',
    'Delgado Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_796 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640796', (SELECT id_carrera FROM iia), 6
  FROM u_796
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_797 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640797@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Paula',
    'Solis Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_797 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640797', (SELECT id_carrera FROM iia), 3
  FROM u_797
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_798 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640798@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Manuel',
    'Rivera Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_798 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640798', (SELECT id_carrera FROM iia), 4
  FROM u_798
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_799 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640799@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Diego',
    'Avila Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_799 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640799', (SELECT id_carrera FROM iia), 7
  FROM u_799
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_750, a_751, a_752, a_753, a_754, a_755, a_756, a_757, a_758, a_759, a_760, a_761, a_762, a_763, a_764, a_765, a_766, a_767, a_768, a_769, a_770, a_771, a_772, a_773, a_774, a_775, a_776, a_777, a_778, a_779, a_780, a_781, a_782, a_783, a_784, a_785, a_786, a_787, a_788, a_789, a_790, a_791, a_792, a_793, a_794, a_795, a_796, a_797, a_798, a_799;

-- Batch 800 to 850
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_800 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640800@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Fernanda',
    'Perez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_800 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640800', (SELECT id_carrera FROM iia), 8
  FROM u_800
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_801 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640801@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen Ximena',
    'Mendoza Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_801 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640801', (SELECT id_carrera FROM iia), 9
  FROM u_801
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_802 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640802@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Chavez Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_802 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640802', (SELECT id_carrera FROM iia), 8
  FROM u_802
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_803 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640803@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Sandoval Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_803 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640803', (SELECT id_carrera FROM iia), 3
  FROM u_803
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_804 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640804@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Rodriguez Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_804 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640804', (SELECT id_carrera FROM iia), 1
  FROM u_804
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_805 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640805@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Rivera Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_805 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640805', (SELECT id_carrera FROM iia), 5
  FROM u_805
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_806 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640806@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Fernanda',
    'Tellez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_806 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640806', (SELECT id_carrera FROM iia), 10
  FROM u_806
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_807 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640807@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valeria Renata',
    'Mendoza Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_807 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640807', (SELECT id_carrera FROM iia), 5
  FROM u_807
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_808 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640808@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Dominguez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_808 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640808', (SELECT id_carrera FROM iia), 6
  FROM u_808
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_809 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640809@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Guerrero Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_809 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640809', (SELECT id_carrera FROM iia), 9
  FROM u_809
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_810 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640810@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Avila Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_810 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640810', (SELECT id_carrera FROM iia), 8
  FROM u_810
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_811 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640811@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Torres Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_811 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640811', (SELECT id_carrera FROM iia), 2
  FROM u_811
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_812 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640812@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco',
    'Guerrero De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_812 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640812', (SELECT id_carrera FROM iia), 1
  FROM u_812
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_813 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640813@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela',
    'Perez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_813 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640813', (SELECT id_carrera FROM iia), 1
  FROM u_813
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_814 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640814@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Lopez Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_814 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640814', (SELECT id_carrera FROM iia), 10
  FROM u_814
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_815 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640815@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Romero Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_815 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640815', (SELECT id_carrera FROM iia), 4
  FROM u_815
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_816 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640816@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Elena',
    'Perez Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_816 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640816', (SELECT id_carrera FROM iia), 6
  FROM u_816
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_817 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640817@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Sara',
    'Alvarez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_817 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640817', (SELECT id_carrera FROM iia), 1
  FROM u_817
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_818 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640818@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose',
    'Vazquez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_818 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640818', (SELECT id_carrera FROM iia), 2
  FROM u_818
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_819 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640819@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Gonzalez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_819 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640819', (SELECT id_carrera FROM iia), 8
  FROM u_819
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_820 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640820@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia',
    'Marquez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_820 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640820', (SELECT id_carrera FROM iia), 8
  FROM u_820
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_821 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640821@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel',
    'Tellez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_821 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640821', (SELECT id_carrera FROM iia), 9
  FROM u_821
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_822 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640822@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Ruiz Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_822 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640822', (SELECT id_carrera FROM iia), 4
  FROM u_822
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_823 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640823@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Reyes Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_823 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640823', (SELECT id_carrera FROM iia), 3
  FROM u_823
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_824 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640824@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Manuel',
    'Alvarez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_824 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640824', (SELECT id_carrera FROM iia), 9
  FROM u_824
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_825 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640825@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Eduardo',
    'Rodriguez Castillo',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_825 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640825', (SELECT id_carrera FROM iia), 9
  FROM u_825
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_826 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640826@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Garcia Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_826 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640826', (SELECT id_carrera FROM iia), 2
  FROM u_826
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_827 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640827@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Daniela',
    'Rojas Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_827 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640827', (SELECT id_carrera FROM iia), 5
  FROM u_827
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_828 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640828@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Alvarez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_828 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640828', (SELECT id_carrera FROM iia), 4
  FROM u_828
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_829 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640829@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Contreras Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_829 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640829', (SELECT id_carrera FROM iia), 2
  FROM u_829
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_830 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640830@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Valentina',
    'Silva Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_830 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640830', (SELECT id_carrera FROM iia), 8
  FROM u_830
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_831 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640831@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Sergio',
    'Diaz Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_831 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640831', (SELECT id_carrera FROM iia), 6
  FROM u_831
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_832 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640832@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Velazquez Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_832 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640832', (SELECT id_carrera FROM iia), 4
  FROM u_832
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_833 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640833@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Jose',
    'Vazquez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_833 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640833', (SELECT id_carrera FROM iia), 2
  FROM u_833
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_834 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640834@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Soto Chavez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_834 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640834', (SELECT id_carrera FROM iia), 10
  FROM u_834
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_835 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640835@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Daniela',
    'Estrada Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_835 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640835', (SELECT id_carrera FROM iia), 8
  FROM u_835
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_836 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640836@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Jesus',
    'Gutierrez Ortiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_836 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640836', (SELECT id_carrera FROM iia), 4
  FROM u_836
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_837 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640837@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro Jesus',
    'Lopez Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_837 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640837', (SELECT id_carrera FROM iia), 6
  FROM u_837
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_838 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640838@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Mariana',
    'Vargas Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_838 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640838', (SELECT id_carrera FROM iia), 3
  FROM u_838
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_839 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640839@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Lucia',
    'Delgado Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_839 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640839', (SELECT id_carrera FROM iia), 7
  FROM u_839
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_840 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640840@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Gonzalez Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_840 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640840', (SELECT id_carrera FROM iia), 7
  FROM u_840
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_841 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640841@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana Regina',
    'Tellez Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_841 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640841', (SELECT id_carrera FROM iia), 7
  FROM u_841
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_842 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640842@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Jimenez Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_842 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640842', (SELECT id_carrera FROM iia), 8
  FROM u_842
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_843 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640843@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Moreno Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_843 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640843', (SELECT id_carrera FROM iia), 9
  FROM u_843
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_844 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640844@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Soto Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_844 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640844', (SELECT id_carrera FROM iia), 6
  FROM u_844
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_845 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640845@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Santiago Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_845 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640845', (SELECT id_carrera FROM iia), 3
  FROM u_845
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_846 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640846@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Gomez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_846 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640846', (SELECT id_carrera FROM iia), 8
  FROM u_846
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_847 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640847@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Javier',
    'Hernandez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_847 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640847', (SELECT id_carrera FROM iia), 3
  FROM u_847
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_848 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640848@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Romero Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_848 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640848', (SELECT id_carrera FROM iia), 10
  FROM u_848
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_849 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640849@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Gomez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_849 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640849', (SELECT id_carrera FROM iia), 10
  FROM u_849
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_800, a_801, a_802, a_803, a_804, a_805, a_806, a_807, a_808, a_809, a_810, a_811, a_812, a_813, a_814, a_815, a_816, a_817, a_818, a_819, a_820, a_821, a_822, a_823, a_824, a_825, a_826, a_827, a_828, a_829, a_830, a_831, a_832, a_833, a_834, a_835, a_836, a_837, a_838, a_839, a_840, a_841, a_842, a_843, a_844, a_845, a_846, a_847, a_848, a_849;

-- Batch 850 to 900
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_850 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640850@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Perez Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_850 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640850', (SELECT id_carrera FROM iia), 9
  FROM u_850
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_851 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640851@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea Lucia',
    'Romero Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_851 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640851', (SELECT id_carrera FROM iia), 8
  FROM u_851
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_852 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640852@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Martinez Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_852 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640852', (SELECT id_carrera FROM iia), 10
  FROM u_852
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_853 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640853@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando Oscar',
    'Avila Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_853 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640853', (SELECT id_carrera FROM iia), 7
  FROM u_853
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_854 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640854@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Roberto',
    'Rojas Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_854 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640854', (SELECT id_carrera FROM iia), 5
  FROM u_854
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_855 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640855@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ximena',
    'Solis Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_855 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640855', (SELECT id_carrera FROM iia), 6
  FROM u_855
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_856 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640856@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Roberto',
    'Sanchez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_856 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640856', (SELECT id_carrera FROM iia), 9
  FROM u_856
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_857 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640857@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Mariana',
    'Moreno Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_857 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640857', (SELECT id_carrera FROM iia), 2
  FROM u_857
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_858 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640858@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernando',
    'Aguilar Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_858 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640858', (SELECT id_carrera FROM iia), 6
  FROM u_858
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_859 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640859@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Alejandro',
    'Salazar Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_859 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640859', (SELECT id_carrera FROM iia), 7
  FROM u_859
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_860 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640860@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda Fernanda',
    'Vargas Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_860 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640860', (SELECT id_carrera FROM iia), 1
  FROM u_860
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_861 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640861@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia',
    'Sanchez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_861 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640861', (SELECT id_carrera FROM iia), 5
  FROM u_861
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_862 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640862@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Jorge',
    'Ramirez Rojas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_862 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640862', (SELECT id_carrera FROM iia), 10
  FROM u_862
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_863 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640863@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian Gabriela',
    'Diaz Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_863 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640863', (SELECT id_carrera FROM iia), 1
  FROM u_863
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_864 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640864@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Aguilar Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_864 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640864', (SELECT id_carrera FROM iia), 1
  FROM u_864
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_865 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640865@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carmen',
    'Mendoza Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_865 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640865', (SELECT id_carrera FROM iia), 9
  FROM u_865
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_866 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640866@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Gonzalez Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_866 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640866', (SELECT id_carrera FROM iia), 4
  FROM u_866
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_867 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640867@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Salazar Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_867 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640867', (SELECT id_carrera FROM iia), 3
  FROM u_867
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_868 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640868@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Valeria',
    'Cruz Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_868 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640868', (SELECT id_carrera FROM iia), 4
  FROM u_868
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_869 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640869@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Valentina',
    'Dominguez Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_869 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640869', (SELECT id_carrera FROM iia), 9
  FROM u_869
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_870 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640870@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Reyes Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_870 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640870', (SELECT id_carrera FROM iia), 5
  FROM u_870
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_871 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640871@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Paula',
    'Moreno Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_871 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640871', (SELECT id_carrera FROM iia), 1
  FROM u_871
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_872 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640872@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Garcia Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_872 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640872', (SELECT id_carrera FROM iia), 7
  FROM u_872
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_873 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640873@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Carmen',
    'Contreras Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_873 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640873', (SELECT id_carrera FROM iia), 3
  FROM u_873
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_874 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640874@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Fernanda',
    'Alvarez Delgado',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_874 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640874', (SELECT id_carrera FROM iia), 8
  FROM u_874
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_875 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640875@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Antonio',
    'Moreno Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_875 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640875', (SELECT id_carrera FROM iia), 5
  FROM u_875
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_876 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640876@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Victoria',
    'Gomez Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_876 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640876', (SELECT id_carrera FROM iia), 1
  FROM u_876
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_877 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640877@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Hernandez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_877 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640877', (SELECT id_carrera FROM iia), 7
  FROM u_877
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_878 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640878@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Aguilar Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_878 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640878', (SELECT id_carrera FROM iia), 4
  FROM u_878
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_879 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640879@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Francisco Jorge',
    'Moreno Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_879 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640879', (SELECT id_carrera FROM iia), 3
  FROM u_879
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_880 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640880@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Carmen',
    'Flores Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_880 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640880', (SELECT id_carrera FROM iia), 4
  FROM u_880
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_881 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640881@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Jimenez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_881 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640881', (SELECT id_carrera FROM iia), 1
  FROM u_881
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_882 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640882@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena Julia',
    'Torres Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_882 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640882', (SELECT id_carrera FROM iia), 10
  FROM u_882
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_883 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640883@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Ximena',
    'Ortiz Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_883 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640883', (SELECT id_carrera FROM iia), 6
  FROM u_883
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_884 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640884@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Ana',
    'Gutierrez Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_884 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640884', (SELECT id_carrera FROM iia), 1
  FROM u_884
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_885 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640885@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel Julia',
    'Solis Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_885 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640885', (SELECT id_carrera FROM iia), 3
  FROM u_885
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_886 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640886@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Eduardo',
    'Diaz Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_886 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640886', (SELECT id_carrera FROM iia), 5
  FROM u_886
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_887 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640887@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Perez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_887 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640887', (SELECT id_carrera FROM iia), 7
  FROM u_887
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_888 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640888@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria',
    'Reyes Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_888 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640888', (SELECT id_carrera FROM iia), 1
  FROM u_888
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_889 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640889@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Romero Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_889 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640889', (SELECT id_carrera FROM iia), 8
  FROM u_889
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_890 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640890@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David',
    'Romero Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_890 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640890', (SELECT id_carrera FROM iia), 7
  FROM u_890
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_891 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640891@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Jesus',
    'Diaz Morales',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_891 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640891', (SELECT id_carrera FROM iia), 1
  FROM u_891
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_892 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640892@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia Fernando',
    'Marquez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_892 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640892', (SELECT id_carrera FROM iia), 6
  FROM u_892
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_893 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640893@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Manuel',
    'Ruiz Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_893 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640893', (SELECT id_carrera FROM iia), 4
  FROM u_893
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_894 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640894@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Sara',
    'Vargas Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_894 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640894', (SELECT id_carrera FROM iia), 9
  FROM u_894
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_895 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640895@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Silva Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_895 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640895', (SELECT id_carrera FROM iia), 4
  FROM u_895
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_896 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640896@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia',
    'Garcia Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_896 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640896', (SELECT id_carrera FROM iia), 10
  FROM u_896
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_897 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640897@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andres',
    'Jimenez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_897 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640897', (SELECT id_carrera FROM iia), 2
  FROM u_897
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_898 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640898@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Lucia',
    'Castillo Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_898 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640898', (SELECT id_carrera FROM iia), 5
  FROM u_898
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_899 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640899@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Alexis',
    'Sanchez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_899 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640899', (SELECT id_carrera FROM iia), 4
  FROM u_899
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_850, a_851, a_852, a_853, a_854, a_855, a_856, a_857, a_858, a_859, a_860, a_861, a_862, a_863, a_864, a_865, a_866, a_867, a_868, a_869, a_870, a_871, a_872, a_873, a_874, a_875, a_876, a_877, a_878, a_879, a_880, a_881, a_882, a_883, a_884, a_885, a_886, a_887, a_888, a_889, a_890, a_891, a_892, a_893, a_894, a_895, a_896, a_897, a_898, a_899;

-- Batch 900 to 950
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_900 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640900@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Carmen',
    'Silva Perez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_900 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640900', (SELECT id_carrera FROM iia), 6
  FROM u_900
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_901 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640901@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Natalia Valeria',
    'Gutierrez Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_901 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640901', (SELECT id_carrera FROM iia), 9
  FROM u_901
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_902 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640902@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela',
    'Garcia Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_902 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640902', (SELECT id_carrera FROM iia), 9
  FROM u_902
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_903 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640903@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Elena',
    'Rodriguez Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_903 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640903', (SELECT id_carrera FROM iia), 4
  FROM u_903
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_904 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640904@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Gabriela Manuel',
    'Avila Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_904 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640904', (SELECT id_carrera FROM iia), 7
  FROM u_904
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_905 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640905@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis Luis',
    'Tellez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_905 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640905', (SELECT id_carrera FROM iia), 3
  FROM u_905
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_906 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640906@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Ramirez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_906 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640906', (SELECT id_carrera FROM iia), 5
  FROM u_906
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_907 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640907@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio',
    'Delgado Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_907 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640907', (SELECT id_carrera FROM iia), 6
  FROM u_907
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_908 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640908@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Fernanda',
    'Sanchez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_908 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640908', (SELECT id_carrera FROM iia), 8
  FROM u_908
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_909 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640909@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro',
    'Martinez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_909 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640909', (SELECT id_carrera FROM iia), 5
  FROM u_909
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_910 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640910@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Fernando',
    'Mendoza Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_910 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640910', (SELECT id_carrera FROM iia), 1
  FROM u_910
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_911 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640911@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Adrian',
    'Munoz Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_911 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640911', (SELECT id_carrera FROM iia), 1
  FROM u_911
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_912 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640912@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Antonio Ana',
    'Cruz Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_912 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640912', (SELECT id_carrera FROM iia), 9
  FROM u_912
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_913 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640913@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Morales Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_913 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640913', (SELECT id_carrera FROM iia), 9
  FROM u_913
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_914 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640914@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Carmen',
    'Cruz Romero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_914 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640914', (SELECT id_carrera FROM iia), 9
  FROM u_914
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_915 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640915@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge Diego',
    'Ortiz Rivera',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_915 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640915', (SELECT id_carrera FROM iia), 6
  FROM u_915
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_916 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640916@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Daniela',
    'Flores Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_916 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640916', (SELECT id_carrera FROM iia), 8
  FROM u_916
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_917 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640917@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier',
    'Aguilar Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_917 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640917', (SELECT id_carrera FROM iia), 9
  FROM u_917
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_918 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640918@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alexis',
    'Alvarez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_918 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640918', (SELECT id_carrera FROM iia), 8
  FROM u_918
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_919 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640919@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Valeria',
    'Perez Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_919 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640919', (SELECT id_carrera FROM iia), 10
  FROM u_919
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_920 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640920@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Velazquez Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_920 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640920', (SELECT id_carrera FROM iia), 3
  FROM u_920
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_921 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640921@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Miguel',
    'Solis Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_921 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640921', (SELECT id_carrera FROM iia), 8
  FROM u_921
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_922 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640922@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus',
    'Alvarez Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_922 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640922', (SELECT id_carrera FROM iia), 5
  FROM u_922
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_923 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640923@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Silva Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_923 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640923', (SELECT id_carrera FROM iia), 3
  FROM u_923
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_924 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640924@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila',
    'Tellez Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_924 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640924', (SELECT id_carrera FROM iia), 6
  FROM u_924
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_925 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640925@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Perez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_925 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640925', (SELECT id_carrera FROM iia), 5
  FROM u_925
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_926 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640926@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Luis',
    'Ruiz Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_926 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640926', (SELECT id_carrera FROM iia), 9
  FROM u_926
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_927 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640927@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Moreno Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_927 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640927', (SELECT id_carrera FROM iia), 9
  FROM u_927
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_928 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640928@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ana',
    'Ramirez Ramos',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_928 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640928', (SELECT id_carrera FROM iia), 5
  FROM u_928
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_929 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640929@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina',
    'De La Cruz Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_929 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640929', (SELECT id_carrera FROM iia), 10
  FROM u_929
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_930 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640930@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Natalia',
    'Lopez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_930 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640930', (SELECT id_carrera FROM iia), 10
  FROM u_930
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_931 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640931@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Lucia',
    'Silva Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_931 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640931', (SELECT id_carrera FROM iia), 7
  FROM u_931
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_932 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640932@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Hernandez Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_932 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640932', (SELECT id_carrera FROM iia), 4
  FROM u_932
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_933 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640933@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jorge',
    'Vazquez Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_933 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640933', (SELECT id_carrera FROM iia), 4
  FROM u_933
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_934 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640934@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Salazar Tellez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_934 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640934', (SELECT id_carrera FROM iia), 5
  FROM u_934
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_935 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640935@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina',
    'Santiago Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_935 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640935', (SELECT id_carrera FROM iia), 8
  FROM u_935
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_936 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640936@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto Victoria',
    'Dominguez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_936 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640936', (SELECT id_carrera FROM iia), 3
  FROM u_936
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_937 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640937@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Reyes Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_937 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640937', (SELECT id_carrera FROM iia), 4
  FROM u_937
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_938 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640938@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar',
    'Gonzalez Mendoza',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_938 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640938', (SELECT id_carrera FROM iia), 4
  FROM u_938
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_939 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640939@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria Daniel',
    'Delgado Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_939 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640939', (SELECT id_carrera FROM iia), 5
  FROM u_939
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_940 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640940@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego Daniela',
    'Reyes Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_940 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640940', (SELECT id_carrera FROM iia), 1
  FROM u_940
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_941 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640941@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Diana',
    'Cruz Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_941 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640941', (SELECT id_carrera FROM iia), 3
  FROM u_941
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_942 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640942@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Maria',
    'Salazar Dominguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_942 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640942', (SELECT id_carrera FROM iia), 7
  FROM u_942
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_943 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640943@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Regina',
    'Chavez Jimenez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_943 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640943', (SELECT id_carrera FROM iia), 5
  FROM u_943
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_944 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640944@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Oscar Natalia',
    'Estrada Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_944 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640944', (SELECT id_carrera FROM iia), 7
  FROM u_944
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_945 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640945@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Valentina Hector',
    'Torres Avila',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_945 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640945', (SELECT id_carrera FROM iia), 2
  FROM u_945
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_946 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640946@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Jimenez Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_946 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640946', (SELECT id_carrera FROM iia), 2
  FROM u_946
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_947 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640947@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Flores Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_947 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640947', (SELECT id_carrera FROM iia), 4
  FROM u_947
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_948 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640948@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Javier Ricardo',
    'Moreno Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_948 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640948', (SELECT id_carrera FROM iia), 3
  FROM u_948
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_949 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640949@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Camila Natalia',
    'Aguilar Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_949 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640949', (SELECT id_carrera FROM iia), 5
  FROM u_949
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_900, a_901, a_902, a_903, a_904, a_905, a_906, a_907, a_908, a_909, a_910, a_911, a_912, a_913, a_914, a_915, a_916, a_917, a_918, a_919, a_920, a_921, a_922, a_923, a_924, a_925, a_926, a_927, a_928, a_929, a_930, a_931, a_932, a_933, a_934, a_935, a_936, a_937, a_938, a_939, a_940, a_941, a_942, a_943, a_944, a_945, a_946, a_947, a_948, a_949;

-- Batch 950 to 1000
WITH iia AS (
  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = 'IIA'
),
u_950 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640950@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Roberto',
    'Guzman Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_950 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640950', (SELECT id_carrera FROM iia), 2
  FROM u_950
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_951 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640951@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Ricardo',
    'Chavez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_951 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640951', (SELECT id_carrera FROM iia), 7
  FROM u_951
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_952 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640952@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos',
    'Aguilar Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_952 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640952', (SELECT id_carrera FROM iia), 1
  FROM u_952
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_953 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640953@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jose Diego',
    'Jimenez Salazar',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_953 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640953', (SELECT id_carrera FROM iia), 8
  FROM u_953
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_954 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640954@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Valentina',
    'Delgado Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_954 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640954', (SELECT id_carrera FROM iia), 4
  FROM u_954
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_955 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640955@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Mariana',
    'Gutierrez Solis',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_955 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640955', (SELECT id_carrera FROM iia), 9
  FROM u_955
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_956 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640956@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Julia',
    'Ortiz Sanchez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_956 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640956', (SELECT id_carrera FROM iia), 10
  FROM u_956
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_957 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640957@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella Daniela',
    'Ramos Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_957 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640957', (SELECT id_carrera FROM iia), 8
  FROM u_957
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_958 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640958@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel Javier',
    'Gutierrez Vargas',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_958 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640958', (SELECT id_carrera FROM iia), 2
  FROM u_958
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_959 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640959@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana Alexis',
    'Santiago Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_959 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640959', (SELECT id_carrera FROM iia), 10
  FROM u_959
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_960 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640960@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Adrian',
    'Ortiz Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_960 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640960', (SELECT id_carrera FROM iia), 8
  FROM u_960
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_961 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640961@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'David Renata',
    'Velazquez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_961 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640961', (SELECT id_carrera FROM iia), 8
  FROM u_961
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_962 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640962@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata Carmen',
    'Romero Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_962 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640962', (SELECT id_carrera FROM iia), 9
  FROM u_962
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_963 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640963@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Alejandro',
    'Alvarez Lopez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_963 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640963', (SELECT id_carrera FROM iia), 3
  FROM u_963
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_964 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640964@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniela Jorge',
    'Ramos Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_964 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640964', (SELECT id_carrera FROM iia), 6
  FROM u_964
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_965 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640965@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Andrea',
    'Delgado Gomez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_965 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640965', (SELECT id_carrera FROM iia), 10
  FROM u_965
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_966 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640966@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Victoria',
    'Flores Torres',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_966 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640966', (SELECT id_carrera FROM iia), 4
  FROM u_966
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_967 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640967@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo Sara',
    'Contreras Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_967 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640967', (SELECT id_carrera FROM iia), 7
  FROM u_967
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_968 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640968@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diana',
    'Gutierrez Sandoval',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_968 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640968', (SELECT id_carrera FROM iia), 4
  FROM u_968
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_969 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640969@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Julia Hector',
    'Delgado Flores',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_969 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640969', (SELECT id_carrera FROM iia), 5
  FROM u_969
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_970 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640970@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Andrea',
    'Ruiz Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_970 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640970', (SELECT id_carrera FROM iia), 4
  FROM u_970
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_971 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640971@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Martinez Estrada',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_971 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640971', (SELECT id_carrera FROM iia), 6
  FROM u_971
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_972 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640972@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Renata',
    'Salazar Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_972 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640972', (SELECT id_carrera FROM iia), 9
  FROM u_972
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_973 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640973@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Hernandez Soto',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_973 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640973', (SELECT id_carrera FROM iia), 6
  FROM u_973
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_974 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640974@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Manuel',
    'Ruiz Velazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_974 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640974', (SELECT id_carrera FROM iia), 9
  FROM u_974
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_975 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640975@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Daniel',
    'Dominguez Ramirez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_975 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640975', (SELECT id_carrera FROM iia), 10
  FROM u_975
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_976 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640976@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Eduardo',
    'Santiago Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_976 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640976', (SELECT id_carrera FROM iia), 7
  FROM u_976
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_977 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640977@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Perez Alvarez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_977 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640977', (SELECT id_carrera FROM iia), 10
  FROM u_977
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_978 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640978@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Camila',
    'Ramirez De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_978 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640978', (SELECT id_carrera FROM iia), 7
  FROM u_978
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_979 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640979@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Maria Pedro',
    'De La Cruz Moreno',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_979 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640979', (SELECT id_carrera FROM iia), 6
  FROM u_979
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_980 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640980@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Santiago Santiago',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_980 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640980', (SELECT id_carrera FROM iia), 10
  FROM u_980
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_981 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640981@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Pedro Alexis',
    'Romero Contreras',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_981 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640981', (SELECT id_carrera FROM iia), 4
  FROM u_981
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_982 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640982@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis Mariana',
    'Delgado Garcia',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_982 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640982', (SELECT id_carrera FROM iia), 6
  FROM u_982
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_983 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640983@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Paula',
    'Contreras Gonzalez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_983 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640983', (SELECT id_carrera FROM iia), 2
  FROM u_983
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_984 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640984@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Diego',
    'Flores Hernandez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_984 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640984', (SELECT id_carrera FROM iia), 5
  FROM u_984
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_985 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640985@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Regina Daniel',
    'Tellez Ruiz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_985 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640985', (SELECT id_carrera FROM iia), 10
  FROM u_985
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_986 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640986@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Mariana',
    'Garcia Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_986 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640986', (SELECT id_carrera FROM iia), 4
  FROM u_986
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_987 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640987@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Elena',
    'Alvarez Gutierrez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_987 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640987', (SELECT id_carrera FROM iia), 7
  FROM u_987
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_988 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2025640988@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Isabella',
    'Mendoza Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_988 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2025640988', (SELECT id_carrera FROM iia), 8
  FROM u_988
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_989 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640989@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sergio Julia',
    'Salazar Silva',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_989 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640989', (SELECT id_carrera FROM iia), 4
  FROM u_989
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_990 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640990@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Jesus Sofia',
    'Delgado Vazquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_990 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640990', (SELECT id_carrera FROM iia), 7
  FROM u_990
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_991 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640991@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Luis',
    'Garcia Munoz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_991 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640991', (SELECT id_carrera FROM iia), 6
  FROM u_991
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_992 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2020640992@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Carlos Miguel',
    'Chavez Rodriguez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_992 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2020640992', (SELECT id_carrera FROM iia), 7
  FROM u_992
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_993 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2023640993@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector',
    'Silva Guzman',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_993 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2023640993', (SELECT id_carrera FROM iia), 10
  FROM u_993
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_994 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2022640994@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Hector Victoria',
    'Vazquez Guerrero',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_994 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2022640994', (SELECT id_carrera FROM iia), 9
  FROM u_994
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_995 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640995@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Juan Miguel',
    'Delgado Diaz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_995 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640995', (SELECT id_carrera FROM iia), 1
  FROM u_995
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_996 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640996@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Miguel',
    'Rivera Martinez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_996 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640996', (SELECT id_carrera FROM iia), 4
  FROM u_996
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_997 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2024640997@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Ricardo',
    'Guerrero De La Cruz',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_997 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2024640997', (SELECT id_carrera FROM iia), 5
  FROM u_997
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_998 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640998@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Sofia Fernando',
    'Martinez Reyes',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_998 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640998', (SELECT id_carrera FROM iia), 7
  FROM u_998
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
),
u_999 AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '2021640999@escom.mx',
    '$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja',
    'Manuel Renata',
    'Reyes Marquez',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
),
a_999 AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '2021640999', (SELECT id_carrera FROM iia), 2
  FROM u_999
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)
SELECT count(*) FROM a_950, a_951, a_952, a_953, a_954, a_955, a_956, a_957, a_958, a_959, a_960, a_961, a_962, a_963, a_964, a_965, a_966, a_967, a_968, a_969, a_970, a_971, a_972, a_973, a_974, a_975, a_976, a_977, a_978, a_979, a_980, a_981, a_982, a_983, a_984, a_985, a_986, a_987, a_988, a_989, a_990, a_991, a_992, a_993, a_994, a_995, a_996, a_997, a_998, a_999;

COMMIT;
