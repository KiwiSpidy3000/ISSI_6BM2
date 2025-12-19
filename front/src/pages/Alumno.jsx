import { useEffect, useRef, useState } from 'react'
import jsPDF from 'jspdf'
import autoTable from 'jspdf-autotable'
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts'
import { useNavigate } from 'react-router-dom'
import ChatComponent from '../components/ChatComponent'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Alumno() {
  const nav = useNavigate()
  const [view, setView] = useState('chat')
  const [profile, setProfile] = useState(null)

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''
    fetch(`${API}/alumno/profile`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(d => setProfile(d))
      .catch(console.error)

    const style = document.createElement('style')
    style.textContent = `
      @keyframes float1 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(80px, -140vh, 250px) rotate(120deg) scale(1.3); } 50% { transform: translate3d(-60px, -160vh, 400px) rotate(240deg) scale(0.9); } 75% { transform: translate3d(100px, -180vh, 300px) rotate(360deg) scale(1.1); } }
      @keyframes float2 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(-90px, -130vh, 280px) rotate(-120deg) scale(1.2); } 50% { transform: translate3d(70px, -155vh, 350px) rotate(-240deg) scale(1.4); } 75% { transform: translate3d(-80px, -175vh, 320px) rotate(-360deg) scale(0.95); } }
      @keyframes float3 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(85px, -145vh, 260px) rotate(110deg) scale(1.15); } 50% { transform: translate3d(-75px, -165vh, 380px) rotate(220deg) scale(1.35); } 75% { transform: translate3d(65px, -185vh, 290px) rotate(330deg) scale(1.05); } }
      @keyframes float4 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(-95px, -135vh, 310px) rotate(-110deg) scale(1.25); } 50% { transform: translate3d(90px, -150vh, 370px) rotate(-220deg) scale(0.85); } 75% { transform: translate3d(-70px, -170vh, 340px) rotate(-330deg) scale(1.4); } }
      .pill-hover:hover { transform: translateX(8px); background: rgba(106, 122, 174, 0.3); box-shadow: 0 4px 20px rgba(106, 122, 174, 0.4); }
      .danger-hover:hover { background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%); box-shadow: 0 8px 24px rgba(220, 38, 38, 0.5); }
      .card-hover { transition: all 0.3s ease; cursor: pointer; }
      .card-hover:hover { transform: translateY(-5px); box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4); border-color: rgba(106, 122, 174, 0.5); }
    `
    document.head.appendChild(style)
    return () => document.head.removeChild(style)
  }, [])

  function logout() {
    localStorage.removeItem('access_token');
    nav('/');
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
          <div style={styles.sidebarTitle}>Alumno</div>
          {profile?.nombre_completo && (
            <div style={{ fontSize: '14px', color: '#a8b2d1', marginTop: '4px' }}>
              {profile.nombre_completo.split(' ')[0]}
            </div>
          )}
        </div>

        <nav style={styles.sidebarNav}>
          <button style={{ ...styles.pill, ...(view === 'dashboard' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('dashboard')}>Rendimiento Académico</button>
          <button style={{ ...styles.pill, ...(view === 'perfil' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('perfil')}>Datos Personales</button>
          <button style={{ ...styles.pill, ...(view === 'kardex' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('kardex')}>Kardex</button>
          <button style={{ ...styles.pill, ...(view === 'horario' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('horario')}>Horario</button>
          <button style={{ ...styles.pill, ...(view === 'calificaciones' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('calificaciones')}>Calificaciones</button>
          <button style={{ ...styles.pill, ...(view === 'reins' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('reins')}>Reinscripción</button>
          <button style={{ ...styles.pill, ...(view === 'bajas' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('bajas')}>Bajas</button>
          <button style={{ ...styles.pill, ...(view === 'evaluacion' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('evaluacion')}>Evaluación Docente</button>
          <button style={{ ...styles.pill, ...(view === 'grupos' ? styles.pillActive : {}) }} className="pill-hover" onClick={() => setView('grupos')}>Oferta</button>
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
        {view === 'chat' && (
          <ChatComponent
            userIdentifier={profile?.boleta}
            userName={profile?.nombre_completo?.split(' ')[0]}
            userRole="Alumno"
          />
        )}
        {view === 'dashboard' && <Dashboard />}
        {view === 'perfil' && <DatosPersonales />}
        {view === 'kardex' && <Kardex />}
        {view === 'horario' && <Horario />}
        {view === 'calificaciones' && <Calificaciones />}
        {view === 'reins' && <Reinscripcion />}
        {view === 'bajas' && <Bajas />}
        {view === 'evaluacion' && <Evaluacion />}
        {view === 'grupos' && <Grupos />}
      </main>
    </div>
  )
}

function DatosPersonales() {
  const [profile, setProfile] = useState(null)
  const [isEditing, setIsEditing] = useState(false)
  const [formData, setFormData] = useState({})
  const [saving, setSaving] = useState(false)

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''
    fetch(`${API}/alumno/profile`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(d => {
        setProfile(d)
        setFormData(d)
      })
      .catch(console.error)
  }, [])

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    })
  }

  const handleSave = () => {
    setSaving(true)
    const t = localStorage.getItem('access_token') || ''
    fetch(`${API}/alumno/profile`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${t}`
      },
      body: JSON.stringify({
        curp: formData.curp,
        telefono: formData.telefono,
        direccion: formData.direccion
      })
    })
      .then(async r => {
        if (!r.ok) {
          const err = await r.json().catch(() => ({}))
          throw new Error(err.error || 'Error al guardar cambios')
        }
        setProfile({ ...profile, ...formData })
        setIsEditing(false)
      })
      .catch(e => alert(e.message))
      .finally(() => setSaving(false))
  }

  if (!profile) return <div style={styles.loading}>Cargando...</div>

  // Override style for inputs to fit card width properly
  const profileInputStyle = {
    ...styles.input,
    width: '100%',
    boxSizing: 'border-box',
    minHeight: '42px',
    fontSize: '15px',
    background: 'rgba(58, 74, 122, 0.4)'
  }

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <h2 style={{ ...styles.h2, marginBottom: 0 }}>Datos Personales</h2>
          <p style={{ color: '#6a7aae', marginTop: '6px', fontSize: '14px', margin: '4px 0 0 0' }}>
            Información del alumno y contacto
          </p>
        </div>

        {!isEditing ? (
          <button
            style={styles.button}
            onClick={() => setIsEditing(true)}
          >
            ✏️ Editar Información
          </button>
        ) : (
          <div style={{ display: 'flex', gap: '12px' }}>
            <button
              style={{ ...styles.button, background: 'transparent', border: '1px solid rgba(106, 122, 174, 0.5)' }}
              onClick={() => { setIsEditing(false); setFormData(profile); }}
            >
              Cancelar
            </button>
            <button style={styles.button} onClick={handleSave} disabled={saving}>
              {saving ? 'Guardando...' : '💾 Guardar Cambios'}
            </button>
          </div>
        )}
      </div>

      <div style={styles.card}>
        <div style={styles.dataGrid}>
          {/* Read Only Fields */}
          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>Boleta</span>
            <div style={styles.dataValue}>{profile.boleta}</div>
          </div>
          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>Nombre Completo</span>
            <div style={styles.dataValue}>{profile.nombre_completo}</div>
          </div>
          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>Carrera</span>
            <div style={styles.dataValue}>{profile.carrera}</div>
          </div>
          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>Correo Institucional</span>
            <div style={styles.dataValue}>{profile.email}</div>
          </div>

          {/* Editable Fields */}
          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>CURP</span>
            {isEditing ? (
              <input
                style={profileInputStyle}
                name="curp"
                value={formData.curp || ''}
                onChange={handleChange}
                placeholder="Ingrese su CURP"
              />
            ) : (
              <div style={styles.dataValue}>{profile.curp || <span style={{ opacity: 0.5, fontStyle: 'italic' }}>-</span>}</div>
            )}
          </div>

          <div style={styles.dataItem}>
            <span style={styles.dataLabel}>Teléfono de Contacto</span>
            {isEditing ? (
              <input
                style={profileInputStyle}
                name="telefono"
                value={formData.telefono || ''}
                onChange={handleChange}
                placeholder="55 1234 5678"
              />
            ) : (
              <div style={styles.dataValue}>{profile.telefono || <span style={{ opacity: 0.5, fontStyle: 'italic' }}>-</span>}</div>
            )}
          </div>

          <div style={{ ...styles.dataItem, gridColumn: '1 / -1' }}>
            <span style={styles.dataLabel}>Dirección Particular</span>
            {isEditing ? (
              <textarea
                style={{ ...profileInputStyle, minHeight: '80px', resize: 'vertical', paddingTop: '10px' }}
                name="direccion"
                value={formData.direccion || ''}
                onChange={handleChange}
                placeholder="Calle, Número, Colonia, Alcaldía/Municipio, C.P."
              />
            ) : (
              <div style={{ ...styles.dataValue, lineHeight: '1.5' }}>
                {profile.direccion || <span style={{ opacity: 0.5, fontStyle: 'italic' }}>-</span>}
              </div>
            )}
          </div>

        </div>
      </div>
    </div>
  )
}

function Kardex() {
  const [kardex, setKardex] = useState([])

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''
    fetch(`${API}/alumno/kardex`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(setKardex)
      .catch(console.error)
  }, [])

  // Group by semester
  const grouped = kardex.reduce((acc, item) => {
    const sem = item.semestre || 'Desconocido'
    if (!acc[sem]) acc[sem] = []
    acc[sem].push(item)
    return acc
  }, {})

  // Sort semesters (assuming numeric or simple string sort)
  const sortedSemesters = Object.keys(grouped).sort((a, b) => Number(a) - Number(b))

  return (
    <div>
      <h2 style={styles.h2}>Kardex</h2>
      <div style={styles.grid}>
        {
          sortedSemesters.map(sem => {
            const materias = grouped[sem]
            // Calculate average
            const sum = materias.reduce((acc, m) => {
              const calif = parseFloat(m.calificacion)
              return acc + (isNaN(calif) ? 0 : calif)
            }, 0)
            const count = materias.filter(m => !isNaN(parseFloat(m.calificacion))).length
            const avg = count > 0 ? (sum / count).toFixed(2) : '0.00'

            return (
              <div key={sem} style={styles.groupCard} className="card-hover">
                <div style={styles.cardHeader}>
                  <h3 style={styles.cardTitle}>Semestre {sem}</h3>
                  <span style={styles.inscritosBadge}>Promedio: {avg}</span>
                </div>
                <div style={styles.cardBody}>
                  {materias.map((m, idx) => {
                    const calif = parseFloat(m.calificacion)
                    const aprobado = !isNaN(calif) && calif >= 6
                    return (
                      <div key={idx} style={{ ...styles.cardInfo, justifyContent: 'space-between', borderBottom: '1px solid rgba(255,255,255,0.05)', paddingBottom: '8px' }}>
                        <div style={{ display: 'flex', flexDirection: 'column' }}>
                          <span style={{ color: '#fff', fontWeight: '600', fontSize: '14px' }}>{m.materia || m.materia_nombre}</span>
                          <span style={{ color: '#6a7aae', fontSize: '12px' }}>{m.materia_clave} • {m.creditos} Créditos</span>
                        </div>
                        <span style={{
                          fontWeight: 'bold',
                          color: aprobado ? '#4ade80' : '#f87171',
                          fontSize: '16px'
                        }}>
                          {isNaN(calif) ? '-' : (Number.isInteger(calif) ? calif : calif.toFixed(1))}
                        </span>
                      </div>
                    )
                  })}
                </div>
              </div>
            )
          })
        }
      </div >
    </div >
  )
}

function Horario() {
  const [schedule, setSchedule] = useState([])
  const [currentPeriod, setCurrentPeriod] = useState('')

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''
    // First get periods to find the latest one
    fetch(`${API}/alumno/periodos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(list => {
        if (list && list.length > 0) {
          const latest = list[list.length - 1]
          setCurrentPeriod(latest)
          // Then fetch schedule for that period
          return fetch(`${API}/alumno/horario?periodo=${latest}`, { headers: { Authorization: `Bearer ${t}` } })
        }
        return null
      })
      .then(r => r ? r.json() : [])
      .then(data => setSchedule(data || []))
      .catch(console.error)
  }, [])

  const grouped = schedule.reduce((acc, item) => {
    const key = item.id_grupo
    if (!acc[key]) acc[key] = { ...item, days: {} }
    acc[key].days[item.dia_semana] = item
    return acc
  }, {})

  const rows = Object.values(grouped)
  const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes']

  const downloadPDF = () => {
    const doc = new jsPDF()

    // Header logic
    doc.setFontSize(18)
    doc.text('Instituto Politécnico Nacional', 14, 20)
    doc.setFontSize(14)
    doc.text('Escuela Superior de Cómputo', 14, 28)
    doc.setFontSize(12)
    doc.text(`Horario de Clases - Periodo ${currentPeriod}`, 14, 36)

    const tableBody = rows.map(r => {
      const rowData = [
        r.nombreG || r.id_grupo,
        r.materia_nombre,
        r.profesor
      ]
      days.forEach(d => {
        const dayData = r.days[d]
        rowData.push(dayData ? `${dayData.hora_ini?.slice(0, 5)} - ${dayData.hora_fin?.slice(0, 5)}` : '-')
      })
      return rowData
    })

    autoTable(doc, {
      head: [['Grupo', 'Materia', 'Profesor', ...days]],
      body: tableBody,
      startY: 45,
      styles: { fontSize: 8 },
      headStyles: { fillColor: [26, 40, 71] },
      theme: 'grid'
    })

    doc.save(`horario_${currentPeriod}.pdf`)
  }

  return (
    <div>
      <h2 style={styles.h2}>Horario Actual ({currentPeriod || '...'})</h2>
      <div style={styles.infoBar}>
        <button style={styles.button} onClick={downloadPDF}>📄 Descargar Horario PDF</button>
      </div>

      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              {days.map(d => <th key={d} style={styles.th}>{d}</th>)}
            </tr>
          </thead>
          <tbody>
            {rows.length > 0 ? rows.map((r, i) => (
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.nombreG || r.id_grupo}</td>
                <td style={styles.td}>{r.materia_nombre}</td>
                <td style={styles.td}>{r.profesor}</td>
                {days.map(d => {
                  const dayData = r.days[d]
                  return (
                    <td key={d} style={styles.td}>
                      {dayData ? (
                        <div style={{ fontSize: '12px' }}>
                          <div>{dayData.hora_ini?.slice(0, 5)} - {dayData.hora_fin?.slice(0, 5)}</div>
                        </div>
                      ) : '-'}
                    </td>
                  )
                })}
              </tr>
            )) : (
              <tr><td colSpan={8} style={{ ...styles.td, textAlign: 'center' }}>No hay horario disponible para el periodo actual.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Calificaciones() {
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [rows, setRows] = useState([])
  const [loading, setLoading] = useState(false)
  const [err, setErr] = useState('')

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''
    fetch(`${API}/alumno/periodos`, { headers: { Authorization: `Bearer ${t}` } })
      .then(r => r.json())
      .then(list => {
        const arr = list || []
        setPeriodos(arr)
        if (arr.length) setPeriodo(arr[arr.length - 1])
      })
      .catch(() => setPeriodos([]))
  }, [])

  useEffect(() => {
    if (!periodo) return
    const t = localStorage.getItem('access_token') || ''
    setLoading(true)
    setErr('')
    fetch(`${API}/alumno/calificaciones?periodo=${periodo}`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(async r => {
        if (!r.ok) throw new Error('Error al cargar calificaciones')
        const data = await r.json()
        setRows(data || [])
      })
      .catch(e => {
        setErr(e.message || 'Error al cargar calificaciones')
        setRows([])
      })
      .finally(() => setLoading(false))
  }, [periodo])

  return (
    <div>
      <h2 style={styles.h2}>Calificaciones</h2>

      <div style={styles.infoBar}>
        <b>Periodo:</b>{' '}
        <select
          value={periodo}
          onChange={e => setPeriodo(e.target.value)}
          style={styles.select}
        >
          {periodos.map(p => (
            <option key={p} value={p}>{p}</option>
          ))}
        </select>
      </div>

      {err && <div style={styles.error}>{err}</div>}

      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Clave</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Calif. final</th>
              <th style={styles.th}>Extraordinario</th>
            </tr>
          </thead>
          <tbody>
            {loading ? (
              <tr>
                <td colSpan={4} style={{ ...styles.td, textAlign: 'center', padding: '24px' }}>
                  Cargando...
                </td>
              </tr>
            ) : rows.length === 0 ? (
              <tr>
                <td colSpan={4} style={{ ...styles.td, textAlign: 'center', padding: '24px' }}>
                  No hay calificaciones para este periodo.
                </td>
              </tr>
            ) : (
              rows.map((r, i) => (
                <tr key={i} style={styles.tableRow}>
                  <td style={styles.td}>{r.materia_clave}</td>
                  <td style={styles.td}>{r.materia_nombre}</td>
                  <td style={styles.td}>
                    {r.final_calc != null ? Math.round(Number(r.final_calc)) : '-'}
                  </td>
                  <td style={styles.td}>
                    {r.extraordinario != null ? Math.round(Number(r.extraordinario)) : '-'}
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Reinscripcion() {
  const t = () => localStorage.getItem('access_token') || ''
  const [periodos] = useState(['2025-2', '2025-1', '2024-2', '2024-1'])
  const [periodo, setPeriodo] = useState('2025-2')

  const [semestre, setSemestre] = useState('')
  const [turno, setTurno] = useState('')
  const [inscritas, setInscritas] = useState([])
  const [oferta, setOferta] = useState([])
  const [resumen, setResumen] = useState({ total_creditos: 0, creditos_usados: 0 })
  const [msg, setMsg] = useState('')
  const [horarioData, setHorarioData] = useState([])

  useEffect(() => {
    fetch(`${API}/alumno/periodos`, { headers: { Authorization: `Bearer ${t()}` } })
      .then(r => r.json())
      .then(list => {
        setPeriodos(list || [])
        if (list?.length) setPeriodo(list[list.length - 1])
      })
      .catch(() => setPeriodos([]))
  }, [])

  useEffect(() => {
    if (!periodo) return
    const hdr = { headers: { Authorization: `Bearer ${t()}` } }
    setMsg('')

    fetch(`${API}/alumno/reins/resumen?periodo=${periodo}`, hdr)
      .then(async r => {
        if (!r.ok) throw new Error()
        return r.json()
      })
      .then(data => setResumen(data || { total_creditos: 0, creditos_usados: 0 }))
      .catch(() => setResumen({ total_creditos: 0, creditos_usados: 0 }))

    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}`, hdr)
      .then(async r => {
        if (!r.ok) throw new Error()
        return r.json()
      })
      .then(data => setInscritas(Array.isArray(data) ? data : []))
      .catch(() => setInscritas([]))

    const qs = new URLSearchParams({
      periodo,
      ...(semestre ? { semestre } : {}),
      ...(turno ? { turno } : {})
    })

    fetch(`${API}/alumno/reins/oferta?${qs.toString()}`, hdr)
      .then(async r => {
        if (!r.ok) throw new Error()
        const data = await r.json()
        setOferta(Array.isArray(data) ? data : [])
      })
      .catch(() => setOferta([]))

    // We want PRELIMINARY schedule for preview (shows Preinscrito + Inscrito)
    fetch(`${API}/alumno/reins/horario_preliminar?periodo=${periodo}`, hdr)
      .then(r => r.json())
      .then(setHorarioData)
      .catch(() => setHorarioData([]))
  }, [periodo, semestre, turno])

  function refresh() {
    if (!periodo) return
    const hdr = { headers: { Authorization: `Bearer ${t()}` } }
    const qs = new URLSearchParams({
      periodo,
      ...(semestre ? { semestre } : {}),
      ...(turno ? { turno } : {})
    })

    fetch(`${API}/alumno/reins/resumen?periodo=${periodo}`, hdr)
      .then(r => r.json())
      .then(data => setResumen(data || { total_creditos: 0, creditos_usados: 0 }))
      .catch(() => setResumen({ total_creditos: 0, creditos_usados: 0 }))

    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}`, hdr)
      .then(r => r.json())
      .then(data => {
        // Solo actualizar si hay cambios reales para evitar re-renders innecesarios (optimización básica)
        setInscritas(prev => JSON.stringify(prev) !== JSON.stringify(data) ? (Array.isArray(data) ? data : []) : prev)
      })
      .catch(() => setInscritas([]))

    fetch(`${API}/alumno/reins/oferta?${qs.toString()}`, hdr)
      .then(r => r.json())
      .then(data => {
        // Igual aquí, evitar set si es idéntico
        setOferta(prev => JSON.stringify(prev) !== JSON.stringify(data) ? (Array.isArray(data) ? data : []) : prev)
      })
      .catch(() => setOferta([]))

    fetch(`${API}/alumno/reins/horario_preliminar?periodo=${periodo}`, hdr)
      .then(r => r.json())
      .then(data => setHorarioData(prev => JSON.stringify(prev) !== JSON.stringify(data) ? (data || []) : prev))
      .catch(() => setHorarioData([]))
  }

  // Polling: Actualizar datos cada 10 segundos para mantener sesión sincronizada
  useEffect(() => {
    if (!periodo) return;
    const interval = setInterval(refresh, 10000);
    return () => clearInterval(interval);
  }, [periodo, semestre, turno]);



  async function addGrupo(id_grupo) {
    setMsg('')
    if (inscritas.length >= 6) {
      setMsg('No puedes inscribir más de 6 materias en este periodo (máximo 6).')
      return
    }

    // Check for duplicate key (subject already registered)
    const grupoToAdd = oferta.find(g => g.id_grupo === id_grupo)
    if (grupoToAdd) {
      const alreadyRegistered = inscritas.some(i => i.clave === grupoToAdd.clave)
      if (alreadyRegistered) {
        setMsg('Esta materia ya está inscrita en otro grupo.')
        return
      }
    }


    try {
      const hdr = { Authorization: `Bearer ${t()}` }

      // 1. Validar choque de horario
      const rChoque = await fetch(`${API}/alumno/reins/conflictos?id_grupo=${id_grupo}`, { headers: hdr })
      if (!rChoque.ok) throw new Error('Error validando conflictos')

      const choques = await rChoque.json()
      if (Array.isArray(choques) && choques.length) {
        setMsg('Choque de horario con otra materia.')
        return
      }

      // 2. Intentar preinscribir
      const res = await fetch(`${API}/alumno/reins/preinscribir`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t()}` },
        body: JSON.stringify({ id_grupo })
      })

      // Leer respuesta como texto primero para evitar JSON parse error
      const text = await res.text()
      let data = {}
      try {
        data = text ? JSON.parse(text) : {}
      } catch (e) {
        // Si falla el parseo, asumimos error del servidor (posiblemente HTML o texto plano)
        throw new Error(text || 'Error desconocido del servidor (respuesta no válida)')
      }

      if (!res.ok) {
        setMsg(data.error || text || 'No se pudo agregar el grupo.')
        return
      }

      setMsg('Grupo agregado al carrito de reinscripción.')
      refresh()
    } catch (e) {
      console.error('Error al agregar grupo:', e);
      setMsg(`Error: ${e.message}`);
    }
  }

  async function delGrupo(id_grupo) {
    setMsg('')
    try {
      const res = await fetch(`${API}/alumno/reins/preinscribir/${id_grupo}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${t()}` }
      })
      if (!res.ok) {
        const txt = await res.text()
        alert('Error al eliminar: ' + txt)
        return
      }
      refresh()
    } catch (e) {
      alert('Error de red al eliminar grupo')
    }
  }

  async function confirmar() {
    setMsg('')
    try {
      const res = await fetch(`${API}/alumno/reins/confirmar`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t()}` },
        body: JSON.stringify({ periodo })
      })
      const data = await res.json().catch(() => ({}))
      if (!res.ok) {
        setMsg(data.error || 'Error al confirmar la reinscripción.')
        return
      }
      setMsg('Reinscripción confirmada correctamente.')
      refresh()
    } catch {
      setMsg('Error de red al confirmar la reinscripción.')
    }
  }

  const materiasPeriodo = inscritas.length

  const dias = [
    { id: 1, name: 'Lunes' },
    { id: 2, name: 'Martes' },
    { id: 3, name: 'Miércoles' },
    { id: 4, name: 'Jueves' },
    { id: 5, name: 'Viernes' }
  ]
  const fmtTime = (t) => t ? t.slice(0, 5) : ''

  return (
    <div>
      <h2 style={styles.h2}>Reinscripción</h2>
      <div style={styles.infoBar}>
        <div><b>Créditos totales:</b> {resumen.total_creditos?.toFixed?.(2) ?? resumen.total_creditos}</div>
        <div><b>Créditos utilizados:</b> {resumen.creditos_usados?.toFixed?.(2) ?? resumen.creditos_usados}</div>
        <div><b>Materias inscritas:</b> {materiasPeriodo} / 6</div>
        <div>
          <b>Semestre:</b>{' '}
          <input value={semestre} onChange={e => setSemestre(e.target.value)} placeholder="1..12" style={styles.input} />
        </div>
        <div>
          <b>Turno:</b>{' '}
          <select value={turno} onChange={e => setTurno(e.target.value)} style={styles.select}>
            <option value="">Todos</option>
            <option value="M">M</option>
            <option value="V">V</option>
            <option value="N">N</option>
          </select>
        </div>
        <button style={styles.button} onClick={confirmar}>Confirmar</button>
      </div>

      {msg && <p style={msg.includes('correctamente') || msg.includes('agregado') ? styles.success : styles.error}>{msg}</p>}

      <h3 style={styles.h3}>Horario Preliminar</h3>
      <div style={styles.weekGrid}>
        {dias.map(day => {
          const clasesDelDia = horarioData
            .filter(r => r.dia_semana === day.name)
            .sort((a, b) => (a.hora_ini || '').localeCompare(b.hora_ini || ''))

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
                      <div style={styles.className}>
                        {clase.materia_nombre}<br />
                        <small style={{ opacity: 0.7, fontSize: '11px' }}>{clase.profesor}</small>
                      </div>
                    </div>
                  ))
                )}
              </div>
            </div>
          )
        })}
      </div>

      <h3 style={styles.h3}>Materias Inscritas</h3>
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              <th style={styles.th}>Cr</th>
              <th style={styles.th}></th>
            </tr>
          </thead>
          <tbody>
            {inscritas.map((r, i) => (
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.nombreG || r.id_grupo}</td>
                <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                <td style={styles.td}>{r.profesor || '-'}</td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>
                  {r.estado === 'PREINSCRITO' && (
                    <button onClick={() => delGrupo(r.id_grupo)} style={styles.iconBtn}>🗑</button>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <h3 style={styles.h3}>Oferta</h3>
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              <th style={styles.th}>Horario</th>
              <th style={styles.th}>Cr</th>
              <th style={styles.th}>Lugares</th>
              <th style={styles.th}></th>
            </tr>
          </thead>
          <tbody>
            {oferta.map((r, i) => (
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.nombreG || r.id_grupo}</td>
                <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                <td style={styles.td}>{r.profesor || '-'}</td>
                <td style={styles.td}><small>{r.horario || '-'}</small></td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>{r.lugares_disponibles}</td>
                <td style={styles.td}>
                  <button
                    onClick={() => addGrupo(r.id_grupo)}
                    style={styles.iconBtn}
                    disabled={materiasPeriodo >= 6}
                    title={materiasPeriodo >= 6 ? 'Límite de 6 materias alcanzado' : 'Agregar'}
                  >
                    +
                  </button>
                </td>
              </tr>
            ))}
            {oferta.length === 0 && (
              <tr>
                <td colSpan={7} style={{ ...styles.td, textAlign: 'center', padding: '24px', color: '#6a7aae' }}>
                  No hay grupos disponibles con los filtros aplicados.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Bajas() {
  const t = () => localStorage.getItem('access_token') || ''
  const [periodo, setPeriodo] = useState('')
  const [inscritas, setInscritas] = useState([])
  const [fechaLimite, setFechaLimite] = useState('')
  const [cargaMinima, setCargaMinima] = useState(0)
  const [msg, setMsg] = useState('')
  const [err, setErr] = useState('')

  useEffect(() => {
    const hdr = { headers: { Authorization: `Bearer ${t()}` } }
    fetch(`${API}/alumno/bajas/info`, hdr)
      .then(r => r.json())
      .then(data => {
        setFechaLimite(data.fecha_limite || '-')
        setCargaMinima(data.carga_minima ?? 0)
        if (data.periodo_actual) setPeriodo(data.periodo_actual)
      })
      .catch(() => setErr('Error cargando información de bajas'))
  }, [])

  useEffect(() => {
    if (!periodo) return
    refresh()
  }, [periodo])

  function refresh() {
    const hdr = { headers: { Authorization: `Bearer ${t()}` } }
    setErr('')
    setMsg('')

    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}&estado=INSCRITO`, hdr)
      .then(r => r.json())
      .then(setInscritas)
      .catch(() => setErr('Error cargando materias inscritas'))

    fetch(`${API}/alumno/bajas/info`, hdr)
      .then(r => r.json())
      .then(data => {
        setFechaLimite(data.fecha_limite || '-')
        setCargaMinima(data.carga_minima ?? 0)
      })
      .catch(() => {
        setFechaLimite('-')
        setCargaMinima(0)
      })
  }

  async function darDeBaja(id_grupo) {
    setMsg('')
    setErr('')
    try {
      const res = await fetch(`${API}/alumno/inscripcion/baja/${id_grupo}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${t()}` }
      })

      const data = await res.json().catch(() => ({}))

      if (!res.ok) {
        setErr(data.error || 'No se pudo dar de baja la materia')
        return
      }

      setMsg('Materia dada de baja correctamente.')
      refresh()
    } catch (e) {
      setErr('Error de red al dar de baja la materia')
    }
  }

  return (
    <div>
      <h2 style={styles.h2}>Baja de materias</h2>
      <div style={styles.infoBar}>
        <div><b>Fecha Límite:</b> {fechaLimite || '-'}</div>
        <div><b>Carga Mínima:</b> {cargaMinima} créditos</div>
      </div>

      {msg && <div style={styles.success}>{msg}</div>}
      {err && <div style={styles.error}>{err}</div>}

      <h3 style={styles.h3}>Materias inscritas actualmente</h3>
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              <th style={styles.th}>Créditos</th>
              <th style={styles.th}>Acción</th>
            </tr>
          </thead>
          <tbody>
            {inscritas.map((r, i) => (
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.nombreG || r.id_grupo}</td>
                <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                <td style={styles.td}>{r.profesor || '-'}</td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>
                  <button
                    onClick={() => darDeBaja(r.id_grupo)}
                    style={styles.iconBtn}
                    title="Dar de baja"
                  >
                    🗑
                  </button>
                </td>
              </tr>
            ))}
            {inscritas.length === 0 && (
              <tr>
                <td colSpan={5} style={{ ...styles.td, textAlign: 'center', padding: '24px', color: '#6a7aae' }}>
                  No tienes materias inscritas en este periodo.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}




function Evaluacion() {
  const t = () => localStorage.getItem('access_token') || ''
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [inscritas, setInscritas] = useState([])
  const [selectedGrupo, setSelectedGrupo] = useState(null)
  const [respuestas, setRespuestas] = useState([5, 5, 5, 5, 5])
  const [comentario, setComentario] = useState('')
  const [msg, setMsg] = useState('')
  const [err, setErr] = useState('')

  useEffect(() => {
    fetch(`${API}/alumno/periodos`, { headers: { Authorization: `Bearer ${t()}` } })
      .then(r => r.json())
      .then(list => {
        setPeriodos(list || [])
        if (list?.length) setPeriodo(list[list.length - 1])
      })
      .catch(() => setPeriodos([]))
  }, [])

  useEffect(() => {
    if (!periodo) return
    refresh()
  }, [periodo])

  function refresh() {
    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}&estado=INSCRITO`, { headers: { Authorization: `Bearer ${t()}` } })
      .then(r => r.json())
      .then(setInscritas)
      .catch(() => setInscritas([]))
  }

  async function enviarEvaluacion(e) {
    e.preventDefault()
    if (!selectedGrupo) return
    setMsg('')
    setErr('')
    try {
      const res = await fetch(`${API}/alumno/evaluacion`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t()}` },
        body: JSON.stringify({ id_grupo: selectedGrupo, respuestas, comentario })
      })

      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Error')

      setMsg('Evaluación enviada, gracias.')
      setSelectedGrupo(null)
      setComentario('')
      setRespuestas([5, 5, 5, 5, 5])
    } catch (e) {
      setErr(e.message)
    }
  }

  return (
    <div>
      <h2 style={styles.h2}>Evaluación Docente</h2>
      <div style={styles.infoBar}>
        <b>Periodo:</b>{' '}
        <select value={periodo} onChange={e => setPeriodo(e.target.value)} style={styles.select}>
          {periodos.map(p => <option key={p} value={p}>{p}</option>)}
        </select>
      </div>

      {msg && <div style={styles.success}>{msg}</div>}
      {err && <div style={styles.error}>{err}</div>}

      {!selectedGrupo ? (
        <div style={styles.tableWrap}>
          <table style={styles.table}>
            <thead>
              <tr style={styles.tableHeaderRow}>
                <th style={styles.th}>Materia</th>
                <th style={styles.th}>Profesor</th>
                <th style={styles.th}>Acción</th>
              </tr>
            </thead>
            <tbody>
              {inscritas.map((r, i) => (
                <tr key={i} style={styles.tableRow}>
                  <td style={styles.td}>{r.nombre}</td>
                  <td style={styles.td}>{r.profesor}</td>
                  <td style={styles.td}>
                    <button onClick={() => setSelectedGrupo(r.id_grupo)} style={styles.pill}>Evaluar</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div style={styles.card}>
          <h3 style={styles.h3}>Evaluando Grupo {inscritas.find(g => g.id_grupo === selectedGrupo)?.nombreG || selectedGrupo}</h3>
          <form onSubmit={enviarEvaluacion}>
            {[0, 1, 2, 3, 4].map(i => (
              <div key={i} style={{ marginBottom: 10 }}>
                <label>Pregunta {i + 1} (1 - 5): </label>
                <input
                  type="number"
                  min="1"
                  max="5"
                  value={respuestas[i]}
                  onChange={e => {
                    const n = [...respuestas]
                    n[i] = parseInt(e.target.value)
                    setRespuestas(n)
                  }}
                  style={styles.input}
                />
              </div>
            ))}

            <div style={{ marginBottom: 10 }}>
              <label>Comentario: </label>
              <input value={comentario} onChange={e => setComentario(e.target.value)} style={{ ...styles.input, width: '100%' }} />
            </div>

            <div style={{ display: 'flex', gap: '10px' }}>
              <button type="submit" style={styles.button}>Enviar</button>
              <button type="button" onClick={() => setSelectedGrupo(null)} style={{ ...styles.button, background: '#ccc', color: '#333' }}>Cancelar</button>
            </div>
          </form>
        </div>
      )}
    </div>
  )
}

function Grupos() {
  const t = () => localStorage.getItem('access_token') || ''
  const [grupos, setGrupos] = useState([])
  const [filteredGrupos, setFilteredGrupos] = useState([])
  const [semestre, setSemestre] = useState('')
  const [grupo, setGrupo] = useState('')
  const [turno, setTurno] = useState('')
  const [carrera, setCarrera] = useState('')
  const [err, setErr] = useState('')

  useEffect(() => {
    const token = t()
    fetch(`${API}/alumno/grupos`, {
      headers: { Authorization: `Bearer ${token}` }
    })
      .then(async r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`)
        return r.json()
      })
      .then(data => {
        setGrupos(data || [])
        setFilteredGrupos(data || [])
      })
      .catch(e => {
        console.error(e)
        setErr('Error cargando grupos')
      })
  }, [])

  useEffect(() => {
    let filtered = [...grupos]
    if (semestre) filtered = filtered.filter(g => g.semestre?.toString() === semestre)
    if (grupo) filtered = filtered.filter(g => (g.nombreG || g.grupo || g.id_grupo)?.toString().toLowerCase().includes(grupo.toLowerCase()))
    if (turno) filtered = filtered.filter(g => g.turno === turno)
    if (carrera) {
      const needle = carrera.toLowerCase()
      filtered = filtered.filter(g => (g.carrera || g.carrera_clave || '').toLowerCase().includes(needle))
    }
    setFilteredGrupos(filtered)
  }, [semestre, grupo, turno, carrera, grupos])

  const limpiarFiltros = () => { setSemestre(''); setGrupo(''); setTurno(''); setCarrera('') }

  if (err) return <p style={styles.error}>{err}</p>

  return (
    <div>
      <h2 style={styles.h2}>Grupos</h2>
      <div style={styles.filtrosContainer}>
        <div style={styles.filtrosLabel}>Filtros:</div>
        <div style={styles.filtrosGrid}>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Semestre</label>
            <input
              value={semestre}
              onChange={e => setSemestre(e.target.value)}
              placeholder="1-12"
              style={styles.filtroInput}
            />
          </div>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Grupo</label>
            <input
              value={grupo}
              onChange={e => setGrupo(e.target.value)}
              placeholder="id grupo"
              style={styles.filtroInput}
            />
          </div>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Turno</label>
            <select
              value={turno}
              onChange={e => setTurno(e.target.value)}
              style={styles.filtroSelect}
            >
              <option value="">Todos</option>
              <option value="M">Matutino</option>
              <option value="V">Vespertino</option>
              <option value="N">Nocturno</option>
            </select>
          </div>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Carrera</label>
            <input
              value={carrera}
              onChange={e => setCarrera(e.target.value)}
              placeholder="IIA, ISC..."
              style={styles.filtroInput}
            />
          </div>
          <button onClick={limpiarFiltros} style={styles.clearBtn}>Limpiar</button>
        </div>
      </div>

      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Grupo</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Profesor</th>
              <th style={styles.th}>Créditos</th>
              <th style={styles.th}>Cupo</th>
              <th style={styles.th}>Horario</th>
            </tr>
          </thead>
          <tbody>
            {filteredGrupos.map((g, i) => (
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{g.nombreG || g.grupo || g.id_grupo}</td>
                <td style={styles.td}>{(g.materia_clave || g.clave) + ' ' + (g.materia_nombre || g.nombre)}</td>
                <td style={styles.td}>{g.profesor || '-'}</td>
                <td style={styles.td}>{g.creditos}</td>
                <td style={styles.td}>{g.cupo || g.lugares_disponibles || g.cupo_max || 30}</td>
                <td style={styles.td}>{g.horario || '-'}</td>
              </tr>
            ))}
            {filteredGrupos.length === 0 && (
              <tr>
                <td colSpan="6" style={{ ...styles.td, textAlign: 'center', padding: '32px', color: '#6a7aae' }}>
                  No se encontraron grupos con los filtros aplicados
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}


function Dashboard() {
  const [data, setData] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const t = localStorage.getItem('access_token') || ''

    // Fetch stats
    fetch(`${API}/alumno/stats/trend`, {
      headers: { Authorization: `Bearer ${t}` }
    })
      .then(r => r.json())
      .then(d => {
        if (Array.isArray(d)) {
          // Convertir promedio a float para recharts
          const formatted = d.map(item => ({
            ...item,
            promedio: parseFloat(item.promedio)
          }))
          setData(formatted)
        }
      })
      .catch(console.error)
      .finally(() => setLoading(false))
  }, [])

  if (loading) return <div style={styles.loading}>Cargando estadísticas...</div>

  return (
    <div>
      <h2 style={styles.h2}>Rendimiento Académico</h2>

      <div style={styles.card}>
        <h3 style={{ ...styles.cardTitle, marginBottom: '10px' }}>Tendencia de Promedio por Semestre</h3>
        <p style={{ color: '#aaa', marginBottom: '30px', fontSize: '14px' }}>
          Evolución de tu desempeño académico a través de los periodos cursados.
        </p>

        <div style={{ height: 400, width: '100%' }}>
          {data.length > 0 ? (
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={data} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                <defs>
                  <linearGradient id="colorPromedio" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#818cf8" stopOpacity={0.8} />
                    <stop offset="95%" stopColor="#818cf8" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <XAxis dataKey="periodo" stroke="#6a7aae" />
                <YAxis domain={[0, 10]} stroke="#6a7aae" />
                <CartesianGrid strokeDasharray="3 3" stroke="rgba(106, 122, 174, 0.2)" />
                <Tooltip
                  contentStyle={{ backgroundColor: 'rgba(30, 43, 79, 0.9)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '8px' }}
                  itemStyle={{ color: '#fff' }}
                  labelStyle={{ color: '#a8b2d1' }}
                />
                <Area
                  type="monotone"
                  dataKey="promedio"
                  stroke="#818cf8"
                  strokeWidth={3}
                  fillOpacity={1}
                  fill="url(#colorPromedio)"
                  activeDot={{ r: 8, strokeWidth: 0 }}
                />
              </AreaChart>
            </ResponsiveContainer>
          ) : (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%', color: '#6a7aae', flexDirection: 'column', gap: '10px' }}>
              <span style={{ fontSize: '40px' }}>📊</span>
              <span>No hay datos suficientes para mostrar la gráfica.</span>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

const styles = {
  container: { display: 'flex', height: '100vh', background: 'linear-gradient(135deg, #0f1620 0%, #1a2847 40%, #2d3a6a 100%)', color: '#ffffff', fontFamily: '"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif', position: 'relative', overflow: 'hidden' },
  floatingShapes: { position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', pointerEvents: 'none', zIndex: 1 },
  floatingSvg: { position: 'absolute', stroke: '#4a5a8e', transformStyle: 'preserve-3d' },
  svg0: { width: '180px', height: '180px', left: '5%', bottom: '-25%', animation: 'float1 20s infinite ease-in-out', opacity: 0.3 },
  svg1: { width: '140px', height: '140px', left: '20%', bottom: '-20%', animation: 'float2 22s infinite ease-in-out', opacity: 0.4 },
  svg2: { width: '160px', height: '160px', left: '40%', bottom: '-22%', animation: 'float3 24s infinite ease-in-out', opacity: 0.25 },
  svg3: { width: '120px', height: '120px', left: '60%', bottom: '-18%', animation: 'float4 18s infinite ease-in-out', opacity: 0.5 },
  svg4: { width: '150px', height: '150px', left: '75%', bottom: '-21%', animation: 'float1 21s infinite ease-in-out', opacity: 0.35 },
  svg5: { width: '130px', height: '130px', left: '85%', bottom: '-19%', animation: 'float2 23s infinite ease-in-out', opacity: 0.45 },
  sidebar: { width: '280px', background: 'linear-gradient(180deg, rgba(30, 43, 79, 0.95) 0%, rgba(42, 54, 88, 0.95) 100%)', backdropFilter: 'blur(20px)', borderRight: '1px solid rgba(106, 122, 174, 0.2)', display: 'flex', flexDirection: 'column', padding: '32px 20px', position: 'sticky', top: 0, height: '100vh', overflowY: 'auto', zIndex: 10, boxShadow: '4px 0 24px rgba(0, 0, 0, 0.3)' },
  sidebarHeader: { display: 'flex', flexDirection: 'column', alignItems: 'center', marginBottom: '40px', position: 'relative' },
  avatarGlow: { position: 'absolute', top: '-15px', left: '50%', transform: 'translateX(-50%)', width: '100px', height: '100px', background: 'radial-gradient(circle, rgba(106, 122, 174, 0.4) 0%, transparent 70%)', filter: 'blur(25px)', zIndex: -1 },
  avatar: { width: '80px', height: '80px', borderRadius: '50%', background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '40px', marginBottom: '16px', border: '3px solid rgba(106, 122, 174, 0.3)', boxShadow: '0 8px 32px rgba(106, 122, 174, 0.4)' },
  sidebarTitle: { fontSize: '20px', fontWeight: '700', color: '#ffffff', letterSpacing: '1px' },
  sidebarNav: { display: 'flex', flexDirection: 'column', gap: '12px', flex: 1 },
  pill: { background: 'rgba(58, 74, 122, 0.4)', border: '1px solid rgba(106, 122, 174, 0.3)', color: '#d1d5e8', padding: '14px 20px', borderRadius: '12px', cursor: 'pointer', transition: 'all 0.3s ease', fontSize: '14px', fontWeight: '500', textAlign: 'left', outline: 'none' },
  pillActive: { background: 'linear-gradient(135deg, rgba(106, 122, 174, 0.4) 0%, rgba(90, 106, 158, 0.4) 100%)', border: '1px solid rgba(106, 122, 174, 0.5)', boxShadow: '0 4px 20px rgba(106, 122, 174, 0.3)' },
  sidebarBottom: { display: 'flex', flexDirection: 'column', gap: '12px', marginTop: '20px', paddingTop: '20px', borderTop: '1px solid rgba(106, 122, 174, 0.2)' },
  pillDanger: { background: 'linear-gradient(135deg, rgba(185, 28, 28, 0.3) 0%, rgba(220, 38, 38, 0.3) 100%)', border: '1px solid rgba(220, 38, 38, 0.4)', color: '#ffb3b3', padding: '14px 20px', borderRadius: '12px', cursor: 'pointer', transition: 'all 0.3s ease', fontSize: '14px', fontWeight: '600', textAlign: 'left', outline: 'none' },
  main: { flex: 1, padding: '40px', overflowY: 'auto', position: 'relative', zIndex: 10 },
  h2: { fontSize: '32px', fontWeight: '700', marginBottom: '28px', background: 'linear-gradient(135deg, #ffffff 0%, #6a7aae 100%)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text', letterSpacing: '-1px' },
  h3: { fontSize: '22px', fontWeight: '600', marginTop: '32px', marginBottom: '16px', color: '#d1d5e8' },
  chatSection: { background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(20px)', borderRadius: '20px', border: '1px solid rgba(106, 122, 174, 0.2)', padding: '24px', display: 'flex', flexDirection: 'column', height: 'calc(100vh - 200px)', boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)' },
  chatScroll: { flex: 1, overflowY: 'auto', marginBottom: '20px', display: 'flex', flexDirection: 'column', gap: '12px', paddingRight: '8px' },
  msgBot: { background: 'linear-gradient(135deg, rgba(106, 122, 174, 0.3) 0%, rgba(90, 106, 158, 0.3) 100%)', border: '1px solid rgba(106, 122, 174, 0.3)', padding: '14px 18px', borderRadius: '16px 16px 16px 4px', maxWidth: '75%', alignSelf: 'flex-start', color: '#ffffff', fontSize: '15px', lineHeight: '1.5', boxShadow: '0 4px 12px rgba(0, 0, 0, 0.2)' },
  msgUser: { background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)', padding: '14px 18px', borderRadius: '16px 16px 4px 16px', maxWidth: '75%', alignSelf: 'flex-end', color: '#ffffff', fontSize: '15px', lineHeight: '1.5', boxShadow: '0 4px 12px rgba(106, 122, 174, 0.4)' },
  chatInput: { display: 'flex', gap: '12px', alignItems: 'flex-end' },
  textarea: { flex: 1, background: 'rgba(58, 74, 122, 0.4)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '12px', padding: '14px 16px', color: '#ffffff', fontSize: '15px', resize: 'none', minHeight: '50px', maxHeight: '120px', outline: 'none', fontFamily: 'inherit' },
  sendBtn: { background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)', border: 'none', color: '#ffffff', width: '50px', height: '50px', borderRadius: '12px', cursor: 'pointer', fontSize: '20px', transition: 'all 0.3s ease', boxShadow: '0 4px 16px rgba(106, 122, 174, 0.4)' },
  card: { background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(20px)', borderRadius: '20px', border: '1px solid rgba(106, 122, 174, 0.2)', padding: '32px', boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)' },
  dataGrid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px' },
  dataItem: { background: 'rgba(58, 74, 122, 0.3)', padding: '16px 20px', borderRadius: '12px', border: '1px solid rgba(106, 122, 174, 0.2)' },
  dataLabel: { color: '#6a7aae', fontSize: '13px', fontWeight: '600', display: 'block', marginBottom: '6px', letterSpacing: '0.5px' },
  dataValue: { color: '#ffffff', fontSize: '16px', fontWeight: '500' },
  tableWrap: { background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(20px)', borderRadius: '16px', border: '1px solid rgba(106, 122, 174, 0.2)', overflow: 'hidden', boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)' },
  table: { width: '100%', borderCollapse: 'collapse' },
  tableHeaderRow: { background: 'rgba(58, 74, 122, 0.5)' },
  th: { padding: '16px 20px', textAlign: 'left', color: '#6a7aae', fontWeight: '700', fontSize: '13px', letterSpacing: '1px', textTransform: 'uppercase', borderBottom: '2px solid rgba(106, 122, 174, 0.3)' },
  tableRow: { borderBottom: '1px solid rgba(106, 122, 174, 0.1)', transition: 'background 0.2s ease' },
  td: { padding: '16px 20px', color: '#d1d5e8', fontSize: '14px' },
  infoBar: { display: 'flex', gap: '24px', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', padding: '20px', background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(20px)', borderRadius: '16px', border: '1px solid rgba(106, 122, 174, 0.2)' },
  select: { background: 'rgba(58, 74, 122, 0.6)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '8px', padding: '8px 12px', color: '#ffffff', fontSize: '14px', outline: 'none', cursor: 'pointer' },
  input: { background: 'rgba(58, 74, 122, 0.6)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '8px', padding: '8px 12px', color: '#ffffff', fontSize: '14px', outline: 'none', width: '80px' },
  button: { background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)', border: 'none', color: '#ffffff', padding: '12px 28px', borderRadius: '10px', cursor: 'pointer', fontSize: '14px', fontWeight: '600', transition: 'all 0.3s ease', boxShadow: '0 4px 16px rgba(106, 122, 174, 0.4)' },
  iconBtn: { background: 'rgba(58, 74, 122, 0.6)', border: '1px solid rgba(106, 122, 174, 0.3)', color: '#ffffff', width: '36px', height: '36px', borderRadius: '8px', cursor: 'pointer', fontSize: '16px', transition: 'all 0.2s ease' },
  error: { background: 'rgba(220, 38, 38, 0.2)', border: '1px solid rgba(220, 38, 38, 0.4)', color: '#ffb3b3', padding: '14px 18px', borderRadius: '12px', fontSize: '14px', marginBottom: '16px' },
  success: { background: 'rgba(34, 197, 94, 0.2)', border: '1px solid rgba(34, 197, 94, 0.4)', color: '#86efac', padding: '14px 18px', borderRadius: '12px', fontSize: '14px', marginBottom: '16px' },
  loading: { color: '#6a7aae', fontSize: '16px', textAlign: 'center', padding: '40px' },
  filtrosContainer: { background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(20px)', borderRadius: '16px', border: '1px solid rgba(106, 122, 174, 0.2)', padding: '20px', marginBottom: '24px' },
  filtrosLabel: { color: '#6a7aae', fontSize: '14px', fontWeight: '600', marginBottom: '12px' },
  filtrosGrid: { display: 'flex', gap: '16px', flexWrap: 'wrap', alignItems: 'flex-end' },
  filtroItem: { display: 'flex', flexDirection: 'column', gap: '6px' },
  filtroLabel: { fontSize: '12px', color: '#d1d5e8' },
  filtroInput: { background: 'rgba(58, 74, 122, 0.6)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '8px', padding: '8px 12px', color: '#ffffff', fontSize: '14px', outline: 'none', width: '140px' },
  filtroSelect: { background: 'rgba(58, 74, 122, 0.6)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '8px', padding: '8px 12px', color: '#ffffff', fontSize: '14px', outline: 'none', cursor: 'pointer', width: '140px' },
  clearBtn: { background: 'rgba(58, 74, 122, 0.4)', border: '1px solid rgba(106, 122, 174, 0.3)', color: '#d1d5e8', padding: '8px 16px', borderRadius: '8px', cursor: 'pointer', fontSize: '13px', transition: 'all 0.2s ease', height: '35px' },
  grid: { display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '24px' },
  groupCard: { background: 'rgba(30, 43, 79, 0.6)', backdropFilter: 'blur(10px)', borderRadius: '16px', border: '1px solid rgba(106, 122, 174, 0.2)', padding: '24px', display: 'flex', flexDirection: 'column', position: 'relative', overflow: 'hidden' },
  cardHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' },
  cardTitle: { fontSize: '24px', fontWeight: '700', color: '#ffffff', margin: 0, background: 'linear-gradient(135deg, #ffffff 0%, #a5b4fc 100%)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' },
  inscritosBadge: { background: 'rgba(16, 185, 129, 0.2)', color: '#34d399', border: '1px solid rgba(16, 185, 129, 0.3)', padding: '4px 12px', borderRadius: '8px', fontSize: '14px', fontWeight: '700' },
  cardBody: { display: 'flex', flexDirection: 'column', gap: '12px' },
  cardInfo: { display: 'flex', alignItems: 'center', gap: '10px' },
  weekGrid: { display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: '20px', marginTop: '20px', overflowX: 'auto', paddingBottom: '20px' },
  dayColumn: { background: 'rgba(30, 43, 79, 0.4)', borderRadius: '16px', overflow: 'hidden', display: 'flex', flexDirection: 'column', border: '1px solid rgba(106, 122, 174, 0.2)', minHeight: '400px' },
  dayHeader: { padding: '16px', background: 'rgba(106, 122, 174, 0.15)', textAlign: 'center', fontWeight: '700', color: '#ffffff', borderBottom: '1px solid rgba(106, 122, 174, 0.2)', fontSize: '15px', textTransform: 'uppercase', letterSpacing: '1px' },
  dayContent: { padding: '16px', display: 'flex', flexDirection: 'column', gap: '16px', flex: 1 },
  classCard: { background: 'rgba(63, 81, 181, 0.2)', border: '1px solid rgba(129, 140, 248, 0.3)', borderRadius: '12px', padding: '16px', boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)', transition: 'transform 0.2s ease' },
  classTime: { fontSize: '13px', color: '#818cf8', fontWeight: '700', marginBottom: '6px', display: 'block', background: 'rgba(0, 0, 0, 0.2)', padding: '4px 8px', borderRadius: '6px', width: 'fit-content' },
  className: { fontSize: '14px', color: '#ffffff', fontWeight: '600', lineHeight: '1.4' },
  emptySlot: { textAlign: 'center', color: 'rgba(106, 122, 174, 0.4)', fontSize: '24px', marginTop: '40px', fontWeight: '300' }
}
