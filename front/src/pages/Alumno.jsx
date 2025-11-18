import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom' 
const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Alumno(){
  const nav = useNavigate();   
  const [view, setView] = useState('chat')
  const [messages, setMessages] = useState([{ from:'bot', text:'¡Hola! ¿En qué te puedo ayudar?' }])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)

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
      @keyframes glow {
        0%, 100% { box-shadow: 0 8px 32px rgba(106, 122, 174, 0.4); }
        50% { box-shadow: 0 12px 48px rgba(106, 122, 174, 0.6); }
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

  function logout(){
    localStorage.removeItem('access_token');
    nav('/');
  }

  const scrollRef = useRef(null)
  const [stickBottom, setStickBottom] = useState(true)

  function handleScroll(){
    const el = scrollRef.current
    if(!el) return
    const nearBottom = el.scrollHeight - el.scrollTop - el.clientHeight < 80
    setStickBottom(nearBottom)
  }

  useEffect(()=>{
    const el = scrollRef.current
    if(el && stickBottom){
      el.scrollTop = el.scrollHeight
    }
  }, [messages, stickBottom])

  async function sendMessage(){
    const clean = text.trim()
    if(!clean || sending) return
    setSending(true)
    setMessages(prev => [...prev, {from:'user', text: clean}])
    setText('')
    try{
      const token = localStorage.getItem('access_token') || ''
      const res = await fetch(`${API}/ai/chat`, {
        method:'POST',
        headers:{ 'Content-Type':'application/json', ...(token? {Authorization:`Bearer ${token}`} : {}) },
        body: JSON.stringify({ pregunta: clean })
      });

      if (!res.ok) {
        const raw = await res.text();
        throw new Error(`HTTP ${res.status} ${raw}`);
      }

      const data = await res.json();
      const reply = data.reply ?? data.respuesta ?? 'Hay no se, siguiente pregunta';
      setMessages(prev => [...prev, { from:'bot', text: reply }]);
    }catch{
      setMessages(prev => [...prev, {from:'bot', text:'AI service unavailable.'}])
    }finally{ setSending(false) }
  }
  
  function onKey(e){ if(e.key==='Enter' && !e.shiftKey){ e.preventDefault(); sendMessage() } }

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
          <div style={styles.sidebarTitle}>Alumno</div>
        </div>
        
        <nav style={styles.sidebarNav}>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('perfil')}>Datos Personales</button>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('kardex')}>Kardex</button>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('horario')}>Horario</button>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('calificaciones')}>Calificaciones</button>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('reins')}>Reinscripción</button>
          <button style={styles.pill} className="pill-hover" onClick={()=>setView('bajas')}>Bajas</button>
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
        {view==='chat' && (
          <>
            <h2 style={styles.h2}>Chat Bot</h2>
            <section style={styles.chatSection}>
              <div style={styles.chatScroll} ref={scrollRef} onScroll={handleScroll}>
                {messages.map((m,i)=>(
                  <div key={i} style={m.from === 'user' ? styles.msgUser : styles.msgBot}>
                    {m.text}
                  </div>
                ))}
              </div>
              <div style={styles.chatInput}>
                <textarea 
                  value={text} 
                  onChange={e=>setText(e.target.value)} 
                  onKeyDown={onKey}
                  placeholder="Escribe tu mensaje…" 
                  disabled={sending}
                  style={styles.textarea}
                />
                <button style={styles.sendBtn} onClick={sendMessage} disabled={sending}>▶</button>
              </div>
            </section>
          </>
        )}

        {view==='perfil'  && <DatosPersonales/>}
        {view==='kardex'  && <Kardex/>}
        {view==='horario' && <Horario/>}
        {view==='calificaciones' && <Calificaciones/>}
        {view==='reins' && <Reinscripcion/>}
        {view==='bajas' && <Bajas/>}
        {view==='grupos' && <Grupos/>}
      </main>
    </div>
  )
}

