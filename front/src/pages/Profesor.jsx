import { useEffect, useRef, useState } from 'react'

const API = import.meta.env?.VITE_API_URL || 'http://localhost:3000'

export default function Profesor(){
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const style = document.createElement('style')
    style.textContent = `
      @keyframes float1 {
        0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); }
        25% { transform: translate3d(80px, -140vh, 250px) rotate(120deg) scale(1.3); }
        50% { transform: translate3d(-60px, -160vh, 400px) rotate(240deg) scale(0.9); }
        75% { transform: translate3d(100px, -180vh, 300px) rotate(360deg) scale(1.1); }
      }
      @keyframes float2 {
        0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); }
        25% { transform: translate3d(-90px, -130vh, 280px) rotate(-120deg) scale(1.2); }
        50% { transform: translate3d(70px, -155vh, 350px) rotate(-240deg) scale(1.4); }
        75% { transform: translate3d(-80px, -175vh, 320px) rotate(-360deg) scale(0.95); }
      }
      @keyframes float3 {
        0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); }
        25% { transform: translate3d(85px, -145vh, 260px) rotate(110deg) scale(1.15); }
        50% { transform: translate3d(-75px, -165vh, 380px) rotate(220deg) scale(1.35); }
        75% { transform: translate3d(65px, -185vh, 290px) rotate(330deg) scale(1.05); }
      }
      @keyframes float4 {
        0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); }
        25% { transform: translate3d(-95px, -135vh, 310px) rotate(-110deg) scale(1.25); }
        50% { transform: translate3d(90px, -150vh, 370px) rotate(-220deg) scale(0.85); }
        75% { transform: translate3d(-70px, -170vh, 340px) rotate(-330deg) scale(1.4); }
      }
      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
      }
      @keyframes bounce {
        0%, 80%, 100% { transform: translateY(0); }
        40% { transform: translateY(-6px); }
      }
      .pill-hover:hover {
        transform: translateX(8px);
        background: rgba(106, 122, 174, 0.3);
        box-shadow: 0 4px 20px rgba(106, 122, 174, 0.4);
      }
      .danger-hover:hover {
        background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%);
        box-shadow: 0 8px 24px rgba(220, 38, 38, 0.5);
      }
    `
    document.head.appendChild(style)
    return () => document.head.removeChild(style)
  }, [])

  useEffect(() => {
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
      <div style={styles.loadingOverlay}>
        <div style={styles.spinner}></div>
      </div>
    )
  }

  return (
    <div style={styles.container}>
      <div style={styles.floatingShapes}>
        {[...Array(15)].map((_, i) => (
          <svg key={i} style={{...styles.floatingSvg, ...styles[`svg${i % 10}`]}} xmlns="http://www.w3.org/2000/svg">
            <path d="m2.46177,126.39581c10.12618,-0.06577 20.25237,-0.13151 30.37857,-0.19726c0.06666,-10.3997 0.13333,-20.7994 0.19999,-31.19908c10.07782,0 20.15564,0 30.23346,0c0,-10.46351 0,-20.927 0,-31.39051c10.33589,0 20.67178,0 31.00767,0c0,-10.20827 0,-20.41656 0,-30.62485c10.20829,0 20.41656,0 30.62485,0c0,-10.20829 0,-20.41658 0,-30.62487c15.18483,0 30.36965,0 45.55448,0c0,5.10414 0,10.20829 0,15.31243c-10.08071,0 -20.16136,0 -30.24206,0c0,10.33589 0,20.67178 0,31.00769c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33589 0,20.67178 0,31.00767c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33591 0,20.6718 0,31.00767c-10.33589,0 -20.67178,0 -31.00767,0c0,10.46351 0,20.927 0,31.39049c-15.31243,0 -30.62485,0 -45.93728,0c0.68263,-5.07223 -1.16374,-10.79174 0.43769,-15.68938l0,0z" strokeWidth="7" fill="none"/>
          </svg>
        ))}
      </div>

      <aside style={styles.sidebar}>
        <div style={styles.sidebarHeader}>
          <div style={styles.avatarGlow} />
          <div style={styles.avatar}>👤</div>
          <div style={styles.sidebarTitle}>Panel Profesor</div>
        </div>
        
        <nav style={styles.sidebarNav}>
          <button style={{...styles.pill, ...(view==='perfil' ? styles.pillActive : {})}} className="pill-hover" onClick={()=>setView('perfil')}>
            Datos Personales
          </button>
          <button style={{...styles.pill, ...(view==='grupos' ? styles.pillActive : {})}} className="pill-hover" onClick={()=>setView('grupos')}>
            Grupos
          </button>
          <button style={{...styles.pill, ...(view==='horario' ? styles.pillActive : {})}} className="pill-hover" onClick={()=>setView('horario')}>
            Horario
          </button>
          <button style={{...styles.pill, ...(view==='calificaciones' ? styles.pillActive : {})}} className="pill-hover" onClick={()=>setView('calificaciones')}>
            Calificaciones
          </button>
        </nav>
        
        <div style={styles.sidebarBottom}>
          <button style={{...styles.pill, ...(view==='chat' ? styles.pillActive : {})}} className="pill-hover" onClick={()=>setView('chat')}>
            💬 Chat Bot
          </button>
          <button style={styles.pillDanger} className="danger-hover" onClick={logout}>
            🚪 Cerrar sesión
          </button>
        </div>
      </aside>

      <main style={styles.main}>
        {view === 'perfil' && <DatosPersonales profile={profile} />}
        {view === 'grupos' && <Grupos />}
        {view === 'horario' && <Horario />}
        {view === 'calificaciones' && <Calificaciones />}
        {view === 'chat' && <ChatBot />}
      </main>
    </div>
  )
}

