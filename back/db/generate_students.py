import random

# Configuration
NUM_STUDENTS = 1000
BATCH_SIZE = 50
OUTPUT_FILE = "populate_students_1000.sql"

# Data source
nombres = [
    "Adrian", "Alexis", "Valeria", "Eduardo", "Juan", "Maria", "Jose", "Ana", "Luis", "Fernanda",
    "Carlos", "Sofia", "Miguel", "Camila", "Javier", "Isabella", "David", "Valentina", "Daniel", "Ximena",
    "Francisco", "Mariana", "Pedro", "Lucia", "Alejandro", "Victoria", "Manuel", "Gabriela", "Jesus", "Daniela",
    "Ricardo", "Renata", "Jorge", "Regina", "Roberto", "Andrea", "Fernando", "Natalia", "Hector", "Paula",
    "Diego", "Elena", "Sergio", "Sara", "Antonio", "Carmen", "Andres", "Julia", "Oscar", "Diana"
]

apellidos = [
    "Hernandez", "Garcia", "Martinez", "Lopez", "Gonzalez", "Perez", "Rodriguez", "Sanchez", "Ramirez", "Cruz",
    "Flores", "Gomez", "Morales", "Vazquez", "Jimenez", "Reyes", "Diaz", "Torres", "Gutierrez", "Ruiz",
    "Mendoza", "Aguilar", "Ortiz", "Moreno", "Castillo", "Romero", "Alvarez", "Rivera", "Chavez", "Ramos",
    "De La Cruz", "Dominguez", "Guerrero", "Estrada", "Soto", "Guzman", "Velazquez", "Munoz", "Rojas", "Contreras",
    "Salazar", "Marquez", "Avila", "Sandoval", "Tellez", "Delgado", "Solis", "Silva", "Vargas", "Santiago"
]

# Fixed values
PASS_HASH = "$2b$10$K8pbBVADmIGalUmKnV4o7O94OGfWLNq3fPuL69JUQbNQHByXCGFja" # lyte123
CARRERA_CLAVE = "IIA"

def generate_boleta(index):
    # Base year + random digits. Ensuring uniqueness by using index or set.
    # Let's use a base and increment to be safe and simple, or random with check.
    # User example: 2025336901. Let's use 2020... to 2025...
    year = random.choice([2020, 2021, 2022, 2023, 2024, 2025])
    # suffix from index to ensure uniqueness across this run
    return f"{year}64{index:04d}"

def generate_student_data(index):
    nombre = f"{random.choice(nombres)} {random.choice(nombres)}" if random.random() > 0.5 else random.choice(nombres)
    apellido = f"{random.choice(apellidos)} {random.choice(apellidos)}"
    boleta = generate_boleta(index)
    email = f"{boleta}@escom.mx"
    semestre = random.randint(1, 10)
    return {
        "nombre": nombre,
        "apellido": apellido,
        "boleta": boleta,
        "email": email,
        "semestre": semestre
    }

def generate_sql():
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("BEGIN;\n\n")
        
        students = [generate_student_data(i) for i in range(NUM_STUDENTS)]
        
        # Process in batches
        for i in range(0, NUM_STUDENTS, BATCH_SIZE):
            batch = students[i:i+BATCH_SIZE]
            
            f.write(f"-- Batch {i} to {i+len(batch)}\n")
            f.write("WITH iia AS (\n")
            f.write(f"  SELECT id_carrera FROM escom_aliz.carrera WHERE clave = '{CARRERA_CLAVE}'\n")
            f.write("),\n")
            
            cte_parts = []
            
            for j, student in enumerate(batch):
                idx = i + j
                user_cte = f"u_{idx}"
                alumno_cte = f"a_{idx}"
                
                # Usuario CTE
                user_sql = f"""{user_cte} AS (
  INSERT INTO escom_aliz.usuario (email, pass_hash, nombre, apellido, rol, activo)
  VALUES (
    '{student['email']}',
    '{PASS_HASH}',
    '{student['nombre']}',
    '{student['apellido']}',
    'ALUMNO',
    true
  )
  ON CONFLICT (email) DO UPDATE
    SET nombre    = EXCLUDED.nombre,
        apellido  = EXCLUDED.apellido,
        rol       = EXCLUDED.rol,
        activo    = EXCLUDED.activo,
        pass_hash = EXCLUDED.pass_hash
  RETURNING id_usuario
)"""
                cte_parts.append(user_sql)
                
                # Alumno CTE
                # Note: The last CTE in a WITH clause cannot be followed by a comma if it's the last one before the main query.
                # But here we are chaining them.
                # Actually, we can just chain them all and do a dummy SELECT at the end of the batch.
                
                alumno_sql = f"""{alumno_cte} AS (
  INSERT INTO escom_aliz.alumno (id_alumno, boleta, id_carrera, semestre)
  SELECT id_usuario, '{student['boleta']}', (SELECT id_carrera FROM iia), {student['semestre']}
  FROM {user_cte}
  ON CONFLICT (id_alumno) DO UPDATE
    SET boleta     = EXCLUDED.boleta,
        id_carrera = EXCLUDED.id_carrera,
        semestre   = EXCLUDED.semestre
  RETURNING id_alumno
)"""
                cte_parts.append(alumno_sql)

            # Join all CTEs with commas
            f.write(",\n".join(cte_parts))
            
            # End the WITH block with a dummy select to execute the CTEs
            f.write("\nSELECT count(*) FROM " + ", ".join([f"a_{i+j}" for j in range(len(batch))]) + ";\n\n")
            
        f.write("COMMIT;\n")

if __name__ == "__main__":
    generate_sql()
    print(f"Generated {OUTPUT_FILE} with {NUM_STUDENTS} students.")
