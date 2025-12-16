import os
import random
import json
import csv
import re
import psycopg2
import google.generativeai as genai
from dotenv import load_dotenv
from datetime import datetime

# Force UTF-8 or standard encoding for Windows
try:
    load_dotenv(encoding="utf-8")
except:
    load_dotenv()



# Escom Schema for Admin Text-to-SQL
SCHEMA_ADMIN = """
TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    email VARCHAR(160),
    nombre VARCHAR(80),
    apellido VARCHAR(120),
    rol enum('ALUMNO','PROFESOR','ADMIN')
);
TABLE alumno (
    id_alumno INT REFERENCES usuario(id_usuario),
    boleta VARCHAR(30),
    id_carrera INT,
    semestre SMALLINT
);
TABLE profesor (
    id_profesor INT REFERENCES usuario(id_usuario),
    num_empleado VARCHAR(30),
    departamento VARCHAR(120)
);
TABLE materia (
    id_materia SERIAL PRIMARY KEY,
    clave VARCHAR(16),
    nombre VARCHAR(160),
    semestre SMALLINT,
    creditos SMALLINT
);
TABLE grupo (
    id_grupo SERIAL PRIMARY KEY,
    id_materia INT REFERENCES materia(id_materia),
    id_profesor INT REFERENCES profesor(id_profesor),
    periodo VARCHAR(20),
    cupo_max SMALLINT,
    estado enum('ABIERTO','CERRADO'),
    turno VARCHAR(1)
);
TABLE inscripcion (
    id_inscripcion SERIAL PRIMARY KEY,
    id_alumno INT REFERENCES alumno(id_alumno),
    id_grupo INT REFERENCES grupo(id_grupo),
    estado enum('PREINSCRITO','INSCRITO'),
    fecha TIMESTAMP
);
TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    id_grupo INT REFERENCES grupo(id_grupo),
    dia_semana SMALLINT, -- 1=Lunes, 6=Sabado
    hora_ini TIME,
    hora_fin TIME,
    aula VARCHAR(40)
);
TABLE carrera (
    id_carrera SERIAL PRIMARY KEY,
    nombre VARCHAR(120)
);
"""