function DatosPersonales({ profile }) {
  if (!profile) return <p style={styles.loading}>Cargando...</p>

  return (
    <div style={styles.card}>
      <h2 style={styles.h2}>Datos Personales</h2>
      <div style={styles.dataGrid}>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>RFC:</span>
          <span style={styles.dataValue}>{profile.rfc || '—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Nombre:</span>
          <span style={styles.dataValue}>{profile.nombre_completo || '—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Plantel:</span>
          <span style={styles.dataValue}>{profile.plantel || 'ESCOM'}</span>
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
    setIsTyping(true)
    
    try {
      await new Promise(resolve => setTimeout(resolve, 1500))

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
      setIsTyping(false)
      setSending(false) 
    }
  }

  function onKey(e) { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage() } }

  return (
    <>
      <h2 style={styles.h2}>Chat Bot</h2>
      <section style={styles.chatSection}>
        <div style={styles.chatScroll} ref={scrollRef} onScroll={handleScroll}>
          {messages.map((m, i) => (
            <div key={i} style={m.from === 'user' ? styles.msgUser : styles.msgBot}>{m.text}</div>
          ))}
          {isTyping && (
            <div style={styles.typingIndicator}>
              <div style={{...styles.dot, animationDelay: '0s'}}></div>
              <div style={{...styles.dot, animationDelay: '0.2s'}}></div>
              <div style={{...styles.dot, animationDelay: '0.4s'}}></div>
            </div>
          )}
        </div>
        <div style={styles.chatInput}>
          <textarea 
            value={text} 
            onChange={e => setText(e.target.value)} 
            onKeyDown={onKey}
            placeholder="Escribe tu mensaje…" 
            disabled={sending || isTyping}
            style={styles.textarea}
          />
          <button style={styles.sendBtn} onClick={sendMessage} disabled={sending || isTyping}>▶</button>
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
  const [dataLoading, setDataLoading] = useState(false)

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
    setTimeout(() => {
      setGrupos([
        { id_grupo: '3CM1', materia_nombre: 'Programación Avanzada', materia_clave: 'PRG101', semestre: 3, turno: 'Matutino', inscritos: 35 },
        { id_grupo: '4CM3', materia_nombre: 'Bases de Datos', materia_clave: 'BDD201', semestre: 4, turno: 'Vespertino', inscritos: 28 },
      ])
      setDataLoading(false)
    }, 500)
  }, [periodo])

  return (
    <div>
      <h2 style={styles.h2}>Grupos Asignados</h2>

      <div style={styles.infoBar}>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e => setPeriodo(e.target.value)} style={styles.select}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>
      
      {dataLoading ? (
        <div style={styles.loadingContainer}>
          <div style={styles.spinner}></div>
        </div>
      ) : (
        <div style={styles.tableWrap}>
          <table style={styles.table}>
            <thead>
              <tr style={styles.tableHeaderRow}>
                <th style={styles.th}>Grupo</th>
                <th style={styles.th}>Materia</th>
                <th style={styles.th}>Clave</th>
                <th style={styles.th}>Semestre</th>
                <th style={styles.th}>Turno</th>
                <th style={styles.th}>Inscritos</th>
              </tr>
            </thead>
            <tbody>
              {grupos.map((r, i) => (
                <tr key={i} style={styles.tableRow}>
                  <td style={styles.td}>{r.id_grupo}</td>
                  <td style={styles.td}>{r.materia_nombre}</td>
                  <td style={styles.td}>{r.materia_clave}</td>
                  <td style={styles.td}>{r.semestre || '—'}</td>
                  <td style={styles.td}>{r.turno || '—'}</td>
                  <td style={styles.td}>
                    <span style={styles.badge}>{r.inscritos || 0}</span>
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
  const [dataLoading, setDataLoading] = useState(false)

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
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

  return (
    <div>
      <h2 style={styles.h2}>Horario Semanal</h2>

      <div style={styles.infoBar}>
        <div><b>RFC:</b> {profile?.rfc || '—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo || '—'}</div>
        <div><b>Plantel:</b> ESCOM</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e => setPeriodo(e.target.value)} style={styles.select}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      {dataLoading ? (
        <div style={styles.loadingContainer}>
          <div style={styles.spinner}></div>
        </div>
      ) : (
        <div style={styles.tableWrap}>
          <table style={styles.table}>
            <thead>
              <tr style={styles.tableHeaderRow}>
                <th style={styles.th}>Materia</th>
                {dias.map(d => <th key={d} style={styles.th}>{d}</th>)}
              </tr>
            </thead>
            <tbody>
              {tabla.map((r, i) => (
                <tr key={i} style={styles.tableRow}>
                  <td style={styles.td}>{r.materia}</td>
                  {[1, 2, 3, 4, 5].map(d => (
                    <td key={d} style={styles.td}>
                      <span style={r.slots[d] ? styles.horarioSlot : {color: '#6a7aae'}}>
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
  const [editMode, setEditMode] = useState({})
  const [dataLoading, setDataLoading] = useState(false)

  useEffect(() => {
    if (!grupoSel) return
    setDataLoading(true)
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

    console.log(`Guardando ${field} para ${boleta}: ${valor}`)

    setAlumnos(prev => prev.map(a =>
      a.boleta === boleta ? { ...a, [field]: parseFloat(valor) || 0 } : a
    ))

    const newMode = { ...editMode }
    delete newMode[key]
    setEditMode(newMode)
  }

  return (
    <div>
      <h2 style={styles.h2}>Captura de Calificaciones</h2>

      <div style={styles.infoBar}>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e => setPeriodo(e.target.value)} style={styles.select}>
            <option value="">Selecciona</option>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b>Grupo:</b>{' '}
          <select value={grupoSel} onChange={e => setGrupoSel(e.target.value)} style={styles.select}>
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
        <div style={styles.loadingContainer}>
          <div style={styles.spinner}></div>
        </div>
      ) : (
        <div style={styles.tableWrap}>
          <table style={styles.table}>
            <thead>
              <tr style={styles.tableHeaderRow}>
                <th style={styles.th}>Boleta</th>
                <th style={styles.th}>Nombre</th>
                <th style={styles.th}>1er Parcial</th>
                <th style={styles.th}>2do Parcial</th>
                <th style={styles.th}>Ordinario</th>
              </tr>
            </thead>
            <tbody>
              {alumnos.map((a, i) => {
                const key1 = `${a.boleta}-p1`
                const key2 = `${a.boleta}-p2`
                const key3 = `${a.boleta}-ordinario`

                return (
                  <tr key={i} style={styles.tableRow}>
                    <td style={styles.td}>{a.boleta}</td>
                    <td style={styles.td}>{a.nombre_completo}</td>
                    <td style={styles.td}>
                      {editMode[key1] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          style={styles.inputCalif}
                          value={editMode[key1]}
                          onChange={e => handleEdit(a.boleta, 'p1', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'p1')}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'p1', a.p1 || '')} style={styles.editableCell}>
                          {a.p1 ?? '—'}
                        </span>
                      )}
                    </td>
                    <td style={styles.td}>
                      {editMode[key2] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          style={styles.inputCalif}
                          value={editMode[key2]}
                          onChange={e => handleEdit(a.boleta, 'p2', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'p2')}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'p2', a.p2 || '')} style={styles.editableCell}>
                          {a.p2 ?? '—'}
                        </span>
                      )}
                    </td>
                    <td style={styles.td}>
                      {editMode[key3] !== undefined ? (
                        <input
                          type="number"
                          step="0.1"
                          min="0"
                          max="10"
                          style={styles.inputCalif}
                          value={editMode[key3]}
                          onChange={e => handleEdit(a.boleta, 'ordinario', e.target.value)}
                          onBlur={() => saveCalif(a.boleta, 'ordinario')}
                          autoFocus
                        />
                      ) : (
                        <span onDoubleClick={() => handleEdit(a.boleta, 'ordinario', a.ordinario || '')} style={styles.editableCell}>
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
      <p style={styles.helpText}>
        Doble clic en una celda para editar. La calificación se guarda al salir del campo.
      </p>
    </div>
  )
}

const styles = {
  loadingOverlay: {
    position: 'fixed',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    background: 'linear-gradient(135deg, #0f1620 0%, #1a2847 40%, #2d3a6a 100%)',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 10000,
  },
  spinner: {
    border: '4px solid rgba(106, 122, 174, 0.2)',
    borderTop: '4px solid #6a7aae',
    borderRadius: '50%',
    width: '50px',
    height: '50px',
    animation: 'spin 1s linear infinite',
  },
  container: {
    display: 'flex',
    minHeight: '100vh',
    background: 'linear-gradient(135deg, #0f1620 0%, #1a2847 40%, #2d3a6a 100%)',
    color: '#ffffff',
    fontFamily: '"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
    position: 'relative',
    overflow: 'hidden',
  },
  floatingShapes: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    pointerEvents: 'none',
    zIndex: 1,
  },
  floatingSvg: {
    position: 'absolute',
    stroke: '#4a5a8e',
    transformStyle: 'preserve-3d',
  },
  svg0: {
    width: '180px',
    height: '180px',
    left: '5%',
    bottom: '-25%',
    animation: 'float1 20s infinite ease-in-out',
    opacity: 0.3,
  },
  svg1: {
    width: '140px',
    height: '140px',
    left: '20%',
    bottom: '-20%',
    animation: 'float2 22s infinite ease-in-out',
    opacity: 0.4,
  },
  svg2: {
    width: '160px',
    height: '160px',
    left: '40%',
    bottom: '-22%',
    animation: 'float3 24s infinite ease-in-out',
    opacity: 0.25,
  },
  svg3: {
    width: '120px',
    height: '120px',
    left: '60%',
    bottom: '-18%',
    animation: 'float4 18s infinite ease-in-out',
    opacity: 0.5,
  },
  svg4: {
    width: '150px',
    height: '150px',
    left: '75%',
    bottom: '-21%',
    animation: 'float1 21s infinite ease-in-out',
    opacity: 0.35,
  },
  svg5: {
    width: '130px',
    height: '130px',
    left: '85%',
    bottom: '-19%',
    animation: 'float2 23s infinite ease-in-out',
    opacity: 0.45,
  },
  sidebar: {
    width: '280px',
    background: 'linear-gradient(180deg, rgba(30, 43, 79, 0.95) 0%, rgba(42, 54, 88, 0.95) 100%)',
    backdropFilter: 'blur(20px)',
    borderRight: '1px solid rgba(106, 122, 174, 0.2)',
    display: 'flex',
    flexDirection: 'column',
    padding: '32px 20px',
    position: 'relative',
    zIndex: 10,
    boxShadow: '4px 0 24px rgba(0, 0, 0, 0.3)',
  },
  sidebarHeader: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    marginBottom: '40px',
    position: 'relative',
  },
  avatarGlow: {
    position: 'absolute',
    top: '-15px',
    left: '50%',
    transform: 'translateX(-50%)',
    width: '100px',
    height: '100px',
    background: 'radial-gradient(circle, rgba(106, 122, 174, 0.4) 0%, transparent 70%)',
    filter: 'blur(25px)',
    zIndex: -1,
  },
  avatar: {
    width: '80px',
    height: '80px',
    borderRadius: '50%',
    background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontSize: '40px',
    marginBottom: '16px',
    border: '3px solid rgba(106, 122, 174, 0.3)',
    boxShadow: '0 8px 32px rgba(106, 122, 174, 0.4)',
  },
  sidebarTitle: {
    fontSize: '20px',
    fontWeight: '700',
    color: '#ffffff',
    letterSpacing: '1px',
  },
  sidebarNav: {
    display: 'flex',
    flexDirection: 'column',
    gap: '12px',
    flex: 1,
  },
  pill: {
    background: 'rgba(58, 74, 122, 0.4)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    color: '#d1d5e8',
    padding: '14px 20px',
    borderRadius: '12px',
    cursor: 'pointer',
    transition: 'all 0.3s ease',
    fontSize: '14px',
    fontWeight: '500',
    textAlign: 'left',
    outline: 'none',
  },
  pillActive: {
    background: 'linear-gradient(135deg, rgba(106, 122, 174, 0.4) 0%, rgba(90, 106, 158, 0.4) 100%)',
    border: '1px solid rgba(106, 122, 174, 0.5)',
    boxShadow: '0 4px 20px rgba(106, 122, 174, 0.3)',
  },
  sidebarBottom: {
    display: 'flex',
    flexDirection: 'column',
    gap: '12px',
    marginTop: '20px',
    paddingTop: '20px',
    borderTop: '1px solid rgba(106, 122, 174, 0.2)',
  },
  pillDanger: {
    background: 'linear-gradient(135deg, rgba(185, 28, 28, 0.3) 0%, rgba(220, 38, 38, 0.3) 100%)',
    border: '1px solid rgba(220, 38, 38, 0.4)',
    color: '#ffb3b3',
    padding: '14px 20px',
    borderRadius: '12px',
    cursor: 'pointer',
    transition: 'all 0.3s ease',
    fontSize: '14px',
    fontWeight: '600',
    textAlign: 'left',
    outline: 'none',
  },
  main: {
    flex: 1,
    padding: '40px',
    overflowY: 'auto',
    position: 'relative',
    zIndex: 10,
  },
  h2: {
    fontSize: '32px',
    fontWeight: '700',
    marginBottom: '28px',
    background: 'linear-gradient(135deg, #ffffff 0%, #6a7aae 100%)',
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
    backgroundClip: 'text',
    letterSpacing: '-1px',
    textAlign: 'center',
  },
  card: {
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(20px)',
    borderRadius: '20px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    padding: '32px',
    boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)',
    maxWidth: '600px',
    margin: '0 auto',
  },
  dataGrid: {
    display: 'grid',
    gridTemplateColumns: '1fr',
    gap: '20px',
  },
  dataItem: {
    background: 'rgba(58, 74, 122, 0.3)',
    padding: '16px 20px',
    borderRadius: '12px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
  },
  dataLabel: {
    color: '#6a7aae',
    fontSize: '13px',
    fontWeight: '600',
    display: 'block',
    marginBottom: '6px',
    letterSpacing: '0.5px',
  },
  dataValue: {
    color: '#ffffff',
    fontSize: '16px',
    fontWeight: '500',
  },
  chatSection: {
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(20px)',
    borderRadius: '20px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    padding: '24px',
    display: 'flex',
    flexDirection: 'column',
    height: 'calc(100vh - 200px)',
    boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)',
    maxWidth: '900px',
    margin: '0 auto',
  },
  chatScroll: {
    flex: 1,
    overflowY: 'auto',
    marginBottom: '20px',
    display: 'flex',
    flexDirection: 'column',
    gap: '12px',
    paddingRight: '8px',
  },
  msgBot: {
    background: 'linear-gradient(135deg, rgba(106, 122, 174, 0.3) 0%, rgba(90, 106, 158, 0.3) 100%)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    padding: '14px 18px',
    borderRadius: '16px 16px 16px 4px',
    maxWidth: '75%',
    alignSelf: 'flex-start',
    color: '#ffffff',
    fontSize: '15px',
    lineHeight: '1.5',
    boxShadow: '0 4px 12px rgba(0, 0, 0, 0.2)',
  },
  msgUser: {
    background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)',
    padding: '14px 18px',
    borderRadius: '16px 16px 4px 16px',
    maxWidth: '75%',
    alignSelf: 'flex-end',
    color: '#ffffff',
    fontSize: '15px',
    lineHeight: '1.5',
    boxShadow: '0 4px 12px rgba(106, 122, 174, 0.4)',
  },
  typingIndicator: {
    alignSelf: 'flex-start',
    display: 'flex',
    gap: '4px',
    background: 'rgba(106, 122, 174, 0.3)',
    padding: '10px 16px',
    borderRadius: '16px 16px 16px 4px',
  },
  dot: {
    width: '8px',
    height: '8px',
    background: '#6a7aae',
    borderRadius: '50%',
    animation: 'bounce 1.4s infinite ease-in-out',
  },
  chatInput: {
    display: 'flex',
    gap: '12px',
    alignItems: 'flex-end',
  },
  textarea: {
    flex: 1,
    background: 'rgba(58, 74, 122, 0.4)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    borderRadius: '12px',
    padding: '14px 16px',
    color: '#ffffff',
    fontSize: '15px',
    resize: 'none',
    minHeight: '50px',
    maxHeight: '120px',
    outline: 'none',
    fontFamily: 'inherit',
  },
  sendBtn: {
    background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)',
    border: 'none',
    color: '#ffffff',
    width: '50px',
    height: '50px',
    borderRadius: '12px',
    cursor: 'pointer',
    fontSize: '20px',
    transition: 'all 0.3s ease',
    boxShadow: '0 4px 16px rgba(106, 122, 174, 0.4)',
  },
  infoBar: {
    display: 'flex',
    gap: '24px',
    alignItems: 'center',
    marginBottom: '24px',
    flexWrap: 'wrap',
    padding: '20px',
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(20px)',
    borderRadius: '16px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
  },
  select: {
    background: 'rgba(58, 74, 122, 0.6)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    borderRadius: '8px',
    padding: '8px 12px',
    color: '#ffffff',
    fontSize: '14px',
    outline: 'none',
    cursor: 'pointer',
  },
  tableWrap: {
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(20px)',
    borderRadius: '16px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    overflow: 'hidden',
    boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)',
  },
  table: {
    width: '100%',
    borderCollapse: 'collapse',
  },
  tableHeaderRow: {
    background: 'rgba(58, 74, 122, 0.5)',
  },
  th: {
    padding: '16px 20px',
    textAlign: 'left',
    color: '#6a7aae',
    fontWeight: '700',
    fontSize: '13px',
    letterSpacing: '1px',
    textTransform: 'uppercase',
    borderBottom: '2px solid rgba(106, 122, 174, 0.3)',
  },
  tableRow: {
    borderBottom: '1px solid rgba(106, 122, 174, 0.1)',
    transition: 'background 0.2s ease',
  },
  td: {
    padding: '16px 20px',
    color: '#d1d5e8',
    fontSize: '14px',
  },
  badge: {
    padding: '6px 12px',
    borderRadius: '12px',
    fontSize: '13px',
    fontWeight: '600',
    background: 'rgba(34, 197, 94, 0.2)',
    color: '#4ade80',
    display: 'inline-block',
  },
  horarioSlot: {
    display: 'inline-block',
    padding: '6px 12px',
    borderRadius: '8px',
    background: 'rgba(106, 122, 174, 0.3)',
    color: '#ffffff',
    fontWeight: '600',
    fontSize: '13px',
  },
  loadingContainer: {
    display: 'flex',
    justifyContent: 'center',
    padding: '60px',
  },
  loading: {
    color: '#6a7aae',
    fontSize: '16px',
    textAlign: 'center',
    padding: '40px',
  },
  editableCell: {
    cursor: 'pointer',
    display: 'block',
    padding: '8px',
    borderRadius: '6px',
    transition: 'background 0.2s',
  },
  inputCalif: {
    background: 'rgba(58, 74, 122, 0.6)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    borderRadius: '8px',
    padding: '8px 12px',
    color: '#ffffff',
    fontSize: '14px',
    outline: 'none',
    width: '80px',
  },
  helpText: {
    marginTop: '16px',
    fontSize: '13px',
    color: '#6a7aae',
    textAlign: 'center',
    fontStyle: 'italic',
  },
}