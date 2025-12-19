-- Migration to add CURP and contact info to alumno table
ALTER TABLE escom_aliz.alumno ADD COLUMN IF NOT EXISTS curp TEXT;
ALTER TABLE escom_aliz.usuario ADD COLUMN IF NOT EXISTS direccion TEXT;
ALTER TABLE escom_aliz.usuario ADD COLUMN IF NOT EXISTS telefono TEXT;
