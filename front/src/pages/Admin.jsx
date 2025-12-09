import { useEffect, useRef, useState } from "react"
import { useNavigate } from "react-router-dom"
import ChatComponent from "../components/ChatComponent"

const API = import.meta.env.VITE_API_URL || "http://localhost:3000"

export default function Admin() {
  const nav = useNavigate()
  const [view, setView] = useState("datos")
  const [profile, setProfile] = useState(null)

  useEffect(() => {
    const t = localStorage.getItem("access_token") || ""
    fetch(`${API}/admin/profile`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json())
      .then(d => setProfile(d))
      .catch(() => { })

    // animaciones como Alumno / Profesor
    const style = document.createElement("style")
    style.textContent = `
      @keyframes float1 {
        0%,100% { transform: translate3d(0,0,0) rotate(0deg) scale(1); }
        25% { transform: translate3d(80px,-140vh,250px) rotate(120deg) scale(1.3); }
        50% { transform: translate3d(-60px,-160vh,400px) rotate(240deg) scale(0.9); }
        75% { transform: translate3d(100px,-180vh,300px) rotate(360deg) scale(1.1); }
      }
      @keyframes float2 {
        0%,100% { transform: translate3d(0,0,0) rotate(0deg) scale(1); }
        25% { transform: translate3d(-90px,-130vh,280px) rotate(-120deg) scale(1.2); }
        50% { transform: translate3d(70px,-155vh,350px) rotate(-240deg) scale(1.4); }
        75% { transform: translate3d(-80px,-175vh,320px) rotate(-360deg) scale(0.95); }
      }
      @keyframes float3 {
        0%,100% { transform: translate3d(0,0,0) rotate(0deg) scale(1); }
        25% { transform: translate3d(85px,-145vh,260px) rotate(110deg) scale(1.15); }
        50% { transform: translate3d(-75px,-165vh,380px) rotate(220deg) scale(1.35); }
        75% { transform: translate3d(65px,-185vh,290px) rotate(330deg) scale(1.05); }
      }
      @keyframes float4 {
        0%,100% { transform: translate3d(0,0,0) rotate(0deg) scale(1); }
        25% { transform: translate3d(-95px,-135vh,310px) rotate(-110deg) scale(1.25); }
        50% { transform: translate3d(90px,-150vh,370px) rotate(-220deg) scale(0.85); }
        75% { transform: translate3d(-70px,-170vh,340px) rotate(-330deg) scale(1.4); }
      }
    `
    document.head.appendChild(style)
    return () => document.head.removeChild(style)
  }, [])

  function logout() {
    localStorage.removeItem("access_token")
    nav("/")
  }



  return (
    <div style={styles.container}>
      {/* figuras flotantes */}
      <div style={styles.floatingShapes}>
        {[0, 1, 2, 3, 4].map(i => (
          <svg
            key={i}
            xmlns="http://www.w3.org/2000/svg"
            style={{ ...styles.floatingSvg, ...styles[`svg${i}`] }}
          >
            <circle cx="50" cy="50" r="40" strokeWidth="4" fill="none" />
          </svg>
        ))}
      </div>

      {/* SIDEBAR */}
      <aside style={styles.sidebar}>
        <div style={styles.sidebarHeader}>
          <div style={styles.avatarGlow} />
          <div style={styles.avatar}>🛡️</div>
          <div style={styles.sidebarTitle}>Admin Panel</div>
          {profile?.nombre && (
            <div style={styles.sidebarSubtitle}>
              {profile.nombre.split(" ")[0]}
            </div>
          )}
        </div>

        <nav style={styles.sidebarNav}>
          <button
            style={{
              ...styles.pill,
              ...(view === "datos" ? styles.pillActive : {})
            }}
            onClick={() => setView("datos")}
          >
            Datos Personales
          </button>
          <button
            style={{
              ...styles.pill,
              ...(view === "usuarios" ? styles.pillActive : {})
            }}
            onClick={() => setView("usuarios")}
          >
            Gestión de Usuarios
          </button>
          <button
            style={{
              ...styles.pill,
              ...(view === "clases" ? styles.pillActive : {})
            }}
            onClick={() => setView("clases")}
          >
            Gestión de Clases
          </button>
          <button
            style={{
              ...styles.pill,
              ...(view === "reinscripcion" ? styles.pillActive : {})
            }}
            onClick={() => setView("reinscripcion")}
          >
            Reinscripción
          </button>
        </nav>

        <div style={styles.sidebarBottom}>
          <button
            style={{
              ...styles.pill,
              ...(view === "chat" ? styles.pillActive : {})
            }}
            onClick={() => setView("chat")}
          >
            💬 Chat Bot
          </button>
          <button style={styles.pillDanger} onClick={logout}>
            ⛔ Cerrar sesión
          </button>
        </div>
      </aside>

      {/* CONTENIDO */}
      <main style={styles.main}>
        {view === "datos" && <AdminDatos profile={profile} />}

        {view === "usuarios" && <AdminUsuarios />}

        {view === "clases" && <AdminClases />}

        {view === "reinscripcion" && <AdminReinscripcion />}

        {view === "chat" && (
          <ChatComponent
            userIdentifier={profile?.correo || profile?.id}
            userName={profile?.nombre?.split(" ")[0]}
            userRole="Admin"
          />
        )}
      </main>
    </div>
  )
}

