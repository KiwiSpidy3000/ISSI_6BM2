import { useEffect, useRef, useState } from 'react'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Alumno(){
  // estado del chat
  const [messages, setMessages] = useState([
    { from:'bot', text:'¡Hola! ¿En qué te puedo ayudar?' }
  ])
  const [text, setText] = useState('')
  const [sending, setSending] = useState(false)
  const endRef = useRef(null)

  // autoscroll al final
  useEffect(()=>{ endRef.current?.scrollIntoView({behavior:'smooth'}) }, [messages])

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
      const reply = data?.reply || 'Hubo un problema al obtener respuesta.'
      setMessages(prev => [...prev, {from:'bot', text: reply}])
    }catch(err){
      setMessages(prev => [...prev, {from:'bot', text:'AI service unavailable.'}])
    }finally{
      setSending(false)
    }
  }

  function onKey(e){
    if(e.key === 'Enter' && !e.shiftKey){
      e.preventDefault()
      sendMessage()
    }
  }

  return (
    <div className="dashboard">
      {/* Sidebar */}
      <aside className="sb">
        <div className="sb-header">
          <div className="avatar" aria-hidden="true">👤</div>
          <div className="sb-title">Alumno</div>
        </div>
        <nav className="sb-nav">
          <button className="pill">Datos Personales</button>
          <button className="pill">Kardex</button>
          <button className="pill">Horario</button>
          <button className="pill">Reinscripción</button>
          <button className="pill">Calificaciones</button>
          <button className="pill">Bajas</button>
          <button className="pill">Materias</button>
        </nav>
        <div className="sb-bottom">
          <button className="pill active">Chat Bot</button>
        </div>
      </aside>

      {/* Main */}
      <main className="main">
        <h2 className="h2">Chat Bot</h2>

        <section className="chat">
          <div className="chat-scroll">
            {messages.map((m, i)=>(
              <div key={i} className={`msg ${m.from}`}>
                {m.text}
              </div>
            ))}
            <div ref={endRef} />
          </div>

          <div className="chat-input">
            <textarea
              value={text}
              onChange={e=>setText(e.target.value)}
              onKeyDown={onKey}
              placeholder="Escribe tu mensaje…"
              disabled={sending}
            />
            <button className="send" onClick={sendMessage} disabled={sending} title="Enviar">
              ▶
            </button>
          </div>
        </section>
      </main>
    </div>
  )
}
