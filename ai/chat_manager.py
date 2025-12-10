import os
import csv
import uuid
import glob
from datetime import datetime

CHATS_DIR = os.path.join(os.path.dirname(__file__), "chats")

class ChatManager:
    def __init__(self, chats_dir=CHATS_DIR):
        self.chats_dir = chats_dir
        if not os.path.exists(self.chats_dir):
            os.makedirs(self.chats_dir)

    def _get_filename(self, user_id, chat_id):
        # Format: chat_{user_id}_{chat_id}.csv
        # user_id should be safe (alphanumeric or email). We rely on caller to sanitize if needed, but uuid is safe.
        safe_user_id = str(user_id).replace("@", "_at_").replace(".", "_dot_")
        return os.path.join(self.chats_dir, f"chat_{safe_user_id}_{chat_id}.csv")

    def create_chat(self, user_id, title="Nuevo Chat"):
        chat_id = str(uuid.uuid4())
        filename = self._get_filename(user_id, chat_id)
        print(f"DEBUG: Intentando crear chat en: {os.path.abspath(filename)}")
        
        # Create empty CSV with header
        try:
            with open(filename, "w", encoding="utf-8", newline="") as file:
                writer = csv.DictWriter(file, fieldnames=["timestamp", "usuario", "modelo"])
                writer.writeheader()
            print(f"DEBUG: Chat file created successfully: {filename}")
        except Exception as e:
            print(f"ERROR: Failed to create chat file: {e}")
            raise e
            
        return {
            "chat_id": chat_id,
            "title": title,
            "created_at": datetime.now().isoformat()
        }

    def list_chats(self, user_id):
        safe_user_id = str(user_id).replace("@", "_at_").replace(".", "_dot_")
        pattern = os.path.join(self.chats_dir, f"chat_{safe_user_id}_*.csv")
        files = glob.glob(pattern)
        print(f"DEBUG: Buscando chats para {user_id} (pattern: {pattern}) -> Encontrados: {len(files)}")
        
        chats = []
        for f in files:
            # Extract chat_id from filename
            basename = os.path.basename(f)
            # filename like: chat_user_uuid.csv
            # We know it starts with chat_{safe_user_id}_
            prefix_len = len(f"chat_{safe_user_id}_")
            chat_id = basename[prefix_len:-4] # remove .csv
            
            # Get modification time as a proxy for "last active" or creation
            mod_time = os.path.getmtime(f)
            
            chats.append({
                "chat_id": chat_id,
                "title": f"Chat {chat_id[:8]}", # Simple title for now
                "last_modified": datetime.fromtimestamp(mod_time).isoformat()
            })
            
        # Sort by last modified desc
        chats.sort(key=lambda x: x["last_modified"], reverse=True)
        return chats

    def delete_chat(self, user_id, chat_id):
        filename = self._get_filename(user_id, chat_id)
        if os.path.exists(filename):
            os.remove(filename)
            return True
        return False

    def get_chat_file_path(self, user_id, chat_id):
        filename = self._get_filename(user_id, chat_id)
        if not os.path.exists(filename):
            return None
        return filename

    def get_history(self, user_id, chat_id):
        filename = self._get_filename(user_id, chat_id)
        history = []
        if os.path.exists(filename):
             with open(filename, "r", encoding="utf-8") as file:
                reader = csv.DictReader(file)
                for row in reader:
                    history.append(row)
        return history
