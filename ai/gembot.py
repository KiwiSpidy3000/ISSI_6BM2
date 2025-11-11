import os
import random
import google.generativeai as genai
from dotenv import load_dotenv

load_dotenv()

class ChatbotESCOMGemini:
    def __init__(self, dataset):
        self.dataset = dataset
        self.model = self._inicializar_gemini()
        
    def _inicializar_gemini(self):
        """Inicializa la API de Gemini"""
        api_key = os.getenv('GEMINI_API_KEY')
        if not api_key:
            raise ValueError("❌ No se encontró GEMINI_API_KEY en las variables de entorno")
        
        genai.configure(api_key=api_key)
        return genai.GenerativeModel('gemini-2.5-flash')
    #esta funcion solo se actualiza poniendo el resto de las demas categorias cuando el otro integrante de chatbot las tenga 
    def clasificar_intencion(self, pregunta):
        """Usa Gemini para clasificar la intención de la pregunta"""
        
        prompt = f"""
        Eres un clasificador de intenciones para un chatbot de ESCOM (Escuela Superior de Cómputo).
        Clasifica la siguiente pregunta en UNA SOLA de estas categorías:
        
        CATEGORÍAS DISPONIBLES:
        - saludos: Saludos iniciales como "hola", "buenos días", etc.
        - despedidas: Despedidas como "adiós", "hasta luego", etc.
        - inscripcion_fechas: Preguntas sobre fechas de inscripción
        - inscripcion_requisitos: Preguntas sobre documentos/requisitos para inscripción
        - inscripcion_costo: Preguntas sobre costo de inscripción
        - inscripcion_derechos: Preguntas sobre derechos al inscribirse
        - inscripcion_sanciones: Preguntas sobre sanciones por documentación falsa
        - reinscripcion_fechas: Preguntas sobre fechas de reinscripción
        - reinscripcion_creditos: Preguntas sobre créditos académicos
        - reinscripcion_requisitos: Preguntas sobre requisitos para reinscripción
        - reinscripcion_bajas: Preguntas sobre bajas de materias
        - reglamento_asistencias: Preguntas sobre reglamento de asistencias
        - reglamento_calificaciones: Preguntas sobre calificaciones mínimas
        - reglamento_derechos: Preguntas sobre derechos del estudiante
        - reglamento_obligaciones: Preguntas sobre obligaciones del alumno
        - reglamento_faltas: Preguntas sobre tipos de faltas académicas
        - reglamento_evaluaciones: Preguntas sobre evaluaciones parciales
        - no_entendido: Para preguntas no comprendidas o fuera del contexto
        
        Responde ÚNICAMENTE con el nombre de la categoría, sin explicaciones adicionales.
        
        Pregunta del usuario: "{pregunta}"
        
        Categoría: """
        
        try:
            response = self.model.generate_content(prompt)
            categoria = response.text.strip().lower()
            
          
            categorias_validas = [
                'saludos', 'despedidas', 'no_entendido',
                'inscripcion_fechas', 'inscripcion_requisitos', 'inscripcion_costo', 
                'inscripcion_derechos', 'inscripcion_sanciones',
                'reinscripcion_fechas', 'reinscripcion_creditos', 'reinscripcion_requisitos', 'reinscripcion_bajas',
                'reglamento_asistencias', 'reglamento_calificaciones', 'reglamento_derechos',
                'reglamento_obligaciones', 'reglamento_faltas', 'reglamento_evaluaciones'
            ]
            
            if categoria in categorias_validas:
                return categoria
            else:
                return "no_entendido"
                
        except Exception as e:
            print(f"Error en Gemini: {e}")
            return "no_entendido"
    #esta funcion tambien se actualiza
    def generar_respuesta(self, categoria):
        """Genera una respuesta basada en la categoría clasificada"""
        if categoria == "saludos":
            return random.choice(self.dataset['saludos'])
        
        elif categoria == "despedidas":
            return random.choice(self.dataset['despedidas'])
        
        elif categoria == "inscripcion_fechas":
            return self.dataset['inscripcion']['fechas']
        
        elif categoria == "inscripcion_requisitos":
            return self.dataset['inscripcion']['requisitos']
        
        elif categoria == "inscripcion_costo":
            return self.dataset['inscripcion']['costo']
        
        elif categoria == "inscripcion_derechos":
            return self.dataset['inscripcion']['derechos']
        
        elif categoria == "inscripcion_sanciones":
            return self.dataset['inscripcion']['Sanciones']
        
        elif categoria == "reinscripcion_fechas":
            return self.dataset['reinscripcion']['fechas']
        
        elif categoria == "reinscripcion_creditos":
            return self.dataset['reinscripcion']['creditos']
        
        elif categoria == "reinscripcion_requisitos":
            return self.dataset['reinscripcion']['requisitos']
        
        elif categoria == "reinscripcion_bajas":
            return self.dataset['reinscripcion']['bajas_materias']
        
        elif categoria == "reglamento_asistencias":
            return self.dataset['reglamento']['asistencias']
        
        elif categoria == "reglamento_calificaciones":
            return self.dataset['reglamento']['calificaciones']
        
        elif categoria == "reglamento_derechos":
            return self.dataset['reglamento']['derechos']
        
        elif categoria == "reglamento_obligaciones":
            return self.dataset['reglamento']['obligaciones']
        
        elif categoria == "reglamento_faltas":
            return self.dataset['reglamento']['faltas']
        
        elif categoria == "reglamento_evaluaciones":
            return self.dataset['reglamento']['evaluaciones']
        
        else:
            return random.choice(self.dataset['no_entendido'])
    
    def chat(self):
        """Función principal del chatbot"""
        print("Chatbot ESCOM con Gemini: ¡Hola! Soy tu asistente virtual inteligente.")
        print("\n")
        
        while True:
            try:
                usuario_input = input("Usuario: ").strip()
                
                if not usuario_input:
                    continue
                
               
                print("🔄 Procesando tu pregunta...")
                categoria = self.clasificar_intencion(usuario_input)
                respuesta = self.generar_respuesta(categoria)
                
                print(f"Chatbot: {respuesta}\n")
                print(f"(Intención detectada: {categoria})\n")
                
               
                if categoria == "despedidas":
                    break
                    
            except KeyboardInterrupt:
                print(f"\n Chatbot: {random.choice(self.dataset['despedidas'])}")
                break
            except Exception as e:
                print(f" Chatbot: Ocurrió un error. Por favor, intenta de nuevo.")
                print(f"Error: {e}")

