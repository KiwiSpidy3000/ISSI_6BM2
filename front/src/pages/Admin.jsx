import { useState, useEffect, useRef } from 'react'

const API =import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Admin() {
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)

  useEffect(() => {
    // Cargar datos del perfil del admin
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/admin/profile`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => setProfile(data))
      .catch(() => {})
  }, [])

  function logout() {
    localStorage.removeItem('access_token')
    window.location.href = '/'
  }

  return (
    <div className="dashboard">
      <aside className="sb">
        <div className="sb-header">
          <div className="avatar">👤</div>
          <div className="sb-title">Admin</div>
        </div>
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
            className="pill danger" 
            onClick={logout}
            style={{
              background: '#ffe8e8',
              color: '#8a1f1f'
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

function DatosPersonales({ profile }) {
  if (!profile) return <p>Cargando...</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 24 }}>
        Datos Personales
      </h2>
      <div style={{ 
        maxWidth: 600, 
        margin: '0 auto', 
        background: '#f7f8fc', 
        padding: 32, 
        borderRadius: 12 
      }}>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>Nombre:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.nombre_completo || '—'}</p>
        </div>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>ID:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.id || '—'}</p>
        </div>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>Email:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.email || '—'}</p>
        </div>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>Rol:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>Administrador</p>
        </div>
      </div>
    </div>
  )
}

function ChatBot() {
  const [messages, setMessages] = useState([{ from: 'bot', text: '¡Hola Admin! ¿En qué te puedo ayudar?' }])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)
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
  }, [messages, stickBottom])

  async function sendMessage() {
    const clean = text.trim()
    if (!clean || sending) return
    setSending(true)
    setMessages(prev => [...prev, { from: 'user', text: clean }])
    setText('')
    try {
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
    } finally { setSending(false) }
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
        </div>
        <div className="chat-input">
          <textarea value={text} onChange={e => setText(e.target.value)} onKeyDown={onKey}
            placeholder="Escribe tu mensaje…" disabled={sending} />
          <button className="send" onClick={sendMessage} disabled={sending}>▶</button>
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

  useEffect(() => {
    cargarUsuarios()
  }, [])

  function cargarUsuarios() {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/admin/usuarios`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => setUsuarios(data))
      .catch(() => {})
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
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 20 }}>
        Gestión de Usuarios
      </h2>

      <div style={{ 
        display: 'flex', 
        gap: 16, 
        alignItems: 'center', 
        marginBottom: 20,
        flexWrap: 'wrap'
      }}>
        <div style={{ flex: 1, minWidth: 250, position: 'relative' }}>
          <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#999' }}>
            🔍
          </span>
          <input
            type="text"
            className="input"
            placeholder="Buscar por Nombre, ID....."
            value={busqueda}
            onChange={e => setBusqueda(e.target.value)}
            style={{ paddingLeft: 40 }}
          />
        </div>
        <div>
          <select
            className="input"
            value={tipoFiltro}
            onChange={e => setTipoFiltro(e.target.value)}
            style={{ width: 200 }}
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
          style={{ whiteSpace: 'nowrap' }}
        >
          Añadir Usuario
        </button>
      </div>
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
                <td>{u.tipo}</td>
                <td>{u.estado}</td>
                <td style={{ textAlign: 'center' }}>
                  <button
                    onClick={() => abrirModal(u)}
                    style={{
                      background: '#5566a0',
                      color: '#fff',
                      border: 'none',
                      borderRadius: 20,
                      padding: '6px 16px',
                      cursor: 'pointer',
                      fontSize: 13,
                      fontWeight: 600
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
    const token = localStorage.getItem('access_token') || ''
    
    const endpoint = user 
      ? `${API}/admin/usuarios/${user.id}` 
      : `${API}/admin/usuarios`
    
    const method = user ? 'PUT' : 'POST'

    try {
      await fetch(endpoint, {
        method,
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`
        },
        body: JSON.stringify(formData)
      })
      onSave()
    } catch (err) {
      alert('Error al guardar usuario')
    }
  }

  async function handleDelete() {
    if (!confirm('¿Estás seguro de eliminar este usuario?')) return
    
    const token = localStorage.getItem('access_token') || ''
    try {
      await fetch(`${API}/admin/usuarios/${user.id}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${token}` }
      })
      onSave()
    } catch (err) {
      alert('Error al eliminar usuario')
    }
  }

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      background: 'rgba(0,0,0,0.5)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      zIndex: 1000
    }}>
      <div style={{
        background: '#fff',
        borderRadius: 12,
        padding: 32,
        width: 'min(500px, 90vw)',
        maxHeight: '90vh',
        overflow: 'auto'
      }}>
        <h3 style={{ marginTop: 0, color: '#5566a0' }}>
          {user ? 'Editar Usuario' : 'Añadir Usuario'}
        </h3>
        
        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              ID / Boleta
            </label>
            <input
              type="text"
              className="input"
              value={formData.id}
              onChange={e => handleChange('id', e.target.value)}
              required
              disabled={!!user}
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Nombre Completo
            </label>
            <input
              type="text"
              className="input"
              value={formData.nombre}
              onChange={e => handleChange('nombre', e.target.value)}
              required
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Email
            </label>
            <input
              type="email"
              className="input"
              value={formData.email}
              onChange={e => handleChange('email', e.target.value)}
              required
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Tipo de Usuario
            </label>
            <select
              className="input"
              value={formData.tipo}
              onChange={e => handleChange('tipo', e.target.value)}
            >
              <option value="Alumno">Alumno</option>
              <option value="Maestro">Maestro</option>
              <option value="Admin">Admin</option>
            </select>
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Estado
            </label>
            <select
              className="input"
              value={formData.estado}
              onChange={e => handleChange('estado', e.target.value)}
            >
              <option value="Activo">Activo</option>
              <option value="Inactivo">Inactivo</option>
            </select>
          </div>

          {!user && (
            <div style={{ marginBottom: 16 }}>
              <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
                Contraseña
              </label>
              <input
                type="password"
                className="input"
                value={formData.password}
                onChange={e => handleChange('password', e.target.value)}
                required={!user}
              />
            </div>
          )}

          <div style={{ display: 'flex', gap: 12, marginTop: 24 }}>
            <button type="submit" className="btn" style={{ flex: 1 }}>
              {user ? 'Guardar Cambios' : 'Crear Usuario'}
            </button>
            {user && (
              <button
                type="button"
                onClick={handleDelete}
                style={{
                  flex: 1,
                  background: '#d32f2f',
                  color: '#fff',
                  border: 'none',
                  borderRadius: 28,
                  padding: '12px 22px',
                  fontWeight: 600,
                  cursor: 'pointer'
                }}
              >
                Eliminar
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              style={{
                flex: 1,
                background: '#e0e0e0',
                color: '#333',
                border: 'none',
                borderRadius: 28,
                padding: '12px 22px',
                fontWeight: 600,
                cursor: 'pointer'
              }}
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

  useEffect(() => {
    cargarClases()
  }, [])

  function cargarClases() {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/admin/clases`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => setClases(data))
      .catch(() => {})
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
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 20 }}>
        Gestión de Clases
      </h2>

      <div style={{ 
        display: 'flex', 
        gap: 16, 
        alignItems: 'center', 
        marginBottom: 20,
        flexWrap: 'wrap'
      }}>
        <div style={{ flex: 1, minWidth: 250, position: 'relative' }}>
          <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#999' }}>
            🔍
          </span>
          <input
            type="text"
            className="input"
            placeholder="Buscar por Profesor, ID....."
            value={busqueda}
            onChange={e => setBusqueda(e.target.value)}
            style={{ paddingLeft: 40 }}
          />
        </div>
        <div>
          <select
            className="input"
            value={materiaFiltro}
            onChange={e => setMateriaFiltro(e.target.value)}
            style={{ width: 200 }}
          >
            <option value="">Materia</option>
            {materiasUnicas.map(m => (
              <option key={m} value={m}>{m}</option>
            ))}
          </select>
        </div>
        <button 
          className="btn" 
          onClick={() => abrirModal()}
          style={{ whiteSpace: 'nowrap' }}
        >
          Añadir Clase
        </button>
      </div>

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
                    style={{
                      background: '#5566a0',
                      color: '#fff',
                      border: 'none',
                      borderRadius: 20,
                      padding: '6px 16px',
                      cursor: 'pointer',
                      fontSize: 13,
                      fontWeight: 600
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
    const token = localStorage.getItem('access_token') || ''
    
    const endpoint = clase 
      ? `${API}/admin/clases/${clase.id}` 
      : `${API}/admin/clases`
    
    const method = clase ? 'PUT' : 'POST'

    try {
      await fetch(endpoint, {
        method,
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`
        },
        body: JSON.stringify(formData)
      })
      onSave()
    } catch (err) {
      alert('Error al guardar clase')
    }
  }

  async function handleDelete() {
    if (!confirm('¿Estás seguro de eliminar esta clase?')) return
    
    const token = localStorage.getItem('access_token') || ''
    try {
      await fetch(`${API}/admin/clases/${clase.id}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${token}` }
      })
      onSave()
    } catch (err) {
      alert('Error al eliminar clase')
    }
  }

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      background: 'rgba(0,0,0,0.5)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      zIndex: 1000
    }}>
      <div style={{
        background: '#fff',
        borderRadius: 12,
        padding: 32,
        width: 'min(500px, 90vw)',
        maxHeight: '90vh',
        overflow: 'auto'
      }}>
        <h3 style={{ marginTop: 0, color: '#5566a0' }}>
          {clase ? 'Editar Clase' : 'Añadir Clase'}
        </h3>
        
        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              ID del Grupo
            </label>
            <input
              type="text"
              className="input"
              value={formData.id}
              onChange={e => handleChange('id', e.target.value)}
              required
              disabled={!!clase}
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Materia
            </label>
            <input
              type="text"
              className="input"
              value={formData.materia}
              onChange={e => handleChange('materia', e.target.value)}
              required
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Profesor Asignado
            </label>
            <input
              type="text"
              className="input"
              value={formData.profesor}
              onChange={e => handleChange('profesor', e.target.value)}
              required
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Créditos
            </label>
            <input
              type="number"
              step="0.1"
              className="input"
              value={formData.creditos}
              onChange={e => handleChange('creditos', e.target.value)}
              required
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Grupo
            </label>
            <input
              type="text"
              className="input"
              value={formData.grupo}
              onChange={e => handleChange('grupo', e.target.value)}
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Horario
            </label>
            <input
              type="text"
              className="input"
              placeholder="Ej: Lun-Mie 10:00-12:00"
              value={formData.horario}
              onChange={e => handleChange('horario', e.target.value)}
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={{ display: 'block', marginBottom: 4, fontWeight: 600, fontSize: 14 }}>
              Cupo Máximo
            </label>
            <input
              type="number"
              className="input"
              value={formData.cupo}
              onChange={e => handleChange('cupo', e.target.value)}
            />
          </div>

          <div style={{ display: 'flex', gap: 12, marginTop: 24 }}>
            <button type="submit" className="btn" style={{ flex: 1 }}>
              {clase ? 'Guardar Cambios' : 'Crear Clase'}
            </button>
            {clase && (
              <button
                type="button"
                onClick={handleDelete}
                style={{
                  flex: 1,
                  background: '#d32f2f',
                  color: '#fff',
                  border: 'none',
                  borderRadius: 28,
                  padding: '12px 22px',
                  fontWeight: 600,
                  cursor: 'pointer'
                }}
              >
                Eliminar
              </button>
            )}
            <button
              type="button"
              onClick={onClose}
              style={{
                flex: 1,
                background: '#e0e0e0',
                color: '#333',
                border: 'none',
                borderRadius: 28,
                padding: '12px 22px',
                fontWeight: 600,
                cursor: 'pointer'
              }}
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
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [horaInicio, setHoraInicio] = useState('')
  const [horaFin, setHoraFin] = useState('')
  const [mensaje, setMensaje] = useState('')

  useEffect(() => {
    cargarPeriodos()
  }, [])

  function cargarPeriodos() {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/admin/periodos`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        setPeriodos(data)
        if (data.length) setPeriodo(data[data.length - 1])
      })
      .catch(() => {})
  }

  useEffect(() => {
    if (!periodo) return
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/admin/reinscripcion/${periodo}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        setHoraInicio(data.hora_inicio || '')
        setHoraFin(data.hora_fin || '')
      })
      .catch(() => {})
  }, [periodo])

  async function guardarHorarios(e) {
    e.preventDefault()
    const token = localStorage.getItem('access_token') || ''
    
    try {
      const response = await fetch(`${API}/admin/reinscripcion`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`
        },
        body: JSON.stringify({
          periodo,
          hora_inicio: horaInicio,
          hora_fin: horaFin
        })
      })

      if (response.ok) {
        setMensaje('Horarios de reinscripción guardados exitosamente')
        setTimeout(() => setMensaje(''), 3000)
      } else {
        setMensaje('Error al guardar los horarios')
      }
    } catch (err) {
      setMensaje('Error de conexión')
    }
  }

  return (
    <div>
      <h2 style={{ 
        textAlign: 'center', 
        marginBottom: 40,
        color: '#4a5d85',
        fontSize: 32,
        fontWeight: 700
      }}>
        Gestión de Reinscripción
      </h2>

      <div style={{
        maxWidth: 580,
        margin: '0 auto'
      }}>
        <form onSubmit={guardarHorarios}>
          <div style={{ marginBottom: 28 }}>
            <label style={{ 
              display: 'block', 
              marginBottom: 10, 
              fontWeight: 600, 
              color: '#5566a0',
              fontSize: 15
            }}>
              Periodo Escolar
            </label>
            <select
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '1px solid #cdd3e1',
                borderRadius: 8,
                background: '#fff',
                fontSize: 14,
                color: '#333'
              }}
              value={periodo}
              onChange={e => setPeriodo(e.target.value)}
              required
            >
              <option value="">Selecciona un periodo</option>
              {periodos.map(p => (
                <option key={p} value={p}>{p}</option>
              ))}
            </select>
          </div>

          <div style={{ marginBottom: 28 }}>
            <label style={{ 
              display: 'block', 
              marginBottom: 10, 
              fontWeight: 600, 
              color: '#5566a0',
              fontSize: 15
            }}>
              Hora de Inicio de Reinscripción
            </label>
            <input
              type="datetime-local"
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '1px solid #cdd3e1',
                borderRadius: 8,
                background: '#fff',
                fontSize: 14,
                color: '#333'
              }}
              value={horaInicio}
              onChange={e => setHoraInicio(e.target.value)}
              required
            />
            <small style={{ color: '#7a8195', fontSize: 13, marginTop: 6, display: 'block' }}>
              Fecha y hora en que los alumnos podrán comenzar a reinscribirse
            </small>
          </div>

          <div style={{ marginBottom: 28 }}>
            <label style={{ 
              display: 'block', 
              marginBottom: 10, 
              fontWeight: 600, 
              color: '#5566a0',
              fontSize: 15
            }}>
              Hora de Fin de Reinscripción
            </label>
            <input
              type="datetime-local"
              style={{
                width: '100%',
                padding: '12px 16px',
                border: '1px solid #cdd3e1',
                borderRadius: 8,
                background: '#fff',
                fontSize: 14,
                color: '#333'
              }}
              value={horaFin}
              onChange={e => setHoraFin(e.target.value)}
              required
            />
            <small style={{ color: '#7a8195', fontSize: 13, marginTop: 6, display: 'block' }}>
              Fecha y hora en que finaliza el periodo de reinscripción
            </small>
          </div>

          {mensaje && (
            <div style={{
              padding: 14,
              borderRadius: 8,
              marginBottom: 20,
              background: mensaje.includes('Error') ? '#ffebee' : '#e8f5e9',
              color: mensaje.includes('Error') ? '#c62828' : '#2e7d32',
              fontSize: 13,
              fontWeight: 600,
              textAlign: 'center'
            }}>
              {mensaje}
            </div>
          )}

          <button 
            type="submit"
            style={{
              width: '100%',
              padding: '14px 24px',
              background: '#4a5d85',
              color: '#fff',
              border: 'none',
              borderRadius: 8,
              fontSize: 16,
              fontWeight: 600,
              cursor: 'pointer',
              marginBottom: 32
            }}
          >
            Guardar Horarios de Reinscripción
          </button>
        </form>

        <div style={{
          padding: 7,
          background: '#fff',
          borderRadius: 8,
          border: '1px solid #e0e6f6',
          marginBottom: 20
        }}>
          <h4 style={{ 
            margin: '0 0 7px', 
            color: '#4a5d85', 
            fontSize: 12,
            fontWeight: 600
          }}>
            Información Actual
          </h4>
          <div style={{ fontSize: 14, color: '#5a5a5a', lineHeight: 1.9 }}>
            <p style={{ margin: '0 0 10px' }}>
              <strong>Periodo:</strong> {periodo || 'No seleccionado'}
            </p>
            <p style={{ margin: '0 0 10px' }}>
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