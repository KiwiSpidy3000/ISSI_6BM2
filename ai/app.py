# app.py
from fastapi import FastAPI, HTTPException, Body, Request
from fastapi.middleware.cors import CORSMiddleware
import os, json

from gembot import ChatbotESCOMGemini

app = FastAPI(title="IA ESCOM (Gemini)", version="1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "http://127.0.0.1:3000",
        "http://localhost:5173",
        "http://127.0.0.1:5173",
        "*",
    ],
    allow_methods=["*"],
    allow_headers=["*"],
)

DATASET_PATH = os.path.join(os.path.dirname(__file__), "dataset_escom.json")

_bot = ChatbotESCOMGemini(
    dataset_path=DATASET_PATH,
    conversation_file="conversation_history.csv"
)


@app.get("/health")
def health():
    return {"ok": True}


async def _parse_payload(request: Request) -> dict:
    ct = (request.headers.get("content-type") or "").lower()

    if "application/json" in ct:
        try:
            return await request.json()
        except Exception:
            pass

    if "application/x-www-form-urlencoded" in ct or "multipart/form-data" in ct:
        try:
            form = await request.form()
            return dict(form)
        except Exception:
            pass

    raw = (await request.body()).decode("utf-8", "ignore").strip()
    if not raw:
        return {}
    try:
        import json as _json
        return _json.loads(raw)
    except Exception:
        return {"q": raw}


def _pick_text(payload: dict):
    txt = (
        payload.get("pregunta")
        or payload.get("message")
        or payload.get("text")
        or payload.get("q")
        or ""
    ).strip()
    if not txt:
        raise HTTPException(
            422,
            "Falta el texto: usa 'pregunta' | 'message' | 'text' | 'q'"
        )
    return txt


@app.post("/ai/chat")
async def ai_chat_alias(request: Request):
    payload = await _parse_payload(request)

    q = _pick_text(payload)

    raw_boleta = payload.get("boleta")
    if raw_boleta is None:
        boleta = None
    else:
        boleta = str(raw_boleta).strip() or None   # 👈 seguro aunque venga numérica

    reply = _bot.procesar_pregunta(q, boleta_default=boleta)
    return {"reply": reply}


@app.post("/reload")
def reload_dataset():
    global _bot
    _bot = ChatbotESCOMGemini(
        dataset_path=DATASET_PATH,
        conversation_file="conversation_history.csv"
    )
    return {"reloaded": True}