/* ------------------ SUBVISTAS ------------------ */

function AdminDatos({ profile }) {
  return (
    <>
      <h2 style={styles.h2}>Datos Personales</h2>
      <div style={styles.card}>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Nombre completo</label>
            <input
              style={styles.input}
              defaultValue={profile?.nombre || ""}
              placeholder="Nombre del administrador"
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Correo institucional</label>
            <input
              style={styles.input}
              defaultValue={profile?.correo || ""}
              placeholder="correo@ipn.mx"
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>ID / RFC</label>
            <input
              style={styles.input}
              defaultValue={profile?.id || ""}
              placeholder="AAS901010"
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Plantel</label>
            <input
              style={styles.input}
              defaultValue={profile?.plantel || "ESCOM"}
            />
          </div>
        </div>
        <div style={{ marginTop: "24px", textAlign: "right" }}>
          <button style={styles.buttonPrimary}>Guardar cambios</button>
        </div>
      </div>
    </>
  )
}

function AdminUsuarios() {
  const [usuarios, setUsuarios] = useState([
    {
      id: 12345,
      nombre: "Ana García",
      tipo: "Alumno",
      estado: "Activo",
      carrera: "ISC",
      grupo: "3CM1",
      semestre: 3
    },
    {
      id: 67890,
      nombre: "Profesor Carlos Solís",
      tipo: "Maestro",
      estado: "Activo",
      carrera: "IIA",
      grupo: "5CV2",
      semestre: 5
    },
    {
      id: 10111,
      nombre: "Luis Flores (Inactivo)",
      tipo: "Alumno",
      estado: "Inactivo",
      carrera: "LCC",
      grupo: "1CM1",
      semestre: 1
    }
  ])

  const [filtros, setFiltros] = useState({
    search: "",
    tipoUsuario: "",
    carrera: "",
    grupo: "",
    semestre: ""
  })

  const [modalOpen, setModalOpen] = useState(false)
  const [modalMode, setModalMode] = useState("crear") // "crear" | "editar"
  const [userForm, setUserForm] = useState({
    id: "",
    nombre: "",
    email: "",
    tipo: "Alumno",
    estado: "Activo",
    carrera: "",
    grupo: "",
    semestre: ""
  })

  const openCrear = () => {
    setModalMode("crear")
    setUserForm({
      id: "",
      nombre: "",
      email: "",
      tipo: "Alumno",
      estado: "Activo",
      carrera: "",
      grupo: "",
      semestre: ""
    })
    setModalOpen(true)
  }

  const openEditar = u => {
    setModalMode("editar")
    setUserForm({
      id: u.id,
      nombre: u.nombre,
      email: u.email || "",
      tipo: u.tipo,
      estado: u.estado,
      carrera: u.carrera || "",
      grupo: u.grupo || "",
      semestre: String(u.semestre ?? "")
    })
    setModalOpen(true)
  }

  const handleFiltroChange = (campo, valor) => {
    setFiltros(prev => ({ ...prev, [campo]: valor }))
  }

  const handleFormChange = (campo, valor) => {
    setUserForm(prev => ({ ...prev, [campo]: valor }))
  }

  const usuariosFiltrados = usuarios.filter(u => {
    const matchSearch =
      filtros.search === "" ||
      u.nombre.toLowerCase().includes(filtros.search.toLowerCase()) ||
      String(u.id).includes(filtros.search)

    const matchTipo =
      filtros.tipoUsuario === "" || u.tipo === filtros.tipoUsuario

    const matchCarrera =
      filtros.carrera === "" || (u.carrera || "") === filtros.carrera

    const matchGrupo =
      filtros.grupo === "" || (u.grupo || "") === filtros.grupo

    const matchSemestre =
      filtros.semestre === "" ||
      String(u.semestre ?? "") === filtros.semestre

    return (
      matchSearch &&
      matchTipo &&
      matchCarrera &&
      matchGrupo &&
      matchSemestre
    )
  })

  const guardarUsuario = () => {
    if (modalMode === "crear") {
      setUsuarios(prev => [
        ...prev,
        {
          id: userForm.id || Date.now(),
          nombre: userForm.nombre,
          tipo: userForm.tipo,
          estado: userForm.estado,
          carrera: userForm.carrera,
          grupo: userForm.grupo,
          semestre: Number(userForm.semestre) || "",
          email: userForm.email
        }
      ])
    } else {
      setUsuarios(prev =>
        prev.map(u =>
          String(u.id) === String(userForm.id)
            ? {
              ...u,
              nombre: userForm.nombre,
              tipo: userForm.tipo,
              estado: userForm.estado,
              carrera: userForm.carrera,
              grupo: userForm.grupo,
              semestre: Number(userForm.semestre) || "",
              email: userForm.email
            }
            : u
        )
      )
    }
    setModalOpen(false)
  }

  const eliminarUsuario = () => {
    setUsuarios(prev =>
      prev.filter(u => String(u.id) !== String(userForm.id))
    )
    setModalOpen(false)
  }

  return (
    <>
      <h2 style={styles.h2}>Gestión de Usuarios</h2>

      {/* Barra de filtros */}
      <div style={styles.filtersBar}>
        <input
          style={{ ...styles.input, flex: 2 }}
          placeholder="Buscar por Nombre, ID..."
          value={filtros.search}
          onChange={e => handleFiltroChange("search", e.target.value)}
        />

        <select
          style={styles.select}
          value={filtros.tipoUsuario}
          onChange={e => handleFiltroChange("tipoUsuario", e.target.value)}
        >
          <option value="">Tipo de Usuario</option>
          <option value="Alumno">Alumno</option>
          <option value="Maestro">Maestro</option>
          <option value="Admin">Admin</option>
        </select>

        <select
          style={styles.select}
          value={filtros.carrera}
          onChange={e => handleFiltroChange("carrera", e.target.value)}
        >
          <option value="">Carrera</option>
          <option value="ISC">ISC</option>
          <option value="IIA">IIA</option>
          <option value="LCC">LCC</option>
        </select>

        <select
          style={styles.select}
          value={filtros.grupo}
          onChange={e => handleFiltroChange("grupo", e.target.value)}
        >
          <option value="">Grupo</option>
          <option value="3CM1">3CM1</option>
          <option value="3CM2">3CM2</option>
          <option value="5CV2">5CV2</option>
        </select>

        <select
          style={styles.select}
          value={filtros.semestre}
          onChange={e => handleFiltroChange("semestre", e.target.value)}
        >
          <option value="">Semestre</option>
          {[1, 2, 3, 4, 5, 6, 7, 8, 9].map(n => (
            <option key={n} value={String(n)}>
              {n}
            </option>
          ))}
        </select>

        <button style={styles.buttonPrimary} onClick={openCrear}>
          Añadir Usuario
        </button>
      </div>

      {/* Tabla */}
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>ID</th>
              <th style={styles.th}>Nombre del Usuario</th>
              <th style={styles.th}>Carrera</th>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Semestre</th>
              <th style={styles.th}>Tipo de Usuario</th>
              <th style={styles.th}>Estado</th>
              <th style={styles.th}>Acción</th>
            </tr>
          </thead>
          <tbody>
            {usuariosFiltrados.map(u => (
              <tr key={u.id} style={styles.tableRow}>
                <td style={styles.td}>{u.id}</td>
                <td style={styles.td}>{u.nombre}</td>
                <td style={styles.td}>{u.carrera || "—"}</td>
                <td style={styles.td}>{u.grupo || "—"}</td>
                <td style={styles.td}>{u.semestre || "—"}</td>
                <td style={styles.td}>
                  <span
                    style={{
                      ...styles.badge,
                      ...(u.tipo === "Alumno"
                        ? styles.badgeAlumno
                        : u.tipo === "Maestro"
                          ? styles.badgeMaestro
                          : styles.badgeAdmin)
                    }}
                  >
                    {u.tipo}
                  </span>
                </td>
                <td style={styles.td}>
                  <span
                    style={{
                      ...styles.badge,
                      ...(u.estado === "Activo"
                        ? styles.badgeActivo
                        : styles.badgeInactivo)
                    }}
                  >
                    {u.estado}
                  </span>
                </td>
                <td style={styles.td}>
                  <button
                    style={styles.buttonSmall}
                    onClick={() => openEditar(u)}
                  >
                    Modificar
                  </button>
                </td>
              </tr>
            ))}
            {usuariosFiltrados.length === 0 && (
              <tr>
                <td style={styles.td} colSpan={8}>
                  No hay usuarios que coincidan con los filtros.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Modal Añadir / Editar */}
      {modalOpen && (
        <div style={styles.modalOverlay}>
          <div style={styles.modalCard}>
            <h3 style={styles.modalTitle}>
              {modalMode === "crear" ? "Añadir Usuario" : "Editar Usuario"}
            </h3>

            <div style={styles.formGrid1}>
              <div style={styles.formGroup}>
                <label style={styles.label}>ID / Boleta</label>
                <input
                  style={styles.input}
                  value={userForm.id}
                  onChange={e => handleFormChange("id", e.target.value)}
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Nombre Completo</label>
                <input
                  style={styles.input}
                  value={userForm.nombre}
                  onChange={e => handleFormChange("nombre", e.target.value)}
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Email</label>
                <input
                  style={styles.input}
                  value={userForm.email}
                  onChange={e => handleFormChange("email", e.target.value)}
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Tipo de Usuario</label>
                <select
                  style={styles.select}
                  value={userForm.tipo}
                  onChange={e => handleFormChange("tipo", e.target.value)}
                >
                  <option value="Alumno">Alumno</option>
                  <option value="Maestro">Maestro</option>
                  <option value="Admin">Admin</option>
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Estado</label>
                <select
                  style={styles.select}
                  value={userForm.estado}
                  onChange={e => handleFormChange("estado", e.target.value)}
                >
                  <option value="Activo">Activo</option>
                  <option value="Inactivo">Inactivo</option>
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Carrera</label>
                <input
                  style={styles.input}
                  value={userForm.carrera}
                  onChange={e =>
                    handleFormChange("carrera", e.target.value)
                  }
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Grupo</label>
                <input
                  style={styles.input}
                  value={userForm.grupo}
                  onChange={e => handleFormChange("grupo", e.target.value)}
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Semestre</label>
                <input
                  style={styles.input}
                  value={userForm.semestre}
                  onChange={e =>
                    handleFormChange("semestre", e.target.value)
                  }
                />
              </div>
            </div>

            <div style={styles.modalButtons}>
              <button style={styles.buttonPrimary} onClick={guardarUsuario}>
                {modalMode === "crear" ? "Crear Usuario" : "Guardar Cambios"}
              </button>
              {modalMode === "editar" && (
                <button style={styles.buttonDanger} onClick={eliminarUsuario}>
                  Eliminar
                </button>
              )}
              <button
                style={styles.buttonGhost}
                onClick={() => setModalOpen(false)}
              >
                Cancelar
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}

function AdminClases() {
  // Datos de ejemplo
  const [clases, setClases] = useState([
    {
      id: 1,
      grupo: "3CM1",
      materia: "Programación Avanzada",
      profesor: "Prof. A. Smith",
      carrera: "ISC",
      semestre: "3",
      horario: "Lun y Mié 10:00 - 12:00",
      cupo: 35,
      inscritos: 28,
      estado: "Abierta"
    },
    {
      id: 2,
      grupo: "5CV2",
      materia: "Control de Procesos",
      profesor: "Ing. Ortega",
      carrera: "IIA",
      semestre: "5",
      horario: "Mar y Jue 16:00 - 18:00",
      cupo: 30,
      inscritos: 30,
      estado: "Cerrada"
    }
  ])

  // Filtros de búsqueda (mismos que usuarios pero adaptados)
  const [filtros, setFiltros] = useState({
    search: "",
    carrera: "",
    grupo: "",
    profesor: "",
    semestre: ""
  })

  // Modal para Añadir / Editar clase
  const [modalOpen, setModalOpen] = useState(false)
  const [modalMode, setModalMode] = useState("crear") // "crear" | "editar"
  const [claseForm, setClaseForm] = useState({
    id: "",
    grupo: "",
    materia: "",
    profesor: "",
    carrera: "",
    semestre: "",
    horario: "",
    cupo: "",
    inscritos: "",
    estado: "Abierta"
  })

  const handleFiltroChange = (campo, valor) => {
    setFiltros(prev => ({ ...prev, [campo]: valor }))
  }

  const handleFormChange = (campo, valor) => {
    setClaseForm(prev => ({ ...prev, [campo]: valor }))
  }

  const openCrear = () => {
    setModalMode("crear")
    setClaseForm({
      id: "",
      grupo: "",
      materia: "",
      profesor: "",
      carrera: "",
      semestre: "",
      horario: "",
      cupo: "",
      inscritos: "",
      estado: "Abierta"
    })
    setModalOpen(true)
  }

  const openEditar = clase => {
    setModalMode("editar")
    setClaseForm({
      id: clase.id,
      grupo: clase.grupo,
      materia: clase.materia,
      profesor: clase.profesor,
      carrera: clase.carrera,
      semestre: clase.semestre,
      horario: clase.horario,
      cupo: String(clase.cupo ?? ""),
      inscritos: String(clase.inscritos ?? ""),
      estado: clase.estado
    })
    setModalOpen(true)
  }

  const guardarClase = () => {
    if (modalMode === "crear") {
      setClases(prev => [
        ...prev,
        {
          id: Date.now(),
          grupo: claseForm.grupo,
          materia: claseForm.materia,
          profesor: claseForm.profesor,
          carrera: claseForm.carrera,
          semestre: claseForm.semestre,
          horario: claseForm.horario,
          cupo: Number(claseForm.cupo) || 0,
          inscritos: Number(claseForm.inscritos) || 0,
          estado: claseForm.estado
        }
      ])
    } else {
      setClases(prev =>
        prev.map(c =>
          c.id === claseForm.id
            ? {
              ...c,
              grupo: claseForm.grupo,
              materia: claseForm.materia,
              profesor: claseForm.profesor,
              carrera: claseForm.carrera,
              semestre: claseForm.semestre,
              horario: claseForm.horario,
              cupo: Number(claseForm.cupo) || 0,
              inscritos: Number(claseForm.inscritos) || 0,
              estado: claseForm.estado
            }
            : c
        )
      )
    }
    setModalOpen(false)
  }

  const clasesFiltradas = clases.filter(c => {
    const matchSearch =
      filtros.search === "" ||
      c.materia.toLowerCase().includes(filtros.search.toLowerCase()) ||
      c.profesor.toLowerCase().includes(filtros.search.toLowerCase()) ||
      c.grupo.toLowerCase().includes(filtros.search.toLowerCase())

    const matchCarrera =
      filtros.carrera === "" || c.carrera === filtros.carrera

    const matchGrupo =
      filtros.grupo === "" || c.grupo === filtros.grupo

    const matchProfesor =
      filtros.profesor === "" ||
      c.profesor.toLowerCase().includes(filtros.profesor.toLowerCase())

    const matchSemestre =
      filtros.semestre === "" || c.semestre === filtros.semestre

    return (
      matchSearch &&
      matchCarrera &&
      matchGrupo &&
      matchProfesor &&
      matchSemestre
    )
  })

  return (
    <>
      <h2 style={styles.h2}>Gestión de Clases y Ocupación</h2>

      {/* Barra de filtros y botón Añadir Clase */}
      <div style={styles.filtersBar}>
        <input
          style={{ ...styles.input, flex: 2 }}
          placeholder="Buscar por materia, profesor o grupo..."
          value={filtros.search}
          onChange={e => handleFiltroChange("search", e.target.value)}
        />

        <select
          style={styles.select}
          value={filtros.carrera}
          onChange={e => handleFiltroChange("carrera", e.target.value)}
        >
          <option value="">Carrera</option>
          <option value="ISC">ISC</option>
          <option value="IIA">IIA</option>
          <option value="LCC">LCC</option>
        </select>

        <select
          style={styles.select}
          value={filtros.grupo}
          onChange={e => handleFiltroChange("grupo", e.target.value)}
        >
          <option value="">Grupo</option>
          <option value="3CM1">3CM1</option>
          <option value="3CM2">3CM2</option>
          <option value="5CV2">5CV2</option>
        </select>

        <input
          style={styles.input}
          placeholder="Profesor"
          value={filtros.profesor}
          onChange={e => handleFiltroChange("profesor", e.target.value)}
        />

        <select
          style={styles.select}
          value={filtros.semestre}
          onChange={e => handleFiltroChange("semestre", e.target.value)}
        >
          <option value="">Semestre</option>
          {[1, 2, 3, 4, 5, 6, 7, 8, 9].map(n => (
            <option key={n} value={String(n)}>
              {n}
            </option>
          ))}
        </select>

        <button style={styles.buttonPrimary} onClick={openCrear}>
          Añadir Clase
        </button>
      </div>

      {/* Tabla de clases */}
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              <th style={styles.th}>Carrera</th>
              <th style={styles.th}>Semestre</th>
              <th style={styles.th}>Horario</th>
              <th style={styles.th}>Cupo</th>
              <th style={styles.th}>Inscritos</th>
              <th style={styles.th}>Estado</th>
              <th style={styles.th}>Acción</th>
            </tr>
          </thead>
          <tbody>
            {clasesFiltradas.map(c => (
              <tr key={c.id} style={styles.tableRow}>
                <td style={styles.td}>{c.grupo}</td>
                <td style={styles.td}>{c.materia}</td>
                <td style={styles.td}>{c.profesor}</td>
                <td style={styles.td}>{c.carrera}</td>
                <td style={styles.td}>{c.semestre}</td>
                <td style={styles.td}>{c.horario}</td>
                <td style={styles.td}>{c.cupo}</td>
                <td style={styles.td}>{c.inscritos}</td>
                <td style={styles.td}>
                  <span
                    style={{
                      ...styles.badge,
                      ...(c.estado === "Abierta"
                        ? styles.badgeActivo
                        : styles.badgeInactivo)
                    }}
                  >
                    {c.estado}
                  </span>
                </td>
                <td style={styles.td}>
                  <button
                    style={styles.buttonSmall}
                    onClick={() => openEditar(c)}
                  >
                    Editar
                  </button>
                </td>
              </tr>
            ))}
            {clasesFiltradas.length === 0 && (
              <tr>
                <td style={styles.td} colSpan={10}>
                  No hay clases que coincidan con los filtros.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Modal Añadir / Editar Clase */}
      {modalOpen && (
        <div style={styles.modalOverlay}>
          <div style={styles.modalCard}>
            <h3 style={styles.modalTitle}>
              {modalMode === "crear" ? "Añadir Clase" : "Editar Clase"}
            </h3>

            <div style={styles.formGrid1}>
              <div style={styles.formGroup}>
                <label style={styles.label}>Nombre de la materia</label>
                <input
                  style={styles.input}
                  value={claseForm.materia}
                  onChange={e =>
                    handleFormChange("materia", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Profesor</label>
                <input
                  style={styles.input}
                  value={claseForm.profesor}
                  onChange={e =>
                    handleFormChange("profesor", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Carrera</label>
                <input
                  style={styles.input}
                  value={claseForm.carrera}
                  onChange={e =>
                    handleFormChange("carrera", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Semestre</label>
                <input
                  style={styles.input}
                  value={claseForm.semestre}
                  onChange={e =>
                    handleFormChange("semestre", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Grupo</label>
                <input
                  style={styles.input}
                  value={claseForm.grupo}
                  onChange={e =>
                    handleFormChange("grupo", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Horario</label>
                <input
                  style={styles.input}
                  placeholder="Ej. Lun y Mié 10:00 - 12:00"
                  value={claseForm.horario}
                  onChange={e =>
                    handleFormChange("horario", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Cupo</label>
                <input
                  style={styles.input}
                  value={claseForm.cupo}
                  onChange={e =>
                    handleFormChange("cupo", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Inscritos</label>
                <input
                  style={styles.input}
                  value={claseForm.inscritos}
                  onChange={e =>
                    handleFormChange("inscritos", e.target.value)
                  }
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>Estado</label>
                <select
                  style={styles.select}
                  value={claseForm.estado}
                  onChange={e =>
                    handleFormChange("estado", e.target.value)
                  }
                >
                  <option value="Abierta">Abierta</option>
                  <option value="Cerrada">Cerrada</option>
                </select>
              </div>
            </div>

            <div style={styles.modalButtons}>
              <button style={styles.buttonPrimary} onClick={guardarClase}>
                {modalMode === "crear" ? "Crear Clase" : "Guardar Cambios"}
              </button>
              <button
                style={styles.buttonGhost}
                onClick={() => setModalOpen(false)}
              >
                Cancelar
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}


function AdminReinscripcion() {
  return (
    <>
      <h2 style={styles.h2}>Configuración del Periodo</h2>
      <div style={styles.card}>
        <div style={styles.sectionTitle}>Inscripciones</div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Inicio</label>
            <input style={styles.input} placeholder="dd/mm/aaaa --:--" />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Fin</label>
            <input style={styles.input} placeholder="dd/mm/aaaa --:--" />
          </div>
        </div>

        <div style={{ ...styles.sectionTitle, marginTop: "24px" }}>
          Bajas
        </div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Inicio</label>
            <input style={styles.input} placeholder="dd/mm/aaaa --:--" />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Fin</label>
            <input style={styles.input} placeholder="dd/mm/aaaa --:--" />
          </div>
        </div>

        <div style={{ ...styles.sectionTitle, marginTop: "24px" }}>
          Créditos
        </div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Mínimo</label>
            <input style={styles.input} defaultValue="30" />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Máximo</label>
            <input style={styles.input} defaultValue="90" />
          </div>
        </div>

        <div style={{ marginTop: "24px", textAlign: "right" }}>
          <button style={styles.buttonPrimary}>Guardar Configuración</button>
        </div>
      </div>
    </>
  )
}

/* ------------------ ESTILOS COMPARTIDOS ------------------ */

const styles = {
  container: {
    display: "flex",
    minHeight: "100vh",
    background:
      "linear-gradient(135deg, #0f1620 0%, #1a2847 40%, #2d3a6a 100%)",
    color: "#ffffff",
    fontFamily: '"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
    position: "relative",
    overflow: "hidden"
  },
  floatingShapes: {
    position: "fixed",
    top: 0,
    left: 0,
    width: "100%",
    height: "100%",
    pointerEvents: "none",
    zIndex: 1
  },
  floatingSvg: {
    position: "absolute",
    stroke: "#4a5a8e",
    transformStyle: "preserve-3d"
  },
  svg0: {
    width: "180px",
    height: "180px",
    left: "5%",
    bottom: "-25%",
    animation: "float1 20s infinite ease-in-out",
    opacity: 0.3
  },
  svg1: {
    width: "140px",
    height: "140px",
    left: "20%",
    bottom: "-20%",
    animation: "float2 22s infinite ease-in-out",
    opacity: 0.4
  },
  svg2: {
    width: "160px",
    height: "160px",
    left: "40%",
    bottom: "-22%",
    animation: "float3 24s infinite ease-in-out",
    opacity: 0.25
  },
  svg3: {
    width: "120px",
    height: "120px",
    left: "60%",
    bottom: "-18%",
    animation: "float4 18s infinite ease-in-out",
    opacity: 0.5
  },
  svg4: {
    width: "150px",
    height: "150px",
    left: "75%",
    bottom: "-21%",
    animation: "float1 21s infinite ease-in-out",
    opacity: 0.35
  },

  sidebar: {
    width: "280px",
    background:
      "linear-gradient(180deg, rgba(30,43,79,0.95) 0%, rgba(42,54,88,0.95) 100%)",
    backdropFilter: "blur(20px)",
    borderRight: "1px solid rgba(106,122,174,0.2)",
    display: "flex",
    flexDirection: "column",
    padding: "32px 20px",
    position: "relative",
    zIndex: 10,
    boxShadow: "4px 0 24px rgba(0,0,0,0.3)"
  },
  sidebarHeader: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    marginBottom: "40px",
    position: "relative"
  },
  avatarGlow: {
    position: "absolute",
    top: "-15px",
    left: "50%",
    transform: "translateX(-50%)",
    width: "100px",
    height: "100px",
    background:
      "radial-gradient(circle, rgba(106,122,174,0.4) 0%, transparent 70%)",
    filter: "blur(25px)",
    zIndex: -1
  },
  avatar: {
    width: "80px",
    height: "80px",
    borderRadius: "50%",
    background: "linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontSize: "40px",
    marginBottom: "16px",
    border: "3px solid rgba(106,122,174,0.3)",
    boxShadow: "0 8px 32px rgba(106,122,174,0.4)"
  },
  sidebarTitle: {
    fontSize: "20px",
    fontWeight: 700,
    color: "#ffffff",
    letterSpacing: "1px"
  },
  sidebarSubtitle: {
    fontSize: "14px",
    color: "#a8b2d1",
    marginTop: "4px"
  },
  sidebarNav: {
    display: "flex",
    flexDirection: "column",
    gap: "12px",
    flex: 1
  },
  pill: {
    background: "rgba(58,74,122,0.4)",
    border: "1px solid rgba(106,122,174,0.3)",
    color: "#d1d5e8",
    padding: "14px 20px",
    borderRadius: "12px",
    cursor: "pointer",
    transition: "all 0.3s ease",
    fontSize: "14px",
    fontWeight: 500,
    textAlign: "left",
    outline: "none"
  },
  pillActive: {
    background:
      "linear-gradient(135deg, rgba(106,122,174,0.4) 0%, rgba(90,106,158,0.4) 100%)",
    border: "1px solid rgba(106,122,174,0.5)",
    boxShadow: "0 4px 20px rgba(106,122,174,0.3)"
  },
  sidebarBottom: {
    display: "flex",
    flexDirection: "column",
    gap: "12px",
    marginTop: "20px",
    paddingTop: "20px",
    borderTop: "1px solid rgba(106,122,174,0.2)"
  },
  pillDanger: {
    background:
      "linear-gradient(135deg, rgba(185,28,28,0.3) 0%, rgba(220,38,38,0.3) 100%)",
    border: "1px solid rgba(220,38,38,0.4)",
    color: "#ffb3b3",
    padding: "14px 20px",
    borderRadius: "12px",
    cursor: "pointer",
    transition: "all 0.3s ease",
    fontSize: "14px",
    fontWeight: 600,
    textAlign: "left",
    outline: "none"
  },

  main: {
    flex: 1,
    padding: "40px",
    position: "relative",
    zIndex: 10,
    overflowY: "auto"
  },
  h2: {
    fontSize: "32px",
    fontWeight: 700,
    marginBottom: "28px",
    background: "linear-gradient(135deg, #ffffff 0%, #6a7aae 100%)",
    WebkitBackgroundClip: "text",
    WebkitTextFillColor: "transparent",
    backgroundClip: "text",
    letterSpacing: "-1px"
  },

  card: {
    background: "rgba(30,43,79,0.75)",
    backdropFilter: "blur(20px)",
    borderRadius: "24px",
    border: "1px solid rgba(106,122,174,0.25)",
    padding: "28px 32px",
    boxShadow: "0 16px 40px rgba(0,0,0,0.35)"
  },

  formGrid2: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit,minmax(260px,1fr))",
    gap: "18px"
  },
  formGrid1: {
    display: "grid",
    gridTemplateColumns: "1fr",
    gap: "18px"
  },
  formGroup: {
    display: "flex",
    flexDirection: "column",
    gap: "6px"
  },
  label: {
    fontSize: "13px",
    color: "#c3c8e5"
  },
  input: {
    background: "rgba(58,74,122,0.7)",
    border: "1px solid rgba(106,122,174,0.4)",
    borderRadius: "10px",
    padding: "10px 12px",
    color: "#ffffff",
    fontSize: "14px",
    outline: "none"
  },
  select: {
    background: "rgba(58,74,122,0.7)",
    border: "1px solid rgba(106,122,174,0.4)",
    borderRadius: "10px",
    padding: "10px 12px",
    color: "#ffffff",
    fontSize: "14px",
    outline: "none",
    cursor: "pointer"
  },

  buttonPrimary: {
    background: "linear-gradient(135deg,#5a6a9e 0%,#6a7aae 100%)",
    border: "none",
    color: "#ffffff",
    padding: "10px 24px",
    borderRadius: "12px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: 600,
    boxShadow: "0 4px 16px rgba(106,122,174,0.45)"
  },
  buttonSmall: {
    background: "rgba(58,74,122,0.85)",
    border: "1px solid rgba(106,122,174,0.5)",
    color: "#ffffff",
    padding: "6px 16px",
    borderRadius: "999px",
    cursor: "pointer",
    fontSize: "13px",
    fontWeight: 600
  },
  buttonDanger: {
    background: "rgba(220,38,38,0.9)",
    border: "none",
    color: "#ffffff",
    padding: "10px 20px",
    borderRadius: "12px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: 600
  },
  buttonGhost: {
    background: "rgba(148,163,184,0.35)",
    border: "none",
    color: "#e5e7eb",
    padding: "10px 20px",
    borderRadius: "12px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: 500
  },

  filtersBar: {
    display: "flex",
    gap: "12px",
    marginBottom: "22px",
    alignItems: "center",
    flexWrap: "wrap"
  },

  tableWrap: {
    background: "rgba(30,43,79,0.8)",
    backdropFilter: "blur(18px)",
    borderRadius: "24px",
    border: "1px solid rgba(106,122,174,0.25)",
    overflow: "hidden",
    boxShadow: "0 16px 40px rgba(0,0,0,0.35)"
  },
  table: {
    width: "100%",
    borderCollapse: "collapse"
  },
  tableHeaderRow: {
    background: "rgba(47,64,112,0.95)"
  },
  th: {
    padding: "14px 20px",
    textAlign: "left",
    color: "#c3c8e5",
    fontSize: "12px",
    letterSpacing: "1px",
    textTransform: "uppercase",
    borderBottom: "1px solid rgba(106,122,174,0.4)"
  },
  tableRow: {
    borderBottom: "1px solid rgba(106,122,174,0.18)"
  },
  td: {
    padding: "12px 20px",
    fontSize: "14px",
    color: "#e5e7f5"
  },

  badge: {
    display: "inline-flex",
    alignItems: "center",
    justifyContent: "center",
    padding: "4px 12px",
    borderRadius: "999px",
    fontSize: "12px",
    fontWeight: 600
  },
  badgeAlumno: {
    background: "rgba(59,130,246,0.2)",
    color: "#bfdbfe"
  },
  badgeMaestro: {
    background: "rgba(234,179,8,0.2)",
    color: "#facc15"
  },
  badgeAdmin: {
    background: "rgba(168,85,247,0.25)",
    color: "#e9d5ff"
  },
  badgeActivo: {
    background: "rgba(34,197,94,0.2)",
    color: "#bbf7d0"
  },
  badgeInactivo: {
    background: "rgba(248,113,113,0.18)",
    color: "#fecaca"
  },

  sectionTitle: {
    fontSize: "16px",
    fontWeight: 600,
    color: "#e5e7f5",
    marginBottom: "10px"
  },

  /* Chat */
  chatSection: {
    background: "rgba(30,43,79,0.8)",
    backdropFilter: "blur(20px)",
    borderRadius: "24px",
    border: "1px solid rgba(106,122,174,0.25)",
    padding: "20px",
    display: "flex",
    flexDirection: "column",
    height: "calc(100vh - 200px)",
    boxShadow: "0 16px 40px rgba(0,0,0,0.35)"
  },
  chatScroll: {
    flex: 1,
    overflowY: "auto",
    display: "flex",
    flexDirection: "column",
    gap: "10px",
    paddingRight: "6px",
    marginBottom: "14px"
  },
  msgBot: {
    alignSelf: "flex-start",
    background:
      "linear-gradient(135deg, rgba(106,122,174,0.45) 0%, rgba(90,106,158,0.55) 100%)",
    borderRadius: "18px 18px 18px 4px",
    padding: "10px 14px",
    fontSize: "14px",
    maxWidth: "70%"
  },
  msgUser: {
    alignSelf: "flex-end",
    background: "linear-gradient(135deg,#5a6a9e 0%,#6a7aae 100%)",
    borderRadius: "18px 18px 4px 18px",
    padding: "10px 14px",
    fontSize: "14px",
    maxWidth: "70%"
  },
  chatInput: {
    display: "flex",
    gap: "12px",
    alignItems: "flex-end"
  },
  textarea: {
    flex: 1,
    background: "rgba(58,74,122,0.7)",
    border: "1px solid rgba(106,122,174,0.4)",
    borderRadius: "14px",
    padding: "10px 12px",
    color: "#ffffff",
    fontSize: "14px",
    resize: "none",
    minHeight: "50px",
    maxHeight: "110px",
    outline: "none"
  },
  sendBtn: {
    background: "linear-gradient(135deg,#5a6a9e 0%,#6a7aae 100%)",
    border: "none",
    color: "#ffffff",
    width: "48px",
    height: "48px",
    borderRadius: "14px",
    cursor: "pointer",
    fontSize: "20px",
    boxShadow: "0 4px 16px rgba(106,122,174,0.5)"
  },

  /* Modal */
  modalOverlay: {
    position: "fixed",
    inset: 0,
    background: "rgba(15,23,42,0.75)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 100
  },
  modalCard: {
    width: "520px",
    maxWidth: "90vw",
    background: "#f9fafb",
    borderRadius: "18px",
    padding: "24px 26px",
    boxShadow: "0 25px 60px rgba(15,23,42,0.65)",
    color: "#111827"
  },
  modalTitle: {
    fontSize: "20px",
    fontWeight: 700,
    marginBottom: "18px",
    color: "#1f2937"
  },
  modalButtons: {
    display: "flex",
    gap: "10px",
    justifyContent: "flex-end",
    marginTop: "22px"
  }
}
