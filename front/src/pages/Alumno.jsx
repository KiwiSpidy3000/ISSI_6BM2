import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom' 
const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Alumno(){
const nav = useNavigate();   
  const [view, setView] = useState('chat') // 'chat' | 'perfil' | 'kardex' | 'horario'
  const [messages, setMessages] = useState([{ from:'bot', text:'¡Hola! ¿En qué te puedo ayudar?' }])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)

function logout(){                             // <- NUEVO
    localStorage.removeItem('access_token');
    nav('/'); // te manda a la landing "Bienvenido"
  }

  // ---- SCROLL CONTROL ----
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
        body: JSON.stringify({ message: clean })
      })
      const data = await res.json()
      setMessages(prev => [...prev, {from:'bot', text: data?.reply || 'Sin respuesta.'}])
    }catch{
      setMessages(prev => [...prev, {from:'bot', text:'AI service unavailable.'}])
    }finally{ setSending(false) }
  }
  function onKey(e){ if(e.key==='Enter' && !e.shiftKey){ e.preventDefault(); sendMessage() } }

  return (
    <div className="dashboard">
      {/* Sidebar */}
      <aside className="sb">
        <div className="sb-header">
          <div className="avatar">👤</div>
          <div className="sb-title">Alumno</div>
        </div>
        <nav className="sb-nav">
          <button className="pill" onClick={()=>setView('perfil')}>Datos Personales</button>
          <button className="pill" onClick={()=>setView('kardex')}>Kardex</button>
          <button className="pill" onClick={()=>setView('horario')}>Horario</button>
          <button className="pill" onClick={()=>setView('calificaciones')}>Calificaciones</button>
          <button className="pill" onClick={()=>setView('reins')}>Reinscripción</button>
          <button className="pill">Bajas</button>
          <button className="pill">Materias</button>
        </nav>
        <div className="sb-bottom">
          <button className={`pill ${view==='chat'?'active':''}`} onClick={()=>setView('chat')}>Chat Bot</button>
            <button className="pill danger" onClick={logout}>Cerrar sesión</button>   {/* <- NUEVO */}
        </div>
      </aside>

      {/* Main */}
      <main className="main">
        {view==='chat' && (
          <>
            <h2 className="h2">Chat Bot</h2>
            <section className="chat">
              <div className="chat-scroll" ref={scrollRef} onScroll={handleScroll}>
                {messages.map((m,i)=>(
                  <div key={i} className={`msg ${m.from}`}>{m.text}</div>
                ))}
              </div>
              <div className="chat-input">
                <textarea value={text} onChange={e=>setText(e.target.value)} onKeyDown={onKey}
                  placeholder="Escribe tu mensaje…" disabled={sending}/>
                <button className="send" onClick={sendMessage} disabled={sending}>▶</button>
              </div>
            </section>
          </>
        )}

        {view==='perfil'  && <DatosPersonales/>}
        {view==='kardex'  && <Kardex/>}
        {view==='horario' && <Horario/>}
        {view==='calificaciones' && <Calificaciones/>}
        {view==='reins' && <Reinscripcion/>}
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
  if(err) return <p className="err">{err}</p>
  if(!data) return <p>Cargando…</p>
  return (
    <div className="card" style={{gridTemplateColumns:'1fr'}}>
      <div className="left">
        <h2 className="h2">Datos Personales</h2>
        <p><b>Nombre:</b> {data.nombre_completo||'—'}</p>
        <p><b>Boleta:</b> {data.boleta||'—'}</p>
        <p><b>Email:</b> {data.email||'—'}</p>
        <p><b>Carrera:</b> {data.carrera||'—'} ({data.carrera_clave||'—'})</p>
        <p><b>Semestre:</b> {data.semestre||'—'}</p>
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
  if(err) return <p className="err">{err}</p>
  return (
    <>
      <h2 className="h2">Kardex</h2>
      <div className="tableWrap">
        <table className="tbl">
          <thead>
            <tr>
              <th>Periodo</th><th>Clave</th><th>Materia</th><th>Cr</th><th>Calif.</th><th>Estado</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r,i)=>(
              <tr key={i}>
                <td>{r.periodo}</td>
                <td>{r.materia_clave}</td>
                <td>{r.materia_nombre}</td>
                <td>{r.creditos}</td>
                <td>{r.calificacion ?? r.ordinario ?? '—'}</td>
                <td>{r.estado || '—'}</td>
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
    // perfil
    fetch(`${API}/alumno/profile`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setProfile(data): setErr(data?.error||'Error'))
    // periodos
    fetch(`${API}/alumno/periodos`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json())
      .then(list=>{
        setPeriodos(list)
        if(list?.length) setPeriodo(list[list.length-1]) // último por defecto
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

  // pivot a tabla por materia x día
  const dias = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado']
  const porMateria = {}
  rows.forEach(r=>{
    const key = `${r.materia_clave} ${r.materia_nombre}`
    if(!porMateria[key]) porMateria[key] = { materia:key, slots:{} }
    const hora = `${(r.hora_ini||'').slice(0,5)} - ${(r.hora_fin||'').slice(0,5)}`
    porMateria[key].slots[r.dia_semana] = hora // 1..6
  })
  const tabla = Object.values(porMateria)

  function descargar(){
    // versión simple: imprime solo la sección
    window.print()
  }

  if(err) return <p className="err">{err}</p>

  return (
    <div>
      <h2 className="h2" style={{textAlign:'center'}}>Horario</h2>

      <div style={{display:'flex',gap:16,alignItems:'center',margin:'8px 0 16px'}}>
        <div><b>Boleta:</b> {profile?.boleta||'—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo||'—'}</div>
        <div><b>Plantel:</b> ESCOM</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      <div className="tableWrap">
        <table className="tbl">
          <thead>
            <tr>
              <th>Materia</th>
              {dias.slice(0,5).map(d=><th key={d}>{d}</th>)}
            </tr>
          </thead>
          <tbody>
            {tabla.map((r,i)=>(
              <tr key={i}>
                <td>{r.materia}</td>
                {[1,2,3,4,5].map(d=> <td key={d}>{r.slots[d]||''}</td>)}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div style={{marginTop:12}}>
        <button className="btn" onClick={descargar}>Descargar horario</button>
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

  if(err) return <p className="err">{err}</p>

  return (
    <div>
      <h2 className="h2" style={{textAlign:'center'}}>Calificaciones</h2>

      <div style={{display:'flex',gap:16,alignItems:'center',margin:'8px 0 16px'}}>
        <div><b>Boleta:</b> {profile?.boleta||'—'}</div>
        <div><b>Nombre:</b> {profile?.nombre_completo||'—'}</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)}>
            <option value="" disabled>Selecciona</option>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
      </div>

      <div className="tableWrap">
        <table className="tbl">
          <thead>
            <tr>
              <th>Materia</th>
              <th>1er Parcial</th>
              <th>2do Parcial</th>
              <th>3er Parcial</th>
              <th>Final</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r,i)=>(
              <tr key={i}>
                <td>{`${r.materia_clave} ${r.materia_nombre}`}</td>
                <td>{r.p1 ?? ''}</td>
                <td>{r.p2 ?? ''}</td>
                <td>{r.ordinario ?? ''}</td>
                <td>{r.final_calc ?? r.ordinario ?? ''}</td>
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

  const semOpts = [...new Set(oferta.map(o=>o.semestre).filter(Boolean))] // si más tarde expones semestre desde el back

  return (
    <div>
      <h2 className="h2" style={{textAlign:'center'}}>Reinscripción</h2>

      <div style={{display:'flex',gap:20,alignItems:'center',marginBottom:10}}>
        <div><b>Créditos totales:</b> {resumen.total_creditos?.toFixed?.(2) ?? resumen.total_creditos}</div>
        <div><b>Créditos utilizados:</b> {resumen.creditos_usados?.toFixed?.(2) ?? resumen.creditos_usados}</div>
        <div>
          <b>Periodo:</b>{' '}
          <select value={periodo} onChange={e=>setPeriodo(e.target.value)}>
            {periodos.map(p=><option key={p} value={p}>{p}</option>)}
          </select>
        </div>
        <div>
          <b>Semestre:</b>{' '}
          <input value={semestre} onChange={e=>setSemestre(e.target.value)} placeholder="1..12" style={{width:60}}/>
        </div>
        <div>
          <b>Turno:</b>{' '}
          <select value={turno} onChange={e=>setTurno(e.target.value)}>
            <option value="">Todos</option>
            <option value="M">M</option><option value="V">V</option><option value="N">N</option>
          </select>
        </div>
        <button className="btn" onClick={confirmar}>Confirmar</button>
      </div>

      {msg && <p className="err">{msg}</p>}

      <h3 style={{marginTop:12}}>Materias Inscritas</h3>
      <div className="tableWrap">
        <table className="tbl">
          <thead><tr><th>Grupo</th><th>Materia</th><th>Profesor</th><th>Cr</th><th></th></tr></thead>
          <tbody>
            {inscritas.map((r,i)=>(
              <tr key={i}>
                <td>{r.id_grupo}</td>
                <td>{`${r.clave} ${r.nombre}`}</td>
                <td>{r.profesor||'—'}</td>
                <td>{r.creditos}</td>
                <td><button onClick={()=>delGrupo(r.id_grupo)}>🗑</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <h3 style={{marginTop:16}}>Oferta</h3>
      <div className="tableWrap">
        <table className="tbl">
          <thead><tr><th>Grupo</th><th>Materia</th><th>Profesor</th><th>Cr</th><th>Lugares</th><th></th></tr></thead>
          <tbody>
            {oferta.map((r,i)=>(
              <tr key={i}>
                <td>{r.id_grupo}</td>
                <td>{`${r.clave} ${r.nombre}`}</td>
                <td>{r.profesor||'—'}</td>
                <td>{r.creditos}</td>
                <td>{r.lugares_disponibles}</td>
                <td><button onClick={()=>addGrupo(r.id_grupo)}>＋</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
