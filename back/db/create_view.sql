DROP VIEW IF EXISTS escom_aliz.vw_kardex;
CREATE OR REPLACE VIEW escom_aliz.vw_kardex AS
SELECT
    i.id_alumno,
    g.periodo,
    m.clave AS materia_clave,
    m.nombre AS materia_nombre,
    -- Use ordinario as the final grade for now, or fallback to 0
    COALESCE(c.ordinario, 0) AS calificacion_final,
    CASE
        WHEN COALESCE(c.ordinario, 0) >= 6 THEN 'APROBADO'
        ELSE 'REPROBADO'
    END AS estatus
FROM escom_aliz.inscripcion i
JOIN escom_aliz.grupo g ON i.id_grupo = g.id_grupo
JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
LEFT JOIN escom_aliz.calificacion c ON i.id_alumno = c.id_alumno AND i.id_grupo = c.id_grupo
WHERE i.estado IN ('INSCRITO') 
  AND g.periodo != '2025-2';
