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
        // 1. GET /api/admin/db-counts
        console.log('\nTesting GET /api/admin/db-counts...');
        const resCounts = await fetch(`${API_URL}/api/admin/db-counts`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        console.log('Status:', resCounts.status);
        if (resCounts.ok) {
            const data = await resCounts.json();
            console.log('DB Counts:', data);
        } else {
            console.error('Failed to get counts');
            const txt = await resCounts.text();
            console.error('Response:', txt);
        }

        // 2. GET /api/admin/materias/iia
        console.log('\nTesting GET /api/admin/materias/iia...');
        const resMat = await fetch(`${API_URL}/api/admin/materias/iia`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        console.log('Status:', resMat.status);
        if (resMat.ok) {
            const data = await resMat.json();
            console.log(`Retrieved ${data.length} subjects`);
        }

    } catch (err) {
        console.error('Test failed:', err);
    }
}

runTests();
