<%-- Document : personal Author : DevLearn Team --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>AI Roadmap Generator | DevLearn</title>
                <meta name="description"
                    content="Create a personalized AI learning roadmap tailored to your major and current skill set.">
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
                    rel="stylesheet">
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
                <script>
                    tailwind.config = {
                        theme: { extend: { colors: { primary: '#10B981', 'primary-dark': '#059669' } } }
                    }
                </script>

                <style>
                    /* ─── RESET ─────────────────────────────────────────────────────── */
                    *,
                    *::before,
                    *::after {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0;
                    }

                    /* ─── BODY / BACKGROUND ──────────────────────────────────────────  */
                    body {
                        font-family: 'Inter', sans-serif;
                        min-height: 100vh;
                        overflow-x: hidden;
                        background: linear-gradient(135deg, #f0fdf9 0%, #e6f7f1 50%, #f8fffc 100%);
                        color: #0f172a;
                    }

                    /* ─── TOKENS ─────────────────────────────────────────────────────  */
                    :root {
                        --primary: #10B981;
                        --primary-dark: #059669;
                        --primary-light: #ecfdf5;
                        --primary-brd: #a7f3d0;
                        --primary-dim: rgba(16, 185, 129, 0.1);
                        --text: #0f172a;
                        --text-muted: #64748b;
                        --text-sub: #94a3b8;
                        --border: #e2e8f0;
                        --border-hi: #bbf7d0;
                        --card-bg: #ffffff;
                        --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
                        --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
                        --shadow-lg: 0 12px 36px rgba(0, 0, 0, 0.1);
                        --shadow-green: 0 8px 28px rgba(16, 185, 129, 0.22);
                        --radius: 16px;
                        --transition: 0.25s ease;
                    }

                    /* ─── LAYOUT ─────────────────────────────────────────────────────  */
                    .page-wrapper {
                        padding: 100px 24px 80px;
                    }

                    .container {
                        max-width: 860px;
                        margin: 0 auto;
                    }

                    /* ─── HERO ───────────────────────────────────────────────────────  */
                    .hero {
                        text-align: center;
                        margin-bottom: 48px;
                    }

                    .badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 7px 20px;
                        border-radius: 999px;
                        background: var(--primary-light);
                        border: 1px solid var(--primary-brd);
                        color: #065f46;
                        font-size: 12px;
                        font-weight: 700;
                        letter-spacing: 0.7px;
                        text-transform: uppercase;
                        margin-bottom: 22px;
                    }

                    .badge-dot {
                        width: 7px;
                        height: 7px;
                        border-radius: 50%;
                        background: var(--primary);
                        animation: blink 1.6s infinite;
                    }

                    @keyframes blink {

                        0%,
                        100% {
                            opacity: 1;
                            transform: scale(1)
                        }

                        50% {
                            opacity: .4;
                            transform: scale(1.5)
                        }
                    }

                    .hero-title {
                        font-size: clamp(2rem, 5vw, 3.2rem);
                        font-weight: 900;
                        line-height: 1.12;
                        letter-spacing: -1px;
                        color: var(--text);
                        margin-bottom: 16px;
                    }

                    .hero-title .accent {
                        background: linear-gradient(135deg, #10B981, #059669);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .hero-sub {
                        font-size: 16px;
                        color: var(--text-muted);
                        max-width: 520px;
                        margin: 0 auto;
                        line-height: 1.75;
                    }

                    /* ─── STAT PILLS ─────────────────────────────────────────────────  */
                    .stats-row {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 14px;
                        margin-bottom: 40px;
                    }

                    .stat-pill {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        border-radius: var(--radius);
                        padding: 18px 16px;
                        text-align: center;
                        box-shadow: var(--shadow-sm);
                        transition: all var(--transition);
                    }

                    .stat-pill:hover {
                        border-color: var(--primary-brd);
                        box-shadow: var(--shadow-green);
                        transform: translateY(-3px);
                    }

                    .stat-num {
                        font-size: 24px;
                        font-weight: 800;
                        color: var(--primary);
                    }

                    .stat-text {
                        font-size: 11.5px;
                        color: var(--text-muted);
                        margin-top: 4px;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    /* ─── STEPS BAR ──────────────────────────────────────────────────  */
                    .steps-bar {
                        display: flex;
                        align-items: center;
                        margin-bottom: 28px;
                    }

                    .step-item {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        flex: 1;
                    }

                    .step-circle {
                        width: 34px;
                        height: 34px;
                        border-radius: 50%;
                        background: var(--primary);
                        color: #fff;
                        font-size: 13px;
                        font-weight: 700;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15), 0 4px 12px rgba(16, 185, 129, 0.3);
                    }

                    .step-circle.done {
                        background: var(--primary-dark);
                    }

                    .step-circle.inactive {
                        background: #e2e8f0;
                        color: #94a3b8;
                        box-shadow: none;
                    }

                    .step-label {
                        font-size: 11px;
                        font-weight: 600;
                        margin-top: 7px;
                        color: var(--primary-dark);
                        letter-spacing: 0.3px;
                    }

                    .step-label.inactive {
                        color: var(--text-sub);
                    }

                    .step-connector {
                        flex: 1;
                        height: 2px;
                        background: var(--primary-brd);
                        margin-top: -11px;
                    }

                    .step-connector.inactive {
                        background: #e2e8f0;
                    }

                    /* ─── WHITE CARD ─────────────────────────────────────────────────  */
                    .main-card {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        border-radius: 20px;
                        padding: 40px 44px;
                        box-shadow: var(--shadow-md);
                        transition: box-shadow var(--transition);
                        position: relative;
                        overflow: hidden;
                    }

                    .main-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, var(--primary), #34d399, var(--primary));
                    }

                    .main-card:hover {
                        box-shadow: 0 16px 48px rgba(16, 185, 129, 0.12);
                    }

                    /* ─── CARD HEADER ────────────────────────────────────────────────  */
                    .card-head {
                        display: flex;
                        align-items: center;
                        gap: 13px;
                        margin-bottom: 28px;
                    }

                    .card-icon {
                        width: 44px;
                        height: 44px;
                        border-radius: 13px;
                        background: var(--primary-light);
                        border: 1px solid var(--primary-brd);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 20px;
                    }

                    .card-title-text {
                        font-size: 18px;
                        font-weight: 800;
                        color: var(--text);
                    }

                    .card-subtitle {
                        font-size: 13px;
                        color: var(--text-muted);
                        margin-top: 2px;
                    }

                    /* ─── SECTION LABEL ──────────────────────────────────────────────  */
                    .section-label {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        font-size: 10.5px;
                        font-weight: 700;
                        letter-spacing: 1.2px;
                        text-transform: uppercase;
                        color: var(--primary-dark);
                        margin-bottom: 14px;
                    }

                    .section-label::after {
                        content: '';
                        flex: 1;
                        height: 1px;
                        background: linear-gradient(90deg, var(--primary-brd), transparent);
                    }

                    /* ─── DIVIDER ────────────────────────────────────────────────────  */
                    .divider {
                        border: none;
                        border-top: 1px solid var(--border);
                        margin: 24px 0;
                    }

                    /* ─── MAJOR CARDS ────────────────────────────────────────────────  */
                    .major-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(175px, 1fr));
                        gap: 10px;
                    }

                    .major-card {
                        padding: 16px 16px;
                        border: 1.5px solid var(--border);
                        border-radius: 14px;
                        background: #fafafa;
                        cursor: pointer;
                        transition: all var(--transition);
                        display: flex;
                        flex-direction: column;
                        gap: 5px;
                    }

                    .major-card:hover {
                        border-color: var(--primary-brd);
                        background: var(--primary-light);
                        transform: translateY(-2px);
                        box-shadow: var(--shadow-sm);
                    }

                    .major-card.selected {
                        border-color: var(--primary);
                        background: var(--primary-light);
                        box-shadow: 0 4px 18px rgba(16, 185, 129, 0.18);
                    }

                    .major-card-icon {
                        font-size: 22px;
                    }

                    .major-card-name {
                        font-size: 13px;
                        font-weight: 700;
                        color: var(--text);
                    }

                    .major-card-desc {
                        font-size: 11px;
                        color: var(--text-muted);
                    }

                    .select-hidden {
                        display: none !important;
                    }

                    /* ─── SKILL TAGS ─────────────────────────────────────────────────  */
                    .skills-grid {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 9px;
                    }

                    .skill-tag {
                        display: inline-flex;
                        align-items: center;
                        gap: 7px;
                        padding: 8px 16px;
                        border: 1.5px solid var(--border);
                        border-radius: 999px;
                        background: #fafafa;
                        color: var(--text-muted);
                        font-size: 13px;
                        font-weight: 600;
                        cursor: pointer;
                        user-select: none;
                        transition: all var(--transition);
                    }

                    .skill-tag:hover {
                        border-color: var(--primary-brd);
                        color: #065f46;
                        background: var(--primary-light);
                        transform: translateY(-1px);
                    }

                    .skill-tag.selected {
                        background: var(--primary);
                        border-color: var(--primary-dark);
                        color: #fff;
                        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
                        transform: translateY(-1px);
                    }

                    /* ─── PRIMARY BUTTON ─────────────────────────────────────────────  */
                    .btn-primary {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 9px;
                        height: 52px;
                        padding: 0 36px;
                        border-radius: 14px;
                        border: none;
                        background: linear-gradient(135deg, #10B981, #059669);
                        color: #fff;
                        font-size: 15px;
                        font-weight: 700;
                        font-family: 'Inter', sans-serif;
                        cursor: pointer;
                        box-shadow: var(--shadow-green);
                        transition: all var(--transition);
                        position: relative;
                        overflow: hidden;
                    }

                    .btn-primary::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: -100%;
                        width: 100%;
                        height: 100%;
                        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                        transition: left 0.5s;
                    }

                    .btn-primary:hover::before {
                        left: 100%;
                    }

                    .btn-primary:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 12px 32px rgba(16, 185, 129, 0.4);
                    }

                    .btn-primary:active {
                        transform: translateY(0);
                    }

                    /* ─── TIP STRIP ──────────────────────────────────────────────────  */
                    .tip-strip {
                        margin-top: 24px;
                        display: flex;
                        gap: 12px;
                        align-items: flex-start;
                        padding: 14px 18px;
                        background: var(--primary-light);
                        border: 1px solid var(--primary-brd);
                        border-radius: 12px;
                        font-size: 13px;
                        line-height: 1.65;
                        color: #065f46;
                    }

                    .tip-strip-icon {
                        font-size: 20px;
                        flex-shrink: 0;
                        color: var(--primary);
                    }

                    .tip-strip strong {
                        color: var(--primary-dark);
                    }

                    /* ─── FOOTER ─────────────────────────────────────────────────────  */
                    .site-footer {
                        background: #fff;
                        border-top: 1px solid #e2e8f0;
                        padding: 64px 24px 36px;
                    }

                    .footer-inner {
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    .footer-grid {
                        display: grid;
                        grid-template-columns: 2fr 1fr 1fr 1fr;
                        gap: 48px;
                        margin-bottom: 48px;
                    }

                    .footer-logo-link {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        margin-bottom: 14px;
                        text-decoration: none;
                    }

                    .footer-logo-box {
                        width: 40px;
                        height: 40px;
                        border-radius: 10px;
                        background: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #fff;
                        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
                    }

                    .footer-logo-name {
                        font-size: 20px;
                        font-weight: 800;
                        color: var(--text);
                    }

                    .footer-desc {
                        font-size: 14px;
                        color: var(--text-muted);
                        line-height: 1.7;
                        max-width: 280px;
                        margin-bottom: 20px;
                    }

                    .footer-socials {
                        display: flex;
                        gap: 10px;
                    }

                    .footer-social-btn {
                        width: 36px;
                        height: 36px;
                        border-radius: 50%;
                        border: 1px solid var(--border);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: var(--text-muted);
                        text-decoration: none;
                        transition: all var(--transition);
                    }

                    .footer-social-btn:hover {
                        background: var(--primary);
                        border-color: var(--primary);
                        color: #fff;
                        transform: translateY(-3px);
                    }

                    .footer-col-title {
                        font-size: 11px;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 1.5px;
                        color: var(--text);
                        margin-bottom: 18px;
                    }

                    .footer-links {
                        list-style: none;
                        display: flex;
                        flex-direction: column;
                        gap: 11px;
                    }

                    .footer-links a {
                        font-size: 14px;
                        color: var(--text-muted);
                        text-decoration: none;
                        transition: color 0.2s;
                    }

                    .footer-links a:hover {
                        color: var(--primary);
                    }

                    .footer-bottom {
                        padding-top: 24px;
                        border-top: 1px solid var(--border);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: 12px;
                        color: var(--text-sub);
                        font-size: 13px;
                    }

                    .footer-bottom-right {
                        display: flex;
                        gap: 20px;
                        align-items: center;
                    }

                    @media(max-width: 1024px) {
                        .footer-grid {
                            grid-template-columns: repeat(2, 1fr);
                            gap: 32px;
                        }
                    }

                    @media(max-width: 640px) {
                        .footer-grid {
                            grid-template-columns: 1fr;
                        }

                        .main-card {
                            padding: 26px 20px;
                        }

                        .stats-row {
                            grid-template-columns: 1fr;
                        }

                        .major-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }
                    }
                </style>
            </head>

            <body>

                <!-- ── HEADER ────────────────────────────────────────────────────────────── -->
                <jsp:include page="../common/header.jsp" />

                <!-- ── USER PILL ─────────────────────────────────────────────────────────── -->
                <jsp:include page="../common/userbuttom.jsp" />

                <!-- Header override: keep dark glass nav on light bg -->
                <style>
                    header.glass-header-nav,
                    .glass-header-nav {
                        background: rgba(15, 23, 42, 0.92) !important;
                        backdrop-filter: blur(20px) !important;
                        -webkit-backdrop-filter: blur(20px) !important;
                        border-bottom: 1px solid rgba(16, 185, 129, 0.2) !important;
                        box-shadow: 0 4px 32px rgba(0, 0, 0, 0.3) !important;
                        position: fixed !important;
                        top: 0 !important;
                        left: 0 !important;
                        width: 100% !important;
                        z-index: 50 !important;
                    }
                </style>

                <!-- ── PAGE ───────────────────────────────────────────────────────────────── -->
                <div class="page-wrapper">
                    <div class="container">

                        <!-- STAT PILLS -->
                        <div class="stats-row">
                            <div class="stat-pill">
                                <div class="stat-num">12K+</div>
                                <div class="stat-text">Roadmaps Generated</div>
                            </div>
                            <div class="stat-pill">
                                <div class="stat-num">6</div>
                                <div class="stat-text">Supported Majors</div>
                            </div>
                            <div class="stat-pill">
                                <div class="stat-num">98%</div>
                                <div class="stat-text">Satisfaction Rate</div>
                            </div>
                        </div>

                        <!-- HERO -->
                        <div class="hero">
                            <div class="badge">
                                <span class="badge-dot"></span>
                                AI-Powered Learning
                            </div>
                            <h1 class="hero-title">
                                Build Your <span class="accent">Personalized Roadmap</span>
                            </h1>
                            <p class="hero-sub">
                                Tell us your major and what you already know — our AI will craft a step-by-step learning
                                path built exactly for you.
                            </p>
                        </div>

                        <!-- STEPS -->
                        <div class="steps-bar">
                            <div class="step-item">
                                <div class="step-circle done">✓</div>
                                <span class="step-label">Major</span>
                            </div>
                            <div class="step-connector"></div>
                            <div class="step-item">
                                <div class="step-circle">2</div>
                                <span class="step-label">Skills</span>
                            </div>
                            <div class="step-connector inactive"></div>
                            <div class="step-item">
                                <div class="step-circle inactive">3</div>
                                <span class="step-label inactive">Roadmap</span>
                            </div>
                        </div>

                        <!-- MAIN CARD -->
                        <div class="main-card">
                            <div class="card-head">
                                <div class="card-icon">🎯</div>
                                <div>
                                    <div class="card-title-text">Info &amp; Goals</div>
                                    <div class="card-subtitle">Select your target major and existing skills</div>
                                </div>
                            </div>

                            <form id="personalForm" action="${pageContext.request.contextPath}/roadmap" method="GET">
                                <!-- Hidden select for submit -->
                                <select class="select-hidden" id="majorSelect" name="major" required>
                                    <option value="" disabled selected></option>
                                    <option value="se">Software Engineering</option>
                                    <option value="ai">Artificial Intelligence</option>
                                    <option value="ds">Data Science</option>
                                    <option value="is">Information Systems</option>
                                    <option value="cs">Computer Science</option>
                                    <option value="ns">Network &amp; Security</option>
                                </select>

                                <!-- MAJOR -->
                                <p class="section-label">
                                    <span class="material-symbols-outlined" style="font-size:14px">school</span>
                                    Target Major
                                </p>
                                <div class="major-grid" id="majorGrid">
                                    <div class="major-card" data-value="se" onclick="selectMajor(this)">
                                        <div class="major-card-icon">💻</div>
                                        <div class="major-card-name">Software Eng.</div>
                                        <div class="major-card-desc">Build real-world systems</div>
                                    </div>
                                    <div class="major-card" data-value="ai" onclick="selectMajor(this)">
                                        <div class="major-card-icon">🤖</div>
                                        <div class="major-card-name">Artificial Intelligence</div>
                                        <div class="major-card-desc">ML, Deep Learning & more</div>
                                    </div>
                                    <div class="major-card" data-value="ds" onclick="selectMajor(this)">
                                        <div class="major-card-icon">📊</div>
                                        <div class="major-card-name">Data Science</div>
                                        <div class="major-card-desc">Analytics & visualization</div>
                                    </div>
                                    <div class="major-card" data-value="is" onclick="selectMajor(this)">
                                        <div class="major-card-icon">🗄️</div>
                                        <div class="major-card-name">Info. Systems</div>
                                        <div class="major-card-desc">Business & tech bridge</div>
                                    </div>
                                    <div class="major-card" data-value="cs" onclick="selectMajor(this)">
                                        <div class="major-card-icon">🔬</div>
                                        <div class="major-card-name">Computer Science</div>
                                        <div class="major-card-desc">Theory & algorithms</div>
                                    </div>
                                    <div class="major-card" data-value="ns" onclick="selectMajor(this)">
                                        <div class="major-card-icon">🔐</div>
                                        <div class="major-card-name">Network &amp; Security</div>
                                        <div class="major-card-desc">Cybersecurity & infra</div>
                                    </div>
                                </div>

                                <hr class="divider">

                                <!-- SKILLS -->
                                <p class="section-label">
                                    <span class="material-symbols-outlined" style="font-size:14px">psychology</span>
                                    Skills You Already Have
                                </p>
                                <div class="skills-grid" id="skillsGrid">
                                    <div class="skill-tag" data-skill="c" onclick="toggleSkill(this)"><span>⚙️</span> C
                                        Programming</div>
                                    <div class="skill-tag" data-skill="java" onclick="toggleSkill(this)"><span>☕</span>
                                        Java OOP</div>
                                    <div class="skill-tag" data-skill="python" onclick="toggleSkill(this)">
                                        <span>🐍</span> Python</div>
                                    <div class="skill-tag" data-skill="js" onclick="toggleSkill(this)"><span>✨</span>
                                        JavaScript</div>
                                    <div class="skill-tag" data-skill="html" onclick="toggleSkill(this)"><span>🌐</span>
                                        HTML &amp; CSS</div>
                                    <div class="skill-tag" data-skill="sql" onclick="toggleSkill(this)"><span>🗃️</span>
                                        SQL / Database</div>
                                    <div class="skill-tag" data-skill="react" onclick="toggleSkill(this)">
                                        <span>⚛️</span> React / Next.js</div>
                                    <div class="skill-tag" data-skill="git" onclick="toggleSkill(this)"><span>🌿</span>
                                        Git / GitHub</div>
                                    <div class="skill-tag" data-skill="docker" onclick="toggleSkill(this)">
                                        <span>🐳</span> Docker</div>
                                    <div class="skill-tag" data-skill="linux" onclick="toggleSkill(this)">
                                        <span>🐧</span> Linux</div>
                                </div>
                                <input type="hidden" id="selectedSkills" name="skills" value="">

                                <!-- CTA -->
                                <div style="display:flex;align-items:center;gap:14px;margin-top:32px;flex-wrap:wrap;">
                                    <button type="submit" class="btn-primary" id="btnCreate">
                                        <span class="material-symbols-outlined"
                                            style="font-size:18px">auto_awesome</span>
                                        Generate AI Roadmap
                                    </button>
                                </div>

                                <!-- TIP -->
                                <div class="tip-strip">
                                    <span class="material-symbols-outlined tip-strip-icon">lightbulb</span>
                                    <span><strong>Tip:</strong> Select multiple skills so AI can better understand your
                                        background and craft the most accurate roadmap for your level.</span>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>

                <!-- ── FOOTER ─────────────────────────────────────────────────────────────── -->
                <footer class="site-footer">
                    <div class="footer-inner">
                        <div class="footer-grid">
                            <div>
                                <a href="${pageContext.request.contextPath}/home" class="footer-logo-link">
                                    <div class="footer-logo-box">
                                        <span class="material-symbols-outlined"
                                            style="font-size:20px;font-weight:700">terminal</span>
                                    </div>
                                    <span class="footer-logo-name">DevLearn</span>
                                </a>
                                <p class="footer-desc">Accompanying thousands of students on their journey to becoming
                                    professional software engineers.</p>
                                <div class="footer-socials">
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">social_leaderboard</span></a>
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">terminal</span></a>
                                    <a class="footer-social-btn" href="#"><span class="material-symbols-outlined"
                                            style="font-size:18px">smart_display</span></a>
                                </div>
                            </div>
                            <div>
                                <div class="footer-col-title">Courses</div>
                                <ul class="footer-links">
                                    <li><a href="#">Frontend Development</a></li>
                                    <li><a href="#">Backend Development</a></li>
                                    <li><a href="#">Mobile Development</a></li>
                                    <li><a href="#">Data Science &amp; AI</a></li>
                                    <li><a href="#">DevOps &amp; Cloud</a></li>
                                </ul>
                            </div>
                            <div>
                                <div class="footer-col-title">Resources</div>
                                <ul class="footer-links">
                                    <li><a href="#">Tech Blog</a></li>
                                    <li><a href="#">Community</a></li>
                                    <li><a href="#">Free Materials</a></li>
                                    <li><a href="#">YouTube Channel</a></li>
                                    <li><a href="#">IT Podcast</a></li>
                                </ul>
                            </div>
                            <div>
                                <div class="footer-col-title">Quick Links</div>
                                <ul class="footer-links">
                                    <li><a href="#">About Us</a></li>
                                    <li><a href="${pageContext.request.contextPath}/teacher-jobs">Careers</a></li>
                                    <li><a href="#">Terms of Service</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                    <li><a href="#">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="footer-bottom">
                            <span>© 2024 DevLearn Academy. Built for the tech community.</span>
                            <div class="footer-bottom-right">
                                <span style="display:flex;align-items:center;gap:5px">
                                    <span class="material-symbols-outlined" style="font-size:16px">language</span>
                                    English
                                </span>
                                <span style="display:flex;align-items:center;gap:5px">
                                    <span class="material-symbols-outlined" style="font-size:16px">support_agent</span>
                                    1900 1234
                                </span>
                            </div>
                        </div>
                    </div>
                </footer>

                <script>
                    function selectMajor(card) {
                        document.querySelectorAll('.major-card').forEach(c => c.classList.remove('selected'));
                        card.classList.add('selected');
                        document.getElementById('majorSelect').value = card.getAttribute('data-value');
                    }

                    function toggleSkill(el) {
                        el.classList.toggle('selected');
                        syncSkillsInput();
                    }
                    function syncSkillsInput() {
                        const selected = [];
                        document.querySelectorAll('.skill-tag.selected').forEach(t => selected.push(t.getAttribute('data-skill')));
                        document.getElementById('selectedSkills').value = selected.join(',');
                    }

                    document.getElementById('personalForm').addEventListener('submit', function (e) {
                        syncSkillsInput();
                        if (!document.getElementById('majorSelect').value) {
                            e.preventDefault();
                            document.querySelectorAll('.major-card').forEach(c => {
                                c.style.borderColor = '#fca5a5';
                                setTimeout(() => { c.style.borderColor = ''; }, 1500);
                            });
                            document.getElementById('majorGrid').scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }
                    });

                    // Entrance animation
                    (function () {
                        const els = document.querySelectorAll('.stat-pill, .main-card, .major-card');
                        const obs = new IntersectionObserver((entries) => {
                            entries.forEach((entry, i) => {
                                if (entry.isIntersecting) {
                                    entry.target.style.opacity = '0';
                                    entry.target.style.transform = 'translateY(16px)';
                                    setTimeout(() => {
                                        entry.target.style.transition = 'opacity 0.45s ease, transform 0.45s ease';
                                        entry.target.style.opacity = '1';
                                        entry.target.style.transform = 'translateY(0)';
                                    }, 60 * i);
                                    obs.unobserve(entry.target);
                                }
                            });
                        }, { threshold: 0.1 });
                        els.forEach(c => obs.observe(c));
                    })();
                </script>
            </body>

            </html>