#Aqui se implementaria el dataset que va a pasar el otro integrante del modulo de chatbot
dataset_escom = {
    "saludos": [
        "Hola, soy el asistente virtual de ESCOM. ¿En qué puedo ayudarte?",
        "¡Buen día! Soy el chatbot de ESCOM. ¿Tienes alguna pregunta sobre trámites escolares?",
        "Hola, estoy aquí para resolver tus dudas sobre el sistema de gestión escolar."
    ],
    "despedidas": [
        "¡Hasta luego! Revisa tu información en SAES.",
        "Fue un placer ayudarte. ¡Éxito en tus estudios!",
        "¡Adiós! No dudes en consultarme si tienes más preguntas."
    ],
    "reglamento": {
        "asistencias": "El porcentaje mínimo de asistencia requerido es del 80% para tener derecho a examen.",
        "calificaciones": "La calificación mínima aprobatoria es 6.0 en escala de 0 a 10.",
        "derechos": "Los estudiantes tienen derecho a revisar sus exámenes y solicitar aclaraciones.",
        "obligaciones": "Es obligatorio portar la credencial de estudiante dentro de las instalaciones.",
        "faltas": "Las faltas académicas se clasifican en leves, graves y muy graves.",
        "evaluaciones": "Debes presentar todas las evaluaciones parciales para tener derecho a calificación final."
    },
    
    "inscripcion": {
        "fechas": "El próximo periodo de inscripciones para alumnos de nuevo ingreso será el 3 de Febrero de 2026, de igual manera recuerda que puedes consultar información de próximas fechas en el calendario oficial. Recuerda que de no concluir el procedimiento de inscripción antes de los plazos y fechas, o se incumple con las condiciones establecidas en la convocatoria para la admisión del aspirante, se cancelarán los trámites realizados sin que haya responsabilidad alguna para el Instituto.",
        "requisitos": "Los requisitos para ingresar como alumno al Instituto de acuerdo al árticulo 6 del reglamento general de estudios son:\n1) Cumplir con los antecedentes académicos y demás requisitos que señale la convocatoria respectiva.\n2) Presentar el examen de admisión para el nivel superior.\n3) Ser seleccionado para ingresar.\nRecuerda que como aspirante de acuerdo al árticulo 8 del reglamento general de estudios al cumplir con todos los requisitos de ingreso y al realizar en tiempo y forma tu trámite de inscripción adquirirás la calidad de alumno con los derechos y obligaciones que establezcan las disposiciones normativas aplicables.",
        "costo": "La inscripción para los alumnos de nuevo ingreso es totalmente gratuita, pero si deseas apoyar a tu nueva institución puedes realizar un donativo en la cuenta bancaria que indica el documento en la convocatoria de inscripción",
        "derechos": "El ingreso mediante el proceso de admisión al Instituto permite al alumno:\n1) Iniciar, continuar y concluir un programa académico.\n2) Cursar en cualquier periodo escolar en que se impartan unidades de aprendizaje de conformidad con el programa académico.\n3) Realizar movilidad académica atendiendo lo establecido en el artículo 62 del presente Reglamento.\n4) Solicitar la equivalencia o revalidación de estudios, de conformidad con los artículos 17 y 18 del Reglamento General de Estudios, según sea el caso.",
        "Sanciones":"La inscripción será nula de pleno derecho cuando el aspirante entregue documentación falsa o alterada, haciéndose del conocimiento de la Oficina del Abogado General del Instituto para que en el ámbito de su competencia ejerza las acciones legales conducentes. En este supuesto, el aspirante no podrá gestionar nueva inscripción a programa académico."
    },
    "reinscripcion": {
        "fechas": "El próximo periodo de reinscripciones para alumnos de segundo semestre o superior será el 3 de Febrero de 2026",
        "creditos": "Para tu reinscripción debes tener en cuenta que acorde a tu plan de estudio tienes un total de creditos que emplearas para completar tu trayecto academico en el plan que estes inscrito, para cada semestre tendras un numero de creditos que te permitiran inscribir una cierta cantidad de materias dependiendo de tu carga academica.",
        "requisitos": "Para poder reinscribirte a un semestre posterior debes tener en cuenta los siguientes puntos:\n1)Si el alumno se encuentra en situación escolar regular, podrá reinscribirse en un número de créditos comprendido entre la carga mínima y la máxima indicadas en el plan de estudio. Cuando el alumno solicite reinscribirse a una carga menor a la mínima o mayor a la máxima, deberá presentar por escrito una solicitud justificada al titular de la unidad académica para que, en su caso, obtenga la autorización correspondiente, en un término no mayor a tres días hábiles, siempre que esto no implique sobrepasar la duración máxima del plan.\n2) Si el alumno tiene adeudos de unidades de aprendizaje, tendrá derecho a recursar sus adeudos de acuerdo con el Artículo 48 del Reglamento General de Estudios, e inscribir unidades de aprendizaje adicionales de su plan de estudio hasta completar al menos la carga mínima y sin rebasar la carga media de créditos del plan, siempre y cuando no se encuentre en el supuesto del Artículo 98 del Reglamento Interno. \nCuando el alumno no pueda recursar las unidades\nde aprendizaje adeudadas en el periodo escolar correspondiente, no podrá sustituirlas por unidades de aprendizaje diferentes a las que adeuda.\nEn caso de no poder reinscribirse, podrá presentar la evaluación a título de suficiencia en el periodo escolar correspondiente, el cual será contabilizado en la duración de su trayectoria escolar.\n3)Si el alumno adeuda al menos una unidad de aprendizaje en términos de lo establecido en el Artículo 98 del Reglamento Interno, o si adeudando una unidad de aprendizaje de cualquier otro period escolar solicita reinscribirse a una carga menor a la mínima, deberá presentar por escrito una solicitud justificada a la Comisión de Situación Escolar del Consejo Técnico Consultivo Escolar para, en su caso, obtener la autorización correspondiente.",
        "bajas_materias": "Puedes dar de baja en las tres primeras semanas habiles las materias que hayas inscrito en el semstre que este cursando, pero solo si mantienes la carga minima de creditos establecido en tu plan de estudio. Tratándose de una misma unidad de aprendizaje procederá la baja en un máximo de dos ocasiones. En ambos casos deberas presentar la solicitud por escrito antes la Subdirección de Servicios Educativos e Integración Social o el Colegio de Profesores, esto durante las primeras tres semanas del comienzo de tu periodo escolar. Considera que: Si la materia que quieras dar de baja es una materia que estes recursando, la baja de la materia no procedera."
    },
    "no_entendido": [
        "Lo siento, no entendí tu pregunta. ¿Podrías reformularla?",
        "No estoy seguro de entender. ¿Puedes ser más específico?",
        "Mi conocimiento es limitado sobre ese tema. ¿Tienes otra pregunta?"
    ]
}



if __name__ == "__main__":
    try:
        chatbot_escom = ChatbotESCOMGemini(dataset_escom)
        
        print("Hola! ¿En que puedo ayudarte el dia de hoy?")
        
    
        chatbot_escom.chat()
       
            
            
    except Exception as e:
        print(f"❌ Error al inicializar el chatbot: {e}")
        print("\n🔧 Configuración necesaria:")
        print("1. Crea un archivo .env en la misma carpeta")
        print("2. Agrega: GEMINI_API_KEY=tu_clave_api_real")
        print("3. Obtén tu API key en: https://aistudio.google.com/")
        print("4. Instala: pip install google-generativeai python-dotenv")