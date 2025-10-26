import { useNavigate } from 'react-router-dom'

export default function Landing(){
  const nav = useNavigate()
  return (
    <div className="container">
      <div className="card">
        <div className="left">
          <h1 className="h1">¡Hola!</h1>
          <h2 className="h2">Bienvenido al SAES</h2>
          <p className="p">
            Aquí podrás consultar tus materias, horarios y calificaciones desde un solo lugar.
          </p>
          <button className="btn" onClick={()=>nav('/login')}>Iniciar Sesión</button>
        </div>
        <div className="right" aria-hidden="true" />
      </div>
    </div>
  )
}
