# Work Plan: Mission SAES

## Phase 1: Database & Configuration
1.  **Create Configuration Table:** Add a table to store period dates (inscription start/end, drop start/end).
2.  **Insert Default Config:** Set up "2025-2" as the active period with open windows for testing.

## Phase 2: Backend - Enrollment & Drops
1.  **Implement Prerequisites Check:** Add logic to `preinscribir` to check if `id_prereq` is passed.
2.  **Implement Load Check:** Add logic to check max credits.
3.  **Implement Drop Endpoint:** Create `DELETE /alumno/inscripcion/baja/:id_grupo` with time window and min load checks.

## Phase 3: Backend - Admin & Evaluation
1.  **Admin Endpoints:** Implement `GET/POST` for period config and `PATCH` for group status.
2.  **Evaluation Endpoint:** Implement `POST /alumno/evaluacion`.

## Phase 4: Frontend Integration
1.  **Admin Dashboard:** Add a simple panel to set dates and view group occupancy.
2.  **Student Portal:**
    - Add "Dar de Baja" button in the schedule/list.
    - Show "Evaluación" button for finished courses (or active ones if allowed).
    - Display error messages for failed enrollment (Prereq missing, etc.).

## Phase 5: Verification
1.  **Test Flows:**
    - Try to enroll without prerequisite -> Fail.
    - Try to drop below min load -> Fail.
    - Change dates as Admin -> Verify Student access blocked/allowed.
