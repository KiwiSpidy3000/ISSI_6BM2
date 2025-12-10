# app.py
from fastapi import FastAPI, HTTPException, Body, Request
from fastapi.middleware.cors import CORSMiddleware
import os, json

from gembot import ChatbotESCOMGemini
from chat_manager import ChatManager

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
    dataset_path=DATASET_PATH
)
_chat_manager = ChatManager()


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

    # Chat ID management
    chat_id = payload.get("chat_id")
    user_id = payload.get("user_id") # Needed to locate the file

    conversation_file = None
    if chat_id and user_id:
        conversation_file = _chat_manager.get_chat_file_path(user_id, chat_id)
        if not conversation_file:
             # Auto-create if not exists? Or just fail? Let's fail for now or treat as transient.
             # Better: backend creates on demand if valid user/chat provided? 
             # No, let's enforce explicit creation via /ai/chat/new for clarity, 
             # but if frontend sends a chat_id that file should exist.
             # If it doesn't exist, we might fall back to no history or error.
             # Let's try to ensure it exists or create it?
             # For robustness, if file missing but ID provided, maybe just use it?
             pass 

    reply = _bot.procesar_pregunta(q, boleta_default=boleta, conversation_file=conversation_file)
    return {"reply": reply}


@app.post("/reload")
def reload_dataset():
    global _bot
    _bot = ChatbotESCOMGemini(
        dataset_path=DATASET_PATH
    )
    return {"reloaded": True}

# --- Chat Management Endpoints ---

@app.post("/ai/chats/new")
async def create_new_chat(request: Request):
    payload = await _parse_payload(request)
    print(f"DEBUG: create_new_chat payload received: {payload}")
    user_id = payload.get("user_id")
    if not user_id:
         raise HTTPException(status_code=400, detail="Missing user_id")
    
    chat_data = _chat_manager.create_chat(user_id)
    return chat_data

@app.get("/ai/chats")
async def list_user_chats(user_id: str):
    if not user_id:
        raise HTTPException(status_code=400, detail="Missing user_id")
    return _chat_manager.list_chats(user_id)

@app.delete("/ai/chats/{chat_id}")
async def delete_user_chat(chat_id: str, user_id: str):
    if not user_id or not chat_id:
        raise HTTPException(status_code=400, detail="Missing parameters")
    success = _chat_manager.delete_chat(user_id, chat_id)
    return {"deleted": success}

@app.get("/ai/chats/{chat_id}")
async def get_chat_history(chat_id: str, user_id: str):
    if not user_id or not chat_id:
        raise HTTPException(status_code=400, detail="Missing parameters")
    history = _chat_manager.get_history(user_id, chat_id)
    return history
