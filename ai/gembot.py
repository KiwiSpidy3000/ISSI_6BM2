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
    
    def _preparar_contexto_dataset(self, conversation_file):
        contexto_historico = self._obtener_contexto_historico(conversation_file)

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

    # ------------------ reglas rápidas antes de Gemini ------------------

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

    # ------------------ núcleo: procesar pregunta ------------------

    def procesar_pregunta(self, pregunta, boleta_default=None, conversation_file=None):
        """
        Procesa la pregunta usando Gemini con el contexto del dataset.
        La boleta NUNCA se envía a Gemini: sólo se usa localmente para
        consultar la BD cuando el modelo devuelve un comando DB_QUERY.
        """

        # 0) Atajos sin pasar por Gemini
        directa = self._reglas_directas(pregunta, boleta_default)
        if directa is not None:
            self._guardar_mensaje(pregunta, directa, conversation_file)
            return directa

        # 1) Actualizar contexto (AHORA DEPENDE DE conversation_file)
        contexto_dataset = self._preparar_contexto_dataset(conversation_file)

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
            if respuesta_gemini.startswith("DB_QUERY:"):
                cmd = respuesta_gemini[len("DB_QUERY:"):].strip()
                tipo, _, _ = cmd.partition(":")

                tipo = tipo.strip().upper()

                consultas_validas = {
                    "PROMEDIO",
                    "CALIFICACIONES",
                    "HORARIO",
                    "INFORMACION_PERSONAL",
                    "MATERIAS_INSCRITAS",
                    "KARDEX",
                    "EVALUACION_DOCENTE",
                }

                if boleta_default and tipo in consultas_validas:
                    query_real = f"{tipo}:{boleta_default}"
                else:
                    respuesta_final = (
                        "Por seguridad no puedo consultar información personal, "
                        "porque el sistema no me envió tu boleta."
                    )
                    self._guardar_mensaje(pregunta, respuesta_final, conversation_file)
                    return respuesta_final

                # 3) Ejecutar consulta en BD
                resultado_bd = self._ejecutar_query_bd(query_real)

                # 4) Pedir a Gemini que redacte la respuesta bonita (sin boleta)
                prompt_final = f"""
                Contexto del dataset ESCOM: {json.dumps(self.dataset, ensure_ascii=False)}

                El usuario preguntó: "{pregunta}"
                La consulta a la base de datos devolvió: "{resultado_bd}"

                Genera una respuesta natural, útil y profesional combinando esta información.
                Si es relevante, incorpora también información general del dataset ESCOM.
                
                Respuesta final:
                """
                respuesta_final_obj = self.model.generate_content(prompt_final)
                respuesta_final = respuesta_final_obj.text.strip()

                self._guardar_mensaje(pregunta, respuesta_final, conversation_file)
                return respuesta_final

            # 5) Respuesta directa del modelo
            self._guardar_mensaje(pregunta, respuesta_gemini, conversation_file)
            return respuesta_gemini

        except Exception as e:
            print(f"Error en Gemini: {e}")
            respuesta_error = random.choice(
                self.dataset.get(
                    "no_entendido",
                    ["Lo siento, ocurrió un error. Por favor, intenta de nuevo."],
                )
            )
            self._guardar_mensaje(pregunta, respuesta_error, conversation_file)
            return respuesta_error

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
