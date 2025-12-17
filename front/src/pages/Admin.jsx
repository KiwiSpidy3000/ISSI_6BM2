import { useEffect, useRef, useState } from "react"
import { useNavigate } from "react-router-dom"
import ChatComponent from "../components/ChatComponent"

const API = import.meta.env.VITE_API_URL || "http://localhost:3000"

export default function Admin() {
  const nav = useNavigate()
  const [view, setView] = useState("datos")
  // Datos estáticos del admin
  const [profile] = useState({
    nombre: "Alison Estevez Pérez",
    correo: "alison@ejemplo.mx",
    id: "EPPA050928ERF",
    plantel: "ESCOM"
  })

  useEffect(() => {
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
          <button
            style={{
              ...styles.pill,
              ...(view === "solicitudes" ? styles.pillActive : {})
            }}
            onClick={() => setView("solicitudes")}
          >
            Solicitudes Pass
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

        {view === "solicitudes" && <AdminSolicitudes />}

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

const styles = {
  container: {
    display: "flex",
    minHeight: "100vh",
    background: "#0f0c15",
    color: "#fff",
    fontFamily: "'Inter', sans-serif",
    position: "relative",
    overflow: "hidden"
  },
  // Floating Background Shapes
  floatingShapes: {
    position: "absolute",
    top: 0,
    left: 0,
    width: "100%",
    height: "100%",
    pointerEvents: "none",
    zIndex: 0
  },
  floatingSvg: {
    position: "absolute",
    top: "50%",
    left: "50%",
    opacity: 0.15
  },
  svg0: { stroke: "#a855f7", animation: "float1 25s infinite ease-in-out" },
  svg1: { stroke: "#3b82f6", animation: "float2 28s infinite ease-in-out" },
  svg2: { stroke: "#ec4899", animation: "float3 30s infinite ease-in-out" },
  svg3: { stroke: "#14b8a6", animation: "float4 32s infinite ease-in-out" },
  svg4: { stroke: "#f59e0b", animation: "float1 29s infinite ease-in-out" },

  // Sidebar
  sidebar: {
    width: "260px",
    background: "rgba(20, 20, 25, 0.6)",
    backdropFilter: "blur(12px)",
    borderRight: "1px solid rgba(255,255,255,0.08)",
    display: "flex",
    flexDirection: "column",
    padding: "24px",
    zIndex: 10
  },
  sidebarHeader: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    marginBottom: "40px",
    position: "relative"
  },
  avatar: {
    width: "64px",
    height: "64px",
    borderRadius: "50%",
    background: "linear-gradient(135deg, #3b82f6, #9333ea)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontSize: "32px",
    marginBottom: "12px",
    boxShadow: "0 0 20px rgba(147, 51, 234, 0.5)",
    zIndex: 2
  },
  avatarGlow: {
    position: "absolute",
    top: "50%",
    left: "50%",
    transform: "translate(-50%, -50%)",
    width: "100px",
    height: "100px",
    background: "radial-gradient(circle, rgba(59,130,246,0.3) 0%, transparent 70%)",
    zIndex: 1
  },
  sidebarTitle: {
    fontSize: "18px",
    fontWeight: "700",
    color: "#e2e8f0"
  },
  sidebarSubtitle: {
    fontSize: "14px",
    color: "#94a3b8",
    marginTop: "4px"
  },
  sidebarNav: {
    display: "flex",
    flexDirection: "column",
    gap: "8px",
    flex: 1
  },
  sidebarBottom: {
    marginTop: "auto",
    display: "flex",
    flexDirection: "column",
    gap: "8px"
  },

  // Navigation Pills
  pill: {
    padding: "12px 16px",
    borderRadius: "12px",
    background: "transparent",
    border: "none",
    color: "#cbd5e1",
    textAlign: "left",
    cursor: "pointer",
    fontSize: "15px",
    fontWeight: "500",
    transition: "all 0.2s",
    display: "flex",
    alignItems: "center",
    gap: "10px"
  },
  pillActive: {
    background: "rgba(255, 255, 255, 0.1)",
    color: "#fff",
    boxShadow: "0 0 10px rgba(255,255,255,0.05)"
  },
  pillDanger: {
    padding: "12px 16px",
    borderRadius: "12px",
    background: "rgba(239, 68, 68, 0.1)",
    border: "1px solid rgba(239, 68, 68, 0.2)",
    color: "#f87171",
    textAlign: "center",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.2s"
  },

  // Main Content
  main: {
    flex: 1,
    padding: "40px",
    overflowY: "auto",
    zIndex: 5,
    position: "relative"
  },
  h2: {
    fontSize: "28px",
    fontWeight: "700",
    marginBottom: "24px",
    background: "linear-gradient(to right, #fff, #cbd5e1)",
    WebkitBackgroundClip: "text",
    WebkitTextFillColor: "transparent"
  },
  card: {
    background: "rgba(30, 41, 59, 0.6)",
    backdropFilter: "blur(16px)",
    border: "1px solid rgba(255,255,255,0.08)",
    borderRadius: "20px",
    padding: "32px",
    boxShadow: "0 4px 30px rgba(0,0,0,0.3)"
  },

  // Forms
  formGrid2: {
    display: "grid",
    gridTemplateColumns: "1fr 1fr",
    gap: "24px"
  },
  formGrid1: {
    display: "grid",
    gridTemplateColumns: "1fr",
    gap: "20px"
  },
  formGroup: {
    display: "flex",
    flexDirection: "column",
    gap: "8px"
  },
  label: {
    fontSize: "14px",
    color: "#94a3b8",
    fontWeight: "500"
  },
  input: {
    background: "rgba(15, 23, 42, 0.8)",
    border: "1px solid rgba(255,255,255,0.1)",
    borderRadius: "10px",
    padding: "12px 16px",
    color: "#fff",
    fontSize: "15px",
    outline: "none",
    transition: "border-color 0.2s"
  },
  select: {
    background: "rgba(15, 23, 42, 0.8)",
    border: "1px solid rgba(255,255,255,0.1)",
    borderRadius: "10px",
    padding: "12px 16px",
    color: "#fff",
    fontSize: "15px",
    outline: "none"
  },

  // Buttons
  buttonPrimary: {
    background: "linear-gradient(135deg, #3b82f6, #2563eb)",
    border: "none",
    borderRadius: "10px",
    padding: "10px 24px",
    color: "#fff",
    fontSize: "15px",
    fontWeight: "600",
    cursor: "pointer",
    boxShadow: "0 4px 15px rgba(37, 99, 235, 0.4)",
    transition: "transform 0.1s"
  },
  buttonSmall: {
    background: "rgba(59, 130, 246, 0.15)",
    border: "1px solid rgba(59, 130, 246, 0.3)",
    borderRadius: "8px",
    padding: "6px 12px",
    color: "#60a5fa",
    fontSize: "13px",
    fontWeight: "600",
    cursor: "pointer"
  },
  buttonGhost: {
    background: "transparent",
    border: "1px solid rgba(255,255,255,0.2)",
    borderRadius: "10px",
    padding: "10px 24px",
    color: "#e2e8f0",
    fontSize: "15px",
    fontWeight: "500",
    cursor: "pointer"
  },
  buttonDanger: {
    background: "rgba(220, 38, 38, 0.2)",
    border: "1px solid rgba(220, 38, 38, 0.4)",
    borderRadius: "10px",
    padding: "10px 24px",
    color: "#f87171",
    fontSize: "15px",
    fontWeight: "600",
    cursor: "pointer"
  },

  // Filter Bar
  filtersBar: {
    display: "flex",
    gap: "12px",
    marginBottom: "24px",
    background: "rgba(30, 41, 59, 0.4)",
    padding: "16px",
    borderRadius: "16px",
    border: "1px solid rgba(255,255,255,0.05)"
  },

  // Table
  tableWrap: {
    background: "rgba(30, 41, 59, 0.4)",
    backdropFilter: "blur(12px)",
    borderRadius: "16px",
    border: "1px solid rgba(255,255,255,0.05)",
    overflow: "hidden"
  },
  table: {
    width: "100%",
    borderCollapse: "collapse"
  },
  tableHeaderRow: {
    background: "rgba(15, 23, 42, 0.6)",
    borderBottom: "1px solid rgba(255,255,255,0.05)"
  },
  th: {
    padding: "16px",
    textAlign: "left",
    fontSize: "13px",
    fontWeight: "600",
    color: "#94a3b8",
    textTransform: "uppercase",
    letterSpacing: "0.5px"
  },
  tableRow: {
    borderBottom: "1px solid rgba(255,255,255,0.02)"
  },
  td: {
    padding: "16px",
    fontSize: "14px",
    color: "#cbd5e1"
  },

  // Badges
  badge: {
    padding: "4px 10px",
    borderRadius: "20px",
    fontSize: "12px",
    fontWeight: "600"
  },
  badgeAlumno: { background: "rgba(52, 211, 153, 0.15)", color: "#34d399" },
  badgeMaestro: { background: "rgba(251, 191, 36, 0.15)", color: "#fbbf24" },
  badgeAdmin: { background: "rgba(167, 139, 250, 0.15)", color: "#a78bfa" },
  badgeActivo: { background: "rgba(59, 130, 246, 0.15)", color: "#60a5fa" },
  badgeInactivo: { background: "rgba(148, 163, 184, 0.2)", color: "#94a3b8" },

  // Modal
  modalOverlay: {
    position: "fixed",
    top: 0,
    left: 0,
    width: "100%",
    height: "100%",
    background: "rgba(0,0,0,0.6)",
    backdropFilter: "blur(4px)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 50
  },
  modalCard: {
    width: "500px",
    maxHeight: "90vh",
    overflowY: "auto",
    background: "#1e293b",
    border: "1px solid rgba(255,255,255,0.1)",
    borderRadius: "20px",
    padding: "32px",
    boxShadow: "0 20px 50px rgba(0,0,0,0.5)"
  },
  modalTitle: {
    fontSize: "22px",
    fontWeight: "700",
    marginBottom: "24px",
    color: "#fff"
  },
  modalButtons: {
    display: "flex",
    gap: "12px",
    marginTop: "32px",
    justifyContent: "flex-end"
  }
}

/* ------------------ SUBVISTAS ------------------ */

function AdminDatos() {
  return (
    <>
      <h2 style={styles.h2}>Datos Personales</h2>
      <div style={styles.card}>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Nombre completo</label>
            <input
              style={styles.input}
              value="Alison Estevez Pérez"
              readOnly
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Correo institucional</label>
            <input
              style={styles.input}
              value="alison@ejemplo.mx"
              readOnly
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>ID / RFC</label>
            <input
              style={styles.input}
              value="EPPA050928ERF"
              readOnly
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Plantel</label>
            <input
              style={styles.input}
              value="ESCOM"
              readOnly
            />
          </div>
        </div>
      </div>
    </>
  )
}

function AdminUsuarios() {
  /* REPLACE MOCK DATA WITH REAL DATA */
  const [usuarios, setUsuarios] = useState([])

  const [carrerasList, setCarrerasList] = useState([])
  const [gruposList, setGruposList] = useState([])

  const loadUsuarios = () => {
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/usuarios`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => {
        if (r.status === 401) throw new Error("Sesión expirada")
        return r.json()
      })
      .then(d => {
        if (Array.isArray(d)) setUsuarios(d)
      })
      .catch(e => {
        console.error("Error loading users:", e)
        if (e.message === "Sesión expirada") alert("Tu sesión ha expirado. Por favor inicia sesión nuevamente.")
      })
  }

  // Fetch real users and helpers
  useEffect(() => {
    loadUsuarios()
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/carreras`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json()).then(d => Array.isArray(d) && setCarrerasList(d)).catch(() => { })
    fetch(`${API}/admin/grupos`, { headers: { Authorization: `Bearer ${t}` } }) // Reusing GET groups for list
      .then(r => r.json()).then(d => Array.isArray(d) && setGruposList(d)).catch(() => { })
  }, [])

  const [filtros, setFiltros] = useState({
    search: "",
    tipoUsuario: "",
    carrera: "",
    grupo: "",
    semestre: ""
  })

  const [modalOpen, setModalOpen] = useState(false)
  const [modalMode, setModalMode] = useState("crear") // "crear" | "editar"
  /* State for Form */
  const [userForm, setUserForm] = useState({
    id: "",       // Internal DB ID (hidden)
    identifier: "", // Boleta or NumEmpleado
    nombre: "",
    apellido: "",
    password: "",
    email: "",
    tipo: "ALUMNO", // Default Uppercase to match DB enum logic or mapping
    estado: "Activo",
    carrera: "",
    grupo: "",
    semestre: "",
    departamento: ""
  })

  // Start with clean state
  const openCrear = () => {
    setModalMode("crear")
    setUserForm({
      id: "",
      identifier: "",
      nombre: "",
      apellido: "",
      password: "",
      email: "",
      tipo: "ALUMNO",
      estado: "Activo",
      carrera: "",
      grupo: "",
      semestre: "",
      departamento: ""
    })
    setModalOpen(true)
  }

  // Populate from existing user object
  // Note: Backend now returns boleta, num_empleado, departamento
  const openEditar = u => {
    setModalMode("editar")
    let currentIdentifier = ""
    if (u.tipo === "ALUMNO") currentIdentifier = u.boleta
    if (u.tipo === "PROFESOR") currentIdentifier = u.num_empleado

    setUserForm({
      id: u.id,
      identifier: currentIdentifier || "",
      nombre: u.nombre || "",
      apellido: u.apellido || "",
      password: "", // dont show pwd
      email: u.email || "",
      tipo: u.tipo || "ALUMNO",
      estado: u.estado,
      carrera: u.id_carrera || "",
      carrera: u.id_carrera || "",
      grupo: u.grupo_id || "",
      semestre: String(u.semestre ?? ""),
      departamento: u.departamento || ""
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

    const matchGrupo =
      filtros.grupo === "" || (u.grupo || "") === filtros.grupo

    const matchSemestre =
      filtros.semestre === "" ||
      String(u.semestre ?? "") === filtros.semestre

    return (
      matchSearch &&
      matchTipo &&
      matchGrupo &&
      matchSemestre
    )
  })

  const guardarUsuario = () => {
    const t = localStorage.getItem("access_token")
    const method = modalMode === "crear" ? "POST" : "PATCH"
    const url = modalMode === "crear"
      ? `${API}/admin/usuarios`
      : `${API}/admin/usuarios/${userForm.id}`

    // Map fields
    const body = {
      nombre: userForm.nombre,
      apellido: userForm.apellido,
      email: userForm.email,
      password: userForm.password || undefined,
      rol: userForm.tipo.toUpperCase(),
      activo: userForm.estado === "Activo",

      // Dynamic fields
      boleta: userForm.tipo.toUpperCase() === 'ALUMNO' ? userForm.identifier : undefined,
      num_empleado: userForm.tipo.toUpperCase() === 'PROFESOR' ? userForm.identifier : undefined,
      departamento: userForm.tipo.toUpperCase() === 'PROFESOR' ? userForm.departamento : undefined,

      semestre: userForm.semestre, // Might be undefined for non-students in backend logic (it's fine)
      semestre: userForm.semestre, // Might be undefined for non-students in backend logic (it's fine)
      carrera_id: userForm.carrera,
      grupo_id: userForm.grupo
    }

    fetch(url, {
      method,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${t}`
      },
      body: JSON.stringify(body)
    })
      .then(async r => {
        if (!r.ok) {
          const txt = await r.text()
          throw new Error(txt)
        }
        return r.json()
      })
      .then(() => {
        setModalOpen(false)
        loadUsuarios()
      })
      .catch(e => alert("Error al guardar: " + e.message))
  }

  const eliminarUsuario = () => {
    if (!confirm("¿Seguro que deseas eliminar este usuario?")) return;
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/usuarios/${userForm.id}`, {
      method: "DELETE",
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(async r => {
        if (!r.ok) throw new Error(await r.text())
        setModalOpen(false)
        loadUsuarios()
      })
      .catch(e => alert("Error: " + e.message))
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
          <option value="ALUMNO">Alumno</option>
          <option value="PROFESOR">Profesor</option>
          <option value="ADMIN">Admin</option>
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
                      ...(u.tipo === "ALUMNO"
                        ? styles.badgeAlumno
                        : u.tipo === "PROFESOR"
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
                <label style={styles.label}>Tipo de Usuario</label>
                <select
                  style={styles.select}
                  value={userForm.tipo}
                  onChange={e => handleFormChange("tipo", e.target.value)}
                >
                  <option value="ALUMNO">Alumno</option>
                  <option value="PROFESOR">Profesor</option>
                  <option value="ADMIN">Admin</option>
                </select>
              </div>

              {/* Identifier Field: Label changes based on Type */}
              {userForm.tipo !== 'ADMIN' && (
                <div style={styles.formGroup}>
                  <label style={styles.label}>
                    {userForm.tipo === 'ALUMNO' ? 'Boleta' : 'Número de Empleado'}
                  </label>
                  <input
                    style={styles.input}
                    value={userForm.identifier}
                    onChange={e => handleFormChange("identifier", e.target.value)}
                    placeholder={userForm.tipo === 'ALUMNO' ? '202564...' : 'P-00...'}
                  />
                </div>
              )}

              <div style={styles.formGroup}>
                <label style={styles.label}>Nombre</label>
                <input
                  style={styles.input}
                  value={userForm.nombre}
                  onChange={e => handleFormChange("nombre", e.target.value)}
                />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Apellido</label>
                <input
                  style={styles.input}
                  value={userForm.apellido}
                  onChange={e => handleFormChange("apellido", e.target.value)}
                />
              </div>

              <div style={styles.formGroup}>
                <label style={styles.label}>
                  {modalMode === 'crear' ? 'Contraseña' : 'Nueva Contraseña (opcional)'}
                </label>
                <input
                  type="password"
                  style={styles.input}
                  value={userForm.password}
                  onChange={e => handleFormChange("password", e.target.value)}
                  placeholder={modalMode === 'editar' ? 'Dejar en blanco para no cambiar' : ''}
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

              {/* Student Specific Fields */}
              {userForm.tipo === 'ALUMNO' && (
                <>
                  <div style={styles.formGroup}>
                    <label style={styles.label}>Carrera</label>
                    <select
                      style={styles.select}
                      value={userForm.carrera}
                      onChange={e => handleFormChange("carrera", e.target.value)}
                    >
                      <option value="">Seleccionar Carrera</option>
                      {carrerasList.map(c => (
                        <option key={c.id} value={c.id}>{c.nombre}</option>
                      ))}
                    </select>
                  </div>
                  <div style={styles.formGroup}>
                    <label style={styles.label}>Semestre</label>
                    <select
                      style={styles.select}
                      value={userForm.semestre}
                      onChange={e => handleFormChange("semestre", e.target.value)}
                    >
                      <option value="">Semestre</option>
                      {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map(s => (
                        <option key={s} value={s}>{s}</option>
                      ))}
                    </select>
                  </div>
                  {/* Grupo is optional helper */}
                  <div style={styles.formGroup}>
                    <label style={styles.label}>Grupo (Opcional)</label>
                    <select
                      style={styles.select}
                      value={userForm.grupo}
                      onChange={e => handleFormChange("grupo", e.target.value)}
                    >
                      <option value="">-</option>
                      {gruposList.map(g => (
                        <option key={g.id} value={g.id}>{g.grupo} - {g.materia_nombre}</option>
                      ))}
                    </select>
                  </div>
                </>
              )}

              {/* Professor Specific Fields */}
              {userForm.tipo === 'PROFESOR' && (
                <div style={styles.formGroup}>
                  <label style={styles.label}>Departamento</label>
                  <input
                    style={styles.input}
                    value={userForm.departamento}
                    onChange={e => handleFormChange("departamento", e.target.value)}
                    placeholder="Ej. Ciencias Básicas"
                  />
                </div>
              )}

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
  const [clases, setClases] = useState([])
  const [materias, setMaterias] = useState([])
  const [profesores, setProfesores] = useState([])
  const [loading, setLoading] = useState(false)

  const loadClases = () => {
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/grupos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(d => { if (Array.isArray(d)) setClases(d) })
      .catch(e => console.error("Error loading classes:", e))
  }

  useEffect(() => {
    loadClases()
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/materias`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json()).then(d => setMaterias(d)).catch(() => { })
    fetch(`${API}/admin/profesores`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json()).then(d => setProfesores(d)).catch(() => { })
  }, [])

  const [filtros, setFiltros] = useState({
    search: "",
    carrera: "",
    grupo: "",
    profesor: "",
    semestre: ""
  })

  const [modalOpen, setModalOpen] = useState(false)
  const [modalMode, setModalMode] = useState("crear")
  const [claseForm, setClaseForm] = useState({
    id: "",
    grupo: "",
    materia: "",
    profesor: "",
    carrera: "",
    semestre: "",
    horario: "", // Display only
    cupo: "",
    inscritos: "",
    estado: "ABIERTO",
    turno: "M"
  })

  // Local state for adding schedules in the modal
  const [scheduleList, setScheduleList] = useState([])
  const [newSlot, setNewSlot] = useState({ dia: 1, hora_ini: '07:00', hora_fin: '08:30', aula: '' })

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
      estado: "ABIERTO",
      turno: "M"
    })
    setScheduleList([])
    setModalOpen(true)
  }

  const openEditar = clase => {
    setModalMode("editar")
    setClaseForm({
      id: clase.id,
      grupo: clase.grupo,
      materia: clase.id_materia || "",
      profesor: clase.id_profesor || "",
      carrera: clase.carrera,
      semestre: clase.semestre,
      horario: clase.horario,
      cupo: String(clase.cupo ?? ""),
      inscritos: String(clase.inscritos ?? ""),
      estado: clase.estado || "ABIERTO",
      turno: 'M' // Default as we might not have it in list view yet? (check backup)
    })
    // NOTE: retrieving existing schedules to edit is complex, 
    // for now we only support adding new ones on creation clearly.
    // Editing schedule is out of scope unless valid endpoint exists to fetch specific group schedules.
    setScheduleList([])
    setModalOpen(true)
  }

  const addSlot = () => {
    if (!newSlot.aula) return alert("Falta Aula")
    setScheduleList([...scheduleList, { ...newSlot }])
    setNewSlot({ dia: 1, hora_ini: '07:00', hora_fin: '08:30', aula: '' })
  }

  const removeSlot = (idx) => {
    setScheduleList(scheduleList.filter((_, i) => i !== idx))
  }

  const guardarClase = async () => {
    const t = localStorage.getItem("access_token")
    const method = modalMode === "crear" ? "POST" : "PATCH"
    const url = modalMode === "crear" ? `${API}/admin/grupos` : `${API}/admin/grupos/${claseForm.id}`

    const body = {
      id_materia: claseForm.materia,
      id_profesor: claseForm.profesor,
      periodo: claseForm.grupo || '2025-1',
      cupo_max: Number(claseForm.cupo),
      turno: claseForm.turno,
      estado: claseForm.estado
    }

    try {
      // 1. Create/Update Group
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json", Authorization: `Bearer ${t}` },
        body: JSON.stringify(body)
      })

      if (!res.ok) {
        const txt = await res.text()
        throw new Error(txt)
      }

      const data = await res.json()
      const groupId = modalMode === 'crear' ? (data.id || data.id_grupo) : claseForm.id

      // 2. Insert schedules (for both create and edit if user added new ones)
      if (scheduleList.length > 0) {
        // We do this sequentially or parallel. Sequential is safer for order/errors.
        const errors = []
        for (const slot of scheduleList) {
          const slotBody = {
            dia: parseInt(slot.dia),
            hora_inicio: slot.hora_ini,
            hora_fin: slot.hora_fin,
            aula: slot.aula
          }
          const sRes = await fetch(`${API}/admin/grupos/${groupId}/horarios`, {
            method: 'POST',
            headers: { "Content-Type": "application/json", Authorization: `Bearer ${t}` },
            body: JSON.stringify(slotBody)
          })
          if (!sRes.ok) {
            const errTxt = await sRes.text()
            console.error("Error saving schedule:", errTxt)
            errors.push(`Día ${slot.dia}: ${errTxt}`)
          }
        }
        if (errors.length > 0) {
          alert("La clase se guardó, pero hubo errores al añadir horarios:\n" + errors.join("\n"))
        }
      }

      setModalOpen(false)
      loadClases()

    } catch (e) {
      alert("Error al guardar clase: " + e.message)
    }
  }


  const clasesFiltradas = clases.filter(c => {
    const matVal = String(c.materia || "").toLowerCase()
    const profVal = String(c.profesor || "").toLowerCase()
    const grpVal = String(c.grupo || "").toLowerCase()

    const matchSearch =
      filtros.search === "" ||
      matVal.includes(filtros.search.toLowerCase()) ||
      profVal.includes(filtros.search.toLowerCase()) ||
      grpVal.includes(filtros.search.toLowerCase())

    const matchCarrera =
      filtros.carrera === "" || String(c.carrera || "") === filtros.carrera

    const matchGrupo =
      filtros.grupo === "" || String(c.grupo || "") === filtros.grupo

    const matchProfesor =
      filtros.profesor === "" ||
      profVal.includes(filtros.profesor.toLowerCase())

    const matchSemestre =
      filtros.semestre === "" || String(c.semestre || "") === filtros.semestre

    return (
      matchSearch && matchCarrera && matchGrupo && matchProfesor && matchSemestre
    )
  })

  return (
    <>
      <h2 style={styles.h2}>Gestión de Clases y Ocupación</h2>

      <div style={styles.filtersBar}>
        <input
          style={{ ...styles.input, flex: 2 }}
          placeholder="Buscar..."
          value={filtros.search}
          onChange={e => handleFiltroChange("search", e.target.value)}
        />
        <button style={styles.buttonPrimary} onClick={openCrear}>
          Añadir Clase
        </button>
      </div>

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
                <td style={styles.td}>{c.estado}</td>
                <td style={styles.td}>
                  <button style={styles.buttonSmall} onClick={() => openEditar(c)}>Editar</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {modalOpen && (
        <div style={styles.modalOverlay}>
          <div style={{ ...styles.modalCard, width: '700px' }}>
            <h3 style={styles.modalTitle}>
              {modalMode === "crear" ? "Añadir Clase" : "Editar Clase"}
            </h3>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
              <div style={styles.formGroup}>
                <label style={styles.label}>Filtrar por Semestre</label>
                <select
                  style={styles.select}
                  value={claseForm.semestreFilter || ""}
                  onChange={e => {
                    const val = e.target.value
                    setClaseForm(prev => ({ ...prev, semestreFilter: val, materia: "" })) // Reset materia on filter change
                  }}
                >
                  <option value="">Todos</option>
                  {[1, 2, 3, 4, 5, 6, 7, 8].map(n => (
                    <option key={n} value={n}>Semestre {n}</option>
                  ))}
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Materia</label>
                <select
                  style={styles.select}
                  value={claseForm.materia}
                  onChange={e => handleFormChange("materia", e.target.value)}
                  disabled={!claseForm.semestreFilter && materias.length > 50} // Optional UX hint
                >
                  <option value="">Selecciona materia</option>
                  {materias
                    .filter(m => !claseForm.semestreFilter || String(m.semestre) === String(claseForm.semestreFilter))
                    .map(m => (
                      <option key={m.id_materia} value={m.id_materia}>
                        {m.clave} - {m.nombre}
                      </option>
                    ))}
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Profesor</label>
                <select style={styles.select} value={claseForm.profesor} onChange={e => handleFormChange("profesor", e.target.value)}>
                  <option value="">Selecciona profesor</option>
                  {profesores.map(p => (
                    <option key={p.id_profesor} value={p.id_profesor}>{p.nombre}</option>
                  ))}
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Periodo (Grupo)</label>
                <input style={styles.input} value={claseForm.grupo} onChange={e => handleFormChange("grupo", e.target.value)} placeholder="2025-1" />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Turno</label>
                <select style={styles.select} value={claseForm.turno} onChange={e => handleFormChange("turno", e.target.value)}>
                  <option value="M">Matutino</option>
                  <option value="V">Vespertino</option>
                </select>
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Cupo</label>
                <input style={styles.input} value={claseForm.cupo} onChange={e => handleFormChange("cupo", e.target.value)} />
              </div>
              <div style={styles.formGroup}>
                <label style={styles.label}>Estado</label>
                <select style={styles.select} value={claseForm.estado} onChange={e => handleFormChange("estado", e.target.value)}>
                  <option value="ABIERTO">Abierta</option>
                  <option value="CERRADO">Cerrada</option>
                </select>
              </div>
            </div>

            {/* SECTION HORARIOS */}
            <div style={{ marginTop: '20px', borderTop: '1px solid #ccc', paddingTop: '10px' }}>
              <h4 style={{ ...styles.label, fontSize: '14px', marginBottom: '10px' }}>Añadir Horarios</h4>

              {/* Controls */}
              <div style={{ display: 'flex', gap: '8px', marginBottom: '10px' }}>
                <select style={{ ...styles.select, width: '100px' }} value={newSlot.dia} onChange={e => setNewSlot({ ...newSlot, dia: e.target.value })}>
                  <option value="1">Lun</option>
                  <option value="2">Mar</option>
                  <option value="3">Mié</option>
                  <option value="4">Jue</option>
                  <option value="5">Vie</option>
                </select>
                <input style={{ ...styles.input, width: '80px' }} type="time" value={newSlot.hora_ini} onChange={e => setNewSlot({ ...newSlot, hora_ini: e.target.value })} />
                <input style={{ ...styles.input, width: '80px' }} type="time" value={newSlot.hora_fin} onChange={e => setNewSlot({ ...newSlot, hora_fin: e.target.value })} />
                <input style={{ ...styles.input, width: '80px' }} placeholder="Aula" value={newSlot.aula} onChange={e => setNewSlot({ ...newSlot, aula: e.target.value })} />
                <button style={styles.buttonSmall} onClick={addSlot}>+</button>
              </div>

              {/* List */}
              <div style={{ maxHeight: '100px', overflowY: 'auto', background: 'rgba(0,0,0,0.1)', borderRadius: '8px', padding: '8px' }}>
                {scheduleList.map((s, i) => (
                  <div key={i} style={{ display: 'flex', justifyContent: 'space-between', fontSize: '13px', marginBottom: '4px' }}>
                    <span>
                      {['D', 'L', 'M', 'Mi', 'J', 'V', 'S'][s.dia]} {s.hora_ini}-{s.hora_fin} ({s.aula})
                    </span>
                    <button style={{ ...styles.buttonGhost, padding: '2px 6px', fontSize: '10px', color: '#f87171' }} onClick={() => removeSlot(i)}>x</button>
                  </div>
                ))}
                {scheduleList.length === 0 && <span style={{ fontSize: '12px', color: '#888' }}>Sin horarios agregados</span>}
              </div>
            </div>

            <div style={styles.modalButtons}>
              <button style={styles.buttonPrimary} onClick={guardarClase}>Guardar</button>
              <button style={styles.buttonGhost} onClick={() => setModalOpen(false)}>Cancelar</button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}


function AdminReinscripcion() {
  const [config, setConfig] = useState({
    INICIO_INSCRIPCION: '',
    FIN_INSCRIPCION: '',
    INICIO_BAJA: '',
    FIN_BAJA: '',
    MIN_CREDITOS: '30',
    MAX_CREDITOS: '90'
  })
  const [msg, setMsg] = useState('')

  useEffect(() => {
    loadConfig()
  }, [])

  const loadConfig = () => {
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/config`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(d => {
        // Merge with defaults to ensure controlled inputs
        setConfig(prev => ({ ...prev, ...d }))
      })
      .catch(console.error)
  }

  const handleChange = (field, val) => {
    setConfig(prev => ({ ...prev, [field]: val }))
  }

  const saveConfig = () => {
    setMsg('')
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/config`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify(config)
    })
      .then(r => {
        if (!r.ok) throw new Error('Error al guardar')
        return r.json()
      })
      .then(() => {
        setMsg('Configuración guardada correctamente')
        loadConfig()
      })
      .catch(() => setMsg('Error al guardar la configuración'))
  }

  return (
    <>
      <h2 style={styles.h2}>Configuración del Periodo</h2>

      <div style={styles.card}>
        <div style={styles.sectionTitle}>Inscripciones</div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Inicio (YYYY-MM-DDTHH:mm)</label>
            <input
              style={styles.input}
              type="datetime-local"
              value={config.INICIO_INSCRIPCION}
              onChange={e => handleChange('INICIO_INSCRIPCION', e.target.value)}
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Fin (YYYY-MM-DDTHH:mm)</label>
            <input
              style={styles.input}
              type="datetime-local"
              value={config.FIN_INSCRIPCION}
              onChange={e => handleChange('FIN_INSCRIPCION', e.target.value)}
            />
          </div>
        </div>

        <div style={{ ...styles.sectionTitle, marginTop: "24px" }}>
          Bajas
        </div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Inicio (YYYY-MM-DDTHH:mm)</label>
            <input
              style={styles.input}
              type="datetime-local"
              value={config.INICIO_BAJA}
              onChange={e => handleChange('INICIO_BAJA', e.target.value)}
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Fin (YYYY-MM-DDTHH:mm)</label>
            <input
              style={styles.input}
              type="datetime-local"
              value={config.FIN_BAJA}
              onChange={e => handleChange('FIN_BAJA', e.target.value)}
            />
          </div>
        </div>

        <div style={{ ...styles.sectionTitle, marginTop: "24px" }}>
          Créditos
        </div>
        <div style={styles.formGrid2}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Mínimo</label>
            <input
              style={styles.input}
              type="number"
              value={config.MIN_CREDITOS}
              onChange={e => handleChange('MIN_CREDITOS', e.target.value)}
            />
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Máximo</label>
            <input
              style={styles.input}
              type="number"
              value={config.MAX_CREDITOS}
              onChange={e => handleChange('MAX_CREDITOS', e.target.value)}
            />
          </div>
        </div>

        <div style={{ marginTop: "24px", textAlign: "right" }}>
          <button style={styles.buttonPrimary} onClick={saveConfig}>Guardar Configuración</button>
        </div>
        {msg && <div style={{ marginTop: '10px', color: '#bbf7d0', textAlign: 'right' }}>{msg}</div>}
      </div>

      {/* Visual List of Current Config */}
      <div style={{ marginTop: '30px' }}>
        <h3 style={styles.h3}>Resumen de Configuración Actual</h3>
        <div style={{ ...styles.card, marginTop: '10px' }}>
          <ul style={{ listStyle: 'none', padding: 0 }}>
            <li style={{ padding: '8px 0', borderBottom: '1px solid rgba(106,122,174,0.2)' }}>
              <strong style={{ color: '#a8b2d1' }}>Periodo de Inscripción:</strong> <br />
              {config.INICIO_INSCRIPCION ? new Date(config.INICIO_INSCRIPCION).toLocaleString() : 'No definido'} — {config.FIN_INSCRIPCION ? new Date(config.FIN_INSCRIPCION).toLocaleString() : 'No definido'}
            </li>
            <li style={{ padding: '8px 0', borderBottom: '1px solid rgba(106,122,174,0.2)' }}>
              <strong style={{ color: '#a8b2d1' }}>Periodo de Bajas:</strong> <br />
              {config.INICIO_BAJA ? new Date(config.INICIO_BAJA).toLocaleString() : 'No definido'} — {config.FIN_BAJA ? new Date(config.FIN_BAJA).toLocaleString() : 'No definido'}
            </li>
            <li style={{ padding: '8px 0' }}>
              <strong style={{ color: '#a8b2d1' }}>Límites de Créditos:</strong> <br />
              Mín: {config.MIN_CREDITOS} / Máx: {config.MAX_CREDITOS}
            </li>
          </ul>
        </div>
      </div>
    </>
  )
}

function AdminSolicitudes() {
  const [requests, setRequests] = useState([])
  const [loading, setLoading] = useState(false)

  const loadRequests = () => {
    setLoading(true)
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/solicitudes-pass`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(d => {
        if (Array.isArray(d)) setRequests(d)
      })
      .catch(e => console.error(e))
      .finally(() => setLoading(false))
  }

  useEffect(() => { loadRequests() }, [])

  const handleApprove = (id) => {
    if (!confirm("¿Aprobar cambio de contraseña? Esto actualizará la contraseña del usuario.")) return
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/solicitudes-pass/${id}/aprobar`, {
      method: "POST",
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(async r => {
        if (!r.ok) throw new Error(await r.text())
        alert("Solicitud aprobada y contraseña actualizada.")
        loadRequests()
      })
      .catch(e => alert("Error: " + e.message))
  }

  const handleReject = (id) => {
    if (!confirm("¿Rechazar solicitud?")) return
    const t = localStorage.getItem("access_token")
    fetch(`${API}/admin/solicitudes-pass/${id}`, {
      method: "DELETE",
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(async r => {
        if (!r.ok) throw new Error(await r.text())
        loadRequests()
      })
      .catch(e => alert("Error: " + e.message))
  }

  return (
    <>
      <h2 style={styles.h2}>Solicitudes de Cambio de Contraseña</h2>
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Fecha</th>
              <th style={styles.th}>Nombre</th>
              <th style={styles.th}>Email</th>
              <th style={styles.th}>Rol</th>
              <th style={styles.th}>Nueva Contraseña</th>
              <th style={styles.th}>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {loading && <tr><td colSpan="6" style={{ padding: '20px', textAlign: 'center', color: '#ccc' }}>Cargando...</td></tr>}
            {!loading && requests.length === 0 && (
              <tr><td colSpan="6" style={{ padding: '20px', textAlign: 'center', color: '#ccc' }}>No hay solicitudes pendientes.</td></tr>
            )}
            {requests.map(r => (
              <tr key={r.id} style={styles.tableRow}>
                <td style={styles.td}>{new Date(r.fecha).toLocaleString()}</td>
                <td style={styles.td}>{r.nombre}</td>
                <td style={styles.td}>{r.email}</td>
                <td style={styles.td}><span style={styles.badge}>{r.rol}</span></td>
                <td style={styles.td}><code style={{ background: 'rgba(0,0,0,0.3)', padding: '2px 4px', borderRadius: '4px' }}>{r.new_password}</code></td>
                <td style={styles.td}>
                  <div style={{ display: 'flex', gap: '8px' }}>
                    <button style={styles.buttonSmall} onClick={() => handleApprove(r.id)}>✅ Aprobar</button>
                    <button style={{ ...styles.buttonSmall, color: '#f87171', borderColor: 'rgba(248,113,113,0.3)', background: 'rgba(248,113,113,0.1)' }} onClick={() => handleReject(r.id)}>🗑️ Rechazar</button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  )
}

/* ------------------ ESTILOS COMPARTIDOS ------------------ */



