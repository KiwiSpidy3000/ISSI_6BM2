import os
import random
import json
import csv
import re
import uuid
import shutil
import psycopg2
import google.generativeai as genai
from dotenv import load_dotenv
from datetime import datetime

load_dotenv()


class ChatbotESCOMGemini:
    def __init__(self, dataset_path, db_config=None, conversation_file="conversation_history.csv"):
        self.dataset = self._cargar_dataset(dataset_path)
        # Configuración original de BD preservada
        self.db_config = db_config or {
            "host": os.getenv("DB_HOST", "localhost"),
            "database": os.getenv("DB_NAME", "lytebd1"),
            "user": os.getenv("DB_USER", "postgres"),
            "password": os.getenv("DB_PASSWORD", ""),
            "port": os.getenv("DB_PORT", "5432"),
        }
        self.conversation_file = conversation_file
        self._inicializar_archivo_historial()
        self.db_connection = self._conectar_bd()
        self.model = self._inicializar_gemini()
        # El contexto ya no es estático, se genera por chat_id

    # ------------------ Gestión de Archivos y Chats (NUEVO) ------------------

    def _inicializar_archivo_historial(self):
        """Crea el archivo CSV con soporte para chat_id y boleta si no existe."""
        if not os.path.exists(self.conversation_file):
            try:
                with open(self.conversation_file, "w", encoding="utf-8", newline="") as file:
                    # Columnas actualizadas para soporte multi-chat [cite: 18]
                    writer = csv.DictWriter(file, fieldnames=["chat_id", "boleta", "timestamp", "rol", "mensaje"])
                    writer.writeheader()
                print("📄 Nuevo archivo de historial creado con estructura multi-chat")
            except Exception as e:
                print(f"⚠️ Error al crear historial: {e}")

    def crear_chat(self, boleta):
        """Crea un nuevo ID de conversación[cite: 18]."""
        chat_id = str(uuid.uuid4())
        self._guardar_mensaje(chat_id, boleta, "sistema", "Inicio de nueva conversación")
        return chat_id

    def listar_chats(self, boleta):
        """Devuelve todos los chat_id asociados a una boleta[cite: 30]."""
        if not os.path.exists(self.conversation_file):
            return []
        
        chats_encontrados = set()
        try:
            with open(self.conversation_file, "r", encoding="utf-8") as file:
                reader = csv.DictReader(file)
                for row in reader:
                    if row.get("boleta") == str(boleta):
                        chats_encontrados.add(row["chat_id"])
        except Exception as e:
            print(f"Error listando chats: {e}")
            return []
        
        return list(chats_encontrados)

    def eliminar_chat(self, boleta, chat_id):
        """Elimina físicamente los registros de un chat específico[cite: 46]."""
        if not os.path.exists(self.conversation_file):
            return False

        temp_file = self.conversation_file + ".tmp"
        chat_deleted = False

        try:
            with open(self.conversation_file, "r", encoding="utf-8") as infile, \
                 open(temp_file, "w", encoding="utf-8", newline="") as outfile:
                
                reader = csv.DictReader(infile)
                writer = csv.DictWriter(outfile, fieldnames=reader.fieldnames)
                writer.writeheader()

                for row in reader:
                    # Si coincide chat_id Y boleta, NO lo escribimos (borrado lógico)
                    if row["chat_id"] == chat_id and row["boleta"] == str(boleta):
                        chat_deleted = True
                        continue
                    writer.writerow(row)
            
            shutil.move(temp_file, self.conversation_file)
            return chat_deleted
        except Exception as e:
            print(f"Error al eliminar chat: {e}")
            return False

    def _guardar_mensaje(self, chat_id, boleta, rol, mensaje_texto):
        """Guarda mensaje con contexto de chat y usuario."""
        try:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            row = {
                "chat_id": chat_id,
                "boleta": boleta,
                "timestamp": timestamp,
                "rol": rol,     # 'usuario', 'modelo' o 'sistema'
                "mensaje": mensaje_texto,
            }
            with open(self.conversation_file, "a", encoding="utf-8", newline="") as file:
                writer = csv.DictWriter(file, fieldnames=["chat_id", "boleta", "timestamp", "rol", "mensaje"])
                writer.writerow(row)
        except Exception as e:
            print(f"⚠️ Error al guardar mensaje: {e}")

    def _obtener_contexto_historico(self, chat_id, num_mensajes=6):
        """Recupera historial filtrado solo para el chat_id actual[cite: 42]."""
        if not os.path.exists(self.conversation_file) or not chat_id:
            return ""

        mensajes_chat = []
        try:
            with open(self.conversation_file, "r", encoding="utf-8") as file:
                reader = csv.DictReader(file)
                for row in reader:
                    # Filtramos por ID de chat
                    if row.get("chat_id") == chat_id and row.get("rol") != "sistema":
                        mensajes_chat.append(row)
        except Exception:
            return ""

        contexto = "\nCONTEXTO DE ESTA CONVERSACIÓN:\n"
        mensajes_recientes = mensajes_chat[-num_mensajes:]

        for m in mensajes_recientes:
            if m["rol"] == "usuario":
                contexto += f"Usuario: {m['mensaje']}\n"
            elif m["rol"] == "modelo":
                contexto += f"Asistente: {m['mensaje']}\n"

        return contexto

    def obtener_historial_chat(self, boleta, chat_id):
        """Devuelve el historial completo de un chat específico como lista de dicts."""
        if not os.path.exists(self.conversation_file):
            return []
            
        mensajes = []
        try:
            with open(self.conversation_file, "r", encoding="utf-8") as file:
                reader = csv.DictReader(file)
                for row in reader:
                    # Validamos boleta y chat_id
                    if row.get("chat_id") == chat_id and row.get("boleta") == str(boleta):
                         # Convertimos rol de 'modelo' a 'bot' para consistencia con frontend si es necesario,
                         # o lo dejamos tal cual. El front usa 'bot' y 'user'.
                         # En csv guardamos: 'usuario', 'modelo', 'sistema'.
                         
                         rol_csv = row.get("rol")
                         rol_front = "bot"
                         if rol_csv == "usuario":
                             rol_front = "user"
                         elif rol_csv == "modelo":
                             rol_front = "bot"
                         elif rol_csv == "sistema":
                             continue # Omitimos mensajes de sistema si queremos
                             
                         mensajes.append({
                             "from": rol_front,
                             "text": row.get("mensaje"),
                             "timestamp": row.get("timestamp")
                         })
        except Exception as e:
             print(f"Error recuperando historial: {e}")
             return []
             
        return mensajes

    # ------------------ utilidades básicas (Originales) ------------------

    def _cargar_dataset(self, dataset_path):
        try:
            with open(dataset_path, "r", encoding="utf-8") as file:
                return json.load(file)
        except Exception as e:
            raise ValueError(f"Error al cargar el dataset: {e}")

    def _conectar_bd(self):
        try:
            conn = psycopg2.connect(**self.db_config)
            conn.autocommit = True
            print("✅ Conexión a la base de datos local establecida")
            return conn
        except Exception as e:
            print(f"❌ Error al conectar con la base de datos local: {e}")
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

    def _preparar_contexto_dataset(self, chat_id):
        # El contexto ahora depende del chat_id específico
        contexto_historico = self._obtener_contexto_historico(chat_id)

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

        Además, tienes acceso a una base de datos real con información personal de estudiantes.

        INSTRUCCIONES IMPORTANTES:
        1. Para preguntas generales sobre reglamentos, inscripciones, reinscripciones, etc.: 
           Responde en base a la información del dataset, siendo útil y preciso.

        2. Para consultas que requieran datos específicos del estudiante (calificaciones, promedio, horarios, etc.): 
           - Identifica que necesitas acceder a la base de datos
           - Devuelve un comando especial en el formato: DB_QUERY:[TIPO_QUERY]:[PARÁMETROS]
           - NO intentes inventar datos personales ni boletas.

        3. Considera el contexto de conversación anterior para mantener continuidad.

        4. Sé amable, profesional y proporciona información verídica según el dataset.

        FORMATOS DE QUERY PARA BASE DE DATOS:
        - PROMEDIO:[BOLETA]
        - CALIFICACIONES:[BOLETA]
        - HORARIO:[BOLETA]
        - INFORMACION_PERSONAL:[BOLETA]
        - MATERIAS_INSCRITAS:[BOLETA]
        - KARDEX:[BOLETA]
        - EVALUACION_DOCENTE:[BOLETA]

        EJEMPLOS:
        - Usuario: "¿Cuál es mi promedio?" -> DB_QUERY:PROMEDIO:DEFAULT
        - Usuario: "Necesito mis calificaciones" -> DB_QUERY:CALIFICACIONES:DEFAULT
        """

    # ------------------ acceso BD (Originales) ------------------

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

            else:
                return "Tipo de query no reconocido"

        except Exception as e:
            return f"Error al consultar la base de datos: {str(e)}"
        finally:
            if cursor:
                cursor.close()

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

    def _obtener_informacion_personal(self, cursor, boleta):
        query = """
        SELECT u.nombre, u.apellido, u.email, c.nombre as carrera, a.semestre
        FROM escom_aliz.alumno a
        JOIN escom_aliz.usuario u ON a.id_alumno = u.id_usuario
        JOIN escom_aliz.carrera c ON a.id_carrera = c.id_carrera
        WHERE a.boleta = %s
        """
        cursor.execute(query, (boleta,))
        info = cursor.fetchone()

        if not info:
            return "No se encontró información del estudiante."

        nombre, apellido, email, carrera, semestre = info
        return (
            "Información del estudiante:\n"
            f"- Nombre: {nombre} {apellido}\n"
            f"- Email: {email}\n"
            f"- Carrera: {carrera}\n"
            f"- Semestre: {semestre}"
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

    # ------------------ reglas rápidas (Actualizadas) ------------------

    def _reglas_directas(self, pregunta, boleta_default=None):
        t = pregunta.lower()

        # Preguntas de promedio
        if "promedio" in t:
            boleta = boleta_default or self._extraer_boleta(pregunta)
            if not boleta:
                return (
                    "Por seguridad no puedo consultar tu promedio porque el sistema "
                    "no me envió tu boleta."
                )
            return self._ejecutar_query_bd(f"PROMEDIO:{boleta}")

        # Horario
        if "horario" in t:
            boleta = boleta_default or self._extraer_boleta(pregunta)
            if not boleta:
                return (
                    "Por seguridad no puedo consultar tu horario porque el sistema "
                    "no me envió tu boleta."
                )
            return self._ejecutar_query_bd(f"HORARIO:{boleta}")

        # Kardex
        if "kardex" in t:
            boleta = boleta_default or self._extraer_boleta(pregunta)
            if not boleta:
                return (
                    "Por seguridad no puedo consultar tu kardex porque el sistema "
                    "no me envió tu boleta."
                )
            return self._ejecutar_query_bd(f"KARDEX:{boleta}")

        # Derechos de estudiantes
        if "derechos" in t and ("estudiante" in t or "estudiantes" in t or "alumno" in t):
            reglamento = self.dataset.get("reglamento", {})
            texto = reglamento.get("derechos")
            if texto:
                return texto

        return None

    # ------------------ núcleo: procesar pregunta (Actualizado) ------------------

    def procesar_pregunta(self, pregunta, boleta, chat_id):
        """
        Procesa la pregunta dentro de un chat específico. [cite: 55]
        """
        # Validación
        if not chat_id:
            return "Error: Se requiere un ID de chat para procesar el mensaje."
        
        # 0) Guardar mensaje del usuario
        self._guardar_mensaje(chat_id, boleta, "usuario", pregunta)

        # 0.5) Atajos sin pasar por Gemini (Reglas directas)
        directa = self._reglas_directas(pregunta, boleta)
        if directa is not None:
            self._guardar_mensaje(chat_id, boleta, "modelo", directa)
            return directa

        # 1) Actualizar contexto ESPECÍFICO para este chat_id
        self.contexto_dataset = self._preparar_contexto_dataset(chat_id)

        prompt = f"""
        {self.contexto_dataset}
        
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
            if respuesta_gemini.startswith("DB_QUERY:"):
                cmd = respuesta_gemini[len("DB_QUERY:"):].strip()
                tipo, _, _ = cmd.partition(":")
                tipo = tipo.strip().upper()

                # Consultas válidas
                consultas_validas = {
                    "PROMEDIO",
                    "CALIFICACIONES",
                    "HORARIO",
                    "INFORMACION_PERSONAL",
                    "MATERIAS_INSCRITAS",
                    "KARDEX",
                    "EVALUACION_DOCENTE",
                }

                if boleta and tipo in consultas_validas:
                    # Usamos la boleta que viene del request, no una extraída del texto
                    query_real = f"{tipo}:{boleta}"
                else:
                    respuesta_final = (
                        "Por seguridad no puedo consultar información personal, "
                        "porque el sistema no me envió tu boleta válida."
                    )
                    self._guardar_mensaje(chat_id, boleta, "modelo", respuesta_final)
                    return respuesta_final

                # 3) Ejecutar consulta en BD
                resultado_bd = self._ejecutar_query_bd(query_real)

                # 4) Pedir a Gemini que redacte la respuesta bonita
                prompt_final = f"""
                Contexto del dataset ESCOM: {json.dumps(self.dataset, ensure_ascii=False)}

                El usuario preguntó: "{pregunta}"
                La consulta a la base de datos devolvió: "{resultado_bd}"

                Genera una respuesta natural, útil y profesional combinando esta información.
                
                Respuesta final:
                """
                respuesta_final_obj = self.model.generate_content(prompt_final)
                respuesta_final = respuesta_final_obj.text.strip()

                self._guardar_mensaje(chat_id, boleta, "modelo", respuesta_final)
                return respuesta_final

            # 5) Respuesta directa del modelo
            self._guardar_mensaje(chat_id, boleta, "modelo", respuesta_gemini)
            return respuesta_gemini

        except Exception as e:
            print(f"Error en Gemini: {e}")
            respuesta_error = random.choice(
                self.dataset.get(
                    "no_entendido",
                    ["Lo siento, ocurrió un error. Por favor, intenta de nuevo."],
                )
            )
            self._guardar_mensaje(chat_id, boleta, "modelo", respuesta_error)
            return respuesta_error

    # ------------------ modo consola (opcional/debug) ------------------

    def chat(self):
        print("🤖 Chatbot ESCOM con Gemini: ¡Hola! Soy tu asistente virtual inteligente.")
        print("💾 Sistema Multi-Chat activado.")
        
        # Para pruebas en consola, creamos un chat temporal con boleta falsa
        boleta_debug = "2020630000" 
        chat_id_debug = self.crear_chat(boleta_debug)
        print(f"🆔 Chat ID temporal: {chat_id_debug}")

        while True:
            try:
                usuario_input = input("👤 Usuario: ").strip()
                if not usuario_input:
                    continue

                if usuario_input.lower() in ["salir", "exit", "quit", "adiós", "adios", "bye"]:
                    print("🤖 Chatbot: ¡Hasta luego!")
                    break

                print("🔄 Procesando tu pregunta...")
                # Llamada actualizada con los 3 argumentos
                respuesta = self.procesar_pregunta(usuario_input, boleta_debug, chat_id_debug)
                print(f"🤖 Chatbot: {respuesta}\n")

            except KeyboardInterrupt:
                print("\n🤖 Chatbot: ¡Hasta luego!")
                break
            except Exception as e:
                print(f"Error: {e}")

    def __del__(self):
        if hasattr(self, "db_connection") and self.db_connection:
            self.db_connection.close()
            print("✅ Conexión a la base de datos cerrada")


if __name__ == "__main__":
    try:
        dataset_path = "ISSI_6BM2/ai/dataset_escom.json" # Asegúrate que la ruta sea correcta
        chatbot_escom = ChatbotESCOMGemini(
            dataset_path=dataset_path,
            conversation_file="conversation_history.csv",
        )
        chatbot_escom.chat()
    except Exception as e:
        print(f"❌ Error al inicializar el chatbot: {e}")