class ChatbotESCOMGemini:
    def __init__(self, dataset_path, db_config=None):
        self.dataset = self._cargar_dataset(dataset_path)
        self.db_config = db_config or {
            "host": os.getenv("DB_HOST", "localhost"),
            "database": os.getenv("DB_NAME", "lytebd1"),
            "user": os.getenv("DB_USER", "postgres"),
            "password": os.getenv("DB_PASSWORD", ""),
            "port": os.getenv("DB_PORT", "5432"),
        }
        self.db_connection = self._conectar_bd()
        self.model = self._inicializar_gemini()
        # self.contexto_dataset se generará dinámicamente

    # ------------------ utilidades básicas ------------------

    def _cargar_dataset(self, dataset_path):
        try:
            with open(dataset_path, "r", encoding="utf-8") as file:
                return json.load(file)
        except Exception as e:
            raise ValueError(f"Error al cargar el dataset: {e}")

    def _leer_historial(self, conversation_file):
        historial = []
        try:
            if conversation_file and os.path.exists(conversation_file):
                with open(conversation_file, "r", encoding="utf-8") as file:
                    reader = csv.DictReader(file)
                    for row in reader:
                        historial.append(row)
        except Exception as e:
            print(f"⚠️ Error al leer historial: {e}")
        return historial

    def _guardar_mensaje(self, usuario, modelo, conversation_file):
        if not conversation_file:
            return
        try:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            mensaje = {
                "timestamp": timestamp,
                "usuario": usuario,
                "modelo": modelo,
            }
            # Asegurar headers si el archivo está vacío (aunque ChatManager lo crea)
            file_exists = os.path.exists(conversation_file)
            with open(conversation_file, "a", encoding="utf-8", newline="") as file:
                writer = csv.DictWriter(file, fieldnames=["timestamp", "usuario", "modelo"])
                if not file_exists:
                    writer.writeheader()
                writer.writerow(mensaje)
        except Exception as e:
            print(f"⚠️ Error al guardar mensaje: {e}")

    def _obtener_contexto_historico(self, conversation_file, num_mensajes=5):
        historial = self._leer_historial(conversation_file)
        if not historial:
            return ""

        contexto = "\nCONTEXTO DE CONVERSACIÓN ANTERIOR:\n"
        mensajes_recientes = historial[-num_mensajes:]

        for mensaje in mensajes_recientes:
            if mensaje["usuario"].strip():
                contexto += f"Usuario: {mensaje['usuario']}\n"
            if mensaje["modelo"].strip():
                contexto += f"Asistente: {mensaje['modelo']}\n"

        return contexto

    def _conectar_bd(self):
        try:
            # Add client_encoding to params to ensure consistent communication
            params = self.db_config.copy()
            params["client_encoding"] = "utf8"
            conn = psycopg2.connect(**params)
            conn.autocommit = True
            print("✅ Conexión a la base de datos local establecida")
            return conn
        except Exception as e:
            # Safely print error even if it contains non-utf8 chars (like Windows Spanish messages)
            try:
                msg = str(e)
            except:
                msg = "Error de codificación en el mensaje de error de BD"
            print(f"❌ Error al conectar con la base de datos local: {msg}")
            print("🔧 Asegúrate de que PostgreSQL esté corriendo en localhost")
            return None


    def _extraer_boleta(self, texto):
        """Busca una cadena de 10 dígitos que parezca boleta."""
        m = re.search(r"\b(\d{10})\b", texto)
        return m.group(1) if m else None

    def _inicializar_gemini(self):
        api_key = os.getenv("GEMINI_API_KEY")
        if not api_key:
            raise ValueError("❌ No se encontró GEMINI_API_KEY en las variables de entorno")

        genai.configure(api_key=api_key)
        return genai.GenerativeModel("gemini-2.0-flash")

    # ------------------ contexto para Gemini ------------------
    
    def _preparar_contexto_dataset(self, conversation_file, role="ALUMNO", user_id=None):
        contexto_historico = self._obtener_contexto_historico(conversation_file)

        schema_ctx = ""
        if role == "ADMIN":
            schema_ctx = f"ESQUEMA DE BASE DE DATOS (SOLO PARA ADMIN):\n{SCHEMA_ADMIN}\nPuedes generar queries SQL personalizados si el admin pide algo específico que no cubre la API estándar. FORMATO: DB_QUERY:CUSTOM_SQL: SELECT ..."

        return f"""
        Eres un asistente virtual especializado en ESCOM (Escuela Superior de Cómputo). 
        Tienes acceso a la siguiente base de información oficial:

        DATASET ESCOM - INFORMACIÓN INSTITUCIONAL:
        {json.dumps(self.dataset, ensure_ascii=False, indent=2)}

        {contexto_historico}

        ESTRUCTURA DEL DATASET:
        - saludos: Lista de saludos iniciales
        - despedidas: Lista de mensajes de despedida  
        - reglamento: Información sobre normas académicas (asistencias, calificaciones, derechos, obligaciones, faltas, evaluaciones, etc)
        - no_entendido: Respuestas para preguntas no comprendidas

        Además, tienes acceso a una base de datos real.
        TU ROL ACTUAL ES: {role}
        ID USUARIO ACTUAL: {user_id if user_id else "DESCONOCIDO"}


        INSTRUCCIONES IMPORTANTES:
        1. Para preguntas generales sobre reglamentos, inscripciones, reinscripciones, etc.: 
           Responde en base a la información del dataset, siendo útil y preciso.

        2. Para consultas que requieran datos específicos del estudiante (calificaciones, promedio, horarios, etc.): 
           - Identifica que necesitas acceder a la base de datos
           - Devuelve un comando especial en el formato: DB_QUERY:[TIPO_QUERY]:[PARÁMETROS]
           - NO intentes inventar datos personales ni boletas.

        3. Considera el contexto de conversación anterior para mantener continuidad.

        4. Reglas por ROL:
           - ALUMNO: Solo puede consultar SU info (promedio, horario, etc).
           - PROFESOR: Puede consultar "Mis grupos", "Alumnos de mi grupo X". NO tiene acceso a listados generales.
           - ADMIN: TIENE ACCESO TOTAL E IRRESTRICTO. Puede ver correos, nombres, listas completas de usuarios. NO ocultes información por privacidad si el rol es ADMIN.
           
        {schema_ctx}

        FORMATOS DE QUERY PARA BASE DE DATOS:
        
        [COMUNES]
        - DB_QUERY:INFORMACION_PERSONAL:DEFAULT  (Para el usuario actual)

        [ALUMNO]
        - DB_QUERY:PROMEDIO:DEFAULT
        - DB_QUERY:CALIFICACIONES:DEFAULT
        - DB_QUERY:HORARIO:DEFAULT
        - DB_QUERY:KARDEX:DEFAULT

        [PROFESOR]
        - DB_QUERY:LISTA_GRUPOS:DEFAULT  (Grupos que imparte el profesor actual)
        - DB_QUERY:ALUMNOS_GRUPO:[ID_GRUPO] (Lista de alumnos en un grupo especifico)

        [ADMIN]
        - DB_QUERY:STATS_GENERAL:DEFAULT
        - DB_QUERY:INFO_PROFESOR:[NOMBRE o ID]
        - DB_QUERY:INFO_ALUMNO:[BOLETA o NOMBRE]
        - DB_QUERY:LISTA_ALUMNOS:DEFAULT (Muestra lista de alumnos registrados)
        - DB_QUERY:LISTA_PROFESORES:DEFAULT (Muestra lista de profesores registrados)
        - DB_QUERY:CUSTOM_SQL:[CODIGO SQL] (Para consultas complejas no cubiertas arriba, ej: Joins, búsquedas especificas. SOLO SELECT)

        EJEMPLOS:
        - (Alumno) "¿Cuál es mi promedio?" -> DB_QUERY:PROMEDIO:DEFAULT
        - (Profesor) "¿Qué grupos doy?" -> DB_QUERY:LISTA_GRUPOS:DEFAULT
        - (Profesor) "¿Quiénes están en el grupo 12?" -> DB_QUERY:ALUMNOS_GRUPO:12
        - (Admin) "Dame info del profesor Juan" -> DB_QUERY:INFO_PROFESOR:Juan
        - (Admin) "Dame los primeros 5 alumnos" -> DB_QUERY:LISTA_ALUMNOS:DEFAULT
        - (Admin) "¿Qué grupos inscribió el alumno 123?" -> DB_QUERY:CUSTOM_SQL:SELECT g.id_grupo, m.nombre FROM inscripcion i JOIN grupo g ON i.id_grupo = g.id_grupo JOIN materia m ON g.id_materia = m.id_materia JOIN alumno a ON i.id_alumno = a.id_alumno WHERE a.boleta = '123'
        """

    # ------------------ acceso BD ------------------

    def _ejecutar_query_bd(self, query):
        if not self.db_connection:
            return "Error: No hay conexión a la base de datos"

        cursor = None
        try:
            cursor = self.db_connection.cursor()

            if query.startswith("PROMEDIO:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_promedio(cursor, boleta)

            elif query.startswith("CALIFICACIONES:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_calificaciones(cursor, boleta)

            elif query.startswith("HORARIO:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_horario(cursor, boleta)

            elif query.startswith("HORARIO_PROFESOR:"):
                user_id = query.split(":", 1)[1]
                return self._obtener_horario_profesor(cursor, user_id)

            elif query.startswith("INFORMACION_PERSONAL:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_informacion_personal(cursor, boleta)

            elif query.startswith("MATERIAS_INSCRITAS:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_materias_inscritas(cursor, boleta)

            elif query.startswith("KARDEX:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_kardex(cursor, boleta)

            elif query.startswith("EVALUACION_DOCENTE:"):
                boleta = query.split(":", 1)[1]
                return self._obtener_evaluaciones_docente(cursor, boleta)

            elif query.startswith("LISTA_GRUPOS:"):
                user_id = query.split(":", 1)[1]
                return self._obtener_grupos_profesor(cursor, user_id)

            elif query.startswith("ALUMNOS_GRUPO:"):
                id_grupo = query.split(":", 1)[1]
                return self._obtener_alumnos_grupo(cursor, id_grupo)

            elif query.startswith("STATS_GENERAL:"):
                return self._obtener_stats_admin(cursor)

            elif query.startswith("INFO_PROFESOR:"):
                termino = query.split(":", 1)[1]
                return self._buscar_profesor(cursor, termino)

            elif query.startswith("INFO_ALUMNO:"):
                termino = query.split(":", 1)[1]
                return self._buscar_alumno_admin(cursor, termino)

            elif query.startswith("LISTA_ALUMNOS:"):
                return self._listar_alumnos(cursor)

            elif query.startswith("LISTA_PROFESORES:"):
                return self._listar_profesores(cursor)

            else:
                return "Tipo de query no reconocido"

        except Exception as e:
            return f"Error al consultar la base de datos: {str(e)}"
        finally:
            if cursor:
                cursor.close()

    def _resolver_id_entidad(self, cursor, identificador, role):
        """Devuelve (id_alumno, 'ALUMNO') o (id_profesor, 'PROFESOR') resolviendo email/usuario."""
        if not identificador: return None
        
        # Si role es profesor, buscamos su id_profesor usando usuario
        if role == "PROFESOR":
            q_profe = """
            SELECT p.id_profesor 
            FROM escom_aliz.profesor p
            JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
            WHERE CAST(u.id_usuario AS TEXT) = %s OR u.email = %s OR p.num_empleado = %s
            """
            cursor.execute(q_profe, (str(identificador), str(identificador), str(identificador)))
            row = cursor.fetchone()
            return row[0] if row else None
            
        return identificador # Default fallback (boleta alumno)

    def _obtener_promedio(self, cursor, boleta):
        query = """
        SELECT AVG(c.final_calc) as promedio
        FROM escom_aliz.calificacion c
        JOIN escom_aliz.alumno a ON c.id_alumno = a.id_alumno
        WHERE a.boleta = %s
        """
        cursor.execute(query, (boleta,))
        resultado = cursor.fetchone()
        return f"Tu promedio general es: {resultado[0]:.2f}" if resultado and resultado[0] else \
            "No se encontraron calificaciones registradas para tu boleta."

    def _obtener_calificaciones(self, cursor, boleta):
        query = """
        SELECT m.nombre, c.p1, c.p2, c.ordinario, c.final_calc
        FROM escom_aliz.calificacion c
        JOIN escom_aliz.alumno a ON c.id_alumno = a.id_alumno
        JOIN escom_aliz.grupo g ON c.id_grupo = g.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE a.boleta = %s
        """
        cursor.execute(query, (boleta,))
        calificaciones = cursor.fetchall()

        if not calificaciones:
            return "No se encontraron calificaciones."

        resultado = "Estas son tus calificaciones:\n"
        for materia, p1, p2, ordinario, final in calificaciones:
            resultado += f"- {materia}: P1={p1 or 'N/A'}, P2={p2 or 'N/A'}, Ordinario={ordinario or 'N/A'}, Final={final or 'N/A'}\n"
        return resultado

    def _obtener_horario(self, cursor, boleta):
        query = """
        SELECT DISTINCT m.nombre, h.dia_semana, h.hora_ini, h.hora_fin, h.aula
        FROM escom_aliz.inscripcion i
        JOIN escom_aliz.alumno a ON i.id_alumno = a.id_alumno
        JOIN escom_aliz.grupo g ON i.id_grupo = g.id_grupo
        JOIN escom_aliz.horario h ON g.id_grupo = h.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE a.boleta = %s AND i.estado IN ('PREINSCRITO', 'INSCRITO')
        ORDER BY h.dia_semana, h.hora_ini
        """
        cursor.execute(query, (boleta,))
        horarios = cursor.fetchall()

        if not horarios:
            return "No se encontró horario para este estudiante."

        dias = {1: "Lunes", 2: "Martes", 3: "Miércoles", 4: "Jueves", 5: "Viernes", 6: "Sábado"}

        resultado = "Este es tu horario actual:\n"
        for materia, dia, hora_ini, hora_fin, aula in horarios:
            resultado += f"- {dias.get(dia, f'Día {dia}')}: {hora_ini} - {hora_fin} | {materia} | Aula: {aula}\n"
        return resultado

    def _obtener_informacion_personal(self, cursor, id_ref):
        # id_ref puede ser boleta (alumno) o id_usuario (admin/profesor)
        # Intentamos buscar por id_usuario primero (casos admin/profe que usan user_id)
        # O boleta para alumnos
        query = """
        SELECT u.nombre, u.apellido, u.email, u.rol, 
               COALESCE(a.boleta, 'N/A') as boleta, 
               COALESCE(c.nombre, 'N/A') as carrera
        FROM escom_aliz.usuario u
        LEFT JOIN escom_aliz.alumno a ON u.id_usuario = a.id_alumno
        LEFT JOIN escom_aliz.carrera c ON a.id_carrera = c.id_carrera
        WHERE CAST(u.id_usuario AS TEXT) = %s OR a.boleta = %s
        """
        cursor.execute(query, (id_ref, id_ref))
        info = cursor.fetchone()

        if not info:
             return "No se encontró información del usuario."

        nombre, apellido, email, rol, boleta, carrera = info
        return (
            f"Información del usuario ({rol}):\n"
            f"- Nombre: {nombre} {apellido}\n"
            f"- Email: {email}\n"
            f"- Boleta: {boleta}\n"
            f"- Carrera: {carrera}"
        )

    def _obtener_materias_inscritas(self, cursor, boleta):
        query = """
        SELECT m.nombre, g.periodo, g.estado
        FROM escom_aliz.inscripcion i
        JOIN escom_aliz.alumno a ON i.id_alumno = a.id_alumno
        JOIN escom_aliz.grupo g ON i.id_grupo = g.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE a.boleta = %s AND i.estado IN ('PREINSCRITO', 'INSCRITO')
        """
        cursor.execute(query, (boleta,))
        materias = cursor.fetchall()

        if not materias:
            return "No hay materias inscritas actualmente."

        resultado = "Materias inscritas actualmente:\n"
        for materia, periodo, estado in materias:
            resultado += f"- {materia} | Periodo: {periodo} | Estado: {estado}\n"
        return resultado

    def _obtener_kardex(self, cursor, boleta):
        query = """
        SELECT materia_nombre, periodo, calificacion_final, estatus
        FROM escom_aliz.vw_kardex k
        JOIN escom_aliz.alumno a ON k.id_alumno = a.id_alumno
        WHERE a.boleta = %s
        ORDER BY periodo
        """
        cursor.execute(query, (boleta,))
        kardex = cursor.fetchall()

        if not kardex:
            return "No se encontró información del kardex."

        resultado = "Kardex académico:\n"
        for materia, periodo, calificacion, estatus in kardex:
            resultado += f"- {materia} | {periodo} | Calificación: {calificacion} | {estatus}\n"
        return resultado

    def _obtener_evaluaciones_docente(self, cursor, boleta):
        query = """
        SELECT u.nombre, m.nombre, e.i1, e.i2, e.i3, e.i4, e.i5, e.comentario
        FROM escom_aliz.evaluacion_docente e
        JOIN escom_aliz.alumno a ON e.id_alumno = a.id_alumno
        JOIN escom_aliz.profesor p ON e.id_profesor = p.id_profesor
        JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
        JOIN escom_aliz.grupo g ON e.id_grupo = g.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE a.boleta = %s
        """
        cursor.execute(query, (boleta,))
        evaluaciones = cursor.fetchall()

        if not evaluaciones:
            return "No se encontraron evaluaciones docentes."

        resultado = "Evaluaciones docentes realizadas:\n"
        for profesor, materia, i1, i2, i3, i4, i5, comentario in evaluaciones:
            promedio = (i1 + i2 + i3 + i4 + i5) / 5
            resultado += f"- Profesor: {profesor} | Materia: {materia}\n"
            resultado += f"  Calificación: {promedio:.1f}/5 | Comentario: {comentario or 'Sin comentario'}\n"
        return resultado

    def _obtener_grupos_profesor(self, cursor, user_id):
        # Resolver ID real del profesor si user_id es email
        real_id = self._resolver_id_entidad(cursor, user_id, "PROFESOR")
        if not real_id: return "No se encontró tu registro de profesor."

        query = """
        SELECT g.id_grupo, m.clave, m.nombre, g.periodo, g.turno
        FROM escom_aliz.grupo g
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE g.id_profesor = %s
        ORDER BY g.periodo DESC
        """
        cursor.execute(query, (real_id,))
        grupos = cursor.fetchall()
        
        if not grupos:
            return "No tienes grupos asignados actualmente."
            
        res = "Tus grupos asignados:\n"
        for gid, clave, nom, per, turn in grupos:
            res += f"- GRUPO {gid}: {nom} ({clave}) | Periodo {per} | Turno {turn}\n"
        return res
    
    def _obtener_horario_profesor(self, cursor, user_id):
        real_id = self._resolver_id_entidad(cursor, user_id, "PROFESOR")
        if not real_id: return "No se encontró registro de profesor."

        query = """
        SELECT g.id_grupo, m.nombre, h.dia_semana, h.hora_ini, h.hora_fin, h.aula
        FROM escom_aliz.grupo g
        JOIN escom_aliz.horario h ON g.id_grupo = h.id_grupo
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        WHERE g.id_profesor = %s AND g.periodo = '2025-2'
        ORDER BY h.dia_semana, h.hora_ini
        """
        cursor.execute(query, (real_id,))
        rows = cursor.fetchall()
        if not rows: return "No hay horarios asignados en el periodo actual."

        dias = {1: "Lunes", 2: "Martes", 3: "Miércoles", 4: "Jueves", 5: "Viernes", 6: "Sábado"}
        res = "Tu horario de enseñanza (2025-2):\n"
        for gid, mat, d, ini, fin, aula in rows:
             res += f"- {dias.get(d, d)}: {ini}-{fin} | {mat} (Gpo {gid}) | Aula {aula}\n"
        return res

    def _obtener_alumnos_grupo(self, cursor, id_grupo):
        query = """
        SELECT a.boleta, u.nombre, u.apellido, i.estado
        FROM escom_aliz.inscripcion i
        JOIN escom_aliz.alumno a ON i.id_alumno = a.id_alumno
        JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
        WHERE i.id_grupo = %s
        ORDER BY u.apellido
        """
        try:
            cursor.execute(query, (id_grupo,))
        except Exception:
            return "Error: ID de grupo inválido"
            
        alumnos = cursor.fetchall()
        if not alumnos:
            return f"No hay alumnos inscritos en el grupo {id_grupo}."
            
        res = f"Alumnos en el grupo {id_grupo}:\n"
        for bol, nom, ape, est in alumnos:
            res += f"- {bol}: {nom} {ape} ({est})\n"
        return res

    def _obtener_stats_admin(self, cursor):
        cursor.execute("SELECT COUNT(*) FROM escom_aliz.alumno")
        n_alumnos = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM escom_aliz.profesor")
        n_profes = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM escom_aliz.grupo WHERE periodo='2025-2'")
        n_grupos = cursor.fetchone()[0]
        
        return (
            f"Estadísticas Generales:\n"
            f"- Total Alumnos: {n_alumnos}\n"
            f"- Total Profesores: {n_profes}\n"
            f"- Grupos activos (2025-2): {n_grupos}"
        )

    def _buscar_profesor(self, cursor, termino):
        term = f"%{termino}%"
        query = """
        SELECT p.id_profesor, u.nombre, u.apellido, u.email, p.departamento
        FROM escom_aliz.profesor p
        JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
        WHERE u.nombre ILIKE %s OR u.apellido ILIKE %s OR CAST(p.id_profesor AS TEXT) = %s
        LIMIT 5
        """
        cursor.execute(query, (term, term, termino))
        rows = cursor.fetchall()
        
        if not rows:
            return f"No encontré profesores que coincidan con '{termino}'."
            
        res = "Profesores encontrados:\n"
        for pid, nom, ape, mail, depto in rows:
            res += f"- [{pid}] {nom} {ape} | {mail} | Depto: {depto}\n"
        return res

    def _buscar_alumno_admin(self, cursor, termino):
        term = f"%{termino}%"
        query = """
        SELECT a.boleta, u.nombre, u.apellido, c.nombre
        FROM escom_aliz.alumno a
        JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
        JOIN escom_aliz.carrera c ON a.id_carrera = c.id_carrera
        WHERE u.nombre ILIKE %s OR u.apellido ILIKE %s OR a.boleta = %s
        LIMIT 5
        """
        cursor.execute(query, (term, term, termino))
        rows = cursor.fetchall()
        
        if not rows:
            return f"No encontré alumnos que coincidan con '{termino}'."
            
        res = "Alumnos encontrados:\n"
        for bol, nom, ape, carr in rows:
            res += f"- [{bol}] {nom} {ape} | {carr}\n"
        return res

    def _listar_alumnos(self, cursor):
        query = """
        SELECT a.boleta, u.nombre, u.apellido, c.nombre
        FROM escom_aliz.alumno a
        JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
        JOIN escom_aliz.carrera c ON a.id_carrera = c.id_carrera
        ORDER BY a.boleta
        LIMIT 20
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        if not rows: return "No hay alumnos registrados."
        res = "Lista de Alumnos (Primeros 20):\n"
        for bol, nom, ape, carr in rows:
            res += f"- {bol}: {nom} {ape} ({carr})\n"
        return res

    def _listar_profesores(self, cursor):
        query = """
        SELECT p.id_profesor, u.nombre, u.apellido, p.departamento
        FROM escom_aliz.profesor p
        JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
        ORDER BY u.nombre
        LIMIT 20
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        if not rows: return "No hay profesores registrados."
        res = "Lista de Profesores (Primeros 20):\n"
        for pid, nom, ape, depto in rows:
            res += f"- {pid}: {nom} {ape} ({depto})\n"
        return res

    def _ejecutar_sql_custom(self, sql_query):
        # 1. Verificar si es SELECT (seguridad basica)
        if not sql_query.strip().upper().startswith("SELECT"):
            return "Error de seguridad: Solo se permiten consultas SELECT (Lectura)."
        
        # 2. Ejecutar
        try:
            if not self.db_connection:
                 return "Error de BD: Sin conexión."
            cursor = self.db_connection.cursor()
            cursor.execute(sql_query)
            
            # 3. Formatear
            rows = cursor.fetchall()
            if not rows: return "La consulta SQL no devolvió resultados."
            
            # Intento de obtener nombres de columnas para contexto
            col_names = [desc[0] for desc in cursor.description]
            res = f"Resultado SQL ({len(rows)} filas):\n" + " | ".join(col_names) + "\n"
            res += "-" * 30 + "\n"
            
            # Limite de filas para no saturar contexto
            for row in rows[:20]:
                res += " | ".join([str(c) for c in row]) + "\n"
            
            if len(rows) > 20: res += "... (truncado a 20 filas) ..."
            
            cursor.close()
            return res
        except Exception as e:
            return f"Error SQL: {str(e)}"

    # ------------------ reglas rápidas antes de Gemini ------------------

    def _reglas_directas(self, pregunta, boleta_default=None, role="ALUMNO"):
        t = pregunta.lower()

        # Preguntas de promedio
        if "promedio" in t and role == "ALUMNO":
            boleta = boleta_default or self._extraer_boleta(pregunta)
            if not boleta:
                return "Por seguridad no puedo consultar tu promedio porque el sistema no me envió tu boleta."
            return self._ejecutar_query_bd(f"PROMEDIO:{boleta}")

        # Horario
        if "horario" in t:
            identificador = boleta_default or self._extraer_boleta(pregunta)
            if not identificador:
                return "No tengo tu identificador para buscar el horario."
            
            if role == "PROFESOR":
                # Nuevo: Horario para profesor (basado en grupos que imparte)
                return self._ejecutar_query_bd(f"HORARIO_PROFESOR:{identificador}")
            else:
                # Default (Alumno)
                return self._ejecutar_query_bd(f"HORARIO:{identificador}")

        # Kardex
        if "kardex" in t and role == "ALUMNO":
            boleta = boleta_default or self._extraer_boleta(pregunta)
            if not boleta:
                return "Por seguridad no puedo consultar tu kardex porque el sistema no me envió tu boleta."
            return self._ejecutar_query_bd(f"KARDEX:{boleta}")

        # Derechos de estudiantes
        if "derechos" in t and ("estudiante" in t or "estudiantes" in t or "alumno" in t):
            reglamento = self.dataset.get("reglamento", {})
            texto = reglamento.get("derechos")
            if texto:
                return texto

        return None

    # ------------------ núcleo: procesar pregunta ------------------

    def procesar_pregunta(self, pregunta, boleta_default=None, conversation_file=None, role="ALUMNO"):
        """
        Procesa la pregunta usando Gemini con el contexto del dataset.
        La boleta/id NUNCA se envía a Gemini: sólo se usa localmente.
        Role: ALUMNO, PROFESOR, ADMIN
        """

        # 0) Atajos sin pasar por Gemini
        print(f"DEBUG: procesar_pregunta con role='{role}' user_id='{boleta_default}'") # Debug role
        directa = self._reglas_directas(pregunta, boleta_default, role)
        if directa is not None:
            self._guardar_mensaje(pregunta, directa, conversation_file)
            return directa

        # 1) Actualizar contexto (AHORA DEPENDE DE conversation_file)
        contexto_dataset = self._preparar_contexto_dataset(conversation_file, role, boleta_default)

        prompt = f"""
        {contexto_dataset}
        
        PREGUNTA DEL USUARIO: "{pregunta}"

        Recuerda:
        - Si la respuesta está en el dataset ESCOM o es una pregunta general,
          responde normalmente, en texto natural.
        - Si necesitas información personalizada del alumno, devuelve SOLO
          un comando DB_QUERY con la palabra DEFAULT como boleta, por ejemplo:
            DB_QUERY:PROMEDIO:DEFAULT
            DB_QUERY:CALIFICACIONES:DEFAULT
            DB_QUERY:HORARIO:DEFAULT
            DB_QUERY:KARDEX:DEFAULT
          No inventes boletas ni pidas el número al usuario.

        RESPUESTA:
        """

        try:
            response = self.model.generate_content(prompt)
            respuesta_gemini = response.text.strip()

            # 2) ¿Es comando para la BD?
            # Buscamos el patrón DB_QUERY:TIPO:PARAMETRO en cualquier parte del texto
            match = re.search(r"DB_QUERY:([A-Z_]+):(.+)", respuesta_gemini)
            
            # ATENCION: Validar que el match sea real y no alucinación parcial
            if match:
                tipo = match.group(1).strip().upper()
                param_cmd = match.group(2).strip() # Puede traer basura despues, clean it?
                # Usualmente viene solo hasta fin de linea o fin de string
                # Cortamos en espacio o salto de linea si es necesario, 
                # pero mejor asumimos que el modelo sigue la instruccion de "SOLO un comando"
                # o el regex capture hasta el final.

                consultas_validas = {
                    "PROMEDIO", "CALIFICACIONES", "HORARIO",
                    "INFORMACION_PERSONAL", "MATERIAS_INSCRITAS", 
                    "KARDEX", "EVALUACION_DOCENTE",
                    "LISTA_GRUPOS", "ALUMNOS_GRUPO",
                    "STATS_GENERAL", "INFO_PROFESOR", "INFO_ALUMNO",
                    "LISTA_ALUMNOS", "LISTA_PROFESORES", "CUSTOM_SQL"
                }

                if tipo in consultas_validas:
                    if boleta_default:
                        if param_cmd == "DEFAULT":
                             query_real = f"{tipo}:{boleta_default}"
                        else:
                             query_real = f"{tipo}:{param_cmd}"
                    else:
                        # Si no hay boleta/user_id, NO podemos ejecutar consultas "personales" (DEFAULT)
                        # Pero si el param NO es DEFAULT (ej: INFO_PROFESOR:Juan), sí podríamos.
                        if param_cmd != "DEFAULT":
                             query_real = f"{tipo}:{param_cmd}"
                        else:
                            return "Por seguridad no puedo consultar información personal, porque el sistema no me envió tu identificador."

                    # 2.5) VALIDACIÓN DE PERMISOS (RBAC)
                    permisos_rol = {
                        "ALUMNO": {"PROMEDIO", "CALIFICACIONES", "HORARIO", "KARDEX", "MATERIAS_INSCRITAS", "EVALUACION_DOCENTE", "INFORMACION_PERSONAL"},
                        "PROFESOR": {"LISTA_GRUPOS", "ALUMNOS_GRUPO", "INFORMACION_PERSONAL"}, # Info personal propia
                        "ADMIN": "ALL"
                    }
                    
                    allowed = permisos_rol.get(role, set())
                    if allowed != "ALL" and tipo not in allowed:
                        # Extra check for CUSTOM_SQL (Implicitly covered by ALL, but just to be safe if Logic changes)
                        msg = f"Lo siento, tu rol de {role} no tiene permisos para realizar esta consulta ({tipo})."
                        self._guardar_mensaje(pregunta, msg, conversation_file)
                        return msg

                    # 3) Ejecutar consulta en BD
                    # Special handling for CUSTOM_SQL
                    if tipo == "CUSTOM_SQL":
                        # param_cmd comes as "SELECT ...", pass it directly
                        resultado_bd = self._ejecutar_sql_custom(param_cmd)
                    else:
                        resultado_bd = self._ejecutar_query_bd(query_real)


                    # 4) Pedir a Gemini que redacte la respuesta final
                    prompt_final = f"""
                    Contexto del dataset ESCOM: {json.dumps(self.dataset, ensure_ascii=False)}

                    El usuario preguntó: "{pregunta}"
                    La consulta a la BD ({tipo}) devolvió: "{resultado_bd}"

                    Genera una respuesta natural, útil y profesional combinando esta información.
                    Respuesta final:
                    """
                    respuesta_final_obj = self.model.generate_content(prompt_final)
                    respuesta_final = respuesta_final_obj.text.strip()

                    self._guardar_mensaje(pregunta, respuesta_final, conversation_file)
                    return respuesta_final

            # 5) Respuesta directa del modelo (si no hubo match o no era valido)
            self._guardar_mensaje(pregunta, respuesta_gemini, conversation_file)
            return respuesta_gemini

        except Exception as e:
            print(f"Error en Gemini: {e}")
            # Retornar el error específico para que el usuario sepa si falló la API Key o la BD
            error_msg = f"Error en el servicio de IA: {str(e)}"
            self._guardar_mensaje(pregunta, error_msg, conversation_file)
            return error_msg

    # ------------------ modo consola (opcional) ------------------

    def chat(self):
        print("🤖 Chatbot ESCOM con Gemini: ¡Hola! Soy tu asistente virtual inteligente.")
        print("📚 Tengo acceso a información institucional de ESCOM.")
        print("👤 Puedo consultar tu información personal cuando sea necesario.")
        print("💾 Conversación guardada en:", self.conversation_file)
        print("💡 Ejemplos: 'mi promedio', 'inscripciones', 'requisitos reinscripción', 'horario'\n")

        if self.conversation_history:
            print(f"📖 Contexto cargado: {len(self.conversation_history)} mensajes anteriores")

        while True:
            try:
                usuario_input = input("👤 Usuario: ").strip()
                if not usuario_input:
                    continue

                if usuario_input.lower() in ["salir", "exit", "quit", "adiós", "adios", "bye"]:
                    despedida = random.choice(self.dataset.get("despedidas", ["¡Hasta luego!"]))
                    print(f"🤖 Chatbot: {despedida}")
                    self._guardar_mensaje(usuario_input, despedida)
                    break

                print("🔄 Procesando tu pregunta...")
                respuesta = self.procesar_pregunta(usuario_input)
                print(f"🤖 Chatbot: {respuesta}\n")

            except KeyboardInterrupt:
                despedida = random.choice(self.dataset.get("despedidas", ["¡Hasta luego!"]))
                print(f"\n🤖 Chatbot: {despedida}")
                break
            except Exception as e:
                error_msg = f"Ocurrió un error. Por favor, intenta de nuevo. Error: {e}"
                print(f"🤖 Chatbot: {error_msg}")
                self._guardar_mensaje(
                    usuario_input if "usuario_input" in locals() else "Unknown", error_msg
                )

    def __del__(self):
        if hasattr(self, "db_connection") and self.db_connection:
            self.db_connection.close()
            print("✅ Conexión a la base de datos cerrada")


if __name__ == "__main__":
    try:
        dataset_path = "gembto/dataset_escom.json"
        chatbot_escom = ChatbotESCOMGemini(
            dataset_path=dataset_path,
            conversation_file="conversation_history.csv",
        )
        chatbot_escom.chat()
    except Exception as e:
        print(f"❌ Error al inicializar el chatbot: {e}")
        print("\n🔧 Configuración necesaria:")
        print("1. Crea un archivo .env con:")
        print("   GEMINI_API_KEY=tu_clave_api_real")
        print("   DB_HOST=localhost")
        print("   DB_NAME=lytebd1")
        print("   DB_USER=postgres")
        print("   DB_PASSWORD=tu_password")
        print("   DB_PORT=5432")
