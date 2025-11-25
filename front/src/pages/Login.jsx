import { useState, useEffect } from 'react'

const API = import.meta.env?.VITE_API_URL || 'http://localhost:3000'

const images = [
  '/Images/EscomTarde.png',
  '/Images/Escom1.png',
  '/Images/Escom2.png'
]

// 🟢 CORRECCIÓN CLAVE: Estas rutas deben coincidir EXACTAMENTE con tu App.jsx
const ROUTES = {
  alumno: '/me',        // En tu App.jsx la ruta del alumno es "/me"
  profesor: '/profesor',// En tu App.jsx es "/profesor"
  admin: '/admin'       // En tu App.jsx es "/admin"
};

export default function Login() {
  const [login, setLogin] = useState('')
  const [password, setPassword] = useState('')

  // Nuevo estado para el rol (por defecto alumno)
  const [role, setRole] = useState('alumno')

  const [captcha, setCaptcha] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [okMsg, setOkMsg] = useState('')
  const [currentImage, setCurrentImage] = useState(0)

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentImage((prev) => (prev + 1) % images.length)
    }, 4000)
    return () => clearInterval(interval)
  }, [])

  useEffect(() => {
    const style = document.createElement('style')
    style.textContent = `
      @keyframes float1 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(80px, -140vh, 250px) rotate(120deg) scale(1.3); } 50% { transform: translate3d(-60px, -160vh, 400px) rotate(240deg) scale(0.9); } 75% { transform: translate3d(100px, -180vh, 300px) rotate(360deg) scale(1.1); } }
      @keyframes float2 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(-90px, -130vh, 280px) rotate(-120deg) scale(1.2); } 50% { transform: translate3d(70px, -155vh, 350px) rotate(-240deg) scale(1.4); } 75% { transform: translate3d(-80px, -175vh, 320px) rotate(-360deg) scale(0.95); } }
      @keyframes float3 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(85px, -145vh, 260px) rotate(110deg) scale(1.15); } 50% { transform: translate3d(-75px, -165vh, 380px) rotate(220deg) scale(1.35); } 75% { transform: translate3d(65px, -185vh, 290px) rotate(330deg) scale(1.05); } }
      @keyframes float4 { 0%, 100% { transform: translate3d(0, 0, 0) rotate(0deg) scale(1); } 25% { transform: translate3d(-95px, -135vh, 310px) rotate(-110deg) scale(1.25); } 50% { transform: translate3d(90px, -150vh, 370px) rotate(-220deg) scale(0.85); } 75% { transform: translate3d(-70px, -170vh, 340px) rotate(-330deg) scale(1.4); } }
    `
    document.head.appendChild(style)
    return () => document.head.removeChild(style)
  }, [])

  async function handleSubmit(e) {
    e.preventDefault()
    setError(''); setOkMsg('')

    if (!captcha) { setError('Marca el captcha.'); return }
    if (!login || !password) { setError('Completa usuario y contraseña.'); return }

    setLoading(true)
    try {
      const res = await fetch(`${API}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        // Nota: Enviamos el rol para validación en backend
        body: JSON.stringify({
          login,
          password,
          role: role.toUpperCase(), // 'ALUMNO', 'PROFESOR', 'ADMIN'
          captchaToken: 'SKIP_CAPTCHA'
        })
      })
      const data = await res.json()
      if (!res.ok) { throw new Error(data?.error || 'Error de autenticación') }

      localStorage.setItem('access_token', data.access_token)
      localStorage.setItem('user_role', role) // Guardamos el rol para uso futuro

      setOkMsg(`¡Bienvenido! Ingresando como ${role}...`)

      // 🟢 REDIRECCIÓN BASADA EN EL ROL SELECCIONADO
      setTimeout(() => {
        const path = ROUTES[role] || '/';
        window.location.href = path;
      }, 700)

    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div style={styles.container}>
      <div style={styles.floatingShapes}>
        {[...Array(20)].map((_, i) => (
          <svg key={i} style={{ ...styles.floatingSvg, ...styles[`svg${i % 10}`] }} xmlns="http://www.w3.org/2000/svg">
            <path d="m2.46177,126.39581c10.12618,-0.06577 20.25237,-0.13151 30.37857,-0.19726c0.06666,-10.3997 0.13333,-20.7994 0.19999,-31.19908c10.07782,0 20.15564,0 30.23346,0c0,-10.46351 0,-20.927 0,-31.39051c10.33589,0 20.67178,0 31.00767,0c0,-10.20827 0,-20.41656 0,-30.62485c10.20829,0 20.41656,0 30.62485,0c0,-10.20829 0,-20.41658 0,-30.62487c15.18483,0 30.36965,0 45.55448,0c0,5.10414 0,10.20829 0,15.31243c-10.08071,0 -20.16136,0 -30.24206,0c0,10.33589 0,20.67178 0,31.00769c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33589 0,20.67178 0,31.00767c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33591 0,20.6718 0,31.00767c-10.33589,0 -20.67178,0 -31.00767,0c0,10.46351 0,20.927 0,31.39049c-15.31243,0 -30.62485,0 -45.93728,0c0.68263,-5.07223 -1.16374,-10.79174 0.43769,-15.68938l0,0z" strokeWidth="7" fill="none" />
          </svg>
        ))}
      </div>

      {/* BOTONES DE ROL AGREGADOS */}
      <div style={styles.roleRow}>
        <button
          type="button"
          onClick={() => setRole('alumno')}
          style={role === 'alumno' ? styles.roleBtnActive : styles.roleBtn}
        >
          Soy Alumno
        </button>
        <button
          type="button"
          onClick={() => setRole('profesor')}
          style={role === 'profesor' ? styles.roleBtnActive : styles.roleBtn}
        >
          Soy Profesor
        </button>
        <button
          type="button"
          onClick={() => setRole('admin')}
          style={role === 'admin' ? styles.roleBtnSmallActive : styles.roleBtnSmall}
        >
          admin
        </button>
      </div>

      <div style={styles.card}>
        <div style={styles.leftPanel}>
          <div style={styles.imageCarousel}>
            {images.map((img, idx) => (
              <div
                key={idx}
                style={{
                  ...styles.carouselImage,
                  opacity: currentImage === idx ? 1 : 0,
                  backgroundImage: `url(${img})`
                }}
              />
            ))}
          </div>
          <div style={styles.overlay} />
        </div>

        <div style={styles.rightPanel}>
          <div style={styles.formContainer}>
            <div style={styles.header}>
              <h2 style={styles.title}>
                {role === 'admin' ? 'Admin Access' : role === 'profesor' ? 'Acceso Profesor' : 'Acceso Alumno'}
              </h2>
              <p style={styles.subtitle}>
                Sistema de Gestión Académica
              </p>
            </div>

            <div style={styles.formWrapper}>
              <div style={styles.inputGroup}>
                <input
                  style={styles.input}
                  value={login}
                  onChange={e => setLogin(e.target.value)}
                  placeholder={role === 'admin' ? "Usuario Admin" : "Boleta / Usuario"}
                />
              </div>

              <div style={styles.inputGroup}>
                <input
                  style={styles.input}
                  type="password"
                  value={password}
                  onChange={e => setPassword(e.target.value)}
                  placeholder="Contraseña"
                />
              </div>

              <div style={styles.captchaRow}>
                <label style={styles.captchaLabel}>
                  <input
                    type="checkbox"
                    checked={captcha}
                    onChange={e => setCaptcha(e.target.checked)}
                    style={styles.checkbox}
                  />
                  <span style={styles.captchaText}>No soy un robot</span>
                </label>
              </div>

              {error && <div style={styles.error}>{error}</div>}
              {okMsg && <div style={styles.success}>{okMsg}</div>}

              <button
                type="button"
                onClick={handleSubmit}
                style={styles.button}
                disabled={loading}
              >
                {loading ? 'Verificando...' : 'Ingresar'}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

const styles = {
  container: {
    minHeight: '100vh',
    display: 'flex',
    flexDirection: 'column', // Para apilar botones y card verticalmente
    alignItems: 'center',
    justifyContent: 'center',
    background: 'linear-gradient(135deg, #1a2847 0%, #2d3a6a 50%, #34446a 100%)',
    padding: '20px',
    fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    position: 'relative',
    overflow: 'hidden',
  },
  // ... (Mantén aquí tus estilos de svg0 a svg9, card, leftPanel, etc. intactos) ...
  floatingShapes: { position: 'absolute', top: 0, left: 0, width: '100%', height: '100%', pointerEvents: 'none' },
  floatingSvg: { position: 'absolute', stroke: '#4a5a8e', transformStyle: 'preserve-3d' },
  svg0: { width: '200px', height: '200px', left: '5%', bottom: '-25%', animation: 'float1 20s infinite ease-in-out', opacity: 0.6, stroke: '#4a5a8e' },
  svg1: { width: '150px', height: '150px', left: '15%', bottom: '-20%', animation: 'float2 22s infinite ease-in-out', opacity: 0.7, stroke: '#5a6a9e' },
  svg2: { width: '180px', height: '180px', left: '28%', bottom: '-22%', animation: 'float3 24s infinite ease-in-out', opacity: 0.5, stroke: '#3a4a7a' },
  svg3: { width: '130px', height: '130px', left: '42%', bottom: '-18%', animation: 'float4 18s infinite ease-in-out', opacity: 0.8, stroke: '#6a7aae' },
  svg4: { width: '170px', height: '170px', left: '55%', bottom: '-21%', animation: 'float1 21s infinite ease-in-out', opacity: 0.6, stroke: '#4a5a8e' },
  svg5: { width: '140px', height: '140px', left: '68%', bottom: '-19%', animation: 'float2 23s infinite ease-in-out', opacity: 0.65, stroke: '#5a6a9e' },
  svg6: { width: '160px', height: '160px', left: '80%', bottom: '-20%', animation: 'float3 25s infinite ease-in-out', opacity: 0.7, stroke: '#3a4a7a' },
  svg7: { width: '120px', height: '120px', left: '90%', bottom: '-15%', animation: 'float4 19s infinite ease-in-out', opacity: 0.75, stroke: '#6a7aae' },
  svg8: { width: '190px', height: '190px', left: '20%', bottom: '-24%', animation: 'float1 26s infinite ease-in-out', opacity: 0.55, stroke: '#7a8abe' },
  svg9: { width: '110px', height: '110px', left: '75%', bottom: '-16%', animation: 'float2 20s infinite ease-in-out', opacity: 0.8, stroke: '#5a6a9e' },

  card: { display: 'flex', maxWidth: '900px', width: '100%', borderRadius: '20px', overflow: 'hidden', boxShadow: '0 25px 80px rgba(0,0,0,0.4)', background: 'linear-gradient(180deg, #2d3a6a 0%, #34446a 100%)', position: 'relative', zIndex: 10 },
  leftPanel: { flex: '1', position: 'relative', padding: '40px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', overflow: 'hidden', minHeight: '400px' },
  imageCarousel: { position: 'absolute', top: 0, left: 0, width: '100%', height: '100%' },
  carouselImage: { position: 'absolute', top: 0, left: 0, width: '100%', height: '100%', backgroundSize: 'cover', backgroundPosition: 'center', transition: 'opacity 1.5s ease-in-out' },
  overlay: { position: 'absolute', top: 0, left: 0, width: '100%', height: '100%', background: 'linear-gradient(180deg, rgba(30, 43, 79, 0.4) 0%, rgba(42, 54, 88, 0.5) 100%)' },
  rightPanel: { flex: '1', background: 'linear-gradient(135deg, #1e2b4f 0%, #2a3658 100%)', padding: '40px', display: 'flex', alignItems: 'center' },
  formContainer: { width: '100%', maxWidth: '380px' },
  header: { marginBottom: '32px' },
  title: { color: '#ffffff', fontSize: '28px', fontWeight: '600', marginBottom: '8px' },
  subtitle: { color: '#a8b2d1', fontSize: '14px' },
  link: { color: '#6a7aae', textDecoration: 'none', fontWeight: '500', transition: 'color 0.2s' },
  formWrapper: { display: 'flex', flexDirection: 'column', gap: '16px' },
  inputGroup: { width: '100%' },
  input: { width: '100%', background: 'rgba(58, 74, 122, 0.4)', border: '1px solid rgba(106, 122, 174, 0.3)', borderRadius: '10px', padding: '13px 18px', color: '#ffffff', fontSize: '14px', outline: 'none', transition: 'all 0.3s', boxSizing: 'border-box' },
  captchaRow: { marginTop: '6px' },
  captchaLabel: { display: 'flex', alignItems: 'center', cursor: 'pointer' },
  checkbox: { width: '18px', height: '18px', marginRight: '10px', cursor: 'pointer', accentColor: '#6a7aae' },
  captchaText: { color: '#d1d5e8', fontSize: '14px' },
  button: { width: '100%', background: 'linear-gradient(135deg, #4a5a8e 0%, #5a6a9e 100%)', color: 'white', border: 'none', borderRadius: '10px', padding: '15px', fontSize: '15px', fontWeight: '600', cursor: 'pointer', transition: 'all 0.3s', marginTop: '12px', boxShadow: '0 4px 15px rgba(74, 90, 142, 0.3)' },
  error: { background: 'rgba(239, 68, 68, 0.15)', border: '1px solid rgba(239, 68, 68, 0.4)', color: '#ffb3b3', padding: '12px', borderRadius: '10px', fontSize: '14px' },
  success: { background: 'rgba(34, 197, 94, 0.15)', border: '1px solid rgba(34, 197, 94, 0.4)', color: '#a3f3c3', padding: '12px', borderRadius: '10px', fontSize: '14px' },

  // NUEVOS ESTILOS PARA LOS BOTONES DE ROL
  roleRow: { display: 'flex', gap: '10px', marginBottom: '20px', alignItems: 'center', flexWrap: 'wrap', zIndex: 20 },
  roleBtn: { background: 'rgba(106,122,174,0.1)', color: '#a8b2d1', border: '1px solid rgba(106,122,174,0.3)', borderRadius: '10px', padding: '10px 14px', fontSize: '14px', fontWeight: 600, cursor: 'pointer', transition: 'all 0.2s' },
  roleBtnActive: { background: 'linear-gradient(135deg, #4a5a8e 0%, #5a6a9e 100%)', color: '#fff', border: '1px solid #5a6a9e', borderRadius: '10px', padding: '10px 14px', fontSize: '14px', fontWeight: 600, cursor: 'pointer', boxShadow: '0 0 15px rgba(90, 106, 158, 0.5)', transform: 'scale(1.05)', transition: 'all 0.2s' },
  roleBtnSmall: { background: 'rgba(106,122,174,0.05)', color: '#6a7aae', border: '1px solid rgba(106,122,174,0.2)', borderRadius: '999px', padding: '6px 10px', fontSize: '12px', fontWeight: 700, cursor: 'pointer', marginLeft: 'auto' },
  roleBtnSmallActive: { background: '#6a7aae', color: '#fff', border: '1px solid #6a7aae', borderRadius: '999px', padding: '6px 10px', fontSize: '12px', fontWeight: 700, cursor: 'pointer', boxShadow: '0 0 10px rgba(106,122,174,0.5)' },
}