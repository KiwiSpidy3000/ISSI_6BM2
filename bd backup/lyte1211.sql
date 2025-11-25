--
-- PostgreSQL database dump
--

\restrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-12 07:18:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5180 (class 1262 OID 16388)
-- Name: lytebd1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lytebd1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';


ALTER DATABASE lytebd1 OWNER TO postgres;

\unrestrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP
\connect lytebd1
\restrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5181 (class 0 OID 0)
-- Name: lytebd1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE lytebd1 SET search_path TO 'escom_aliz', 'public';
ALTER ROLE postgres IN DATABASE lytebd1 SET search_path TO 'escom_aliz', 'public';


\unrestrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP
\connect lytebd1
\restrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 16389)
-- Name: escom_aliz; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA escom_aliz;


ALTER SCHEMA escom_aliz OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 24576)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA escom_aliz;


--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 918 (class 1247 OID 16398)
-- Name: estado_grupo_enum; Type: TYPE; Schema: escom_aliz; Owner: postgres
--

CREATE TYPE escom_aliz.estado_grupo_enum AS ENUM (
    'ABIERTO',
    'CERRADO',
    'CANCELADO'
);


ALTER TYPE escom_aliz.estado_grupo_enum OWNER TO postgres;

--
-- TOC entry 921 (class 1247 OID 16406)
-- Name: estado_insc_enum; Type: TYPE; Schema: escom_aliz; Owner: postgres
--

CREATE TYPE escom_aliz.estado_insc_enum AS ENUM (
    'PREINSCRITO',
    'INSCRITO',
    'BAJA'
);


ALTER TYPE escom_aliz.estado_insc_enum OWNER TO postgres;

--
-- TOC entry 915 (class 1247 OID 16391)
-- Name: rol_enum; Type: TYPE; Schema: escom_aliz; Owner: postgres
--

CREATE TYPE escom_aliz.rol_enum AS ENUM (
    'ALUMNO',
    'PROFESOR',
    'ADMIN'
);


ALTER TYPE escom_aliz.rol_enum OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 16668)
-- Name: sp_validar_choque_horario(integer, integer); Type: FUNCTION; Schema: escom_aliz; Owner: postgres
--

CREATE FUNCTION escom_aliz.sp_validar_choque_horario(p_id_alumno integer, p_id_grupo_nuevo integer) RETURNS TABLE(grupo_existente integer, dia_semana smallint, hora_ini time without time zone, hora_fin time without time zone, aula character varying)
    LANGUAGE sql
    AS $$
  SELECT gexist.id_grupo, hexist.dia_semana, hexist.hora_ini, hexist.hora_fin, hexist.aula
  FROM inscripcion iexist
  JOIN grupo    gexist ON gexist.id_grupo = iexist.id_grupo
  JOIN horario  hexist ON hexist.id_grupo = gexist.id_grupo
  JOIN horario  hnuevo ON hnuevo.id_grupo = p_id_grupo_nuevo
  WHERE iexist.id_alumno = p_id_alumno
    AND iexist.estado IN ('PREINSCRITO','INSCRITO')
    AND hexist.dia_semana = hnuevo.dia_semana
    AND (hnuevo.hora_ini < hexist.hora_fin AND hnuevo.hora_fin > hexist.hora_ini);
$$;


ALTER FUNCTION escom_aliz.sp_validar_choque_horario(p_id_alumno integer, p_id_grupo_nuevo integer) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16671)
-- Name: trg_cerrar_grupo_si_se_llena_fn(); Type: FUNCTION; Schema: escom_aliz; Owner: postgres
--

CREATE FUNCTION escom_aliz.trg_cerrar_grupo_si_se_llena_fn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  v_ocupados INT;
  v_cupo     INT;
BEGIN
  SELECT COUNT(*) INTO v_ocupados
  FROM inscripcion
  WHERE id_grupo = NEW.id_grupo
    AND estado IN ('PREINSCRITO','INSCRITO');

  SELECT cupo_max INTO v_cupo FROM grupo WHERE id_grupo = NEW.id_grupo;

  IF v_ocupados >= v_cupo THEN
    UPDATE grupo SET estado = 'CERRADO' WHERE id_grupo = NEW.id_grupo;
  END IF;

  RETURN NULL;
END$$;


ALTER FUNCTION escom_aliz.trg_cerrar_grupo_si_se_llena_fn() OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16669)
-- Name: trg_inscripcion_cupo_fn(); Type: FUNCTION; Schema: escom_aliz; Owner: postgres
--

CREATE FUNCTION escom_aliz.trg_inscripcion_cupo_fn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  v_ocupados INT;
  v_cupo     INT;
BEGIN
  IF NEW.estado IN ('PREINSCRITO','INSCRITO') THEN
    SELECT COUNT(*) INTO v_ocupados
    FROM inscripcion
    WHERE id_grupo = NEW.id_grupo
      AND estado IN ('PREINSCRITO','INSCRITO');

    SELECT cupo_max INTO v_cupo FROM grupo WHERE id_grupo = NEW.id_grupo;

    IF v_ocupados >= v_cupo THEN
      RAISE EXCEPTION 'Cupo lleno para este grupo';
    END IF;
  END IF;
  RETURN NEW;
END$$;


ALTER FUNCTION escom_aliz.trg_inscripcion_cupo_fn() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 16443)
-- Name: alumno; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.alumno (
    id_alumno integer NOT NULL,
    boleta character varying(30) NOT NULL,
    id_carrera integer NOT NULL,
    semestre smallint NOT NULL,
    CONSTRAINT alumno_semestre_check CHECK (((semestre >= 1) AND (semestre <= 12)))
);


