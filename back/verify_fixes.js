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
        return { error: data.error, status: res.status };
    }
    return { access_token: data.access_token, status: res.status };
}

async function verifyStudentView() {
    console.log('--- Verifying Student View Improvements ---');

    // 1. Login as Miguel (Student)
    const r = await login('2021301170@alumno.ipn.mx', 'lyte123', 'ALUMNO');
    const token = r.access_token;
    if (!token) throw new Error('Login failed');
    console.log('1. Login successful');

    // 2. Check Kardex for Semester
    console.log('2. Checking Kardex for Semester column...');
    const kRes = await fetch(`${API}/alumno/kardex`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const kardex = await kRes.json();
    if (kardex.length > 0) {
        const first = kardex[0];
        if (first.semestre !== undefined) {
            console.log(`   ✅ Kardex has semester: ${first.semestre}`);
        } else {
            console.error('   ❌ Kardex missing semester field:', first);
        }
    } else {
        console.warn('   ⚠️ Kardex is empty');
    }

    // 3. Check Schedule for Table Data
    console.log('3. Checking Schedule data...');
    // Fetch periods first to get a valid one
    const pRes = await fetch(`${API}/alumno/periodos`, {
        headers: { Authorization: `Bearer ${token}` }
    });
    const periodos = await pRes.json();
    const lastPeriod = periodos[periodos.length - 1];
    console.log(`   Using period: ${lastPeriod}`);

    if (lastPeriod) {
        // Check enrollments first
        const eRes = await fetch(`${API}/alumno/reins/inscritas?periodo=${lastPeriod}`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        const enrollments = await eRes.json();
        console.log(`   Enrollments for ${lastPeriod}: ${enrollments.length}`);
        if (enrollments.length > 0) {
            console.log('   Sample enrollment:', enrollments[0]);
        }

        const hRes = await fetch(`${API}/alumno/horario?periodo=${lastPeriod}`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        const schedule = await hRes.json();
        console.log(`   Schedule items: ${schedule.length}`);

        if (schedule.length > 0) {
            const first = schedule[0];
            const requiredFields = ['id_grupo', 'materia_nombre', 'profesor', 'dia_semana', 'hora_ini', 'hora_fin', 'aula'];
            const missing = requiredFields.filter(f => first[f] === undefined);
            if (missing.length === 0) {
                console.log('   ✅ Schedule has all required fields');
                console.log(`   Sample: Group ${first.id_grupo}, ${first.materia_nombre}, ${first.dia_semana} ${first.hora_ini}-${first.hora_fin}`);
            } else {
                console.error('   ❌ Schedule missing fields:', missing);
            }
        } else {
            console.warn('   ⚠️ Schedule is empty for this period (might be due to missing horario records for groups)');
        }
    } else {
        console.warn('   ⚠️ No periods found for student');
    }
}

async function main() {
    try {
        await verifyStudentView();
    } catch (e) {
        console.error('Verification failed:', e);
    }
}

main();
