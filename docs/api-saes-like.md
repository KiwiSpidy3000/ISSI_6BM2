# SAES-like API Design

## 1. Student Enrollment (Inscripción)
**Existing:** `/alumno/reins/preinscribir` (add to cart), `/alumno/reins/confirmar` (finalize).
**Proposed Enhancements:**
- **Middleware/Logic:** Add checks for "Inscription Window" and "Prerequisites" in `preinscribir` and `confirmar`.

### Endpoints
- **POST /alumno/inscripcion/inscribir** (Wrapper or enhancement of `preinscribir`)
  - **Body:** `{ "id_grupo": 123 }`
  - **Validations:**
    - Student exists and is active.
    - Current date is within `periodo_inscripcion` (needs new config table or column).
    - Group has capacity (already exists).
    - No schedule conflict (already exists).
    - **[NEW]** Prerequisites met (check `materia.id_prereq`).
    - **[NEW]** Credits limit not exceeded (check `alumno.semestre` vs max load).
  - **Response:** `200 OK`, `400 Bad Request` (Conflict, Full, Prereq missing, etc.).

## 2. Student Drops (Bajas)
- **DELETE /alumno/inscripcion/baja/:id_grupo**
  - **Params:** `id_grupo`
  - **Validations:**
    - Current date is within `periodo_bajas` (needs new config).
    - Student is enrolled in the group.
    - **[NEW]** Minimum load check: Remaining credits >= min allowed (e.g., ~30 credits or 3 subjects).
  - **Response:** `200 OK`, `400 Bad Request` (Outside period, Min load violation).

## 3. Admin Configuration
- **GET /admin/config/periodos**
  - **Response:** List of periods with their start/end dates, inscription window, drop window.
- **POST /admin/config/periodos**
  - **Body:** `{ "periodo": "2025-2", "inicio_insc": "...", "fin_insc": "...", "inicio_baja": "...", "fin_baja": "..." }`
  - **Action:** Upsert into a new `configuracion_periodo` table.

- **GET /admin/grupos/ocupacion**
  - **Query:** `?periodo=2025-2`
  - **Response:** List of groups with `cupo_max`, `inscritos`, `estado`.
- **PATCH /admin/grupos/:id_grupo/status**
  - **Body:** `{ "estado": "CERRADO" }` (ABIERTO, CERRADO, CANCELADO)

## 4. Teacher Evaluation
- **POST /alumno/evaluacion**
  - **Body:** `{ "id_grupo": 123, "respuestas": [5, 5, 4, 5, 5], "comentario": "..." }`
  - **Validations:**
    - Student is enrolled in the group.
    - Evaluation not already submitted.
  - **Response:** `200 OK`.

## 5. Data Structures (New/Modified)
- **Table `configuracion`** (or similar): To store global dates for the current period.
  - `clave` (PK), `valor` (JSON or Text).
  - Example: `clave='PERIODO_ACTUAL'`, `valor='{"periodo":"2025-2", "insc_inicio":"...", ...}'`.
