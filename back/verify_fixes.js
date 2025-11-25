// Native fetch available in Node 18+

const API = 'http://localhost:3000';

async function login(email, password) {
    const res = await fetch(`${API}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ login: email, password, captchaToken: 'SKIP_CAPTCHA' })
    });
    const text = await res.text();
    let data;
    try {
        data = JSON.parse(text);
    } catch (e) {
        console.error('Login response not JSON:', text);
        throw new Error('Login failed (invalid JSON)');
    }
    if (!res.ok) throw new Error(`Login failed: ${data.error}`);
    return data.access_token;
}

async function verifyMiguel() {
    console.log('--- Verifying Miguel (Student) ---');
    const token = await login('2021301170@alumno.ipn.mx', 'lyte123');

    // 1. Check Kardex (should have passed subjects)
    const kRes = await fetch(`${API}/alumno/kardex`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const kText = await kRes.text();
    let kardex;
    try {
        kardex = JSON.parse(kText);
    } catch (e) {
        console.error('Kardex response not JSON:', kText);
        throw new Error('Kardex failed');
    }
    console.log(`Kardex items: ${kardex.length}`);
    if (kardex.length > 0) console.log('Sample:', kardex[0]);

    // 2. Check Offer (should be filtered by IIA)
    const oRes = await fetch(`${API}/alumno/reins/oferta?periodo=2024-1`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const oText = await oRes.text();
    let offer;
    try {
        offer = JSON.parse(oText);
    } catch (e) {
        console.error('Offer response not JSON:', oText);
        throw new Error('Offer failed');
    }
    console.log(`Offer items: ${offer.length}`);
    if (offer.length > 0) console.log('Sample:', offer[0]);
}

async function verifyIdalia() {
    console.log('--- Verifying Idalia (Professor) ---');
    const token = await login('idalia.maldonado@escom.ipn.mx', 'prof123');

    // 1. Check Profile
    const pRes = await fetch(`${API}/profesor/profile`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const pText = await pRes.text();
    let profile;
    try {
        profile = JSON.parse(pText);
    } catch (e) {
        console.error('Profile response not JSON:', pText);
        throw new Error('Profile failed');
    }
    console.log('Profile:', profile);

    // 2. Check Groups
    const gRes = await fetch(`${API}/profesor/grupos?periodo=2024-1`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const gText = await gRes.text();
    let groups;
    try {
        groups = JSON.parse(gText);
    } catch (e) {
        console.error('Groups response not JSON:', gText);
        throw new Error('Groups failed');
    }
    console.log(`Groups assigned: ${groups.length}`);
    if (groups.length > 0) console.log('Sample:', groups[0]);
}

async function main() {
    try {
        await verifyMiguel();
        await verifyIdalia();
    } catch (e) {
        console.error('Verification failed:', e);
    }
}

main();
