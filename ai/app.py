# app.py
from fastapi import FastAPI, HTTPException, Body, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os, json
from gembot import ChatbotESCOMGemini, dataset_escom

app = FastAPI(title="IA ESCOM (Gemini)", version="1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000","http://127.0.0.1:3000","http://localhost:5173","http://127.0.0.1:5173","*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

DATASET_PATH = os.path.join(os.path.dirname(__file__), "dataset_escom.json")

def cargar_dataset():
    if os.path.exists(DATASET_PATH):
        with open(DATASET_PATH,"r",encoding="utf-8") as f:
            return json.load(f)
    return dataset_escom

_bot = ChatbotESCOMGemini(cargar_dataset())

@app.get("/health")
def health(): return {"ok": True}

def _pick_text(payload: dict):
    txt = (payload.get("pregunta")
           or payload.get("message")
           or payload.get("text")
           or payload.get("q")
           or "").strip()
    if not txt:
        raise HTTPException(422, "Falta el texto: usa 'pregunta' | 'message' | 'text' | 'q'")
    return txt

@app.post("/classify")
def classify(payload: dict = Body(...)):
    q = _pick_text(payload)
    cat = _bot.clasificar_intencion(q)
    return {"categoria": cat}

@app.post("/answer")
def answer(payload: dict = Body(...)):
    cat = (payload.get("categoria") or "").strip()
    if not cat: raise HTTPException(422, "Falta 'categoria'")
    resp = _bot.generar_respuesta(cat)
    return {"respuesta": resp}

@app.post("/chat")
async def chat(request: Request):
    payload = await _parse_payload(request)
    q = _pick_text(payload)
    cat = _bot.clasificar_intencion(q)
    resp = _bot.generar_respuesta(cat)
    return {"categoria": cat, "respuesta": resp}

@app.post("/ai/chat")
async def ai_chat_alias(request: Request):
    payload = await _parse_payload(request)
    q = _pick_text(payload)
    cat = _bot.clasificar_intencion(q)
    resp = _bot.generar_respuesta(cat)
    return {"reply": resp, "categoria": cat}

@app.post("/reload")
def reload_dataset():
    global _bot
    _bot = ChatbotESCOMGemini(cargar_dataset())
    return {"reloaded": True}

# --- helper: aceptar json/form/text ---
async def _parse_payload(request: Request) -> dict:
    ct = (request.headers.get("content-type") or "").lower()
    # JSON
    if "application/json" in ct:
        try:
            return await request.json()
        except Exception:
            pass
    # FORM
    if "application/x-www-form-urlencoded" in ct or "multipart/form-data" in ct:
        try:
            form = await request.form()
            return dict(form)
        except Exception:
            pass
    # TEXTO PLANO o cuerpo raro
    raw = (await request.body()).decode("utf-8", "ignore").strip()
    if not raw:
        return {}
    try:
        import json as _json
        return _json.loads(raw)  # por si mandaron JSON sin header
    except Exception:
        return {"q": raw}  # usa el cuerpo como texto

def _pick_text(payload: dict):
    txt = (payload.get("pregunta")
           or payload.get("message")
           or payload.get("text")
           or payload.get("q")
           or "").strip()
    if not txt:
        raise HTTPException(422, "Falta el texto: usa 'pregunta' | 'message' | 'text' | 'q'")
    return txt