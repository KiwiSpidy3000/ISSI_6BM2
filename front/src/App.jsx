import { Routes, Route, Navigate } from 'react-router-dom'
import Landing from './pages/Landing.jsx'
import Login from './pages/Login.jsx'
import Alumno from './pages/Alumno.jsx'   // <- cambia aquí

export default function App(){
  return (
    <Routes>
      <Route path="/" element={<Landing/>}/>
      <Route path="/login" element={<Login/>}/>
      <Route path="/me" element={<Alumno/>}/>   {/* antes era <Me/> */}
      <Route path="*" element={<Navigate to="/" replace/>}/>
    </Routes>
  )
}
