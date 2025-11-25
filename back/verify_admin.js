import 'dotenv/config';
import jwt from 'jsonwebtoken';

const API_URL = 'http://localhost:3000';
const { JWT_SECRET } = process.env;

if (!JWT_SECRET) {
    console.error('JWT_SECRET is missing in .env');
    process.exit(1);
}

// Generate Admin Token
const token = jwt.sign({ sub: 1, rol: 'ADMIN', nombre: 'Admin Test' }, JWT_SECRET, { expiresIn: '1h' });
console.log('Generated Admin Token:', token);

async function runTests() {
    try {
        // 1. GET /admin/config
        console.log('\nTesting GET /admin/config...');
        const resConfig = await fetch(`${API_URL}/admin/config`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        console.log('Status:', resConfig.status);
        if (resConfig.ok) {
            const data = await resConfig.json();
            console.log('Config Data:', data);
        } else {
            console.error('Failed to get config');
            const txt = await resConfig.text();
            console.error('Response:', txt);
        }

        // 2. POST /admin/config
        console.log('\nTesting POST /admin/config...');
        const newConfig = {
            INICIO_INSCRIPCION: new Date().toISOString(),
            FIN_INSCRIPCION: new Date(Date.now() + 86400000).toISOString(),
            MAX_CREDITOS: 95
        };
        const resPostConfig = await fetch(`${API_URL}/admin/config`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${token}`
            },
            body: JSON.stringify(newConfig)
        });
        console.log('Status:', resPostConfig.status);
        if (resPostConfig.ok) {
            console.log('Config updated successfully');
        } else {
            console.error('Failed to update config');
            const txt = await resPostConfig.text();
            console.error('Response:', txt);
        }

        // 3. GET /admin/grupos/ocupacion
        console.log('\nTesting GET /admin/grupos/ocupacion...');
        const resGrupos = await fetch(`${API_URL}/admin/grupos/ocupacion`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        console.log('Status:', resGrupos.status);
        let grupos = [];
        if (resGrupos.ok) {
            grupos = await resGrupos.json();
            console.log(`Retrieved ${grupos.length} groups`);
            if (grupos.length > 0) console.log('First group:', grupos[0]);
        } else {
            console.error('Failed to get groups');
            const txt = await resGrupos.text();
            console.error('Response:', txt);
        }

        // 4. PATCH /admin/grupos/:id/status
        if (grupos.length > 0) {
            const g = grupos[0];
            console.log(`\nTesting PATCH /admin/grupos/${g.id_grupo}/status...`);
            const newStatus = g.estado === 'ABIERTO' ? 'CERRADO' : 'ABIERTO';
            const resPatch = await fetch(`${API_URL}/admin/grupos/${g.id_grupo}/status`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`
                },
                body: JSON.stringify({ estado: newStatus })
            });
            console.log('Status:', resPatch.status);
            if (resPatch.ok) {
                console.log(`Group status updated to ${newStatus}`);
            } else {
                console.error('Failed to update group status');
                const txt = await resPatch.text();
                console.error('Response:', txt);
            }
        }

    } catch (err) {
        console.error('Test failed:', err);
    }
}

runTests();
