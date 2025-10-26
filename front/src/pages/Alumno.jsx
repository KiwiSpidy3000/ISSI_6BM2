import { useEffect, useRef, useState } from 'react'
const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Alumno(){
  const [view, setView] = useState('chat') // 'chat' | 'perfil' | 'kardex' | 'horario'
  const [messages, setMessages] = useState([{ from:'bot', text:'¡Hola! ¿En qué te puedo ayudar?' }])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)

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
          <button className="pill">Reinscripción</button>
          <button className="pill">Calificaciones</button>
          <button className="pill">Bajas</button>
          <button className="pill">Materias</button>
        </nav>
        <div className="sb-bottom">
          <button className={`pill ${view==='chat'?'active':''}`} onClick={()=>setView('chat')}>Chat Bot</button>
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
  const [rows,setRows]=useState([])
  const [err,setErr]=useState('')
  useEffect(()=>{
    const t = localStorage.getItem('access_token')||''
    fetch(`${API}/alumno/horario`,{headers:{Authorization:`Bearer ${t}`}})
      .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
      .then(({ok,data})=> ok? setRows(data): setErr(data?.error||'Error'))
      .catch(()=>setErr('Error de red'))
  },[])
  if(err) return <p className="err">{err}</p>
  return (
    <>
      <h2 className="h2">Horario</h2>
      <div className="tableWrap">
        <table className="tbl">
          <thead>
            <tr>
              <th>Día</th><th>Inicio</th><th>Fin</th><th>Aula</th><th>Clave</th><th>Materia</th><th>Profesor</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r,i)=>(
              <tr key={i}>
                <td>{r.dia_semana}</td>
                <td>{r.hora_ini?.slice(0,5)}</td>
                <td>{r.hora_fin?.slice(0,5)}</td>
                <td>{r.aula || '—'}</td>
                <td>{r.materia_clave}</td>
                <td>{r.materia_nombre}</td>
                <td>{r.profesor || '—'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  )
}



