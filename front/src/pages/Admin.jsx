import { useState, useEffect, useRef } from 'react'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

// INYECCIÓN DE ESTILOS CSS MEJORADOS Y ESTRICTAMENTE RESPONSIVOS
const improvedStyles = `
/* --- ANIMACIONES DE CARGA --- */
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(247, 248, 252, 0.9);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 10000;
}

.spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #4a5d85;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

/* --- ESTILOS GENERALES Y LAYOUT BASE --- */
body {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
      'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
      sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

/* Contenedor principal del Dashboard */
.dashboard {
  display: flex;
  min-height: 100vh;
  flex-direction: row; 
  background-color: #f7f8fc;
}

/* Sidebar (Barra Lateral) - Escritorio */
.sb {
  width: 250px; 
  background-color: #4a5d85;
  color: white;
  padding: 20px 0;
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  box-shadow: 2px 0 10px rgba(0,0,0,0.1);
}

.sb-header {
    display: flex;
    align-items: center;
    padding: 0 20px 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    margin-bottom: 15px;
}

.sb-title {
    font-size: 20px;
    font-weight: 700;
    margin-left: 10px;
}

.sb-nav, .sb-bottom {
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 0 15px; /* Reducido a 15px */
}

.sb-nav {
    flex-grow: 1; 
}

.pill {
    padding: 10px 15px; /* Reducido */
    border: none;
    border-radius: 8px; 
    text-align: left;
    cursor: pointer;
    font-size: 14px; /* Reducido */
    font-weight: 600;
    transition: background-color 0.2s, transform 0.1s;
}

.pill:hover:not([style*="background: #5566a0"]) {
    background-color: #cdd3e1 !important; 
}

.sb-bottom {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid rgba(255, 255, 255, 0.2);
}

/* Contenido Principal */
.main {
  flex-grow: 1;
  padding: 20px; 
  background-color: #f7f8fc;
  overflow-y: auto;
  overflow-x: hidden; 
}

.main-content-wrapper {
  max-width: 1300px; 
  margin: 0 auto;
}

/* Estilos de botones y inputs comunes */
.input {
    padding: 10px 14px;
    border: 1px solid #cdd3e1;
    border-radius: 6px;
    background: #fff;
    font-size: 14px;
    width: 100%;
    box-sizing: border-box;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.input:focus {
    outline: none;
    border-color: #5566a0;
    box-shadow: 0 0 0 3px rgba(85, 102, 160, 0.2);
}

.btn {
    padding: 10px 18px;
    background: #5566a0;
    color: #fff;
    border: none;
    border-radius: 20px; 
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.1s;
}

.btn:hover {
    background-color: #4a5d85;
}

.h2 {
    color: #4a5d85;
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    border-bottom: 2px solid #e0e6f6;
    padding-bottom: 8px;
}

/* --- ESTILOS TABLAS Y DATOS --- */
.tableWrap {
  overflow-x: auto;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  padding: 10px;
}

.tbl {
  width: 100%;
  border-collapse: collapse;
  min-width: 600px; /* Asegura el scroll horizontal en móvil */
}

.tbl thead tr {
    background-color: #e0e6fb; 
    color: #4a5d85;
    text-transform: uppercase;
    font-size: 12px;
}

.tbl th, .tbl td {
  padding: 10px 12px;
  border-bottom: 1px solid #e0e6f6;
  text-align: left;
}

.tbl td {
    font-size: 13px;
    color: #333;
}

/* --- ESTILOS CHAT BOT --- */
.chat {
    display: flex;
    flex-direction: column;
    height: 65vh; 
    max-width: 700px;
    margin: 0 auto;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    background: #fff;
}

.msg.bot {
    background-color: #e0e6fb; 
    color: #333;
}

/* Typing Animation... (mantenidas) */
@keyframes bounce {
  0%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-6px); }
}

.typing-indicator .dot {
  animation: bounce 1.4s infinite ease-in-out;
}

/* --- RESPONSIVIDAD (Media Queries) --- */

@media (max-width: 768px) {
  /* Layout principal */
  .dashboard {
    flex-direction: column; 
  }
  
  /* Sidebar/Navbar en móvil: Hacemos una barra horizontal scrollable */
  .sb {
    width: 100%; 
    padding: 0; /* Quitamos padding vertical */
    height: auto; 
    flex-direction: row; /* Horizontal */
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    align-items: center;
    position: sticky; /* Fija la barra de navegación en la parte superior */
    top: 0;
    z-index: 100;
  }

  .sb-header {
      padding: 10px 15px; /* Menos padding */
      border-bottom: none;
      margin-bottom: 0;
      flex-shrink: 0; /* No encoger el título */
  }
  
  .sb-title {
      font-size: 16px; /* Título más pequeño */
  }

  /* Contenedor de Navegación */
  .sb-nav-wrapper {
      display: flex;
      overflow-x: auto; /* Permitir scroll horizontal en la navegación */
      -webkit-overflow-scrolling: touch;
      padding: 0 10px;
      flex-grow: 1; /* Ocupa el espacio restante */
  }

  /* La navegación principal se convierte en botones pequeños en línea */
  .sb-nav {
    flex-direction: row; 
    gap: 8px;
    padding: 0; 
    margin-right: 15px;
  }
  
  .sb-nav .pill {
    flex-shrink: 0; /* No encoger los botones */
    padding: 6px 10px; /* Botones mucho más pequeños */
    font-size: 12px; 
    text-align: center;
    border-radius: 15px; /* Forma de pastilla más marcada */
  }
  
  /* Los botones de acción (Chat y Logout) */
  .sb-bottom {
    flex-direction: row; 
    gap: 8px;
    padding: 10px 15px;
    border-top: none;
    border-left: 1px solid rgba(255, 255, 255, 0.2);
    flex-shrink: 0;
    margin-top: 0;
  }
  
  .sb-bottom .pill {
    padding: 6px 10px;
    font-size: 12px;
    border-radius: 15px;
  }
  
  .main {
    padding: 15px; /* Reducir padding en móvil */
  }

  /* Inputs de filtro y botón de acción en Gestión Usuarios/Clases */
  .flex-wrap-mobile {
    flex-direction: column;
    gap: 10px !important; 
  }
  
  .flex-wrap-mobile > div {
    min-width: 100% !important;
  }
}
`

