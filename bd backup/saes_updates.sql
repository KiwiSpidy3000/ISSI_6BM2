-- Updates for SAES features

-- 1. Configuration Table
CREATE TABLE IF NOT EXISTS escom_aliz.configuracion (
    clave VARCHAR(50) PRIMARY KEY,
    valor TEXT NOT NULL,
    descripcion VARCHAR(255)
);

-- 2. Default Configuration (Period 2025-2)
-- We use ON CONFLICT to avoid errors if re-run
INSERT INTO escom_aliz.configuracion (clave, valor, descripcion) VALUES
('PERIODO_ACTUAL', '2025-2', 'Periodo académico activo'),
('INICIO_INSCRIPCION', '2025-01-01 00:00:00', 'Fecha inicio inscripciones'),
('FIN_INSCRIPCION', '2025-12-31 23:59:59', 'Fecha fin inscripciones'),
('INICIO_BAJA', '2025-01-01 00:00:00', 'Fecha inicio bajas'),
('FIN_BAJA', '2025-12-31 23:59:59', 'Fecha fin bajas'),
('MIN_CREDITOS', '30', 'Carga mínima de créditos para no ser irregular'),
('MAX_CREDITOS', '90', 'Carga máxima de créditos permitida')
ON CONFLICT (clave) DO UPDATE SET valor = EXCLUDED.valor;

-- 3. Ensure evaluacion_docente is ready (already exists in dump, but good to double check or add if missing)
-- (It was present in the dump, so we skip creating it, but we might want a unique constraint)
-- ALTER TABLE escom_aliz.evaluacion_docente ADD CONSTRAINT unique_eval UNIQUE (id_alumno, id_grupo);
-- The dump didn't show a unique constraint, let's add it to prevent duplicate evals.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'evaluacion_docente_unique_idx') THEN
        ALTER TABLE escom_aliz.evaluacion_docente ADD CONSTRAINT evaluacion_docente_unique_idx UNIQUE (id_alumno, id_grupo);
    END IF;
END $$;
