# Database Access Layer Overview

This document explains the organization of the database access layer in the Lyte backend and how it maps to the database schema.

## Organization

The database logic is separated into a dedicated module within `back/db/`:

-   **`back/db/pool.js`**: Manages the PostgreSQL connection pool. It reads configuration from environment variables (`DATABASE_URL`, `DB_SCHEMA`) and exports a `pool` instance.
-   **`back/db/queries.js`**: Contains all the SQL queries and database interaction logic. It exports async functions for both reading and writing data. These functions use parameterized queries to prevent SQL injection.

## REST API Mapping

The backend (`back/server.js`) exposes these database functions via REST endpoints under the `/api` prefix.

| Endpoint | Method | Function in `queries.js` | Description |
| :--- | :--- | :--- | :--- |
| `/api/admin/db-counts` | GET | `getTableCounts` | Returns row counts for key tables. |
| `/api/admin/materias/iia` | GET | `getIIACurriculum` | Returns the curriculum for the IIA career. |
| `/api/admin/profesores` | GET | `getProfessorsWithUserData` | Returns a list of professors with user details. |
| `/api/admin/oferta` | GET | `getGroupOfferIIA` | Returns the group offer, optionally filtered by period/semester. |
| `/api/admin/horarios/:id` | GET | `getSchedulesByGroup` | Returns the schedule for a specific group. |
| `/api/alumno/:id/kardex-basic` | GET | `getEnrollmentsByStudent` | Returns a student's enrollment history. |
| `/api/alumno/:id/calificaciones` | GET | `getGradesByStudent` | Returns a student's grades. |
| `/api/admin/profesores` | POST | `insertProfessor` | Creates a new professor (user + professor). |
| `/api/admin/alumnos` | POST | `insertStudent` | Creates a new student (user + alumno). |
| `/api/admin/grupos` | POST | `insertGroup` | Creates a new group. |
| `/api/admin/horarios` | POST | `insertSchedule` | Creates a new schedule entry. |
| `/api/alumno/inscripciones` | POST | `insertEnrollment` | Enrolls a student in a group. |

## Inspection Queries

The file `docs/db_inspection_queries.sql` contains raw SQL queries that correspond to the read operations above. You can run these queries directly in a database tool like pgAdmin to verify the data or debug issues.

## Security

-   **Authentication**: All endpoints require a valid JWT token.
-   **Authorization**: Admin endpoints check for `rol === 'ADMIN'`. Student endpoints allow access to Admins or the student themselves.
-   **SQL Injection**: All queries use parameterized inputs (e.g., `$1`, `$2`) to ensure safety.
-   **Transactions**: Insertions that affect multiple tables (e.g., creating a user and then a professor) are wrapped in database transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) to ensure data integrity.