ALTER TABLE escom_aliz.alumno OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16577)
-- Name: calificacion; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.calificacion (
    id_calificacion integer NOT NULL,
    id_alumno integer NOT NULL,
    id_grupo integer NOT NULL,
    p1 numeric(5,2),
    p2 numeric(5,2),
    ordinario numeric(5,2),
    final_calc numeric(5,2) GENERATED ALWAYS AS (COALESCE(ordinario, round(((COALESCE(p1, (0)::numeric) * 0.4) + (COALESCE(p2, (0)::numeric) * 0.6)), 2))) STORED,
    CONSTRAINT calificacion_ordinario_check CHECK (((ordinario >= (0)::numeric) AND (ordinario <= (100)::numeric))),
    CONSTRAINT calificacion_p1_check CHECK (((p1 >= (0)::numeric) AND (p1 <= (100)::numeric))),
    CONSTRAINT calificacion_p2_check CHECK (((p2 >= (0)::numeric) AND (p2 <= (100)::numeric)))
);


ALTER TABLE escom_aliz.calificacion OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16576)
-- Name: calificacion_id_calificacion_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.calificacion ALTER COLUMN id_calificacion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.calificacion_id_calificacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16414)
-- Name: carrera; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.carrera (
    id_carrera integer NOT NULL,
    clave character varying(16) NOT NULL,
    nombre character varying(120) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE escom_aliz.carrera OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16413)
-- Name: carrera_id_carrera_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.carrera ALTER COLUMN id_carrera ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.carrera_id_carrera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 16602)
-- Name: evaluacion_docente; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.evaluacion_docente (
    id_eval integer NOT NULL,
    id_alumno integer NOT NULL,
    id_profesor integer NOT NULL,
    id_grupo integer NOT NULL,
    i1 smallint NOT NULL,
    i2 smallint NOT NULL,
    i3 smallint NOT NULL,
    i4 smallint NOT NULL,
    i5 smallint NOT NULL,
    comentario character varying(500),
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT evaluacion_docente_i1_check CHECK (((i1 >= 1) AND (i1 <= 5))),
    CONSTRAINT evaluacion_docente_i2_check CHECK (((i2 >= 1) AND (i2 <= 5))),
    CONSTRAINT evaluacion_docente_i3_check CHECK (((i3 >= 1) AND (i3 <= 5))),
    CONSTRAINT evaluacion_docente_i4_check CHECK (((i4 >= 1) AND (i4 <= 5))),
    CONSTRAINT evaluacion_docente_i5_check CHECK (((i5 >= 1) AND (i5 <= 5)))
);


ALTER TABLE escom_aliz.evaluacion_docente OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16601)
-- Name: evaluacion_docente_id_eval_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.evaluacion_docente ALTER COLUMN id_eval ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.evaluacion_docente_id_eval_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16506)
-- Name: grupo; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.grupo (
    id_grupo integer NOT NULL,
    id_materia integer NOT NULL,
    id_profesor integer NOT NULL,
    periodo character varying(20) NOT NULL,
    cupo_max smallint NOT NULL,
    estado escom_aliz.estado_grupo_enum DEFAULT 'ABIERTO'::escom_aliz.estado_grupo_enum,
    created_at timestamp with time zone DEFAULT now(),
    turno character varying(1) DEFAULT 'M'::character varying,
    CONSTRAINT grupo_cupo_max_check CHECK (((cupo_max >= 1) AND (cupo_max <= 200))),
    CONSTRAINT grupo_turno_check CHECK (((turno)::text = ANY ((ARRAY['M'::character varying, 'V'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE escom_aliz.grupo OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16505)
-- Name: grupo_id_grupo_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.grupo ALTER COLUMN id_grupo ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.grupo_id_grupo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16532)
-- Name: horario; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.horario (
    id_horario integer NOT NULL,
    id_grupo integer NOT NULL,
    dia_semana smallint NOT NULL,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    aula character varying(40) NOT NULL,
    CONSTRAINT horario_check CHECK ((hora_fin > hora_ini)),
    CONSTRAINT horario_dia_semana_check CHECK (((dia_semana >= 1) AND (dia_semana <= 6)))
);


ALTER TABLE escom_aliz.horario OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16531)
-- Name: horario_id_horario_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.horario ALTER COLUMN id_horario ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.horario_id_horario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16553)
-- Name: inscripcion; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.inscripcion (
    id_inscripcion integer NOT NULL,
    id_alumno integer NOT NULL,
    id_grupo integer NOT NULL,
    estado escom_aliz.estado_insc_enum DEFAULT 'PREINSCRITO'::escom_aliz.estado_insc_enum,
    fecha timestamp with time zone DEFAULT now()
);


ALTER TABLE escom_aliz.inscripcion OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16552)
-- Name: inscripcion_id_inscripcion_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.inscripcion ALTER COLUMN id_inscripcion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.inscripcion_id_inscripcion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16480)
-- Name: materia; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.materia (
    id_materia integer NOT NULL,
    clave character varying(16) NOT NULL,
    nombre character varying(160) NOT NULL,
    creditos smallint NOT NULL,
    horas_semana smallint NOT NULL,
    id_carrera integer NOT NULL,
    id_prereq integer,
    semestre smallint,
    CONSTRAINT materia_creditos_check CHECK (((creditos >= 1) AND (creditos <= 20))),
    CONSTRAINT materia_horas_semana_check CHECK (((horas_semana >= 1) AND (horas_semana <= 20))),
    CONSTRAINT materia_semestre_check CHECK (((semestre >= 1) AND (semestre <= 12)))
);


