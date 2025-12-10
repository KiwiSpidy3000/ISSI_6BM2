import { useEffect, useRef, useState } from 'react'
import { PieChart, Pie, Cell, Tooltip, Legend, BarChart, Bar, XAxis, YAxis, CartesianGrid, ResponsiveContainer } from 'recharts'
import ChatComponent from '../components/ChatComponent'

const API = import.meta.env?.VITE_API_URL || 'http://localhost:3000'

export default function Profesor() {
  const [view, setView] = useState('perfil')
  const [profile, setProfile] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [navContext, setNavContext] = useState(null)

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
      .card-hover {
        transition: all 0.3s ease;
        cursor: pointer;
      }
      .card-hover:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
        border-color: rgba(106, 122, 174, 0.5);
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
        .then(data => {
          if (data.error) console.error(data.error);
          else setProfile(data);
        })
        .catch(() => { })
        .finally(() => setIsLoading(false))
    }, 500)
  }, [])

  function logout() {
    localStorage.removeItem('access_token')
    window.location.href = '/'
  }

  function handleGroupSelect(groupData) {
    setNavContext(groupData)
    setView('calificaciones')
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
          <svg key={i} style={{ ...styles.floatingSvg, ...styles[`svg${i % 10}`] }} xmlns="http://www.w3.org/2000/svg">
            <path d="m2.46177,126.39581c10.12618,-0.06577 20.25237,-0.13151 30.37857,-0.19726c0.06666,-10.3997 0.13333,-20.7994 0.19999,-31.19908c10.07782,0 20.15564,0 30.23346,0c0,-10.46351 0,-20.927 0,-31.39051c10.33589,0 20.67178,0 31.00767,0c0,-10.20827 0,-20.41656 0,-30.62485c10.20829,0 20.41656,0 30.62485,0c0,-10.20829 0,-20.41658 0,-30.62487c15.18483,0 30.36965,0 45.55448,0c0,5.10414 0,10.20829 0,15.31243c-10.08071,0 -20.16136,0 -30.24206,0c0,10.33589 0,20.67178 0,31.00769c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33589 0,20.67178 0,31.00767c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33591 0,20.6718 0,31.00767c-10.33589,0 -20.67178,0 -31.00767,0c0,10.46351 0,20.927 0,31.39049c-15.31243,0 -30.62485,0 -45.93728,0c0.68263,-5.07223 -1.16374,-10.79174 0.43769,-15.68938l0,0z" strokeWidth="7" fill="none" />
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
          <button style={{ ...styles.pill, ...(view === 'perfil' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('perfil')}>
            Datos Personales
          </button>
          <button style={{ ...styles.pill, ...(view === 'grupos' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('grupos')}>
            Grupos
          </button>
          <button style={{ ...styles.pill, ...(view === 'horario' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('horario')}>
            Horario
          </button>
          <button style={{ ...styles.pill, ...(view === 'reportes' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('reportes')}>
            Reportes
          </button>
          <button style={{ ...styles.pill, ...(view === 'calificaciones' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('calificaciones')}>
            Calificaciones
          </button>
        </nav>

        <div style={styles.sidebarBottom}>
          <button style={{ ...styles.pill, ...(view === 'chat' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('chat')}>
            💬 Chat Bot
          </button>
          <button style={styles.pillDanger} className="danger-hover" onClick={logout}>
            🚪 Cerrar sesión
          </button>
        </div>
      </aside>

      <main style={styles.main}>
        {view === 'perfil' && <DatosPersonales profile={profile} />}
        {view === 'grupos' && <Grupos onGroupClick={handleGroupSelect} />}
        {view === 'horario' && <Horario profile={profile} initialPeriod={navContext?.periodo} />}
        {view === 'calificaciones' && <Calificaciones context={navContext} />}
        {view === 'reportes' && <Reportes />}
        {view === 'chat' && (
          <ChatComponent
            userIdentifier={profile?.num_empleado || profile?.rfc}
            userName={profile?.nombre_completo?.split(' ')[0]}
            userRole="Profesor"
          />
        )}
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
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Departamento:</span>
          <span style={styles.dataValue}>{profile.departamento || '—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>No. Empleado:</span>
          <span style={styles.dataValue}>{profile.num_empleado || '—'}</span>
        </div>
      </div>
    </div>
  )
}




function Grupos({ onGroupClick }) {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [grupos, setGrupos] = useState([])
  const [dataLoading, setDataLoading] = useState(false)

  // Fetch periods
  useEffect(() => {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${token}` } })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data) && data.length > 0) {
          setPeriodos(data)
          setPeriodo(data[0]) // Default to latest
        } else {
          // Fallback if no periods found
          setPeriodos(['2025-2'])
          setPeriodo('2025-2')
        }
      })
      .catch(err => {
        console.error('Error fetching periods:', err)
        setPeriodos(['2025-2'])
        setPeriodo('2025-2')
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/grupos?periodo=${periodo}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data)) setGrupos(data)
        else setGrupos([])
      })
      .catch(err => {
        console.error('Error fetch grupos:', err)
        setGrupos([])
      })
      .finally(() => setDataLoading(false))
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
        <div style={styles.grid}>
          {grupos.length === 0 && <p style={{ color: '#aaa', gridColumn: '1/-1', textAlign: 'center' }}>No hay grupos para este periodo.</p>}
          {grupos.map((g) => (
            <div
              key={g.id_grupo}
              style={styles.groupCard}
              className="card-hover"
              onClick={() => onGroupClick && onGroupClick({ id_grupo: g.id_grupo, periodo: g.periodo })}
            >
              <div style={styles.cardHeader}>
                <h3 style={styles.cardTitle}>{g.id_grupo}</h3>
                <span style={{
                  ...styles.cardBadge,
                  background: g.turno === 'M' ? 'rgba(251, 191, 36, 0.2)' : 'rgba(129, 140, 248, 0.2)',
                  color: g.turno === 'M' ? '#fbbf24' : '#818cf8',
                  border: `1px solid ${g.turno === 'M' ? 'rgba(251, 191, 36, 0.3)' : 'rgba(129, 140, 248, 0.3)'}`
                }}>
                  {g.turno === 'M' ? 'Matutino' : 'Vespertino'}
                </span>
              </div>

              <div style={styles.cardBody}>
                <div style={styles.cardInfo}>
                  <span style={styles.cardLabel}>Materia:</span>
                  <span style={styles.cardValue}>{g.materia_nombre}</span>
                </div>
                <div style={styles.cardInfo}>
                  <span style={styles.cardLabel}>Clave:</span>
                  <span style={styles.cardValue}>{g.materia_clave}</span>
                </div>
                <div style={styles.cardInfo}>
                  <span style={styles.cardLabel}>Semestre:</span>
                  <span style={styles.cardValue}>{g.semestre}º</span>
                </div>

                <div style={styles.cardDivider} />

                <div style={{ ...styles.cardInfo, justifyContent: 'space-between' }}>
                  <span style={styles.cardLabel}>Alumnos Inscritos:</span>
                  <span style={styles.inscritosBadge}>{g.inscritos || 0}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}

function Horario({ profile, initialPeriod }) {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState(initialPeriod || '')
  const [rows, setRows] = useState([])
  const [dataLoading, setDataLoading] = useState(false)

  // Fetch periods
  useEffect(() => {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${token}` } })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data) && data.length > 0) {
          setPeriodos(data)
          if (!initialPeriod) setPeriodo(data[0]) // Default to latest if no suggestion
          else if (!periodo) setPeriodo(data[0])
        } else {
          setPeriodos(['2025-2'])
          if (!periodo) setPeriodo('2025-2')
        }
      })
      .catch(err => {
        console.error('Error fetching periods:', err)
        setPeriodos(['2025-2'])
        if (!periodo) setPeriodo('2025-2')
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    setDataLoading(true)
    const token = localStorage.getItem('access_token') || ''

    fetch(`${API}/profesor/horario?periodo=${periodo}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data)) setRows(data)
        else setRows([])
      })
      .catch(err => {
        console.error('Error fetching horario:', err)
        setRows([])
      })
      .finally(() => setDataLoading(false))
  }, [periodo])

  const dias = [
    { id: 1, name: 'Lunes' },
    { id: 2, name: 'Martes' },
    { id: 3, name: 'Miércoles' },
    { id: 4, name: 'Jueves' },
    { id: 5, name: 'Viernes' }
  ]

  // Helper to format time
  const fmtTime = (t) => t ? t.slice(0, 5) : ''

  return (
    <div>
      <h2 style={styles.h2}>Horario Semanal</h2>

      <div style={styles.infoBar}>
        <div><b>Docente:</b> {profile?.nombre_completo || 'â€”'}</div>
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
        <div style={styles.weekGrid}>
          {dias.map(day => {
            const clasesDelDia = rows
              .filter(r => r.dia_semana === day.id)
              .sort((a, b) => a.hora_ini.localeCompare(b.hora_ini))

            return (
              <div key={day.id} style={styles.dayColumn}>
                <div style={styles.dayHeader}>{day.name}</div>
                <div style={styles.dayContent}>
                  {clasesDelDia.length === 0 ? (
                    <div style={styles.emptySlot}>-</div>
                  ) : (
                    clasesDelDia.map((clase, idx) => (
                      <div key={idx} style={styles.classCard}>
                        <div style={styles.classTime}>
                          {fmtTime(clase.hora_ini)} - {fmtTime(clase.hora_fin)}
                        </div>
                        <div style={styles.className}>{clase.materia_nombre}</div>
                      </div>
                    ))
                  )}
                </div>
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}

function Calificaciones({ context }) {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState(context?.periodo || '')
  const [grupos, setGrupos] = useState([])
  const [grupoSel, setGrupoSel] = useState(context?.id_grupo || null)
  const [alumnos, setAlumnos] = useState([])
  const [editMode, setEditMode] = useState({})
  const [dataLoading, setDataLoading] = useState(false)

  // Fetch periods
  useEffect(() => {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${token}` } })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data) && data.length > 0) {
          setPeriodos(data)
          if (!periodo) setPeriodo(data[0])
        } else {
          setPeriodos(['2025-2'])
          if (!periodo) setPeriodo('2025-2')
        }
      })
      .catch(err => {
        console.error('Error fetching periods:', err)
        setPeriodos(['2025-2'])
        if (!periodo) setPeriodo('2025-2')
      })
  }, [])

  // Cargar grupos del profesor para el select
  useEffect(() => {
    if (!periodo) return
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/grupos?periodo=${periodo}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data)) {
          setGrupos(data)
          // Si no hay grupo seleccionado (o cambiamos de periodo), seleccionar el primero
          if (data.length > 0 && !grupoSel) setGrupoSel(data[0].id_grupo)
          // Si el grupo seleccionado ya no existe en el nuevo periodo, seleccionar el primero
          if (grupoSel && !data.find(g => g.id_grupo === grupoSel)) {
            setGrupoSel(data.length > 0 ? data[0].id_grupo : null)
          }
        }
        else setGrupos([])
      })
      .catch(err => console.error(err))
  }, [periodo])

  // Cargar alumnos del grupo seleccionado
  useEffect(() => {
    if (!grupoSel) return
    setDataLoading(true)
    const token = localStorage.getItem('access_token') || ''

    fetch(`${API}/profesor/grupo/${grupoSel}/alumnos`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data)) setAlumnos(data)
        else setAlumnos([])
      })
      .catch(err => {
        console.error('Error loading alumnos:', err)
        setAlumnos([])
      })
      .finally(() => setDataLoading(false))
  }, [grupoSel])

  function handleEdit(boleta, field, value) {
    setEditMode(prev => ({ ...prev, [`${boleta}-${field}`]: value }))
  }

  async function saveCalif(boleta, field) {
    const key = `${boleta}-${field}`
    const valor = editMode[key]
    if (valor === undefined) return

    console.log(`Guardando ${field} para ${boleta}: ${valor}`)

    fetch(`${API}/profesor/calificar`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${localStorage.getItem('access_token')}`
      },
      body: JSON.stringify({
        id_grupo: grupoSel,
        boleta,
        field,
        value: parseFloat(valor) || 0
      })
    })
      .then(r => r.json())
      .then(res => {
        if (res.error) console.error(res.error)
        else {
          setAlumnos(prev => prev.map(a =>
            a.boleta === boleta ? { ...a, [field]: parseFloat(valor) || 0 } : a
          ))
        }
      })
      .catch(err => console.error(err))

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
                          {a.p1 ?? 'â€”'}
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
                          {a.p2 ?? 'â€”'}
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
                          {a.ordinario ?? 'â€”'}
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
        Doble clic en una celda para editar. La calificaciÃ³n se guarda al salir del campo.
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
  grid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
    gap: '24px',
  },
  groupCard: {
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(10px)',
    borderRadius: '16px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    padding: '24px',
    display: 'flex',
    flexDirection: 'column',
    position: 'relative',
    overflow: 'hidden',
  },
  cardHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '20px',
  },
  cardTitle: {
    fontSize: '24px',
    fontWeight: '700',
    color: '#ffffff',
    margin: 0,
    background: 'linear-gradient(135deg, #ffffff 0%, #a5b4fc 100%)',
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
  },
  cardBadge: {
    padding: '6px 12px',
    borderRadius: '20px',
    fontSize: '12px',
    fontWeight: '600',
    letterSpacing: '0.5px',
    textTransform: 'uppercase',
  },
  cardBody: {
    display: 'flex',
    flexDirection: 'column',
    gap: '12px',
  },
  cardInfo: {
    display: 'flex',
    alignItems: 'center',
    gap: '10px',
  },
  cardLabel: {
    color: '#6a7aae',
    fontSize: '14px',
    fontWeight: '500',
    minWidth: '70px',
  },
  cardValue: {
    color: '#e2e8f0',
    fontSize: '15px',
    fontWeight: '600',
  },
  cardDivider: {
    height: '1px',
    background: 'rgba(106, 122, 174, 0.2)',
    margin: '8px 0',
  },
  inscritosBadge: {
    background: 'rgba(16, 185, 129, 0.2)',
    color: '#34d399',
    border: '1px solid rgba(16, 185, 129, 0.3)',
    padding: '4px 12px',
    borderRadius: '8px',
    fontSize: '14px',
    fontWeight: '700',
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

  // Kanban Schedule Styles
  weekGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(5, 1fr)',
    gap: '20px',
    marginTop: '20px',
    overflowX: 'auto',
    paddingBottom: '20px',
  },
  dayColumn: {
    background: 'rgba(30, 43, 79, 0.4)',
    borderRadius: '16px',
    overflow: 'hidden',
    display: 'flex',
    flexDirection: 'column',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    minHeight: '400px',
  },
  dayHeader: {
    padding: '16px',
    background: 'rgba(106, 122, 174, 0.15)',
    textAlign: 'center',
    fontWeight: '700',
    color: '#ffffff',
    borderBottom: '1px solid rgba(106, 122, 174, 0.2)',
    fontSize: '15px',
    textTransform: 'uppercase',
    letterSpacing: '1px',
  },
  dayContent: {
    padding: '16px',
    display: 'flex',
    flexDirection: 'column',
    gap: '16px',
    flex: 1,
  },
  classCard: {
    background: 'rgba(63, 81, 181, 0.2)',
    border: '1px solid rgba(129, 140, 248, 0.3)',
    borderRadius: '12px',
    padding: '16px',
    boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
    transition: 'transform 0.2s ease',
  },
  classTime: {
    fontSize: '13px',
    color: '#818cf8',
    fontWeight: '700',
    marginBottom: '6px',
    display: 'block',
    background: 'rgba(0, 0, 0, 0.2)',
    padding: '4px 8px',
    borderRadius: '6px',
    width: 'fit-content',
  },
  className: {
    fontSize: '14px',
    color: '#ffffff',
    fontWeight: '600',
    lineHeight: '1.4',
  },
  emptySlot: {
    textAlign: 'center',
    color: 'rgba(106, 122, 174, 0.4)',
    fontSize: '24px',
    marginTop: '40px',
    fontWeight: '300',
  },
}

function Reportes() {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [grupos, setGrupos] = useState([])
  const [grupoSel, setGrupoSel] = useState('')
  const [stats, setStats] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/periodos`, { headers: { Authorization: `Bearer ${token}` } })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data) && data.length > 0) {
          setPeriodos(data)
          setPeriodo(data[0])
        } else {
          setPeriodos(['2025-2'])
          setPeriodo('2025-2')
        }
      })
  }, [])

  useEffect(() => {
    if (!periodo) return
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/grupos?periodo=${periodo}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => {
        if (Array.isArray(data)) {
          setGrupos(data)
          if (data.length > 0) setGrupoSel(data[0].id_grupo)
          else setGrupoSel('')
        }
      })
  }, [periodo])

  useEffect(() => {
    if (!grupoSel) {
      setStats(null)
      return
    }
    setLoading(true)
    const token = localStorage.getItem('access_token') || ''
    fetch(`${API}/profesor/grupo/${grupoSel}/stats`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(r => r.json())
      .then(data => setStats(data))
      .catch(err => console.error(err))
      .finally(() => setLoading(false))
  }, [grupoSel])

  const exportCSV = () => {
    if (!stats) return
    const csvContent =
      `Grupo,Total Alumnos,Aprobados,Reprobados,Promedio\n` +
      `${grupoSel},${stats.total_alumnos},${stats.aprobados},${stats.reprobados},${stats.promedio_general}`

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' })
    const url = URL.createObjectURL(blob)
    const link = document.createElement('a')
    link.href = url
    link.setAttribute('download', `reporte_grupo_${grupoSel}.csv`)
    document.body.appendChild(link)
    link.click()
  }

  const pieData = stats ? [
    { name: 'Aprobados', value: parseInt(stats.aprobados || 0) },
    { name: 'Reprobados', value: parseInt(stats.reprobados || 0) }
  ] : []

  const COLORS = ['#4ade80', '#f87171']

  return (
    <div>
      <h2 style={styles.h2}>Reportes de Rendimiento</h2>

      <div style={styles.infoBar}>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e => setPeriodo(e.target.value)} style={styles.select}>
            {periodos.map(p => <option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b>Grupo:</b>{' '}
          <select value={grupoSel} onChange={e => setGrupoSel(e.target.value)} style={styles.select}>
            {grupos.map(g => <option key={g.id_grupo} value={g.id_grupo}>{g.materia_nombre} ({g.id_grupo})</option>)}
          </select>
        </div>
        <button onClick={exportCSV} style={styles.pill} className="pill-hover">
          Exportar CSV
        </button>
      </div>

      {loading ? (
        <p style={{ color: '#fff', textAlign: 'center' }}>Cargando estadísticas...</p>
      ) : stats ? (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
          <div style={styles.card}>
            <h3 style={{ ...styles.cardTitle, marginBottom: '20px', textAlign: 'center' }}>Aprobación</h3>
            <ResponsiveContainer width="100%" height={250}>
              <PieChart>
                <Pie
                  data={pieData}
                  cx="50%"
                  cy="50%"
                  innerRadius={50}
                  outerRadius={70}
                  paddingAngle={5}
                  dataKey="value"
                >
                  {pieData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip contentStyle={{ backgroundColor: '#333', border: 'none', borderRadius: '8px' }} />
                <Legend verticalAlign="bottom" height={36} />
              </PieChart>
            </ResponsiveContainer>
          </div>

          <div style={styles.card}>
            <h3 style={{ ...styles.cardTitle, marginBottom: '20px', textAlign: 'center' }}>Métricas Generales</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px', justifyContent: 'center', height: '100%' }}>
              <div style={styles.dataItem}>
                <span style={styles.dataLabel}>Promedio General:</span>
                <span style={{ ...styles.dataValue, fontSize: '24px', color: '#818cf8' }}>
                  {stats.promedio_general ? parseFloat(stats.promedio_general).toFixed(2) : '-'}
                </span>
              </div>
              <div style={styles.dataItem}>
                <span style={styles.dataLabel}>Total Alumnos:</span>
                <span style={styles.dataValue}>{stats.total_alumnos}</span>
              </div>
            </div>
          </div>
        </div>
      ) : (
        <p style={{ color: '#aaa', textAlign: 'center' }}>Seleccione un grupo para ver el reporte.</p>
      )}
    </div>
  )
}
