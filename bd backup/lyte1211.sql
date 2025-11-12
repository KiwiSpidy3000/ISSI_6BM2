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
);


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

INSERT INTO escom_aliz.materia VALUES (1, 'BD1', 'Bases de Datos I', 8, 5, 2, NULL, NULL);
INSERT INTO escom_aliz.materia VALUES (2, 'IA1', 'Fundamentos de IA', 8, 5, 2, NULL, NULL);
INSERT INTO escom_aliz.materia VALUES (3, 'IIA101', 'Fundamentos de Programación', 8, 5, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (4, 'IIA102', 'Matemáticas Discretas', 8, 5, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (5, 'IIA103', 'Cálculo Diferencial', 8, 5, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (6, 'IIA104', 'Comunicación Oral y Escrita', 6, 3, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (7, 'IIA105', 'Mecánica y Electromagnetismo', 8, 5, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (8, 'IIA106', 'Fundamentos Económicos', 6, 3, 2, NULL, 1);
INSERT INTO escom_aliz.materia VALUES (9, 'IIA201', 'Programación Orientada a Objetos', 8, 5, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (10, 'IIA202', 'Estructuras de Datos', 8, 5, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (11, 'IIA203', 'Cálculo Integral', 8, 5, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (12, 'IIA204', 'Álgebra Lineal', 8, 5, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (13, 'IIA205', 'Probabilidad y Estadística', 8, 5, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (14, 'IIA206', 'Taller de Ética', 4, 2, 2, NULL, 2);
INSERT INTO escom_aliz.materia VALUES (17, 'IIA303', 'Lenguajes Formales y Autómatas', 8, 5, 2, NULL, 3);
INSERT INTO escom_aliz.materia VALUES (18, 'IIA304', 'Señales y Sistemas', 8, 5, 2, NULL, 3);
INSERT INTO escom_aliz.materia VALUES (19, 'IIA305', 'Metodología de la Investigación', 6, 3, 2, NULL, 3);
INSERT INTO escom_aliz.materia VALUES (20, 'IIA401', 'Bases de Datos II', 8, 5, 2, NULL, 4);
INSERT INTO escom_aliz.materia VALUES (21, 'IIA402', 'Aprendizaje Automático I', 8, 5, 2, NULL, 4);
INSERT INTO escom_aliz.materia VALUES (22, 'IIA403', 'Sistemas Operativos', 8, 5, 2, NULL, 4);
INSERT INTO escom_aliz.materia VALUES (23, 'IIA404', 'Arquitectura de Computadoras', 8, 5, 2, NULL, 4);


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


-- Completed on 2025-11-12 07:18:18

--
-- PostgreSQL database dump complete
--

\unrestrict jPh8b8Psj1QZkFjzxdVHbDtvkRBW6guajqZSbA86sl4JsgipzuC20NkVpNMI2RP

