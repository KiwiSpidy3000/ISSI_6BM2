import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

export default function Landing() {
  const nav = useNavigate();


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
        0%, 100% { box-shadow: 0 8px 32px rgba(106, 122, 174, 0.4), 0 0 60px rgba(106, 122, 174, 0.2); }
        50% { box-shadow: 0 12px 48px rgba(106, 122, 174, 0.6), 0 0 80px rgba(106, 122, 174, 0.4); }
      }
      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      @keyframes shimmer {
        0% { background-position: -1000px 0; }
        100% { background-position: 1000px 0; }
      }
      .btn-hover:hover {
        transform: translateY(-4px) scale(1.05);
        box-shadow: 0 16px 56px rgba(106, 122, 174, 0.6), 0 0 100px rgba(106, 122, 174, 0.5) !important;
      }
      .btn-hover:hover .arrow {
        transform: translateX(8px);
      }
      .content-animate {
        animation: fadeInUp 1s ease-out forwards;
      }
      .title-shimmer {
        background: linear-gradient(90deg, #ffffff 0%, #6a7aae 50%, #ffffff 100%);
        background-size: 200% auto;
        animation: shimmer 3s linear infinite;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }
    `
    document.head.appendChild(style)
    return () => document.head.removeChild(style)
  }, [])

  return (
    <div style={styles.container}>
      <div style={styles.floatingShapes}>
        {[...Array(20)].map((_, i) => (
          <svg key={i} style={{...styles.floatingSvg, ...styles[`svg${i % 10}`]}} xmlns="http://www.w3.org/2000/svg">
            <path d="m2.46177,126.39581c10.12618,-0.06577 20.25237,-0.13151 30.37857,-0.19726c0.06666,-10.3997 0.13333,-20.7994 0.19999,-31.19908c10.07782,0 20.15564,0 30.23346,0c0,-10.46351 0,-20.927 0,-31.39051c10.33589,0 20.67178,0 31.00767,0c0,-10.20827 0,-20.41656 0,-30.62485c10.20829,0 20.41656,0 30.62485,0c0,-10.20829 0,-20.41658 0,-30.62487c15.18483,0 30.36965,0 45.55448,0c0,5.10414 0,10.20829 0,15.31243c-10.08071,0 -20.16136,0 -30.24206,0c0,10.33589 0,20.67178 0,31.00769c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33589 0,20.67178 0,31.00767c-10.20829,0 -20.41656,0 -30.62485,0c0,10.33591 0,20.6718 0,31.00767c-10.33589,0 -20.67178,0 -31.00767,0c0,10.46351 0,20.927 0,31.39049c-15.31243,0 -30.62485,0 -45.93728,0c0.68263,-5.07223 -1.16374,-10.79174 0.43769,-15.68938l0,0z" strokeWidth="7" fill="none"/>
          </svg>
        ))}
      </div>

      <div style={styles.overlay} />

      <header style={styles.header}>
        <div style={styles.logoContainer}>
          <div style={styles.logoGlow} />
          <div style={styles.logo}>
            <span style={styles.logoAccent}>S</span>AES
          </div>
        </div>
      </header>

      <main style={styles.main}>
        <div style={{...styles.content}} className="content-animate">
          <div style={styles.welcomeWrapper}>
            <div style={styles.welcomeLine} />
            <p style={styles.welcome}>BIENVENIDO AL SAES</p>
            <div style={styles.welcomeDot} />
          </div>
          
          <h1 style={styles.title}>
            <span style={styles.titleRegular}>Sistema de gestión para</span><br />
            <span className="title-shimmer">consultar materias,</span><br />
            <span className="title-shimmer">horarios y calificaciones.</span>
          </h1>
          
          <button style={styles.btnPrimary} onClick={()=>nav('/login')} className="btn-hover">
            <span style={styles.btnText}>INICIAR SESIÓN</span>
            <span style={styles.btnArrow} className="arrow">→</span>
          </button>
        </div>
      </main>

      <div style={styles.bgImage} />
    </div>
  )
}

const styles = {
  container: {
    minHeight: '100vh',
    background: 'linear-gradient(135deg, #0f1620 0%, #1a2847 40%, #2d3a6a 100%)',
    color: '#ffffff',
    position: 'relative',
    overflow: 'hidden',
    fontFamily: '"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
  },
  
  floatingShapes: {
    position: 'absolute',
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
    width: '200px',
    height: '200px',
    left: '5%',
    bottom: '-25%',
    animation: 'float1 20s infinite ease-in-out',
    opacity: 0.4,
    stroke: '#4a5a8e',
  },
  svg1: {
    width: '150px',
    height: '150px',
    left: '15%',
    bottom: '-20%',
    animation: 'float2 22s infinite ease-in-out',
    opacity: 0.5,
    stroke: '#5a6a9e',
  },
  svg2: {
    width: '180px',
    height: '180px',
    left: '28%',
    bottom: '-22%',
    animation: 'float3 24s infinite ease-in-out',
    opacity: 0.3,
    stroke: '#3a4a7a',
  },
  svg3: {
    width: '130px',
    height: '130px',
    left: '42%',
    bottom: '-18%',
    animation: 'float4 18s infinite ease-in-out',
    opacity: 0.6,
    stroke: '#6a7aae',
  },
  svg4: {
    width: '170px',
    height: '170px',
    left: '55%',
    bottom: '-21%',
    animation: 'float1 21s infinite ease-in-out',
    opacity: 0.4,
    stroke: '#4a5a8e',
  },
  svg5: {
    width: '140px',
    height: '140px',
    left: '68%',
    bottom: '-19%',
    animation: 'float2 23s infinite ease-in-out',
    opacity: 0.45,
    stroke: '#5a6a9e',
  },
  svg6: {
    width: '160px',
    height: '160px',
    left: '80%',
    bottom: '-20%',
    animation: 'float3 25s infinite ease-in-out',
    opacity: 0.5,
    stroke: '#3a4a7a',
  },
  svg7: {
    width: '120px',
    height: '120px',
    left: '90%',
    bottom: '-15%',
    animation: 'float4 19s infinite ease-in-out',
    opacity: 0.55,
    stroke: '#6a7aae',
  },
  svg8: {
    width: '190px',
    height: '190px',
    left: '20%',
    bottom: '-24%',
    animation: 'float1 26s infinite ease-in-out',
    opacity: 0.35,
    stroke: '#7a8abe',
  },
  svg9: {
    width: '110px',
    height: '110px',
    left: '75%',
    bottom: '-16%',
    animation: 'float2 20s infinite ease-in-out',
    opacity: 0.6,
    stroke: '#5a6a9e',
  },

  overlay: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    background: 'radial-gradient(ellipse at 20% 40%, rgba(74, 90, 142, 0.2) 0%, transparent 50%), radial-gradient(ellipse at 80% 60%, rgba(106, 122, 174, 0.15) 0%, transparent 50%)',
    zIndex: 2,
    pointerEvents: 'none',
  },
  
  header: {
    display: 'flex',
    justifyContent: 'flex-start',
    alignItems: 'center',
    padding: '32px 80px',
    position: 'relative',
    zIndex: 10,
  },

  logoContainer: {
    position: 'relative',
    display: 'inline-block',
  },

  logoGlow: {
    position: 'absolute',
    top: '-10px',
    left: '-10px',
    right: '-10px',
    bottom: '-10px',
    background: 'radial-gradient(circle, rgba(106, 122, 174, 0.3) 0%, transparent 70%)',
    filter: 'blur(20px)',
    zIndex: -1,
  },
  
  logo: {
    fontSize: '36px',
    fontWeight: '800',
    letterSpacing: '2px',
    color: '#ffffff',
    position: 'relative',
  },

  logoAccent: {
    color: '#6a7aae',
    fontSize: '42px',
    textShadow: '0 0 30px rgba(106, 122, 174, 0.6)',
  },
  
  main: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-start',
    minHeight: 'calc(100vh - 128px)',
    padding: '0 80px',
    position: 'relative',
    zIndex: 10,
  },
  
  content: {
    maxWidth: '900px',
    zIndex: 2,
  },

  welcomeWrapper: {
    display: 'flex',
    alignItems: 'center',
    gap: '16px',
    marginBottom: '32px',
  },

  welcomeLine: {
    width: '60px',
    height: '3px',
    background: 'linear-gradient(90deg, #6a7aae 0%, transparent 100%)',
    boxShadow: '0 0 10px rgba(106, 122, 174, 0.5)',
  },
  
  welcome: {
    fontSize: '13px',
    letterSpacing: '4px',
    color: '#6a7aae',
    fontWeight: '700',
    textShadow: '0 0 20px rgba(106, 122, 174, 0.5)',
  },

  welcomeDot: {
    width: '8px',
    height: '8px',
    borderRadius: '50%',
    background: '#6a7aae',
    boxShadow: '0 0 15px rgba(106, 122, 174, 0.8)',
  },
  
  title: {
    fontSize: 'clamp(36px, 5.5vw, 72px)',
    lineHeight: '1.25',
    fontWeight: '700',
    marginBottom: '48px',
    letterSpacing: '-2px',
  },

  titleRegular: {
    color: '#ffffff',
    fontWeight: '400',
  },

  features: {
    display: 'flex',
    gap: '32px',
    marginBottom: '48px',
  },

  featureItem: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '8px',
  },

  featureIcon: {
    fontSize: '32px',
    filter: 'drop-shadow(0 4px 12px rgba(106, 122, 174, 0.4))',
  },

  featureText: {
    fontSize: '12px',
    color: '#a8b2d1',
    fontWeight: '600',
    letterSpacing: '1px',
  },
  
  btnPrimary: {
    background: 'linear-gradient(135deg, #5a6a9e 0%, #6a7aae 100%)',
    border: 'none',
    color: '#ffffff',
    padding: '20px 56px',
    fontSize: '14px',
    letterSpacing: '3px',
    fontWeight: '700',
    cursor: 'pointer',
    transition: 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)',
    borderRadius: '16px',
    boxShadow: '0 8px 32px rgba(106, 122, 174, 0.4)',
    display: 'inline-flex',
    alignItems: 'center',
    gap: '16px',
    position: 'relative',
    overflow: 'hidden',
    marginBottom: '64px',
  },

  btnText: {
    position: 'relative',
    zIndex: 2,
  },

  btnArrow: {
    fontSize: '24px',
    transition: 'transform 0.4s ease',
    position: 'relative',
    zIndex: 2,
  },

  stats: {
    display: 'flex',
    alignItems: 'center',
    gap: '32px',
    padding: '24px 0',
    borderTop: '1px solid rgba(106, 122, 174, 0.2)',
  },

  statItem: {
    display: 'flex',
    flexDirection: 'column',
    gap: '4px',
  },

  statNumber: {
    fontSize: '28px',
    fontWeight: '800',
    background: 'linear-gradient(135deg, #6a7aae 0%, #8a9abe 100%)',
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
    backgroundClip: 'text',
  },

  statLabel: {
    fontSize: '11px',
    color: '#6a7aae',
    letterSpacing: '2px',
    fontWeight: '600',
  },

  statDivider: {
    width: '1px',
    height: '40px',
    background: 'linear-gradient(180deg, transparent 0%, rgba(106, 122, 174, 0.3) 50%, transparent 100%)',
  },
  
  bgImage: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    backgroundImage: 'url(https://www.cec.escom.ipn.mx/images/frente_ESCOM.jpg)',
    backgroundSize: 'cover',
    backgroundPosition: 'center',
    backgroundRepeat: 'no-repeat',
    opacity: 0.2,
    zIndex: 0,
    pointerEvents: 'none',
    filter: 'blur(1px)',
  },
}