function DatosPersonales(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const [data,setData]=useState(null)
  const [err,setErr]=useState('')
  
  useEffect(()=>{
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/profile`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setData(data): setErr(data?.error||'Error'))
      .catch(()=>setErr('Error de red'))
  },[])
  
  if(err) return <p style={styles.error}>{err}</p>
  if(!data) return <p style={styles.loading}>Cargando…</p>
  
  return (
    <div style={styles.card}>
      <h2 style={styles.h2}>Datos Personales</h2>
      <div style={styles.dataGrid}>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Nombre:</span>
          <span style={styles.dataValue}>{data.nombre_completo||'—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Boleta:</span>
          <span style={styles.dataValue}>{data.boleta||'—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Email:</span>
          <span style={styles.dataValue}>{data.email||'—'}</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Carrera:</span>
          <span style={styles.dataValue}>{data.carrera||'—'} ({data.carrera_clave||'—'})</span>
        </div>
        <div style={styles.dataItem}>
          <span style={styles.dataLabel}>Semestre:</span>
          <span style={styles.dataValue}>{data.semestre||'—'}</span>
        </div>
      </div>
    </div>
  )
}

function Kardex(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const [rows,setRows]=useState([])
  const [err,setErr]=useState('')
  
  useEffect(()=>{
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/kardex`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setRows(data): setErr(data?.error||'Error'))
      .catch(()=>setErr('Error de red'))
  },[])
  
  if(err) return <p style={styles.error}>{err}</p>
  
  return (
    <>
      <h2 style={styles.h2}>Kardex</h2>
      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Periodo</th>
              <th style={styles.th}>Clave</th>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>Cr</th>
              <th style={styles.th}>Calif.</th>
              <th style={styles.th}>Estado</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.periodo}</td>
                <td style={styles.td}>{r.materia_clave}</td>
                <td style={styles.td}>{r.materia_nombre}</td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>{r.calificacion ?? r.ordinario ?? '—'}</td>
                <td style={styles.td}>{r.estado || '—'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  )
}

function Horario(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const [profile, setProfile] = useState(null)
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [rows, setRows] = useState([])
  const [err, setErr] = useState('')

  useEffect(()=>{
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/profile`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setProfile(data): setErr(data?.error||'Error'))
    fetch(`${API}/alumno/periodos`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json())
      .then(list=>{
        setPeriodos(list)
        if(list?.length) setPeriodo(list[list.length-1])
      })
  },[])

  useEffect(()=>{
    if(!periodo) return
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/horario?periodo=${encodeURIComponent(periodo)}`,{
      headers:{Authorization:`Bearer ${t}`}
    })
    .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
    .then(({ok,data})=> ok? setRows(data): setErr(data?.error||'Error'))
    .catch(()=>setErr('Error de red'))
  },[periodo])

  const dias = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado']
  const porMateria = {}
  rows.forEach(r=>{
    const key = `${r.materia_clave} ${r.materia_nombre}`
    if(!porMateria[key]) porMateria[key] = { materia:key, slots:{} }
    const hora = `${(r.hora_ini||'').slice(0,5)} - ${(r.hora_fin||'').slice(0,5)}`
    porMateria[key].slots[r.dia_semana] = hora
  })
  const tabla = Object.values(porMateria)

  function descargar(){ window.print() }

  if(err) return <p style={styles.error}>{err}</p>

  return (
    <div>
      <h2 style={styles.h2}>Horario</h2>

      <div style={styles.infoBar}>
        <div><b>Boleta:</b> {profile?.boleta||'—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo||'—'}</div>
        <div><b>Plantel:</b> ESCOM</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)} style={styles.select}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Materia</th>
              {dias.slice(0,5).map(d=><th key={d} style={styles.th}>{d}</th>)}
            </tr>
          </thead>
          <tbody>
            {tabla.map((r,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.materia}</td>
                {[1,2,3,4,5].map(d=> <td key={d} style={styles.td}>{r.slots[d]||''}</td>)}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div style={{marginTop:20}}>
        <button style={styles.button} onClick={descargar}>Descargar horario</button>
      </div>
    </div>
  )
}

