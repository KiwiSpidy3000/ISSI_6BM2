// Native fetch available in Node 18+

const API = 'http://localhost:3000';

async function login(email, password, role) {
    const res = await fetch(`${API}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ login: email, password, role, captchaToken: 'SKIP_CAPTCHA' })
    });
    const text = await res.text();
    let data;
    try {
        data = JSON.parse(text);
    } catch (e) {
        console.error('Login response not JSON:', text);
        throw new Error('Login failed (invalid JSON)');
    }
    if (!res.ok) {
        // Return error for testing
        return { error: data.error, status: res.status };
    }
    return { access_token: data.access_token, status: res.status };
}

async function verifyRoleEnforcement() {
    console.log('--- Verifying Role Enforcement ---');

    // 1. Miguel (Student) trying to login as ALUMNO (Should succeed)
    console.log('1. Miguel (Student) -> ALUMNO');
    const r1 = await login('2021301170@alumno.ipn.mx', 'lyte123', 'ALUMNO');
    if (r1.access_token) console.log('   ✅ Success');
    else console.error('   ❌ Failed:', r1.error);

    // 2. Miguel (Student) trying to login as PROFESOR (Should fail)
    console.log('2. Miguel (Student) -> PROFESOR');
    const r2 = await login('2021301170@alumno.ipn.mx', 'lyte123', 'PROFESOR');
    if (r2.status === 403) console.log('   ✅ Rejected (403):', r2.error);
    else console.error('   ❌ Unexpected:', r2);

    // 3. Idalia (Professor) trying to login as PROFESOR (Should succeed)
    console.log('3. Idalia (Professor) -> PROFESOR');
    const r3 = await login('idalia.maldonado@escom.ipn.mx', 'prof123', 'PROFESOR');
    if (r3.access_token) console.log('   ✅ Success');
    else console.error('   ❌ Failed:', r3.error);

    // 4. Idalia (Professor) trying to login as ALUMNO (Should fail)
    console.log('4. Idalia (Professor) -> ALUMNO');
    const r4 = await login('idalia.maldonado@escom.ipn.mx', 'prof123', 'ALUMNO');
    if (r4.status === 403) console.log('   ✅ Rejected (403):', r4.error);
    else console.error('   ❌ Unexpected:', r4);
}

async function verifyMiguel() {
    console.log('--- Verifying Miguel Data (Student) ---');
    const r = await login('2021301170@alumno.ipn.mx', 'lyte123', 'ALUMNO');
    const token = r.access_token;
    if (!token) throw new Error('Login failed');

    // 1. Check Kardex
    const kRes = await fetch(`${API}/alumno/kardex`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const kardex = await kRes.json();
    console.log(`Kardex items: ${kardex.length}`);

    // 2. Check Offer
    const oRes = await fetch(`${API}/alumno/reins/oferta?periodo=2024-1`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const offer = await oRes.json();
    console.log(`Offer items: ${offer.length}`);
}

async function main() {
    try {
        await verifyRoleEnforcement();
        await verifyMiguel();
    } catch (e) {
        console.error('Verification failed:', e);
    }
}

main();