// Función para inyectar CSS
function injectStyles(css) {
  const style = document.createElement('style');
  style.type = 'text/css';
  style.appendChild(document.createTextNode(css));
  document.head.appendChild(style);
}

// Inyectar estilos al cargar el componente principal
injectStyles(improvedStyles);

export default function Admin() {
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    // Simular tiempo de carga y obtener datos
    setTimeout(() => {
      const token = localStorage.getItem('access_token') || ''
      fetch(`${API}/admin/profile`, {
        headers: { Authorization: `Bearer ${token}` }
      })
        .then(r => r.json())
        .then(data => {
          setProfile(data)
          setIsLoading(false)
        })
        .catch(() => {
          setIsLoading(false)
        })
    }, 1000)
  }, [])

  function logout() {
    localStorage.removeItem('access_token')
    window.location.href = '/'
  }
  
  if (isLoading) {
    return (
      <div className="loading-overlay">
        <div className="spinner"></div>
      </div>
    )
  }

  return (
    <div className="dashboard">
      <aside className="sb">
        {/* HEADER (Título) */}
        <div className="sb-header">
          <div className="sb-title">Admin Panel</div> 
        </div>
        
        <div className="sb-nav-wrapper"> {/* Contenedor para el scroll horizontal en móvil */}
            {/* NAVEGACIÓN PRINCIPAL */}
            <nav className="sb-nav">
              <button 
                className="pill"
                style={{
                  background: view === 'perfil' ? '#5566a0' : '#e0e6fb',
                  color: view === 'perfil' ? '#fff' : '#2f3e5d'
                }}
                onClick={() => setView('perfil')}
              >
                Datos Personales
              </button>
              <button 
                className="pill"
                style={{
                  background: view === 'usuarios' ? '#5566a0' : '#e0e6fb',
                  color: view === 'usuarios' ? '#fff' : '#2f3e5d'
                }}
                onClick={() => setView('usuarios')}
              >
                Gestión de Usuarios
              </button>
              <button 
                className="pill"
                style={{
                  background: view === 'clases' ? '#5566a0' : '#e0e6fb',
                  color: view === 'clases' ? '#fff' : '#2f3e5d'
                }}
                onClick={() => setView('clases')}
              >
                Gestión de Clases
              </button>
              <button 
                className="pill"
                style={{
                  background: view === 'reinscripcion' ? '#5566a0' : '#e0e6fb',
                  color: view === 'reinscripcion' ? '#fff' : '#2f3e5d'
                }}
                onClick={() => setView('reinscripcion')}
              >
                Reinscripción
              </button>
            </nav>
        </div>

        {/* BOTONES DE ACCIÓN (Chat y Logout) */}
        <div className="sb-bottom">
          <button 
            className="pill"
            style={{
              background: view === 'chat' ? '#5566a0' : '#e0e6fb',
              color: view === 'chat' ? '#fff' : '#2f3e5d'
            }}
            onClick={() => setView('chat')}
          >
            Chat Bot
          </button>
          <button 
            className="pill" 
            onClick={logout}
            style={{
              background: '#d32f2f',
              color: '#fff',
              fontWeight: 700
            }}
          >
            Cerrar sesión
          </button>
        </div>
      </aside>

    <main className="main">
      <div className="main-content-wrapper">
        {view === 'perfil' && <DatosPersonales profile={profile} />}
        {view === 'usuarios' && <GestionUsuarios />}
        {view === 'clases' && <GestionClases />}
        {view === 'reinscripcion' && <GestionReinscripcion />}
        {view === 'chat' && <ChatBot />}
      </div>
    </main>
      </div>
  )
}