function Calificaciones(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const [profile, setProfile] = useState(null)
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [rows, setRows] = useState([])
  const [err, setErr] = useState('')

  useEffect(()=>{
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/profile`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setProfile(data): setErr(data?.error||'Error'))
    fetch(`${API}/alumno/periodos`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json())
      .then(list=>{
        setPeriodos(list)
        if(list?.length) setPeriodo(list[list.length-1])
      })
  },[])

  useEffect(()=>{
    if(!periodo) return
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/calificaciones?periodo=${encodeURIComponent(periodo)}`,{
      headers:{Authorization:`Bearer ${t}`}
    })
    .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
    .then(({ok,data})=> ok? setRows(data): setErr(data?.error||'Error'))
    .catch(()=>setErr('Error de red'))
  },[periodo])

  if(err) return <p style={styles.error}>{err}</p>

  return (
    <div>
      <h2 style={styles.h2}>Calificaciones</h2>

      <div style={styles.infoBar}>
        <div><b>Boleta:</b> {profile?.boleta||'—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo||'—'}</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)} style={styles.select}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      <div style={styles.tableWrap}>
        <table style={styles.table}>
          <thead>
            <tr style={styles.tableHeaderRow}>
              <th style={styles.th}>Materia</th>
              <th style={styles.th}>1er Parcial</th>
              <th style={styles.th}>2do Parcial</th>
              <th style={styles.th}>3er Parcial</th>
              <th style={styles.th}>Final</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{`${r.materia_clave} ${r.materia_nombre}`}</td>
                <td style={styles.td}>{r.p1 ?? ''}</td>
                <td style={styles.td}>{r.p2 ?? ''}</td>
                <td style={styles.td}>{r.ordinario ?? ''}</td>
                <td style={styles.td}>{r.final_calc ?? r.ordinario ?? ''}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Reinscripcion(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const t = () => localStorage.getItem('access_token')||''
  const [periodos,setPeriodos]=useState([])
  const [periodo,setPeriodo]=useState('')
  const [semestre,setSemestre]=useState('')
  const [turno,setTurno]=useState('')
  const [inscritas,setInscritas]=useState([])
  const [oferta,setOferta]=useState([])
  const [resumen,setResumen]=useState({total_creditos:0,creditos_usados:0})
  const [msg,setMsg]=useState('')

  useEffect(()=>{
    fetch(`${API}/alumno/periodos`,{headers:{Authorization:`Bearer ${t()}`}})
      .then(r=>r.json()).then(list=>{
        setPeriodos(list); if(list?.length) setPeriodo(list[list.length-1])
      })
  },[])

  useEffect(()=>{ if(!periodo) return; refresh() },[periodo,semestre,turno])

  function refresh(){
    const hdr={headers:{Authorization:`Bearer ${t()}`}}
    fetch(`${API}/alumno/reins/resumen?periodo=${periodo}`,hdr).then(r=>r.json()).then(setResumen)
    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}`,hdr).then(r=>r.json()).then(setInscritas)
    const qs = new URLSearchParams({periodo, ...(semestre?{semestre}:{}) , ...(turno?{turno}:{}) })
    fetch(`${API}/alumno/reins/oferta?${qs.toString()}`,hdr).then(r=>r.json()).then(setOferta)
  }

  async function addGrupo(id_grupo){
    setMsg('')
    const r = await fetch(`${API}/alumno/reins/conflictos?id_grupo=${id_grupo}`,{
      headers:{Authorization:`Bearer ${t()}`}
    }); const choques = await r.json()
    if(choques.length){ setMsg('Choque de horario'); return }
    await fetch(`${API}/alumno/reins/preinscribir`,{
      method:'POST', headers:{'Content-Type':'application/json',Authorization:`Bearer ${t()}`},
      body: JSON.stringify({id_grupo})
    })
    refresh()
  }
  
  async function delGrupo(id_grupo){
    await fetch(`${API}/alumno/reins/preinscribir/${id_grupo}`,{
      method:'DELETE', headers:{Authorization:`Bearer ${t()}`}
    })
    refresh()
  }
  
  async function confirmar(){
    await fetch(`${API}/alumno/reins/confirmar`,{
      method:'POST', headers:{'Content-Type':'application/json',Authorization:`Bearer ${t()}`},
      body: JSON.stringify({periodo})
    })
    refresh()
  }

  return (
    <div>
      <h2 style={styles.h2}>Reinscripción</h2>

      <div style={styles.infoBar}>
        <div><b>Créditos totales:</b> {resumen.total_creditos?.toFixed?.(2) ?? resumen.total_creditos}</div>
        <div><b>Créditos utilizados:</b> {resumen.creditos_usados?.toFixed?.(2) ?? resumen.creditos_usados}</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)} style={styles.select}>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b>Semestre:</b>{' '}
          <input value={semestre} onChange={e=>setSemestre(e.target.value)} placeholder="1..12" style={styles.input}/>
        </div>
        <div>
          <b>Turno:</b>{' '}
          <select value={turno} onChange={e=>setTurno(e.target.value)} style={styles.select}>
            <option value="">Todos</option>
            <option value="M">M</option><option value="V">V</option><option value="N">N</option>
          </select>
        </div>
        <button style={styles.button} onClick={confirmar}>Confirmar</button>
      </div>

      {msg && <p style={styles.error}>{msg}</p>}

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
            {inscritas.map((r,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.id_grupo}</td>
                <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                <td style={styles.td}>{r.profesor||'—'}</td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>
                  <button onClick={()=>delGrupo(r.id_grupo)} style={styles.iconBtn}>🗑</button>
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
              <th style={styles.th}>Cr</th>
              <th style={styles.th}>Lugares</th>
              <th style={styles.th}></th>
            </tr>
          </thead>
          <tbody>
            {oferta.map((r,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{r.id_grupo}</td>
                <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                <td style={styles.td}>{r.profesor||'—'}</td>
                <td style={styles.td}>{r.creditos}</td>
                <td style={styles.td}>{r.lugares_disponibles}</td>
                <td style={styles.td}>
                  <button onClick={()=>addGrupo(r.id_grupo)} style={styles.iconBtn}>＋</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function Bajas(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const t = () => localStorage.getItem('access_token')||''
  const [periodos, setPeriodos] = useState([])
  const [periodo, setPeriodo] = useState('')
  const [inscritas, setInscritas] = useState([])
  const [solicitudes, setSolicitudes] = useState([])
  const [fechaLimite, setFechaLimite] = useState('')
  const [cargaMinima, setCargaMinima] = useState(0)
  const [msg, setMsg] = useState('')
  const [err, setErr] = useState('')

  useEffect(()=>{
    fetch(`${API}/alumno/periodos`,{headers:{Authorization:`Bearer ${t()}`}})
      .then(r=>r.json()).then(list=>{
        setPeriodos(list)
        if(list?.length) setPeriodo(list[list.length-1])
      })
  },[])

  useEffect(()=>{ 
    if(!periodo) return
    refresh()
  },[periodo])

  function refresh(){
    const hdr={headers:{Authorization:`Bearer ${t()}`}}
    
    // Obtener materias inscritas actuales
    fetch(`${API}/alumno/reins/inscritas?periodo=${periodo}`,hdr)
      .then(r=>r.json())
      .then(setInscritas)
      .catch(()=>setErr('Error cargando materias'))

    // Obtener solicitudes de baja pendientes (simulado - ajusta según tu API)
    fetch(`${API}/alumno/bajas/solicitudes?periodo=${periodo}`,hdr)
      .then(r=>r.json())
      .then(setSolicitudes)
      .catch(()=>setSolicitudes([]))

    // Obtener información del periodo
    fetch(`${API}/alumno/bajas/info?periodo=${periodo}`,hdr)
      .then(r=>r.json())
      .then(data=>{
        setFechaLimite(data.fecha_limite || '25/05/2025')
        setCargaMinima(data.carga_minima || 33.33)
      })
      .catch(()=>{
        setFechaLimite('25/05/2025')
        setCargaMinima(33.33)
      })
  }

  async function solicitarBaja(id_grupo, materia_clave, materia_nombre){
    setMsg('')
    setErr('')
    
    try {
      const res = await fetch(`${API}/alumno/bajas/solicitar`,{
        method:'POST',
        headers:{'Content-Type':'application/json', Authorization:`Bearer ${t()}`},
        body: JSON.stringify({
          periodo,
          id_grupo,
          materia_clave,
          materia_nombre
        })
      })
      
      const data = await res.json()
      
      if(!res.ok){
        setErr(data.error || 'Error al solicitar baja')
        return
      }
      
      setMsg('Solicitud de baja enviada. Pendiente de aprobación.')
      refresh()
    } catch(error) {
      setErr('Error de red al solicitar baja')
    }
  }

  const getEstadoStyle = (estado) => {
    switch(estado){
      case 'pendiente':
        return {background: 'rgba(234, 179, 8, 0.2)', color: '#fbbf24', padding: '4px 12px', borderRadius: '8px', fontSize: '12px', fontWeight: '600'}
      case 'aprobada':
        return {background: 'rgba(34, 197, 94, 0.2)', color: '#4ade80', padding: '4px 12px', borderRadius: '8px', fontSize: '12px', fontWeight: '600'}
      case 'rechazada':
        return {background: 'rgba(239, 68, 68, 0.2)', color: '#f87171', padding: '4px 12px', borderRadius: '8px', fontSize: '12px', fontWeight: '600'}
      default:
        return {padding: '4px 12px'}
    }
  }

  if(err) return <p style={styles.error}>{err}</p>

  return (
    <div>
      <h2 style={styles.h2}>Baja de materias</h2>

      <div style={styles.infoBar}>
        <div><b>Fecha Límite:</b> {fechaLimite}</div>
        <div><b>Carga Mínima:</b> {cargaMinima} créditos</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)} style={styles.select}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      {msg && <div style={styles.success}>{msg}</div>}

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
            {inscritas.map((r,i)=>{
              const tieneSolicitud = solicitudes.some(s => s.id_grupo === r.id_grupo && s.estado === 'pendiente')
              return (
                <tr key={i} style={styles.tableRow}>
                  <td style={styles.td}>{r.id_grupo}</td>
                  <td style={styles.td}>{`${r.clave} ${r.nombre}`}</td>
                  <td style={styles.td}>{r.profesor||'—'}</td>
                  <td style={styles.td}>{r.creditos}</td>
                  <td style={styles.td}>
                    {tieneSolicitud ? (
                      <span style={{color: '#fbbf24', fontSize: '13px'}}>⏳ Pendiente</span>
                    ) : (
                      <button 
                        onClick={()=>solicitarBaja(r.id_grupo, r.clave, r.nombre)} 
                        style={styles.iconBtn}
                        title="Solicitar baja"
                      >
                        ⊖
                      </button>
                    )}
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>

      {solicitudes.length > 0 && (
        <>
          <h3 style={styles.h3}>Solicitudes de baja</h3>
          <div style={styles.tableWrap}>
            <table style={styles.table}>
              <thead>
                <tr style={styles.tableHeaderRow}>
                  <th style={styles.th}>Grupo</th>
                  <th style={styles.th}>Materia</th>
                  <th style={styles.th}>Fecha Solicitud</th>
                  <th style={styles.th}>Estado</th>
                  <th style={styles.th}>Comentarios</th>
                </tr>
              </thead>
              <tbody>
                {solicitudes.map((s,i)=>(
                  <tr key={i} style={styles.tableRow}>
                    <td style={styles.td}>{s.id_grupo}</td>
                    <td style={styles.td}>{`${s.materia_clave} ${s.materia_nombre}`}</td>
                    <td style={styles.td}>{s.fecha_solicitud || '—'}</td>
                    <td style={styles.td}>
                      <span style={getEstadoStyle(s.estado)}>
                        {s.estado?.toUpperCase() || 'PENDIENTE'}
                      </span>
                    </td>
                    <td style={styles.td}>{s.comentarios || '—'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      )}
    </div>
  )
}

function Grupos(){
  const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'
  const t = () => localStorage.getItem('access_token')||''
  const [grupos, setGrupos] = useState([])
  const [filteredGrupos, setFilteredGrupos] = useState([])
  const [semestre, setSemestre] = useState('')
  const [grupo, setGrupo] = useState('')
  const [turno, setTurno] = useState('')
  const [carrera, setCarrera] = useState('')
  const [err, setErr] = useState('')

  useEffect(()=>{
    fetch(`${API}/alumno/grupos`,{headers:{Authorization:`Bearer ${t()}`}})
      .then(r=>r.json())
      .then(data=>{
        setGrupos(data)
        setFilteredGrupos(data)
      })
      .catch(()=>setErr('Error cargando grupos'))
  },[])

  useEffect(()=>{
    let filtered = [...grupos]
    
    if(semestre){
      filtered = filtered.filter(g => g.semestre?.toString() === semestre)
    }
    if(grupo){
      filtered = filtered.filter(g => g.grupo?.toLowerCase().includes(grupo.toLowerCase()))
    }
    if(turno){
      filtered = filtered.filter(g => g.turno === turno)
    }
    if(carrera){
      filtered = filtered.filter(g => g.carrera?.toLowerCase().includes(carrera.toLowerCase()))
    }
    
    setFilteredGrupos(filtered)
  },[semestre, grupo, turno, carrera, grupos])

  const limpiarFiltros = () => {
    setSemestre('')
    setGrupo('')
    setTurno('')
    setCarrera('')
  }

  if(err) return <p style={styles.error}>{err}</p>

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
              onChange={e=>setSemestre(e.target.value)} 
              placeholder="1-12" 
              style={styles.filtroInput}
            />
          </div>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Grupo</label>
            <input 
              value={grupo} 
              onChange={e=>setGrupo(e.target.value)} 
              placeholder="1BM1, 2CV3..." 
              style={styles.filtroInput}
            />
          </div>
          <div style={styles.filtroItem}>
            <label style={styles.filtroLabel}>Turno</label>
            <select value={turno} onChange={e=>setTurno(e.target.value)} style={styles.filtroSelect}>
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
              onChange={e=>setCarrera(e.target.value)} 
              placeholder="ISC, LCD..." 
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
            </tr>
          </thead>
          <tbody>
            {filteredGrupos.map((g,i)=>(
              <tr key={i} style={styles.tableRow}>
                <td style={styles.td}>{g.grupo || g.id_grupo}</td>
                <td style={styles.td}>{`${g.materia_clave || g.clave} ${g.materia_nombre || g.nombre}`}</td>
                <td style={styles.td}>{g.profesor || '—'}</td>
                <td style={styles.td}>{g.creditos}</td>
                <td style={styles.td}>{g.cupo || g.lugares_disponibles || 30}</td>
              </tr>
            ))}
            {filteredGrupos.length === 0 && (
              <tr>
                <td colSpan="5" style={{...styles.td, textAlign: 'center', padding: '32px', color: '#6a7aae'}}>
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

const styles = {
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
  },
  h3: {
    fontSize: '22px',
    fontWeight: '600',
    marginTop: '32px',
    marginBottom: '16px',
    color: '#d1d5e8',
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
  card: {
    background: 'rgba(30, 43, 79, 0.6)',
    backdropFilter: 'blur(20px)',
    borderRadius: '20px',
    border: '1px solid rgba(106, 122, 174, 0.2)',
    padding: '32px',
    boxShadow: '0 8px 32px rgba(0, 0, 0, 0.3)',
  },
  dataGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
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
  input: {
    background: 'rgba(58, 74, 122, 0.6)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    borderRadius: '8px',
    padding: '8px 12px',
    color: '#ffffff',
    fontSize: '14px',
    outline: 'none',
    width: '80px',
  },
  button: {
    background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)',
    border: 'none',
    color: '#ffffff',
    padding: '12px 28px',
    borderRadius: '10px',
    cursor: 'pointer',
    fontSize: '14px',
    fontWeight: '600',
    transition: 'all 0.3s ease',
    boxShadow: '0 4px 16px rgba(106, 122, 174, 0.4)',
  },
  iconBtn: {
    background: 'rgba(58, 74, 122, 0.6)',
    border: '1px solid rgba(106, 122, 174, 0.3)',
    color: '#ffffff',
    width: '36px',
    height: '36px',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '16px',
    transition: 'all 0.2s ease',
  },
  error: {
    background: 'rgba(220, 38, 38, 0.2)',
    border: '1px solid rgba(220, 38, 38, 0.4)',
    color: '#ffb3b3',
    padding: '14px 18px',
    borderRadius: '12px',
    fontSize: '14px',
    marginBottom: '16px',
  },
  loading: {
    color: '#6a7aae',
    fontSize: '16px',
    textAlign: 'center',
    padding: '40px',
  },
}