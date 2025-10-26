import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function Login(){
  const [login, setLogin] = useState('')
  const [password, setPassword] = useState('')
  const [captcha, setCaptcha] = useState(false) // solo demo
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [okMsg, setOkMsg] = useState('')
  const nav = useNavigate()

  async function handleSubmit(e){
    e.preventDefault()
    setError(''); setOkMsg('')
    if(!captcha){ setError('Marca el captcha.'); return }
    if(!login || !password){ setError('Completa usuario y contraseña.'); return }

    setLoading(true)
    try{
      const res = await fetch(`${API}/auth/login`,{
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body: JSON.stringify({ login, password, captchaToken:'dummy' })
      })
      const data = await res.json()
      if(!res.ok){ throw new Error(data?.error || 'Error de autenticación') }
      localStorage.setItem('access_token', data.access_token)
      setOkMsg('¡Listo! Autenticación correcta.')
      setTimeout(()=> nav('/me'), 700)
    }catch(err){
      setError(err.message)
    }finally{
      setLoading(false)
    }
  }

  return (
    <div className="container">
      <div className="formCard">
        <div className="formLeft">
          <h2 className="h2">Iniciar Sesión</h2>
          <form className="form" onSubmit={handleSubmit}>
            <div className="row">
              <label>Usuario:</label>
              <input className="input" value={login} onChange={e=>setLogin(e.target.value)} placeholder="correo, boleta o usuario"/>
            </div>
            <div className="row">
              <label>Contraseña:</label>
              <input className="input" type="password" value={password} onChange={e=>setPassword(e.target.value)} placeholder="••••••••"/>
            </div>
            <div className="row">
              <Link className="link" to="#">Recuperar Contraseña</Link>
            </div>
            <div className="captcha">
              <input type="checkbox" checked={captcha} onChange={e=>setCaptcha(e.target.checked)}/>
              <span>No soy un robot (demo)</span>
            </div>

            {error && <div className="err">{error}</div>}
            {okMsg && <div className="success">{okMsg}</div>}

            <button className="btn" disabled={loading}>
              {loading ? 'Entrando…' : 'Entrar'}
            </button>
          </form>
        </div>
        <div className="formRight" aria-hidden="true"/>
      </div>
    </div>
  )
}
