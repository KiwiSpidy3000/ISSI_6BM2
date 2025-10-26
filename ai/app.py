import random, json, re
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

class ChatbotESCOM:
    def __init__(self):
        self.dataset = None
        self.contexto = {}
        self.load_dataset()

    def load_dataset(self, file_path: str | None = None):
        if file_path:
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    self.dataset = json.load(f)
                    return
            except Exception:
                pass
        self.dataset = self._default_dataset()

    def _default_dataset(self):
        return {
            "saludos": [
                "Hola, soy el asistente virtual de ESCOM. ¿En qué puedo ayudarte?",
                "¡Buen día! Soy el chatbot de ESCOM. ¿Tienes alguna pregunta sobre el reglamento?",
                "Hola, estoy aquí para resolver tus dudas sobre el reglamento de ESCOM."
            ],
            "despedidas": [
                "¡Hasta luego! Recuerda revisar el reglamento completo en SAES.",
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
            "no_entendido": [
                "Lo siento, no entendí tu pregunta. ¿Podrías reformularla?",
                "No estoy seguro de entender. ¿Puedes ser más específico?",
                "Mi conocimiento es limitado sobre ese tema. ¿Tienes otra pregunta?"
            ]
        }

    def preprocess_text(self, text: str) -> str:
        text = text.lower().strip()
        text = re.sub(r"[^\w\s]", "", text)
        return text

    def find_intent(self, text: str) -> str:
        text = self.preprocess_text(text)
        saludos = ["hola", "buenos dias", "buenas tardes", "buenas noches", "saludos"]
        despedidas = ["adios", "hasta luego", "chao", "nos vemos", "bye"]
        if any(word in text for word in saludos): return "saludo"
        if any(word in text for word in despedidas): return "despedida"
        for keyword in self.dataset["reglamento"].keys():
            if keyword in text:
                return f"reglamento_{keyword}"
        return "no_entendido"

    def get_response(self, user_input: str) -> str:
        intent = self.find_intent(user_input)
        if intent == "saludo":
            return random.choice(self.dataset["saludos"])
        if intent == "despedida":
            return random.choice(self.dataset["despedidas"])
        if intent.startswith("reglamento_"):
            topic = intent.replace("reglamento_", "")
            return self.dataset["reglamento"].get(topic, "No tengo información sobre ese tema.")
        return random.choice(self.dataset["no_entendido"])

# ----------- FastAPI -----------
bot = ChatbotESCOM()
app = FastAPI(title="Lyte - Chatbot ESCOM")

# Permitir llamadas desde front/back locales
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000", "*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ChatMsg(BaseModel):
    message: str

@app.get("/")
def health():
    return {"ok": True, "service": "chatbot"}

@app.post("/chat")
def chat(msg: ChatMsg):
    reply = bot.get_response(msg.message)
    return {"reply": reply}