ALTER TABLE escom_aliz.materia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16479)
-- Name: materia_id_materia_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.materia ALTER COLUMN id_materia ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.materia_id_materia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 16642)
-- Name: notificacion; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.notificacion (
    id_notificacion integer NOT NULL,
    id_usuario integer NOT NULL,
    mensaje character varying(280) NOT NULL,
    leida boolean DEFAULT false,
    fecha timestamp with time zone DEFAULT now()
);


ALTER TABLE escom_aliz.notificacion OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16641)
-- Name: notificacion_id_notificacion_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.notificacion ALTER COLUMN id_notificacion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.notificacion_id_notificacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16465)
-- Name: profesor; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.profesor (
    id_profesor integer NOT NULL,
    num_empleado character varying(30) NOT NULL,
    departamento character varying(120)
    nombre character varying(80),
    apellido character varying(120)
);

-- llenar registros de la tabla profesor
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP001', 'Ciencias Matemáticas y Físicas', 'Crispin', 'Herrera Yañez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP002', 'Ciencias Matemáticas', 'Cesar', 'Hernandez Vazquez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP003', 'Ciencias Matemáticas', 'Ana Laura', 'Arredondo Sanchez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP004', 'Ciencias Matemáticas', 'Eduardo', 'Rodriguez Flores');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP005', 'Ciencias Matemáticas', 'Tlatoani de Jesus', 'Reyes Bermejo');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP006', 'Ciencias Matemáticas', 'Jose Celestino Elias', 'Hernandez Secundino');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP007', 'Ciencias Matemáticas', 'Perla Cecilia', 'Lucio Peña');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP008', 'Ciencias Matemáticas', 'Marisol', 'Rodriguez Ordaz');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP009', 'Ciencias Matemáticas', 'Alicia Marcela', 'Ramirez Guzman');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0010', 'Ciencias Computacionales', 'Tonahtiu Arturo', 'Ramirez Romero');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0011', 'Ciencias Matemáticas y Físicas', 'Jose Gregorio', 'Rodriguez Villarreal');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0012', 'Ciencias Digitales', 'Josue Emanuel', 'Barron Vera');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0013', 'Ciencias Matemáticas y Físicas', 'Miguel Abel', 'Leon Hernandez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0014', 'Ciencias Sociales', 'Lilian', 'Martinez Acosta');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0015', 'Ciencias Sociales', 'Alejandra', 'Ramos Porras');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0016', 'Ciencias Computacionales', 'Ana Belem', 'Juárez Mendez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0017', 'Ciencias Computacionales', 'Sandra', 'Diaz Santiago');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0018', 'Ciencias Computacionales', 'Jose', 'Sanchez Juarez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0019', 'Ciencias Matemáticas y Físicas', 'Juan Manuel', 'Carballo Jimenez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0020', 'Ciencias Computacionales', 'Erika', 'Hernandez Rubio');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0021', 'Ciencias Digitales', 'Alexis', 'Tasta Nava');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0022', 'Ciencias Sociales', 'Gisela', 'Gonzalez Albarran');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0023', 'Ciencias Computacionales', 'Miguel Ángel', 'Rodriguez Castillo');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0024', 'Ciencias Computacionales', 'Andres', 'Cortes Davalos');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0025', 'Ciencias Matemáticas y Físicas', 'Jorge Alberto', 'Cruz Rojas');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0026', 'Ciencias Digitales', 'Jose Juan', 'Perez Perez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0027', 'Ciencias Sociales', 'Elia Tzindejhe', 'Ramirez Martinez');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0028', 'Ciencias Computacionales', 'Ituriel Enrique', 'Flores Estrada');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0029', 'Ciencias Matemáticas y Físicas', 'Christian Rene', 'Leal Pacheco');
INSERT INTO escom_aliz.profesor (id_profesor, num_empleado, departamento, nombre, apellido) VALUES (1, 'EMP0030', 'Ciencias Computacionales', 'Tonahtiu Arturo', 'Ramirez Romero');

ALTER TABLE escom_aliz.profesor OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16426)
-- Name: usuario; Type: TABLE; Schema: escom_aliz; Owner: postgres
--

CREATE TABLE escom_aliz.usuario (
    id_usuario integer NOT NULL,
    email character varying(160) NOT NULL,
    pass_hash character varying(255) NOT NULL,
    nombre character varying(80) NOT NULL,
    apellido character varying(120) NOT NULL,
    rol escom_aliz.rol_enum NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE escom_aliz.usuario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16425)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE escom_aliz.usuario ALTER COLUMN id_usuario ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME escom_aliz.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 16658)
-- Name: vw_kardex; Type: VIEW; Schema: escom_aliz; Owner: postgres
--

CREATE VIEW escom_aliz.vw_kardex AS
 SELECT a.id_alumno,
    u.nombre AS nombre_alumno,
    m.clave AS materia_clave,
    m.nombre AS materia_nombre,
    g.periodo,
    c.final_calc AS calificacion_final,
        CASE
            WHEN (c.final_calc >= (70)::numeric) THEN 'APROBADO'::text
            ELSE 'NO APROBADO'::text
        END AS estatus
   FROM ((((escom_aliz.calificacion c
     JOIN escom_aliz.alumno a ON ((a.id_alumno = c.id_alumno)))
     JOIN escom_aliz.usuario u ON ((u.id_usuario = a.id_alumno)))
     JOIN escom_aliz.grupo g ON ((g.id_grupo = c.id_grupo)))
     JOIN escom_aliz.materia m ON ((m.id_materia = g.id_materia)));


