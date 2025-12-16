import os
import psycopg2
from dotenv import load_dotenv

# Load env vars
load_dotenv(encoding="utf-8")
try:
    load_dotenv("d:\\Nueva carpeta\\ISSI_6BM2\\back\\.env")
except:
    pass

DB_URL = os.getenv("DATABASE_URL")
if not DB_URL:
    print("Error: DATABASE_URL not found in environment.")
    exit(1)

def debug_schedules():
    try:
        conn = psycopg2.connect(DB_URL)
        cur = conn.cursor()
        
        # Set search path just in case
        cur.execute("SET search_path TO escom_aliz, public")
        
        print("\n=== DEBUGGING SCHEDULES ===")
        
        query = """
        SELECT 
            g.id_grupo, 
            m.nombre as materia, 
            COALESCE(u.nombre || ' ' || u.apellido, 'Sin Profesor') as profesor,
            h.dia_semana, 
            h.hora_ini, 
            h.hora_fin,
            h.aula
        FROM escom_aliz.grupo g
        JOIN escom_aliz.materia m ON g.id_materia = m.id_materia
        LEFT JOIN escom_aliz.profesor p ON g.id_profesor = p.id_profesor
        LEFT JOIN escom_aliz.usuario u ON p.id_profesor = u.id_usuario
        LEFT JOIN escom_aliz.horario h ON g.id_grupo = h.id_grupo
        ORDER BY g.id_grupo, h.dia_semana
        """
        
        cur.execute(query)
        rows = cur.fetchall()
        
        current_group = None
        
        for row in rows:
            g_id, materia, prof, dia, h_ini, h_fin, aula = row
            
            if g_id != current_group:
                print(f"\n[Group ID: {g_id}] {materia} - {prof}")
                current_group = g_id
                
            if dia is not None:
                day_name = {1: "Lunes", 2: "Martes", 3: "Miércoles", 4: "Jueves", 5: "Viernes", 6: "Sábado"}.get(dia, f"Dia {dia}")
                print(f"   -> {day_name} ({dia}) | {h_ini} - {h_fin} | Aula: {aula}")
            else:
                print("   -> (NO SCHEDULE FOUND)")
                
        conn.close()
        print("\n=== END DEBUG ===")
        
    except Exception as e:
        print(f"Error connecting or querying: {e}")

if __name__ == "__main__":
    debug_schedules()
