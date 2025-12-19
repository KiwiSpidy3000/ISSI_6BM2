export default function Dashboard() {
    const [data, setData] = useState([])
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const t = localStorage.getItem('access_token') || ''

        // Fetch stats
        fetch(`${API}/alumno/stats/trend`, {
            headers: { Authorization: `Bearer ${t}` }
        })
            .then(r => r.json())
            .then(d => {
                if (Array.isArray(d)) {
                    setData(d)
                }
            })
            .catch(console.error)
            .finally(() => setLoading(false))
    }, [])

    if (loading) return <div style={styles.loading}>Cargando estadísticas...</div>

    return (
        <div>
            <h2 style={styles.h2}>Dashboard Académico</h2>

            <div style={styles.card}>
                <h3 style={styles.h3}>Tendencia de Promedio por Semestre</h3>
                <p style={{ color: '#aaa', marginBottom: '20px' }}>Evolución de tu desempeño académico a través de los periodos cursados.</p>

                <div style={{ height: 400, width: '100%' }}>
                    {data.length > 0 ? (
                        <ResponsiveContainer width="100%" height="100%">
                            <AreaChart data={data} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                                <defs>
                                    <linearGradient id="colorPromedio" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#82ca9d" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="#82ca9d" stopOpacity={0} />
                                    </linearGradient>
                                </defs>
                                <XAxis dataKey="periodo" stroke="#ccc" />
                                <YAxis domain={[0, 10]} stroke="#ccc" />
                                <CartesianGrid strokeDasharray="3 3" stroke="#444" />
                                <Tooltip
                                    contentStyle={{ backgroundColor: '#333', border: 'none', borderRadius: '8px' }}
                                    itemStyle={{ color: '#fff' }}
                                />
                                <Area type="monotone" dataKey="promedio" stroke="#82ca9d" fillOpacity={1} fill="url(#colorPromedio)" />
                            </AreaChart>
                        </ResponsiveContainer>
                    ) : (
                        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%', color: '#666' }}>
                            No hay suficientes datos para mostrar la gráfica.
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
