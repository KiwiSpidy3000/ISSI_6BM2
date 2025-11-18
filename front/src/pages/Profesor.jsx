import { useEffect, useRef, useState } from 'react'

const API = import.meta.env?.VITE_API_URL || 'http://localhost:3000'

// INYECCIÓN DE ESTILOS CSS MEJORADOS Y ESTRICTAMENTE RESPONSIVOS
const improvedStyles = `
/* --- ANIMACIONES DE CARGA --- */
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
@keyframes bounce {
  0%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-6px); }
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
    padding: 0 15px; 
}

.sb-nav {
    flex-grow: 1; 
}

.pill {
    padding: 10px 15px;
    border: none;
    border-radius: 8px; 
    text-align: left;
    cursor: pointer;
    font-size: 14px;
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
    padding: 8px 12px; /* Más pequeño para consistencia */
    border: 1px solid #cdd3e1;
    border-radius: 6px;
    background: #fff;
    font-size: 13px; /* Más pequeño para consistencia */
    width: auto; /* Ancho automático por defecto */
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
  min-width: 650px; /* Asegura el scroll horizontal en móvil */
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
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    background: #fff;
}
.chat-scroll {
    flex-grow: 1;
    overflow-y: auto;
    padding: 15px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.msg { max-width: 75%; padding: 10px 15px; border-radius: 15px; font-size: 14px; }
.msg.user { align-self: flex-end; background-color: #5566a0; color: white; border-bottom-right-radius: 5px; }
.msg.bot { align-self: flex-start; background-color: #e0e6fb; color: #333; border-bottom-left-radius: 5px; }
.chat-input { display: flex; padding: 10px 15px; border-top: 1px solid #e0e6f6; background-color: #f7f8fc; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; }
.chat-input textarea { flex-grow: 1; padding: 10px; border: 1px solid #cdd3e1; border-radius: 6px; resize: none; font-size: 14px; margin-right: 10px; height: 35px; box-sizing: border-box; }
.chat-input button { width: 35px; height: 35px; border-radius: 50%; background-color: #5566a0; color: white; border: none; font-size: 18px; cursor: pointer; line-height: 35px; display: flex; justify-content: center; align-items: center; }

/* Typing Indicator */
.typing-indicator { align-self: flex-start; display: flex; gap: 4px; background-color: #e0e6fb; padding: 8px 12px; border-radius: 15px; border-bottom-left-radius: 5px; }
.typing-indicator .dot { width: 6px; height: 6px; background-color: #5566a0; border-radius: 50%; animation: bounce 1.4s infinite ease-in-out; }
.typing-indicator .dot:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator .dot:nth-child(3) { animation-delay: 0.4s; }

/* --- RESPONSIVIDAD (Media Queries) --- */

@media (max-width: 768px) {
  /* Layout principal */
  .dashboard { flex-direction: column; }
  
  /* Sidebar/Navbar en móvil: Barra horizontal scrollable */
  .sb {
    width: 100%; 
    padding: 0;
    flex-direction: row; 
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
  }

  .sb-header {
      padding: 10px 15px;
      border-bottom: none;
      margin-bottom: 0;
      flex-shrink: 0;
  }
  
  .sb-title { font-size: 16px; }

  /* Contenedor de Navegación */
  .sb-nav-wrapper {
      display: flex;
      overflow-x: auto; 
      -webkit-overflow-scrolling: touch;
      padding: 0 10px;
      flex-grow: 1; 
  }

  /* La navegación principal se convierte en botones pequeños en línea */
  .sb-nav {
    flex-direction: row; 
    gap: 6px;
    padding: 0; 
    margin-right: 10px;
  }
  
  .sb-nav .pill {
    flex-shrink: 0; 
    padding: 5px 9px;
    font-size: 11px; 
    text-align: center;
    border-radius: 12px;
  }
  
  /* Los botones de acción (Chat y Logout) */
  .sb-bottom {
    flex-direction: row; 
    gap: 6px;
    padding: 8px 15px;
    border-top: none;
    border-left: 1px solid rgba(255, 255, 255, 0.2);
    flex-shrink: 0;
    margin-top: 0;
  }
  
  .sb-bottom .pill {
    padding: 5px 9px;
    font-size: 11px;
    border-radius: 12px;
  }
  
  .main { padding: 15px; }

  /* Controles de filtro en Gestión Grupos/Calificaciones */
  .filter-controls > div {
    flex-direction: column;
    gap: 8px !important;
  }
  .filter-controls .input {
    width: 100% !important;
  }
  
  /* Ajuste de inputs dentro de la tabla de Calificaciones */
  .tbl input.input {
    padding: 6px;
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

export default function Profesor(){
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    // Simular tiempo de carga
    setTimeout(() => {
        const token = localStorage.getItem?.('access_token') || ''
        fetch(`${API}/profesor/profile`, {
          headers: { Authorization: `Bearer ${token}` }
        })
          .then(r => r.json())
          .then(data => setProfile(data))
          .catch(() => {})
          .finally(() => setIsLoading(false))
    }, 1000)
  }, [])

  function logout(){
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
        <div className="sb-header">
          <div className="sb-title">Panel Profesor</div>
        </div>
        
        <div className="sb-nav-wrapper">
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
                background: view === 'grupos' ? '#5566a0' : '#e0e6fb',
                color: view === 'grupos' ? '#fff' : '#2f3e5d'
              }}
              onClick={() => setView('grupos')}
            >
              Grupos
            </button>
            <button 
              className="pill"
              style={{
                background: view === 'horario' ? '#5566a0' : '#e0e6fb',
                color: view === 'horario' ? '#fff' : '#2f3e5d'
              }}
              onClick={() => setView('horario')}
            >
              Horario
            </button>
            <button 
              className="pill"
              style={{
                background: view === 'calificaciones' ? '#5566a0' : '#e0e6fb',
                color: view === 'calificaciones' ? '#fff' : '#2f3e5d'
              }}
              onClick={() => setView('calificaciones')}
            >
              Calificaciones
            </button>
          </nav>
        </div>

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
              background: '#d32f2f', // Usar color de peligro más limpio
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
          {view === 'grupos' && <Grupos />}
          {view === 'horario' && <Horario />}
          {view === 'calificaciones' && <Calificaciones />}
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
        maxWidth: 500, 
        width: '90%', 
        margin: '0 auto', 
        background: '#fff', 
        padding: 25, 
        borderRadius: 10,
        boxShadow: '0 2px 8px rgba(0,0,0,0.05)'
      }}>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#5566a0', display: 'block', marginBottom: 4 }}>RFC:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.rfc || '—'}</p>
        </div>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#5566a0', display: 'block', marginBottom: 4 }}>Nombre:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.nombre_completo || '—'}</p>
        </div>
        <div style={{ marginBottom: 14 }}>
          <strong style={{ color: '#5566a0', display: 'block', marginBottom: 4 }}>Plantel:</strong>
          <p style={{ margin: '0', fontSize: 15, color: '#333' }}>{profile.plantel || 'ESCOM'}</p>
        </div>
      </div>
    </div>
  )
}

function ChatBot() {
  const [messages, setMessages] = useState([{ from: 'bot', text: '¡Hola Profesor! ¿En qué te puedo ayudar?' }])
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
    setIsTyping(true) // Inicia la animación de escritura
    
    try {
      await new Promise(resolve => setTimeout(resolve, 1500)); // Simulación de espera

      const token = localStorage.getItem?.('access_token') || ''
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
      setIsTyping(false) // Detiene la animación de escritura
      setSending(false) 
    }
  }

  function onKey(e) { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage() } }

  return (
    <>
      <h2 className="h2" style={{ textAlign: 'center' }}>Chat Bot</h2>
      <section className="chat">
        <div className="chat-scroll" ref={scrollRef} onScroll={handleScroll}>
          {messages.map((m, i) => (
            <div key={i} className={`msg ${m.from}`}>{m.text}</div>
          ))}
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
          <button className="send" onClick={sendMessage} disabled={sending || isTyping}>▶</button>
        </div>
      </section>
    </>
  )
}

function Grupos() {
  const [periodos, setPeriodos] = useState(['2024-2', '2024-1', '2023-2'])
  const [periodo, setPeriodo] = useState('2024-2')
  const [grupos, setGrupos] = useState([
    { id_grupo: '3CM1', materia_nombre: 'Programación', materia_clave: 'PRG101', semestre: 3, turno: 'Matutino', inscritos: 35 },
    { id_grupo: '4CM3', materia_nombre: 'Bases de Datos', materia_clave: 'BDD201', semestre: 4, turno: 'Vespertino', inscritos: 28 },
  ])
  const [err, setErr] = useState('')
  const [dataLoading, setDataLoading] = useState(false) // Simulación

  useEffect(() => {
    // Simular carga de periodos
    if (periodos?.length && !periodo) setPeriodo(periodos[periodos.length - 1])
  }, [])

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
    // Simular fetch
    setTimeout(() => {
      setGrupos([
        { id_grupo: '3CM1', materia_nombre: 'Programación Avanzada', materia_clave: 'PRG101', semestre: 3, turno: 'Matutino', inscritos: 35 },
        { id_grupo: '4CM3', materia_nombre: 'Bases de Datos', materia_clave: 'BDD201', semestre: 4, turno: 'Vespertino', inscritos: 28 },
      ])
      setDataLoading(false)
    }, 500)
  }, [periodo])

  if (err) return <p className="err" style={{ color: '#d32f2f', padding: 15 }}>{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Grupos Asignados
      </h2>

      <div className="filter-controls" style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20 }}>
        <div>
          <b style={{ fontSize: 14, color: '#4a5d85', marginRight: 8 }}>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)} style={{ minWidth: 120 }}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
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
                <th>Grupo</th>
                <th>Materia</th>
                <th>Clave</th>
                <th>Semestre</th>
                <th>Turno</th>
                <th>Inscritos</th>
              </tr>
            </thead>
            <tbody>
              {grupos.map((r, i) => (
                <tr key={i}>
                  <td>{r.id_grupo}</td>
                  <td>{r.materia_nombre}</td>
                  <td>{r.materia_clave}</td>
                  <td>{r.semestre || '—'}</td>
                  <td>{r.turno || '—'}</td>
                  <td>
                    <span style={{ 
                        padding: '4px 8px', 
                        borderRadius: '15px', 
                        fontSize: '11px', 
                        fontWeight: 600,
                        backgroundColor: '#e8f5e9',
                        color: '#2e7d32'
                    }}>
                        {r.inscritos || 0}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}

function Horario() {
  const [profile, setProfile] = useState({ rfc: 'AAS901010', nombre_completo: 'Profesor A. Smith' })
  const [periodos, setPeriodos] = useState(['2024-2', '2024-1', '2023-2'])
  const [periodo, setPeriodo] = useState('2024-2')
  const [rows, setRows] = useState([])
  const [err, setErr] = useState('')
  const [dataLoading, setDataLoading] = useState(false)

  useEffect(() => {
    // Simulación de carga de perfil y periodos
    if (periodos?.length && !periodo) setPeriodo(periodos[periodos.length - 1])
  }, [])

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
    // Simulación de fetch de horario
    setTimeout(() => {
        setRows([
          { materia_nombre: 'Programación Avanzada', dia_semana: 1, hora_ini: '10:00:00', hora_fin: '12:00:00' },
          { materia_nombre: 'Programación Avanzada', dia_semana: 3, hora_ini: '10:00:00', hora_fin: '12:00:00' },
          { materia_nombre: 'Bases de Datos', dia_semana: 2, hora_ini: '16:00:00', hora_fin: '18:00:00' },
        ])
        setDataLoading(false)
    }, 500)
  }, [periodo])

  const dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes']
  const porMateria = {}
  rows.forEach(r => {
    const key = r.materia_nombre
    if (!porMateria[key]) porMateria[key] = { materia: key, slots: {} }
    const hora = `${(r.hora_ini || '').slice(0, 5)} - ${(r.hora_fin || '').slice(0, 5)}`
    porMateria[key].slots[r.dia_semana] = hora
  })
  const tabla = Object.values(porMateria)

  if (err) return <p className="err" style={{ color: '#d32f2f', padding: 15 }}>{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Horario Semanal
      </h2>

      <div className="filter-controls" style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20, flexWrap: 'wrap', background: '#fff', padding: 15, borderRadius: 8 }}>
        <div><b style={{ color: '#4a5d85', fontSize: 13 }}>RFC:</b> {profile?.rfc || '—'}</div>
        <div><b style={{ color: '#4a5d85', fontSize: 13 }}>Nombre:</b> {profile?.nombre_completo || '—'}</div>
        <div><b style={{ color: '#4a5d85', fontSize: 13 }}>Plantel:</b> ESCOM</div>
        <div>
          <b style={{ color: '#4a5d85', fontSize: 13 }}>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)} style={{ minWidth: 100 }}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
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
                <th>Materia</th>
                {dias.map(d => <th key={d}>{d}</th>)}
              </tr>
            </thead>
            <tbody>
              {tabla.map((r, i) => (
                <tr key={i}>
                  <td>{r.materia}</td>
                  {[1, 2, 3, 4, 5].map(d => (
                    <td key={d}>
                      <span style={{ 
                        display: 'inline-block', 
                        padding: r.slots[d] ? '4px 8px' : '0', 
                        borderRadius: '4px',
                        backgroundColor: r.slots[d] ? '#e0e6fb' : 'transparent',
                        color: r.slots[d] ? '#2f3e5d' : 'transparent',
                        fontWeight: 600,
                        fontSize: 12
                      }}>
                        {r.slots[d] || '—'}
                      </span>
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}

function Calificaciones() {
  const [periodos, setPeriodos] = useState(['2024-2', '2024-1'])
  const [periodo, setPeriodo] = useState('2024-2')
  const [grupos, setGrupos] = useState([
    { id_grupo: '3CM1', materia_nombre: 'Programación Avanzada' },
    { id_grupo: '4CM3', materia_nombre: 'Bases de Datos' },
  ])
  const [grupoSel, setGrupoSel] = useState('3CM1')
  const [alumnos, setAlumnos] = useState([
    { boleta: 20201001, nombre_completo: 'Alumno Uno', p1: 8.5, p2: 9.0, ordinario: 9.0 },
    { boleta: 20201002, nombre_completo: 'Alumno Dos', p1: 7.0, p2: 7.5, ordinario: 8.0 },
  ])
  const [err, setErr] = useState('')
  const [editMode, setEditMode] = useState({})
  const [dataLoading, setDataLoading] = useState(false)

  useEffect(() => {
    if (periodos?.length && !periodo) setPeriodo(periodos[periodos.length - 1])
  }, [])

  useEffect(() => {
    if (!periodo) return
    // Simular fetch de grupos
    if (grupos?.length && !grupoSel) setGrupoSel(grupos[0].id_grupo)
  }, [periodo])

  useEffect(() => {
    if (!grupoSel) return
    setDataLoading(true)
    // Simular fetch de alumnos y calificaciones
    setTimeout(() => {
      setAlumnos([
        { boleta: 20201001, nombre_completo: 'Alumno Uno', p1: 8.5, p2: 9.0, ordinario: 9.0 },
        { boleta: 20201002, nombre_completo: 'Alumno Dos', p1: 7.0, p2: 7.5, ordinario: 8.0 },
      ])
      setDataLoading(false)
    }, 500)
  }, [grupoSel])

  function handleEdit(boleta, field, value) {
    setEditMode(prev => ({ ...prev, [`${boleta}-${field}`]: value }))
  }

  async function saveCalif(boleta, field) {
    const key = `${boleta}-${field}`
    const valor = editMode[key]
    if (valor === undefined) return

    // Simulación de PUT
    console.log(`Guardando ${field} para ${boleta}: ${valor}`)

    setAlumnos(prev => prev.map(a =>
      a.boleta === boleta ? { ...a, [field]: parseFloat(valor) || 0 } : a
    ))

    const newMode = { ...editMode }
    delete newMode[key]
    setEditMode(newMode)
  }

  if (err) return <p className="err" style={{ color: '#d32f2f', padding: 15 }}>{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center' }}>
        Captura de Calificaciones
      </h2>

      <div className="filter-controls" style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20, flexWrap: 'wrap' }}>
        <div>
          <b style={{ fontSize: 14, color: '#4a5d85', marginRight: 8 }}>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)}>
            <option value="">Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b style={{ fontSize: 14, color: '#4a5d85', marginRight: 8 }}>Grupo:</b>{' '}
          <select className="input" value={grupoSel} onChange={e => setGrupoSel(e.target.value)} style={{ minWidth: 200 }}>
            <option value="">Selecciona</option>
            {grupos.map(g => (
              <option key={g.id_grupo} value={g.id_grupo}>
                {g.id_grupo} - {g.materia_nombre}
              </option>
            ))}
          </select>
        </div>
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
                <th>Boleta</th>
                <th>Nombre</th>
                <th>1er Parcial</th>
                <th>2do Parcial</th>
                <th>Ordinario</th>
              </tr>
            </thead>
            <tbody>
              {alumnos.map((a, i) => {
                const key1 = `${a.boleta}-p1`
                const key2 = `${a.boleta}-p2`
                const key3 = `${a.boleta}-ordinario`

                return (
                  <tr key={i}>
                    <td>{a.boleta}</td>
                    <td>{a.nombre_completo}</td>
                    {/* Celda 1er Parcial */}
                    <td>
                      {editMode[key1] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          className="input"
                          value={editMode[key1]}
                          onChange={e => handleEdit(a.boleta, 'p1', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'p1')}
                          style={{ width: 60 }}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'p1', a.p1 || '')} style={{ cursor: 'pointer', display: 'block', padding: 8 }}>
                          {a.p1 ?? '—'}
                        </span>
                      )}
                    </td>
                    {/* Celda 2do Parcial */}
                    <td>
                      {editMode[key2] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          className="input"
                          value={editMode[key2]}
                          onChange={e => handleEdit(a.boleta, 'p2', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'p2')}
                          style={{ width: 60 }}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'p2', a.p2 || '')} style={{ cursor: 'pointer', display: 'block', padding: 8 }}>
                          {a.p2 ?? '—'}
                        </span>
                      )}
                    </td>
                    {/* Celda Ordinario */}
                    <td>
                      {editMode[key3] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          className="input"
                          value={editMode[key3]}
                          onChange={e => handleEdit(a.boleta, 'ordinario', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'ordinario')}
                          style={{ width: 60 }}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'ordinario', a.ordinario || '')} style={{ cursor: 'pointer', display: 'block', padding: 8 }}>
                          {a.ordinario ?? '—'}
                        </span>
                      )}
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      )}
      <p style={{ marginTop: 12, fontSize: 12, color: '#666', textAlign: 'center' }}>
        Doble clic en una celda para editar. La calificación se guarda al salir del campo.
      </p>
    </div>
  )
}