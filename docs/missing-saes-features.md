# Missing SAES Features in Lyte

## 1. Enrollment (Inscripción/Reinscripción)
**Current Status:** Partially Implemented.
- Existing endpoints: `/alumno/reins/*` handle offer query, conflict validation, pre-inscription (cart), and confirmation.
- Existing DB logic: `sp_validar_choque_horario` (conflicts), `trg_inscripcion_cupo_fn` (capacity).

**Missing:**
- **Time Windows:** No validation that the current date is within the allowed inscription period.
- **Load Limits:** No validation for minimum/maximum credits allowed per semester (based on student status or program).
- **Prerequisites:** No validation that the student has passed prerequisite subjects before enrolling.
- **Appointments (Citas):** No system to assign specific dates/times for students to enroll (optional but typical in SAES).

## 2. Drops (Bajas de Unidades de Aprendizaje)
**Current Status:** Not Implemented.
- Only "cart" removal (`DELETE /alumno/reins/preinscribir/:id_grupo`) exists.

**Missing:**
- **Drop Endpoint:** Ability to drop a subject *after* it has been confirmed (`INSCRITO`).
- **Drop Period:** Validation that the drop request is within the allowed "drop window".
- **Minimum Load:** Validation that dropping a subject doesn't leave the student below the minimum required credits.

## 3. Admin Features
**Current Status:** Minimal.
- `create_admin.js` script exists.
- No specific admin endpoints found in `server.js`.

**Missing:**
- **Period Configuration:** Endpoints to set start/end dates for academic periods, inscription windows, and drop windows.
- **Group Management:** Endpoints to view group occupancy and manually change status (OPEN, CLOSED, CANCELLED).
- **Student Management:** View student records/kardex from admin view.

## 4. Teacher Evaluation
**Current Status:** Database only.
- Table `evaluacion_docente` exists.

**Missing:**
- **Submission Endpoint:** API to submit an evaluation for a specific teacher/group.
- **Status Check:** Logic to determine if a student has pending evaluations (often blocks grade viewing in SAES).

## 5. Other
- **Kardex:** Implemented (`/alumno/kardex`).
- **Timetable:** Implemented (`/alumno/horario`).
- **Offer:** Implemented (`/alumno/reins/oferta`).
