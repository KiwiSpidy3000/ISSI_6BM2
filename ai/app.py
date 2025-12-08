# app.py
from fastapi import FastAPI, HTTPException, Body, Request
from fastapi.middleware.cors import CORSMiddleware
import os, json

from gembot import ChatbotESCOMGemini

app = FastAPI(title="IA ESCOM (Gemini)", version="2.0")

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
    # Para endpoints que solo gestionan chats, el texto puede ser opcional
    return txt 


# --- Endpoint de Mensajería ---

@app.post("/ai/chat")
async def ai_chat_alias(request: Request):
    """Envía un mensaje a un chat existente."""
    payload = await _parse_payload(request)

    q = _pick_text(payload)
    if not q:
        raise HTTPException(422, "Falta el texto de la pregunta")

    raw_boleta = payload.get("boleta")
    chat_id = payload.get("chat_id")

    if raw_boleta is None:
        raise HTTPException(400, "Se requiere la boleta del usuario")
    
    boleta = str(raw_boleta).strip()
    
    # Si no envían chat_id, podemos optar por crear uno o lanzar error.
    # Aquí lanzaremos error para forzar al front a crear el chat primero, 
    # o creamos uno al vuelo si prefieres esa lógica (descomenta abajo):
    if not chat_id:
         # chat_id = _bot.crear_chat(boleta)
         raise HTTPException(400, "Se requiere chat_id. Crea un chat primero en /ai/chat/new")

    reply = _bot.procesar_pregunta(q, boleta, chat_id)
    
    return {"reply": reply, "chat_id": chat_id}


# --- Endpoints de Gestión de Chats (Nuevos) ---

@app.post("/ai/chat/new")
async def create_new_chat(request: Request):
    """Crea una nueva conversación para el usuario."""
    payload = await _parse_payload(request)
    boleta = payload.get("boleta")
    
    if not boleta:
        raise HTTPException(400, "Se requiere boleta para crear un chat.")
        
    chat_id = _bot.crear_chat(str(boleta))
    return {
        "success": True, 
        "chat_id": chat_id, 
        "message": "Conversación creada exitosamente"
    }

@app.post("/ai/chats")
async def get_user_chats(request: Request):
    """Lista todas las conversaciones del usuario."""
    payload = await _parse_payload(request)
    boleta = payload.get("boleta")
    
    if not boleta:
        raise HTTPException(400, "Se requiere boleta.")
        
    chats = _bot.listar_chats(str(boleta))
    return {
        "success": True,
        "conversaciones": chats,
        "total": len(chats)
    }

@app.post("/ai/chat/delete")
async def delete_chat(request: Request):
    """Elimina una conversación específica."""
    payload = await _parse_payload(request)
    boleta = payload.get("boleta")
    chat_id = payload.get("chat_id")
    
    if not boleta or not chat_id:
        raise HTTPException(400, "Faltan datos (boleta o chat_id).")
        
    success = _bot.eliminar_chat(str(boleta), chat_id)
    
    if success:
        return {"success": True, "status": "deleted", "chat_id": chat_id}
    else:
        raise HTTPException(404, "Chat no encontrado o no pertenece al usuario.")


@app.post("/ai/chat/history")
async def get_chat_history_endpoint(request: Request):
    """Obtiene el historial completo de una conversación."""
    payload = await _parse_payload(request)
    boleta = payload.get("boleta")
    chat_id = payload.get("chat_id")
    
    if not boleta or not chat_id:
        raise HTTPException(400, "Faltan datos (boleta o chat_id).")
        
    history = _bot.obtener_historial_chat(str(boleta), chat_id)
    return {
        "success": True, 
        "history": history,
        "chat_id": chat_id
    }


@app.post("/reload")
def reload_dataset():
    global _bot
    _bot = ChatbotESCOMGemini(
        dataset_path=DATASET_PATH,
        conversation_file="conversation_history.csv"
    )
    return {"reloaded": True}