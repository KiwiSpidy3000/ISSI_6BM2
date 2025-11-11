import { useEffect, useRef, useState } from 'react'
const API = import.meta.env?.VITE_API_URL || 'http://localhost:3000'

export default function Profesor(){
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)

  useEffect(() => {
    const token = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/profile`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => setProfile(data))
      .catch(() => {})
  }, [])

  function logout(){
    localStorage.removeItem('access_token')
    window.location.href = '/'
  }

  return (
    <div className="dashboard">
      <aside className="sb">
        <div className="sb-header">
          <div className="avatar">👤</div>
          <div className="sb-title">Profesor</div>
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
          {view === 'grupos' && <Grupos />}
          {view === 'horario' && <Horario />}
          {view === 'calificaciones' && <Calificaciones />}
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
          <strong style={{ color: '#5566a0' }}>RFC:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.rfc || '—'}</p>
        </div>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>Nombre:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.nombre_completo || '—'}</p>
        </div>
        <div style={{ marginBottom: 16 }}>
          <strong style={{ color: '#5566a0' }}>Plantel:</strong>
          <p style={{ margin: '4px 0 0', fontSize: 15 }}>{profile.plantel || 'ESCOM'}</p>
        </div>
      </div>
    </div>
  )
}

function ChatBot() {
  const [messages, setMessages] = useState([{ from: 'bot', text: '¡Hola Profesor! ¿En qué te puedo ayudar?' }])
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

function Grupos() {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [grupos, setGrupos] = useState([])
  const [err, setErr] = useState('')

  useEffect(() => {
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(list => {
        setPeriodos(list)
        if (list?.length) setPeriodo(list[list.length - 1])
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/grupos?periodo=${encodeURIComponent(periodo)}`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json().then(d => ({ ok: r.ok, data: d })))
      .then(({ ok, data }) => ok ? setGrupos(data) : setErr(data?.error || 'Error'))
      .catch(() => setErr('Error de red'))
  }, [periodo])

  if (err) return <p className="err">{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 20 }}>
        Grupos
      </h2>

      <div style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20 }}>
        <div>
          <b>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

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
                <td>{r.inscritos || 0}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Horario() {
  const [profile, setProfile] = useState(null)
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [rows, setRows] = useState([])
  const [err, setErr] = useState('')

  useEffect(() => {
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/profile`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json().then(d => ({ ok: r.ok, data: d })))
      .then(({ ok, data }) => ok ? setProfile(data) : setErr(data?.error || 'Error'))

    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(list => {
        setPeriodos(list)
        if (list?.length) setPeriodo(list[list.length - 1])
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/horario?periodo=${encodeURIComponent(periodo)}`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json().then(d => ({ ok: r.ok, data: d })))
      .then(({ ok, data }) => ok ? setRows(data) : setErr(data?.error || 'Error'))
      .catch(() => setErr('Error de red'))
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

  if (err) return <p className="err">{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 20 }}>
        Horario
      </h2>

      <div style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20 }}>
        <div><b>RFC:</b> {profile?.rfc || '—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo || '—'}</div>
        <div><b>Plantel:</b> ESCOM</div>
        <div>
          <b>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

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
                {[1, 2, 3, 4, 5].map(d => <td key={d}>{r.slots[d] || ''}</td>)}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Calificaciones() {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [grupos, setGrupos] = useState([])
  const [grupoSel, setGrupoSel] = useState('')
  const [alumnos, setAlumnos] = useState([])
  const [err, setErr] = useState('')
  const [editMode, setEditMode] = useState({})

  useEffect(() => {
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(list => {
        setPeriodos(list)
        if (list?.length) setPeriodo(list[list.length - 1])
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/grupos?periodo=${encodeURIComponent(periodo)}`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json())
      .then(data => {
        setGrupos(data)
        if (data?.length) setGrupoSel(data[0].id_grupo)
      })
  }, [periodo])

  useEffect(() => {
    if (!grupoSel) return
    const t = localStorage.getItem?.('access_token') || ''
    fetch(`${API}/profesor/calificaciones?id_grupo=${grupoSel}`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json().then(d => ({ ok: r.ok, data: d })))
      .then(({ ok, data }) => ok ? setAlumnos(data) : setErr(data?.error || 'Error'))
      .catch(() => setErr('Error de red'))
  }, [grupoSel])

  function handleEdit(boleta, field, value) {
    setEditMode(prev => ({ ...prev, [`${boleta}-${field}`]: value }))
  }

  async function saveCalif(boleta, field) {
    const key = `${boleta}-${field}`
    const valor = editMode[key]
    if (valor === undefined) return

    const t = localStorage.getItem?.('access_token') || ''
    await fetch(`${API}/profesor/calificaciones`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({
        id_grupo: grupoSel,
        boleta,
        [field]: parseFloat(valor) || 0
      })
    })

    setAlumnos(prev => prev.map(a =>
      a.boleta === boleta ? { ...a, [field]: parseFloat(valor) || 0 } : a
    ))

    const newMode = { ...editMode }
    delete newMode[key]
    setEditMode(newMode)
  }

  if (err) return <p className="err">{err}</p>

  return (
    <div>
      <h2 className="h2" style={{ textAlign: 'center', marginBottom: 20 }}>
        Calificaciones
      </h2>

      <div style={{ display: 'flex', gap: 16, alignItems: 'center', marginBottom: 20 }}>
        <div>
          <b>Periodo:</b>{' '}
          <select className="input" value={periodo} onChange={e => setPeriodo(e.target.value)}>
            <option value="">Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b>Grupo:</b>{' '}
          <select className="input" value={grupoSel} onChange={e => setGrupoSel(e.target.value)}>
            <option value="">Selecciona</option>
            {grupos.map(g => (
              <option key={g.id_grupo} value={g.id_grupo}>
                {g.id_grupo} - {g.materia_nombre}
              </option>
            ))}
          </select>
        </div>
      </div>

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
                  <td>
                    {editMode[key1] !== undefined ? (
                      <input
                        type="number"
                        className="input"
                        value={editMode[key1]}
                        onChange={e => handleEdit(a.boleta, 'p1', e.target.value)}
                        onBlur={() => saveCalif(a.boleta, 'p1')}
                        style={{ width: 80 }}
                        autoFocus
                      />
                    ) : (
                      <span onDoubleClick={() => handleEdit(a.boleta, 'p1', a.p1 || '')} style={{ cursor: 'pointer', display: 'block', padding: 8 }}>
                        {a.p1 ?? '—'}
                      </span>
                    )}
                  </td>
                  <td>
                    {editMode[key2] !== undefined ? (
                      <input
                        type="number"
                        className="input"
                        value={editMode[key2]}
                        onChange={e => handleEdit(a.boleta, 'p2', e.target.value)}
                        onBlur={() => saveCalif(a.boleta, 'p2')}
                        style={{ width: 80 }}
                        autoFocus
                      />
                    ) : (
                      <span onDoubleClick={() => handleEdit(a.boleta, 'p2', a.p2 || '')} style={{ cursor: 'pointer', display: 'block', padding: 8 }}>
                        {a.p2 ?? '—'}
                      </span>
                    )}
                  </td>
                  <td>
                    {editMode[key3] !== undefined ? (
                      <input
                        type="number"
                        className="input"
                        value={editMode[key3]}
                        onChange={e => handleEdit(a.boleta, 'ordinario', e.target.value)}
                        onBlur={() => saveCalif(a.boleta, 'ordinario')}
                        style={{ width: 80 }}
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
      <p style={{ marginTop: 12, fontSize: 14, color: '#666', textAlign: 'center' }}>
        Doble clic en una celda para editar. La calificación se guarda al salir del campo.
      </p>
    </div>
  )
}