ALTER VIEW escom_aliz.vw_kardex OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16663)
-- Name: vw_oferta_con_lugares; Type: VIEW; Schema: escom_aliz; Owner: postgres
--

CREATE VIEW escom_aliz.vw_oferta_con_lugares AS
 SELECT g.id_grupo,
    m.clave AS materia_clave,
    m.nombre AS materia,
    g.periodo,
    g.cupo_max,
    ((g.cupo_max - ( SELECT count(*) AS count
           FROM escom_aliz.inscripcion i
          WHERE ((i.id_grupo = g.id_grupo) AND (i.estado = ANY (ARRAY['PREINSCRITO'::escom_aliz.estado_insc_enum, 'INSCRITO'::escom_aliz.estado_insc_enum]))))))::integer AS lugares_disponibles,
    g.estado
   FROM (escom_aliz.grupo g
     JOIN escom_aliz.materia m ON ((m.id_materia = g.id_materia)));


ALTER VIEW escom_aliz.vw_oferta_con_lugares OWNER TO postgres;

--
-- TOC entry 5159 (class 0 OID 16443)
-- Dependencies: 225
-- Data for Name: alumno; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.alumno VALUES (4, '2025-0001', 2, 3);
INSERT INTO escom_aliz.alumno VALUES (5, '2025-0002', 2, 3);


--
-- TOC entry 5170 (class 0 OID 16577)
-- Dependencies: 236
-- Data for Name: calificacion; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.calificacion VALUES (1, 4, 1, 85.00, 90.00, NULL, DEFAULT);
INSERT INTO escom_aliz.calificacion VALUES (2, 5, 1, 60.00, 65.00, 70.00, DEFAULT);


