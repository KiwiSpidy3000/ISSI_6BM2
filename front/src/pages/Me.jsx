import { useEffect, useState } from 'react'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Me(){
  const [info,setInfo]=useState(null)
  const [err,setErr]=useState('')

  useEffect(()=>{
    const token = localStorage.getItem('access_token')
    if(!token){ setErr('No hay token, inicia sesión.'); return }
    fetch(`${API}/auth/me`,{
      headers:{ Authorization:`Bearer ${token}` }
    })
    .then(r=>r.json().then(d=>({ok:r.ok,data:d})))
    .then(({ok,data})=>{
      if(!ok) throw new Error(data?.error || 'Token inválido')
      setInfo(data.user)
    })
    .catch(e=>setErr(e.message))
  },[])

  return (
    <div className="container">
      <div className="card" style={{gridTemplateColumns:'1fr'}}>
        <div className="left">
          <h2 className="h2">Sesión</h2>
          {info ? (
            <pre>{JSON.stringify(info,null,2)}</pre>
          ) : (
            <p className="err">{err || 'Cargando…'}</p>
          )}
        </div>
      </div>
    </div>
  )
}