// --- Componentes ---

function DatosPersonales({ profile }) {
  if (!profile) return <p>Cargando...</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Datos Personales
      </h2>
      <div style={{ 
        maxWidth: 600, 
        width: '90%', 
        margin: '0 auto', 
        background: '#fff',
        padding: 25, 
        borderRadius: 10,
        boxShadow: '0 2px 8px rgba(0,0,0,0.05)'
      }}>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#4a5d85', display: 'block', marginBottom: 4 }}>Nombre:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.nombre_completo || '—'}</p>
        </div>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#4a5d85', display: 'block', marginBottom: 4 }}>ID:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.id || '—'}</p>
        </div>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#4a5d85', display: 'block', marginBottom: 4 }}>Email:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.email || '—'}</p>
        </div>
        <div>
          <strong style={{ color: '#4a5d85', display: 'block', marginBottom: 4 }}>Rol:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>Administrador</p>
        </div>
      </div>
    </div>
  )
}

function ChatBot() {
  const [messages, setMessages] = useState([{ from: 'bot', text: '¡Hola Admin! ¿En qué te puedo ayudar?' }])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)
  const [isTyping, setIsTyping] = useState(false)
  const scrollRef = useRef(null)
  const [stickBottom, setStickBottom] = useState(true)

  function handleScroll() {
    const el = scrollRef.current
    if (!el) return
    const nearBottom = el.scrollHeight - el.scrollTop - el.clientHeight < 80
    setStickBottom(nearBottom)
  }

  useEffect(() => {
    const el = scrollRef.current
    if (el && stickBottom) {
      el.scrollTop = el.scrollHeight
    }
  }, [messages, stickBottom, isTyping])

  async function sendMessage() {
    const clean = text.trim()
    if (!clean || sending) return
    
    setSending(true)
    setMessages(prev => [...prev, { from: 'user', text: clean }])
    setText('')
    setIsTyping(true)

    try {
      await new Promise(resolve => setTimeout(resolve, 1500)); 

      const token = localStorage.getItem('access_token') || ''
      const res = await fetch(`${API}/ai/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) },
        body: JSON.stringify({ message: clean })
      })
      const data = await res.json()
      
      setMessages(prev => [...prev, { from: 'bot', text: data?.reply || 'Sin respuesta.' }])
    } catch {
      setMessages(prev => [...prev, { from: 'bot', text: 'AI service unavailable.' }])
    } finally { 
      setIsTyping(false)
      setSending(false) 
    }
  }

  function onKey(e) { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage() } }

  return (
    <>
      <h2 className="h2">Chat Bot</h2>
      <section className="chat">
        <div className="chat-scroll" ref={scrollRef} onScroll={handleScroll}>
          {messages.map((m, i) => (
            <div key={i} className={`msg ${m.from}`}>{m.text}</div>
          ))}
          {/* Animación de "Bot escribiendo" */}
          {isTyping && (
            <div className="typing-indicator">
              <div className="dot"></div>
              <div className="dot"></div>
              <div className="dot"></div>
            </div>
          )}
        </div>
        <div className="chat-input">
          <textarea value={text} onChange={e => setText(e.target.value)} onKeyDown={onKey}
            placeholder="Escribe tu mensaje…" disabled={sending || isTyping} />
          <button className="send" onClick={sendMessage} disabled={sending || isTyping}>
            {sending ? '...' : '▶'}
          </button>
        </div>
      </section>
    </>
  )
}

function GestionUsuarios() {
  const [usuarios, setUsuarios] = useState([])
  const [busqueda, setBusqueda] = useState('')
  const [tipoFiltro, setTipoFiltro] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [editingUser, setEditingUser] = useState(null)
  const [dataLoading, setDataLoading] = useState(true)

  useEffect(() => {
    cargarUsuarios()
  }, [])

  function cargarUsuarios() {
    setDataLoading(true)
    // Simulación de carga de datos
    setUsuarios([
        { id: 12345, nombre: 'Ana García', tipo: 'Alumno', estado: 'Activo' },
        { id: 67890, nombre: 'Profesor Carlos Solís', tipo: 'Maestro', estado: 'Activo' },
        { id: 10111, nombre: 'Luis Flores (Inactivo)', tipo: 'Alumno', estado: 'Inactivo' },
    ])
    setTimeout(() => setDataLoading(false), 500)
  }

  const usuariosFiltrados = usuarios.filter(u => {
    const matchBusqueda = !busqueda || 
      u.nombre?.toLowerCase().includes(busqueda.toLowerCase()) ||
      u.id?.toString().includes(busqueda)
    const matchTipo = !tipoFiltro || u.tipo === tipoFiltro
    return matchBusqueda && matchTipo
  })

  function abrirModal(user = null) {
    setEditingUser(user)
    setShowModal(true)
  }

  function cerrarModal() {
    setShowModal(false)
    setEditingUser(null)
  }

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Gestión de Usuarios
      </h2>

      <div className="flex-wrap-mobile" style={{ 
        display: 'flex', 
        gap: 16, 
        alignItems: 'center', 
        marginBottom: 20,
        flexWrap: 'wrap'
      }}>
        <div style={{ flex: 1, minWidth: '40%', position: 'relative' }}>
          <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#999' }}>
            {/* 🔍 */}
          </span>
          <input
            type="text"
            className="input"
            placeholder="Buscar por Nombre, ID..."
            value={busqueda}
            onChange={e => setBusqueda(e.target.value)}
            style={{ paddingLeft: 12, width: '100%' }}
          />
        </div>
        <div style={{ flexGrow: 1, minWidth: '40%' }}>
          <select
            className="input"
            value={tipoFiltro}
            onChange={e => setTipoFiltro(e.target.value)}
            style={{ width: '100%' }}
          >
            <option value="">Tipo de Usuario</option>
            <option value="Alumno">Alumno</option>
            <option value="Maestro">Maestro</option>
            <option value="Admin">Admin</option>
          </select>
        </div>
        <button 
          className="btn" 
          onClick={() => abrirModal()}
          style={{ whiteSpace: 'nowrap', width: 'auto', background: '#4CAF50' }}
        >
          Añadir Usuario
        </button>
      </div>
      
      {dataLoading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: '50px' }}>
            <div className="spinner"></div>
        </div>
      ) : (
        <div className="tableWrap">
          <table className="tbl">
            <thead>
              <tr>
                <th>ID</th>
                <th>Nombre del Usuario</th>
                <th>Tipo de Usuario</th>
                <th>Estado</th>
                <th style={{ textAlign: 'center' }}>Acción</th>
              </tr>
            </thead>
            <tbody>
              {usuariosFiltrados.map((u, i) => (
                <tr key={i}>
                  <td>{u.id}</td>
                  <td>{u.nombre}</td>
                  <td>
                    <span style={{ 
                        padding: '4px 8px', 
                        borderRadius: '15px', 
                        fontSize: '11px', 
                        fontWeight: 600,
                        backgroundColor: u.tipo === 'Admin' ? '#ffe8e8' : u.tipo === 'Maestro' ? '#fffbe0' : '#e0e6fb',
                        color: u.tipo === 'Admin' ? '#8a1f1f' : u.tipo === 'Maestro' ? '#9c6500' : '#2f3e5d'
                    }}>
                        {u.tipo}
                    </span>
                  </td>
                  <td>
                    <span style={{ 
                        padding: '4px 8px', 
                        borderRadius: '15px', 
                        fontSize: '11px', 
                        fontWeight: 600,
                        backgroundColor: u.estado === 'Activo' ? '#e8f5e9' : '#ffe8e8',
                        color: u.estado === 'Activo' ? '#2e7d32' : '#c62828'
                    }}>
                        {u.estado}
                    </span>
                  </td>
                  <td style={{ textAlign: 'center' }}>
                    <button
                      onClick={() => abrirModal(u)}
                      style={{
                        background: '#5566a0',
                        color: '#fff',
                        border: 'none',
                        borderRadius: 20,
                        padding: '6px 14px',
                        cursor: 'pointer',
                        fontSize: 12,
                        fontWeight: 600,
                        transition: 'background-color 0.2s'
                      }}
                    >
                      Modificar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {showModal && (
        <ModalUsuario 
          user={editingUser} 
          onClose={cerrarModal} 
          onSave={() => { cargarUsuarios(); cerrarModal(); }}
        />
      )}
    </div>
  )
}

function ModalUsuario({ user, onClose, onSave }) {
  const [formData, setFormData] = useState({
    id: user?.id || '',
    nombre: user?.nombre || '',
    email: user?.email || '',
    tipo: user?.tipo || 'Alumno',
    estado: user?.estado || 'Activo',
    password: ''
  })

  function handleChange(field, value) {
    setFormData(prev => ({ ...prev, [field]: value }))
  }

  async function handleSubmit(e) {
    e.preventDefault()
    // Lógica de submit omitida para brevedad
    await new Promise(resolve => setTimeout(resolve, 500))
    onSave()
  }

  async function handleDelete() {
    if (!confirm('¿Estás seguro de eliminar este usuario?')) return
    // Lógica de eliminación omitida para brevedad
    await new Promise(resolve => setTimeout(resolve, 500))
    onSave()
  }

  return (
    <div style={{
      position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
      background: 'rgba(0,0,0,0.5)', display: 'flex',
      alignItems: 'center', justifyContent: 'center', zIndex: 1000
    }}>
      <div style={{
        background: '#fff', borderRadius: 10, padding: 25,
        width: 'min(450px, 90vw)', maxHeight: '90vh', overflow: 'auto'
      }}>
        <h3 style={{ marginTop: 0, color: '#5566a0' }}>
          {user ? 'Editar Usuario' : 'Añadir Usuario'}
        </h3>
        
        <form onSubmit={handleSubmit}>
          {/* Los inputs usan la clase .input */}
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              ID / Boleta
            </label>
            <input type="text" className="input" value={formData.id} onChange={e => handleChange('id', e.target.value)} required disabled={!!user} />
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Nombre Completo
            </label>
            <input type="text" className="input" value={formData.nombre} onChange={e => handleChange('nombre', e.target.value)} required />
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Email
            </label>
            <input type="email" className="input" value={formData.email} onChange={e => handleChange('email', e.target.value)} required />
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Tipo de Usuario
            </label>
            <select className="input" value={formData.tipo} onChange={e => handleChange('tipo', e.target.value)}>
              <option value="Alumno">Alumno</option>
              <option value="Maestro">Maestro</option>
              <option value="Admin">Admin</option>
            </select>
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Estado
            </label>
            <select className="input" value={formData.estado} onChange={e => handleChange('estado', e.target.value)}>
              <option value="Activo">Activo</option>
              <option value="Inactivo">Inactivo</option>
            </select>
          </div>

          {!user && (
            <div style={{ marginBottom: 14 }}>
              <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
                Contraseña
              </label>
              <input type="password" className="input" value={formData.password} onChange={e => handleChange('password', e.target.value)} required={!user} />
            </div>
          )}

          {/* Botones usan la clase .btn */}
          <div style={{ display: 'flex', gap: 10, marginTop: 20, flexWrap: 'wrap' }}>
            <button type="submit" className="btn" style={{ flex: 1, minWidth: '100px' }}>
              {user ? 'Guardar Cambios' : 'Crear Usuario'}
            </button>
            {user && (
              <button
                type="button"
                onClick={handleDelete}
                style={{ flex: 1, minWidth: '100px', background: '#d32f2f', color: '#fff', border: 'none', borderRadius: 20, padding: '10px 18px', fontWeight: 600, cursor: 'pointer' }}
              >
                Eliminar
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              style={{ flex: 1, minWidth: '100px', background: '#e0e0e0', color: '#333', border: 'none', borderRadius: 20, padding: '10px 18px', fontWeight: 600, cursor: 'pointer' }}
            >
              Cancelar
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

function GestionClases() {
  const [clases, setClases] = useState([])
  const [busqueda, setBusqueda] = useState('')
  const [materiaFiltro, setMateriaFiltro] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [editingClase, setEditingClase] = useState(null)
  const [dataLoading, setDataLoading] = useState(true)

  useEffect(() => {
    cargarClases()
  }, [])

  function cargarClases() {
    setDataLoading(true)
    setClases([
      { id: 101, profesor: 'Dr. Pérez', materia: 'Matemáticas Avanzadas', creditos: 8, grupo: 'A', horario: 'Lun-Mié 10:00', cupo: 30 },
      { id: 102, profesor: 'Mtra. González', materia: 'Programación', creditos: 10, grupo: 'B', horario: 'Mar-Jue 16:00', cupo: 25 },
    ])
    setTimeout(() => setDataLoading(false), 500)
  }

  const clasesFiltradas = clases.filter(c => {
    const matchBusqueda = !busqueda || 
      c.profesor?.toLowerCase().includes(busqueda.toLowerCase()) ||
      c.id?.toString().includes(busqueda)
    const matchMateria = !materiaFiltro || c.materia === materiaFiltro
    return matchBusqueda && matchMateria
  })

  const materiasUnicas = [...new Set(clases.map(c => c.materia).filter(Boolean))]

  function abrirModal(clase = null) {
    setEditingClase(clase)
    setShowModal(true)
  }

  function cerrarModal() {
    setShowModal(false)
    setEditingClase(null)
  }

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Gestión de Clases
      </h2>

      <div className="flex-wrap-mobile" style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: '40%', position: 'relative' }}>
          <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#999' }}>
            {/* 🔍 */}
          </span>
          <input type="text" className="input" placeholder="Buscar por Profesor, ID..." value={busqueda} onChange={e => setBusqueda(e.target.value)} style={{ paddingLeft: 12, width: '100%' }} />
        </div>
        <div style={{ flexGrow: 1, minWidth: '40%' }}>
          <select className="input" value={materiaFiltro} onChange={e => setMateriaFiltro(e.target.value)} style={{ width: '100%' }}>
            <option value="">Materia</option>
            {materiasUnicas.map(m => (<option key={m} value={m}>{m}</option>))}
          </select>
        </div>
        <button className="btn" onClick={() => abrirModal()} style={{ whiteSpace: 'nowrap', width: 'auto', background: '#4CAF50' }}>
          Añadir Clase
        </button>
      </div>

      {dataLoading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: '50px' }}>
            <div className="spinner"></div>
        </div>
      ) : (
        <div className="tableWrap">
          <table className="tbl">
            <thead>
              <tr>
                <th>ID</th>
                <th>Profesor asignado</th>
                <th>Materia</th>
                <th>Créditos</th>
                <th style={{ textAlign: 'center' }}>Acción</th>
              </tr>
            </thead>
            <tbody>
              {clasesFiltradas.map((c, i) => (
                <tr key={i}>
                  <td>{c.id}</td>
                  <td>{c.profesor}</td>
                  <td>{c.materia}</td>
                  <td>{c.creditos}</td>
                  <td style={{ textAlign: 'center' }}>
                    <button
                      onClick={() => abrirModal(c)}
                      style={{ background: '#5566a0', color: '#fff', border: 'none', borderRadius: 20, padding: '6px 14px', cursor: 'pointer', fontSize: 12, fontWeight: 600, transition: 'background-color 0.2s' }}
                    >
                      Modificar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {showModal && (
        <ModalClase 
          clase={editingClase} 
          onClose={cerrarModal} 
          onSave={() => { cargarClases(); cerrarModal(); }}
        />
      )}
    </div>
  )
}

function ModalClase({ clase, onClose, onSave }) {
  const [formData, setFormData] = useState({
    id: clase?.id || '',
    materia: clase?.materia || '',
    profesor: clase?.profesor || '',
    creditos: clase?.creditos || '',
    grupo: clase?.grupo || '',
    horario: clase?.horario || '',
    cupo: clase?.cupo || ''
  })

  function handleChange(field, value) {
    setFormData(prev => ({ ...prev, [field]: value }))
  }

  async function handleSubmit(e) {
    e.preventDefault()
    await new Promise(resolve => setTimeout(resolve, 500))
    onSave()
  }

  async function handleDelete() {
    if (!confirm('¿Estás seguro de eliminar esta clase?')) return
    await new Promise(resolve => setTimeout(resolve, 500))
    onSave()
  }

  return (
    <div style={{
      position: 'fixed', top: 0, left: 0, right: 0, bottom: 0,
      background: 'rgba(0,0,0,0.5)', display: 'flex',
      alignItems: 'center', justifyContent: 'center', zIndex: 1000
    }}>
      <div style={{
        background: '#fff', borderRadius: 10, padding: 25,
        width: 'min(450px, 90vw)', maxHeight: '90vh', overflow: 'auto'
      }}>
        <h3 style={{ marginTop: 0, color: '#5566a0' }}>
          {clase ? 'Editar Clase' : 'Añadir Clase'}
        </h3>
        
        <form onSubmit={handleSubmit}>
          {/* Inputs usan la clase .input */}
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              ID del Grupo
            </label>
            <input type="text" className="input" value={formData.id} onChange={e => handleChange('id', e.target.value)} required disabled={!!clase} />
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Materia
            </label>
            <input type="text" className="input" value={formData.materia} onChange={e => handleChange('materia', e.target.value)} required />
          </div>

          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Profesor Asignado
            </label>
            <input type="text" className="input" value={formData.profesor} onChange={e => handleChange('profesor', e.target.value)} required />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Créditos
            </label>
            <input type="number" step="0.1" className="input" value={formData.creditos} onChange={e => handleChange('creditos', e.target.value)} required />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Grupo
            </label>
            <input type="text" className="input" value={formData.grupo} onChange={e => handleChange('grupo', e.target.value)} />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Horario
            </label>
            <input type="text" className="input" placeholder="Ej: Lun-Mie 10:00-12:00" value={formData.horario} onChange={e => handleChange('horario', e.target.value)} />
          </div>
          <div style={{ marginBottom: 14 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 13 }}>
              Cupo Máximo
            </label>
            <input type="number" className="input" value={formData.cupo} onChange={e => handleChange('cupo', e.target.value)} />
          </div>
          
          {/* Botones usan la clase .btn */}
          <div style={{ display: 'flex', gap: 10, marginTop: 20, flexWrap: 'wrap' }}>
            <button type="submit" className="btn" style={{ flex: 1, minWidth: '100px' }}>
              {clase ? 'Guardar Cambios' : 'Crear Clase'}
            </button>
            {clase && (
              <button
                type="button"
                onClick={handleDelete}
                style={{ flex: 1, minWidth: '100px', background: '#d32f2f', color: '#fff', border: 'none', borderRadius: 20, padding: '10px 18px', fontWeight: 600, cursor: 'pointer' }}
              >
                Eliminar
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              style={{ flex: 1, minWidth: '100px', background: '#e0e0e0', color: '#333', border: 'none', borderRadius: 20, padding: '10px 18px', fontWeight: 600, cursor: 'pointer' }}
            >
              Cancelar
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

function GestionReinscripcion() {
  const [periodos, setPeriodos] = useState(['2025-1', '2024-2', '2024-1'])
  const [periodo, setPeriodo] = useState('2025-1')
  const [horaInicio, setHoraInicio] = useState('')
  const [horaFin, setHoraFin] = useState('')
  const [mensaje, setMensaje] = useState('')

  useEffect(() => {
    setHoraInicio('2025-01-15T09:00')
    setHoraFin('2025-01-20T18:00')
  }, [periodo])

  async function guardarHorarios(e) {
    e.preventDefault()
    setMensaje('Horarios de reinscripción guardados exitosamente')
    setTimeout(() => setMensaje(''), 3000)
  }

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Gestión de Reinscripción
      </h2>

      <div style={{ maxWidth: 580, width: '90%', margin: '0 auto', background: '#fff', padding: 25, borderRadius: 10, boxShadow: '0 2px 8px rgba(0,0,0,0.05)' }}>
        <form onSubmit={guardarHorarios}>
          <div style={{ marginBottom: 20 }}>
            <label style={{ display: 'block', marginBottom: 8, fontWeight: 600, color: '#5566a0', fontSize: 14 }}>
              Periodo Escolar
            </label>
            <select
              className="input"
              value={periodo}
              onChange={e => setPeriodo(e.target.value)}
              required
            >
              <option value="">Selecciona un periodo</option>
              {periodos.map(p => (<option key={p} value={p}>{p}</option>))}
            </select>
          </div>

          <div style={{ marginBottom: 20 }}>
            <label style={{ display: 'block', marginBottom: 8, fontWeight: 600, color: '#5566a0', fontSize: 14 }}>
              Hora de Inicio de Reinscripción
            </label>
            <input
              type="datetime-local"
              className="input"
              value={horaInicio}
              onChange={e => setHoraInicio(e.target.value)}
              required
            />
            <small style={{ color: '#7a8195', fontSize: 12, marginTop: 4, display: 'block' }}>
              Fecha y hora en que los alumnos podrán comenzar a reinscribirse
            </small>
          </div>

          <div style={{ marginBottom: 20 }}>
            <label style={{ display: 'block', marginBottom: 8, fontWeight: 600, color: '#5566a0', fontSize: 14 }}>
              Hora de Fin de Reinscripción
            </label>
            <input
              type="datetime-local"
              className="input"
              value={horaFin}
              onChange={e => setHoraFin(e.target.value)}
              required
            />
            <small style={{ color: '#7a8195', fontSize: 12, marginTop: 4, display: 'block' }}>
              Fecha y hora en que finaliza el periodo de reinscripción
            </small>
          </div>

          {mensaje && (
            <div style={{
              padding: 12, borderRadius: 6, marginBottom: 15,
              background: mensaje.includes('Error') ? '#ffebee' : '#e8f5e9',
              color: mensaje.includes('Error') ? '#c62828' : '#2e7d32',
              fontSize: 13, fontWeight: 600, textAlign: 'center'
            }}>
              {mensaje}
            </div>
          )}

          <button 
            type="submit"
            className="btn"
            style={{ width: '100%', padding: '10px 18px', marginBottom: 10 }}
          >
            Guardar Horarios de Reinscripción
          </button>
        </form>

        <div style={{ padding: 15, background: '#f7f8fc', borderRadius: 8, border: '1px solid #e0e6f6', marginTop: 15 }}>
          <h4 style={{ margin: '0 0 8px', color: '#4a5d85', fontSize: 14, fontWeight: 700 }}>
            Información Actual
          </h4>
          <div style={{ fontSize: 13, color: '#5a5a5a', lineHeight: 1.6 }}>
            <p style={{ margin: '0 0 5px' }}>
              <strong>Periodo:</strong> {periodo || 'No seleccionado'}
            </p>
            <p style={{ margin: '0 0 5px' }}>
              <strong>Inicio:</strong> {horaInicio ? new Date(horaInicio).toLocaleString('es-MX') : 'No configurado'}
            </p>
            <p style={{ margin: '0' }}>
              <strong>Fin:</strong> {horaFin ? new Date(horaFin).toLocaleString('es-MX') : 'No configurado'}
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}