--
-- TOC entry 5156 (class 0 OID 16414)
-- Dependencies: 222
-- Data for Name: carrera; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.carrera VALUES (1, 'ISC', 'Ingeniería en Sistemas Computacionales', '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.carrera VALUES (2, 'IIA', 'Ingeniería en Inteligencia Artificial', '2025-10-15 23:05:11.823573-06');


--
-- TOC entry 5172 (class 0 OID 16602)
-- Dependencies: 238
-- Data for Name: evaluacion_docente; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.evaluacion_docente VALUES (1, 4, 2, 1, 5, 5, 4, 5, 5, 'Excelente dominio del tema', '2025-10-15 23:06:05.797605-06');


--
-- TOC entry 5164 (class 0 OID 16506)
-- Dependencies: 230
-- Data for Name: grupo; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.grupo VALUES (2, 2, 3, '2025-1', 40, 'ABIERTO', '2025-10-15 23:05:40.050121-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (1, 1, 2, '2025-1', 2, 'CERRADO', '2025-10-15 23:05:40.050121-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (3, 3, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (4, 4, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (5, 5, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (6, 6, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (7, 7, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (8, 8, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (9, 9, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (10, 10, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (11, 11, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (12, 12, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (13, 13, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (14, 14, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (15, 17, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (16, 18, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');
INSERT INTO escom_aliz.grupo VALUES (17, 19, 6, '2025-2', 40, 'ABIERTO', '2025-11-04 07:58:05.297779-06', 'M');


--
-- TOC entry 5166 (class 0 OID 16532)
-- Dependencies: 232
-- Data for Name: horario; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.horario VALUES (1, 1, 1, '10:00:00', '12:00:00', 'A-101');
INSERT INTO escom_aliz.horario VALUES (2, 2, 1, '11:00:00', '13:00:00', 'A-102');
INSERT INTO escom_aliz.horario VALUES (3, 3, 4, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (4, 4, 5, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (5, 5, 1, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (6, 6, 2, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (7, 7, 3, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (8, 8, 4, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (9, 9, 5, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (10, 10, 1, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (11, 11, 2, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (12, 12, 3, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (13, 13, 4, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (14, 14, 5, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (15, 15, 1, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (16, 16, 2, '08:00:00', '09:30:00', 'A-10');
INSERT INTO escom_aliz.horario VALUES (17, 17, 3, '08:00:00', '09:30:00', 'A-10');


--
-- TOC entry 5168 (class 0 OID 16553)
-- Dependencies: 234
-- Data for Name: inscripcion; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.inscripcion VALUES (1, 4, 1, 'INSCRITO', '2025-10-15 23:05:51.690774-06');
INSERT INTO escom_aliz.inscripcion VALUES (2, 5, 1, 'INSCRITO', '2025-10-15 23:05:51.690774-06');
INSERT INTO escom_aliz.inscripcion VALUES (3, 5, 3, 'INSCRITO', '2025-11-04 07:58:05.297779-06');
INSERT INTO escom_aliz.inscripcion VALUES (4, 5, 4, 'INSCRITO', '2025-11-04 07:58:05.297779-06');
INSERT INTO escom_aliz.inscripcion VALUES (5, 5, 6, 'INSCRITO', '2025-11-04 07:58:05.297779-06');
INSERT INTO escom_aliz.inscripcion VALUES (6, 5, 5, 'INSCRITO', '2025-11-04 08:11:32.996679-06');
INSERT INTO escom_aliz.inscripcion VALUES (7, 5, 7, 'INSCRITO', '2025-11-04 08:12:32.557798-06');


--
-- TOC entry 5162 (class 0 OID 16480)
-- Dependencies: 228
-- Data for Name: materia; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--


-- Registros para la carrera de Ingeniería en Inteligencia Artificial (IIA)
-- id_carrera asumido = 1
-- Créditos y horas estimados según estándar IPN (4-6 créditos, 4-6 horas/semana)

INSERT INTO escom_aliz.materia (id_materia, clave, nombre, creditos, horas_semana, id_carrera, id_prereq, semestre)
VALUES
-- Semestre 1
(1, 'IIA101', 'Fundamentos de Programación', 6, 6, 1, NULL, 1),
(2, 'IIA102', 'Matemáticas Discretas', 5, 5, 1, NULL, 1),
(3, 'IIA103', 'Cálculo', 6, 6, 1, NULL, 1),
(4, 'IIA104', 'Comunicación Oral y Escrita', 4, 4, 1, NULL, 1),
(5, 'IIA105', 'Mecánica', 5, 5, 1, NULL, 1),
(6, 'IIA106', 'Fundamentos Económicos', 4, 4, 1, NULL, 1),

-- Semestre 2
(7, 'IIA201', 'Álgebra Lineal', 5, 5, 1, NULL, 2),
(8, 'IIA202', 'Programación Orientada a Objetos', 6, 6, 1, 1, 2),
(9, 'IIA203', 'Probabilidad y Estadística', 5, 5, 1, NULL, 2),
(10, 'IIA204', 'Ecuaciones Diferenciales', 5, 5, 1, 3, 2),
(11, 'IIA205', 'Bases de Datos', 6, 6, 1, 1, 2),
(12, 'IIA206', 'Liderazgo Personal', 3, 3, 1, NULL, 2),

-- Semestre 3
(13, 'IIA301', 'Análisis y Diseño de Algoritmos', 6, 6, 1, 8, 3),
(14, 'IIA302', 'Programación Lógica y Funcional', 6, 6, 1, 8, 3),
(15, 'IIA303', 'Ingeniería de Software', 5, 5, 1, 8, 3),
(16, 'IIA304', 'Finanzas', 4, 4, 1, NULL, 3),

-- Semestre 4
(17, 'IIA401', 'Aprendizaje de Máquina', 6, 6, 1, 13, 4),
(18, 'IIA402', 'Visión Artificial', 6, 6, 1, 13, 4),
(19, 'IIA403', 'Teoría de la Computación', 5, 5, 1, 14, 4),
(20, 'IIA404', 'Procesamiento de Lenguaje Natural', 6, 6, 1, 14, 4),

-- Semestre 5
(21, 'IIA501', 'Computación Paralela', 6, 6, 1, 13, 5),
(22, 'IIA502', 'Optativa A', 5, 5, 1, NULL, 5),
(23, 'IIA503', 'Optativa B', 5, 5, 1, NULL, 5),

-- Semestre 6
(24, 'IIA601', 'Reconocimiento de Voz', 6, 6, 1, 20, 6),
(25, 'IIA602', 'Trabajo Terminal I', 4, 4, 1, NULL, 6),

-- Semestre 7
(26, 'IIA701', 'Trabajo Terminal II', 4, 4, 1, 25, 7),
(27, 'IIA702', 'Optativa C', 5, 5, 1, NULL, 7),
(28, 'IIA703', 'Optativa D', 5, 5, 1, NULL, 7),

-- Semestre 8
(29, 'IIA801', 'Estancia Profesional', 10, 10, 1, NULL, 8),

-- Semestre 9
(30, 'IIA901', 'Gestión Empresarial', 5, 5, 1, NULL, 9);


--
-- TOC entry 5174 (class 0 OID 16642)
-- Dependencies: 240
-- Data for Name: notificacion; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.notificacion VALUES (1, 4, 'Tu inscripción a BD1 ha sido confirmada', false, '2025-10-15 23:06:10.409611-06');


--
-- TOC entry 5160 (class 0 OID 16465)
-- Dependencies: 226
-- Data for Name: profesor; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.profesor VALUES (2, 'P-001', 'Ciencias Computacionales');
INSERT INTO escom_aliz.profesor VALUES (3, 'P-002', 'Ciencias Computacionales');
INSERT INTO escom_aliz.profesor VALUES (6, 'P-6', 'IA');
INSERT INTO escom_aliz.profesor VALUES (7, 'P-7', 'IA');
INSERT INTO escom_aliz.profesor VALUES (8, 'P-8', 'IA');


--
-- TOC entry 5158 (class 0 OID 16426)
-- Dependencies: 224
-- Data for Name: usuario; Type: TABLE DATA; Schema: escom_aliz; Owner: postgres
--

INSERT INTO escom_aliz.usuario VALUES (2, 'cristian@ejemplo.mx', 'hash2', 'Cristhian', 'Pérez', 'PROFESOR', true, '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.usuario VALUES (3, 'valeria@ejemplo.mx', 'hash3', 'Valeria', 'Ramírez', 'PROFESOR', true, '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.usuario VALUES (4, 'alexis@ejemplo.mx', 'hash4', 'Alexis', 'Esquivel', 'ALUMNO', true, '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.usuario VALUES (1, 'alison@ejemplo.mx', '$2a$10$3ECzbPVMTAx87UpCt1HBX.uIH.Tbf3LyYlAE/nwwUVgHAIubJFAIq', 'Alison', 'Estévez', 'ADMIN', true, '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.usuario VALUES (5, 'angel@ejemplo.mx', '$2a$10$e8UNo3MkI9O5aqDjrP7fGe/oNcMsrKp0NsRWzpxb.ysi7mMbN6EKK', 'Miguel', 'Ocampo', 'ALUMNO', true, '2025-10-15 23:05:11.823573-06');
INSERT INTO escom_aliz.usuario VALUES (6, 'idalia@ejemplo.mx', 'idaliacontra', 'Idalia', 'Maldonado', 'PROFESOR', true, '2025-11-04 07:58:05.297779-06');
INSERT INTO escom_aliz.usuario VALUES (7, 'mario@ejemplo.mx', 'mariocontra', 'Mario', 'Islas', 'PROFESOR', true, '2025-11-04 07:58:05.297779-06');
INSERT INTO escom_aliz.usuario VALUES (8, 'fernanda@ejemplo.mx', 'fernandacontra', 'Fernanda', 'Beltran', 'PROFESOR', true, '2025-11-04 07:58:05.297779-06');


--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 235
-- Name: calificacion_id_calificacion_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.calificacion_id_calificacion_seq', 2, true);


--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 221
-- Name: carrera_id_carrera_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.carrera_id_carrera_seq', 4, true);


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 237
-- Name: evaluacion_docente_id_eval_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.evaluacion_docente_id_eval_seq', 1, true);


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 229
-- Name: grupo_id_grupo_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.grupo_id_grupo_seq', 17, true);


--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 231
-- Name: horario_id_horario_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.horario_id_horario_seq', 17, true);


--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 233
-- Name: inscripcion_id_inscripcion_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.inscripcion_id_inscripcion_seq', 7, true);


--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 227
-- Name: materia_id_materia_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.materia_id_materia_seq', 23, true);


--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 239
-- Name: notificacion_id_notificacion_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.notificacion_id_notificacion_seq', 1, true);


--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 223
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: escom_aliz; Owner: postgres
--

SELECT pg_catalog.setval('escom_aliz.usuario_id_usuario_seq', 8, true);


--
-- TOC entry 4953 (class 2606 OID 16454)
-- Name: alumno alumno_boleta_key; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.alumno
    ADD CONSTRAINT alumno_boleta_key UNIQUE (boleta);


--
-- TOC entry 4955 (class 2606 OID 16452)
-- Name: alumno alumno_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.alumno
    ADD CONSTRAINT alumno_pkey PRIMARY KEY (id_alumno);


--
-- TOC entry 4978 (class 2606 OID 16588)
-- Name: calificacion calificacion_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.calificacion
    ADD CONSTRAINT calificacion_pkey PRIMARY KEY (id_calificacion);


--
-- TOC entry 4945 (class 2606 OID 16424)
-- Name: carrera carrera_clave_key; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.carrera
    ADD CONSTRAINT carrera_clave_key UNIQUE (clave);


--
-- TOC entry 4947 (class 2606 OID 16422)
-- Name: carrera carrera_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (id_carrera);


--
-- TOC entry 4982 (class 2606 OID 16623)
-- Name: evaluacion_docente evaluacion_docente_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.evaluacion_docente
    ADD CONSTRAINT evaluacion_docente_pkey PRIMARY KEY (id_eval);


--
-- TOC entry 4965 (class 2606 OID 16518)
-- Name: grupo grupo_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.grupo
    ADD CONSTRAINT grupo_pkey PRIMARY KEY (id_grupo);


--
-- TOC entry 4969 (class 2606 OID 16544)
-- Name: horario horario_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.horario
    ADD CONSTRAINT horario_pkey PRIMARY KEY (id_horario);


--
-- TOC entry 4974 (class 2606 OID 16562)
-- Name: inscripcion inscripcion_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.inscripcion
    ADD CONSTRAINT inscripcion_pkey PRIMARY KEY (id_inscripcion);


--
-- TOC entry 4961 (class 2606 OID 16494)
-- Name: materia materia_clave_key; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.materia
    ADD CONSTRAINT materia_clave_key UNIQUE (clave);


--
-- TOC entry 4963 (class 2606 OID 16492)
-- Name: materia materia_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.materia
    ADD CONSTRAINT materia_pkey PRIMARY KEY (id_materia);


--
-- TOC entry 4987 (class 2606 OID 16651)
-- Name: notificacion notificacion_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id_notificacion);


--
-- TOC entry 4957 (class 2606 OID 16473)
-- Name: profesor profesor_num_empleado_key; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.profesor
    ADD CONSTRAINT profesor_num_empleado_key UNIQUE (num_empleado);


--
-- TOC entry 4959 (class 2606 OID 16471)
-- Name: profesor profesor_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (id_profesor);


--
-- TOC entry 4976 (class 2606 OID 16564)
-- Name: inscripcion uk_alumno_grupo; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.inscripcion
    ADD CONSTRAINT uk_alumno_grupo UNIQUE (id_alumno, id_grupo);


--
-- TOC entry 4980 (class 2606 OID 16590)
-- Name: calificacion uk_calif; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.calificacion
    ADD CONSTRAINT uk_calif UNIQUE (id_alumno, id_grupo);


--
-- TOC entry 4984 (class 2606 OID 16625)
-- Name: evaluacion_docente uk_eval; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.evaluacion_docente
    ADD CONSTRAINT uk_eval UNIQUE (id_alumno, id_grupo);


--
-- TOC entry 4971 (class 2606 OID 16546)
-- Name: horario uk_grupo_dia_hora_aula; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.horario
    ADD CONSTRAINT uk_grupo_dia_hora_aula UNIQUE (id_grupo, dia_semana, hora_ini, aula);


--
-- TOC entry 4967 (class 2606 OID 16520)
-- Name: grupo uk_grupo_materia_prof; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.grupo
    ADD CONSTRAINT uk_grupo_materia_prof UNIQUE (id_materia, id_profesor, periodo);


--
-- TOC entry 4949 (class 2606 OID 16442)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4951 (class 2606 OID 16440)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4972 (class 1259 OID 16575)
-- Name: idx_insc_alumno; Type: INDEX; Schema: escom_aliz; Owner: postgres
--

CREATE INDEX idx_insc_alumno ON escom_aliz.inscripcion USING btree (id_alumno);


--
-- TOC entry 4985 (class 1259 OID 16657)
-- Name: idx_notif_usuario_fecha; Type: INDEX; Schema: escom_aliz; Owner: postgres
--

CREATE INDEX idx_notif_usuario_fecha ON escom_aliz.notificacion USING btree (id_usuario, fecha);


--
-- TOC entry 5004 (class 2620 OID 16672)
-- Name: inscripcion trg_cerrar_grupo_si_se_llena; Type: TRIGGER; Schema: escom_aliz; Owner: postgres
--

CREATE TRIGGER trg_cerrar_grupo_si_se_llena AFTER INSERT ON escom_aliz.inscripcion FOR EACH ROW EXECUTE FUNCTION escom_aliz.trg_cerrar_grupo_si_se_llena_fn();


--
-- TOC entry 5005 (class 2620 OID 16670)
-- Name: inscripcion trg_inscripcion_cupo; Type: TRIGGER; Schema: escom_aliz; Owner: postgres
--

CREATE TRIGGER trg_inscripcion_cupo BEFORE INSERT ON escom_aliz.inscripcion FOR EACH ROW EXECUTE FUNCTION escom_aliz.trg_inscripcion_cupo_fn();


--
-- TOC entry 4988 (class 2606 OID 16455)
-- Name: alumno alumno_id_alumno_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.alumno
    ADD CONSTRAINT alumno_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES escom_aliz.usuario(id_usuario);


--
-- TOC entry 4989 (class 2606 OID 16460)
-- Name: alumno alumno_id_carrera_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.alumno
    ADD CONSTRAINT alumno_id_carrera_fkey FOREIGN KEY (id_carrera) REFERENCES escom_aliz.carrera(id_carrera);


--
-- TOC entry 4998 (class 2606 OID 16591)
-- Name: calificacion calificacion_id_alumno_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.calificacion
    ADD CONSTRAINT calificacion_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES escom_aliz.alumno(id_alumno);


--
-- TOC entry 4999 (class 2606 OID 16596)
-- Name: calificacion calificacion_id_grupo_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.calificacion
    ADD CONSTRAINT calificacion_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES escom_aliz.grupo(id_grupo);


--
-- TOC entry 5000 (class 2606 OID 16626)
-- Name: evaluacion_docente evaluacion_docente_id_alumno_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.evaluacion_docente
    ADD CONSTRAINT evaluacion_docente_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES escom_aliz.alumno(id_alumno);


--
-- TOC entry 5001 (class 2606 OID 16636)
-- Name: evaluacion_docente evaluacion_docente_id_grupo_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.evaluacion_docente
    ADD CONSTRAINT evaluacion_docente_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES escom_aliz.grupo(id_grupo);


--
-- TOC entry 5002 (class 2606 OID 16631)
-- Name: evaluacion_docente evaluacion_docente_id_profesor_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.evaluacion_docente
    ADD CONSTRAINT evaluacion_docente_id_profesor_fkey FOREIGN KEY (id_profesor) REFERENCES escom_aliz.profesor(id_profesor);


--
-- TOC entry 4993 (class 2606 OID 16521)
-- Name: grupo grupo_id_materia_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.grupo
    ADD CONSTRAINT grupo_id_materia_fkey FOREIGN KEY (id_materia) REFERENCES escom_aliz.materia(id_materia);


--
-- TOC entry 4994 (class 2606 OID 16526)
-- Name: grupo grupo_id_profesor_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.grupo
    ADD CONSTRAINT grupo_id_profesor_fkey FOREIGN KEY (id_profesor) REFERENCES escom_aliz.profesor(id_profesor);


--
-- TOC entry 4995 (class 2606 OID 16547)
-- Name: horario horario_id_grupo_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.horario
    ADD CONSTRAINT horario_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES escom_aliz.grupo(id_grupo) ON DELETE CASCADE;


--
-- TOC entry 4996 (class 2606 OID 16565)
-- Name: inscripcion inscripcion_id_alumno_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.inscripcion
    ADD CONSTRAINT inscripcion_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES escom_aliz.alumno(id_alumno);


--
-- TOC entry 4997 (class 2606 OID 16570)
-- Name: inscripcion inscripcion_id_grupo_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.inscripcion
    ADD CONSTRAINT inscripcion_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES escom_aliz.grupo(id_grupo);


--
-- TOC entry 4991 (class 2606 OID 16495)
-- Name: materia materia_id_carrera_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.materia
    ADD CONSTRAINT materia_id_carrera_fkey FOREIGN KEY (id_carrera) REFERENCES escom_aliz.carrera(id_carrera);


--
-- TOC entry 4992 (class 2606 OID 16500)
-- Name: materia materia_id_prereq_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.materia
    ADD CONSTRAINT materia_id_prereq_fkey FOREIGN KEY (id_prereq) REFERENCES escom_aliz.materia(id_materia);


--
-- TOC entry 5003 (class 2606 OID 16652)
-- Name: notificacion notificacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.notificacion
    ADD CONSTRAINT notificacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES escom_aliz.usuario(id_usuario);


--
-- TOC entry 4990 (class 2606 OID 16474)
-- Name: profesor profesor_id_profesor_fkey; Type: FK CONSTRAINT; Schema: escom_aliz; Owner: postgres
--

ALTER TABLE ONLY escom_aliz.profesor
    ADD CONSTRAINT profesor_id_profesor_fkey FOREIGN KEY (id_profesor) REFERENCES escom_aliz.usuario(id_usuario);

INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre) VALUES
(1, '20250001', 1, 1),
(2, '20250002', 2, 2),
(3, '20250003', 3, 3),
(4, '20250004', 1, 4),
(5, '20250005', 2, 5),
(6, '20250006', 3, 6),
(7, '20250007', 1, 7),
(8, '20250008', 2, 8),
(9, '20250009', 3, 1),
(10, '20250010', 1, 2),
(11, '20250011', 2, 3),
(12, '20250012', 3, 4),
(13, '20250013', 1, 5),
(14, '20250014', 2, 6),
(15, '20250015', 3, 7),
(16, '20250016', 1, 8),
(17, '20250017', 2, 1),
(18, '20250018', 3, 2),
(19, '20250019', 1, 3),
(20, '20250020', 2, 4),
(21, '20250021', 3, 5),
(22, '20250022', 1, 6),
(23, '20250023', 2, 7),
(24, '20250024', 3, 8),
(25, '20250025', 1, 1),
(26, '20250026', 2, 2),
(27, '20250027', 3, 3),
(28, '20250028', 1, 4),
(29, '20250029', 2, 5),
(30, '20250030', 3, 6),
(31, '20250031', 1, 7),
(32, '20250032', 2, 8),
(33, '20250033', 3, 1),
(34, '20250034', 1, 2),
(35, '20250035', 2, 3),
(36, '20250036', 3, 4),
(37, '20250037', 1, 5),
(38, '20250038', 2, 6),
(39, '20250039', 3, 7),
(40, '20250040', 1, 8),
(41, '20250041', 2, 1),
(42, '20250042', 3, 2),
(43, '20250043', 1, 3),
(44, '20250044', 2, 4),
(45, '20250045', 3, 5),
(46, '20250046', 1, 6),
(47, '20250047', 2, 7),
(48, '20250048', 3, 8),
(49, '20250049', 1, 1),

INSERT INTO escom_aliz.calificacion (id_calificacion, id_alumno, id_grupo, p1, p2, ordinario) VALUES
(1, 1, 1, 85.00, 90.00, NULL),
(2, 2, 2, 78.50, 82.00, 80.00),
(3, 3, 3, 92.00, 88.00, NULL),
(4, 4, 4, 70.00, 75.00, 72.00),
(5, 5, 5, 88.00, 91.00, NULL),
(6, 6, 6, 65.00, 68.00, 70.00),
(7, 7, 7, 95.00, 93.00, NULL),
(8, 8, 8, 82.00, 85.00, 84.00),
(9, 9, 9, 76.00, 80.00, NULL),
(10, 10, 10, 90.00, 92.00, 91.00),
(11, 11, 1, 68.00, 72.00, NULL),
(12, 12, 2, 85.00, 87.00, 86.00),
(13, 13, 3, 74.00, 78.00, NULL),
(14, 14, 4, 88.00, 90.00, 89.00),
(15, 15, 5, 92.00, 94.00, NULL),
(16, 16, 6, 70.00, 73.00, 71.00),
(17, 17, 7, 80.00, 82.00, NULL),
(18, 18, 8, 95.00, 97.00, 96.00),
(19, 19, 9, 60.00, 65.00, NULL),
(20, 20, 10, 78.00, 81.00, 79.00),
(21, 21, 1, 85.00, 88.00, NULL),
(22, 22, 2, 90.00, 93.00, 91.00),
(23, 23, 3, 72.00, 75.00, NULL),
(24, 24, 4, 88.00, 89.00, 88.50),
(25, 25, 5, 94.00, 96.00, NULL),
(26, 26, 6, 68.00, 70.00, 69.00),
(27, 27, 7, 82.00, 84.00, NULL),
(28, 28, 8, 76.00, 78.00, 77.00),
(29, 29, 9, 88.00, 90.00, NULL),
(30, 30, 10, 92.00, 94.00, 93.00),
(31, 31, 1, 65.00, 68.00, NULL),
(32, 32, 2, 80.00, 83.00, 81.00),
(33, 33, 3, 74.00, 77.00, NULL),
(34, 34, 4, 90.00, 92.00, 91.00),
(35, 35, 5, 85.00, 87.00, NULL),
(36, 36, 6, 70.00, 72.00, 71.00),
(37, 37, 7, 95.00, 97.00, NULL),
(38, 38, 8, 78.00, 80.00, 79.00),
(39, 39, 9, 88.00, 90.00, NULL),
(40, 40, 10, 92.00, 94.00, 93.00),
(41, 41, 1, 68.00, 70.00, NULL),
(42, 42, 2, 82.00, 84.00, 83.00),
(43, 43, 3, 74.00, 76.00, NULL),
(44, 44, 4, 88.00, 90.00, 89.00),
(45, 45, 5, 92.00, 94.00, NULL),
(46, 46, 6, 70.00, 72.00, 71.00),
(47, 47, 7, 80.00, 82.00, NULL),
(48, 48, 8, 95.00, 97.00, 96.00),
(49, 49, 9, 60.00, 65.00, NULL),
(50, 50, 10, 78.00, 81.00, 79.00);



-- Completed on 2025-11-12 07:18:18

--
-- PostgreSQL database dump complete
--

\unrestrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP

