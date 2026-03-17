<%-- Document : personal Created on : Mar 3, 2026 Author : Admin --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Learning Roadmap | DevLearn</title>
    <meta name="description" content="Create a personalized learning roadmap with AI - tailored to your major and skills.">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    
    <%-- Tailwind is required for header.jsp's utility classes --%>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>

    <style>
        /* =====================================================
           RESET & BASE
        ===================================================== */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f2027 0%, #134e4a 50%, #0b3d2e 100%);
            min-height: 100vh; color: #1e1f2e; overflow-x: hidden;
        }

        /* =====================================================
           CSS VARIABLES
        ===================================================== */
        :root {
            --primary: #22c55e; --primary-dark: #16a34a; --primary-hover: #15803d;
            --primary-light: #f0fdf4; --primary-mid: #bbf7d0; --dark-bg: #0f2027;
            --radius-card: 16px; --radius-btn: 12px;
            --shadow-card: 0 10px 30px rgba(0, 0, 0, 0.08);
            --shadow-hover: 0 20px 50px rgba(34, 197, 94, 0.15);
            --transition: 0.3s ease;
        }

        /* ... (Giữ nguyên các CSS cũ của phần FOOTER, HERO SECTION, MAIN CARD, v.v... ) ... */
        /* Vì code CSS khá dài và không có lỗi, anh gộp chung lại cho gọn nhé. Em dán đè toàn bộ là được */
        
        .personal-footer { background: #f8fafc; border-top: 1px solid #e2e8f0; padding: 80px 0 40px; margin-top: 0; }
        .footer-inner { max-width: 1200px; margin: 0 auto; padding: 0 24px; }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 60px; margin-bottom: 60px; }
        .footer-brand-logo { display: flex; align-items: center; gap: 12px; margin-bottom: 24px; text-decoration: none; }
        .footer-logo-box { width: 56px; height: 56px; background: #22c55e; border-radius: 15px; display: flex; align-items: center; justify-content: center; color: #000000; font-weight: 800; font-size: 17px; letter-spacing: -0.5px; font-family: 'Courier New', Courier, monospace; box-shadow: 0 8px 20px rgba(34, 197, 94, 0.25); flex-shrink: 0; }
        .footer-brand-name { font-size: 24px; font-weight: 700; color: #0f172a; letter-spacing: 0.3px; }
        .footer-brand-desc { font-size: 15px; color: #64748b; line-height: 1.6; max-width: 320px; margin-bottom: 32px; }
        .social-links { display: flex; gap: 12px; }
        .social-btn { width: 40px; height: 40px; border-radius: 50%; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #64748b; transition: all 0.3s ease; text-decoration: none; }
        .social-btn:hover { background: #10B981; color: #ffffff; border-color: #10B981; transform: translateY(-3px); box-shadow: 0 10px 15px rgba(16, 185, 129, 0.2); }
        .footer-col-title { font-size: 13px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.5px; color: #0f172a; margin-bottom: 28px; }
        .footer-links { list-style: none; padding: 0; display: flex; flex-direction: column; gap: 14px; }
        .footer-links a { font-size: 15px; color: #64748b; text-decoration: none; transition: color 0.2s ease; }
        .footer-links a:hover { color: #10B981; }
        .footer-bottom { margin-top: 0; padding-top: 32px; border-top: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; color: #94a3b8; font-size: 14px; }
        .footer-bottom-right { display: flex; gap: 24px; align-items: center; color: #475569; font-weight: 500; }
        @media (max-width: 1024px) { .footer-grid { grid-template-columns: repeat(2, 1fr); gap: 40px; } }
        @media (max-width: 640px) { .footer-grid { grid-template-columns: 1fr; } .footer-bottom { flex-direction: column; text-align: center; gap: 20px; } }
        .personal-page { max-width: 820px; margin: 0 auto; padding: 40px 24px 80px; }
        .hero-section { position: relative; text-align: center; margin-bottom: 44px; padding: 80px 0; overflow: hidden; border-radius: 24px; }
        .hero-section::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: radial-gradient(circle at 70% 30%, rgba(34, 197, 94, 0.2) 0%, transparent 60%), radial-gradient(circle at 30% 70%, rgba(16, 185, 129, 0.15) 0%, transparent 60%); z-index: -1; }
        .hero-badge { display: inline-flex; align-items: center; gap: 8px; background: rgba(34, 197, 94, 0.12); border: 1.5px solid rgba(34, 197, 94, 0.35); color: #86efac; font-size: 13px; font-weight: 600; letter-spacing: 0.4px; padding: 8px 20px; border-radius: 50px; margin-bottom: 22px; }
        .hero-badge::before { content: ''; display: inline-block; width: 8px; height: 8px; border-radius: 50%; background: var(--primary); animation: pulse 1.8s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; transform: scale(1); } 50% { opacity: 0.45; transform: scale(1.4); } }
        .hero-title { font-size: clamp(2rem, 5vw, 3rem); font-weight: 800; color: #ffffff; line-height: 1.2; margin-bottom: 14px; letter-spacing: -0.5px; }
        .hero-title span { background: linear-gradient(135deg, #22c55e, #4ade80); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .hero-subtitle { font-size: 16px; color: rgba(255, 255, 255, 0.6); max-width: 550px; margin: 0 auto; line-height: 1.8; }
        .main-card { background: #ffffff; border-radius: var(--radius-card); box-shadow: var(--shadow-card); padding: 40px 44px; border: 1px solid #e5e7eb; transition: box-shadow var(--transition); position: relative; z-index: 10; }
        .main-card:hover { box-shadow: var(--shadow-hover); }
        .card-title { font-size: 18px; font-weight: 700; color: #111827; margin-bottom: 22px; display: flex; align-items: center; gap: 10px; }
        .card-title-icon { width: 36px; height: 36px; background: var(--primary-light); border-radius: 9px; display: flex; align-items: center; justify-content: center; font-size: 17px; border: 1px solid var(--primary-mid); }
        .progress-wrapper { display: flex; align-items: flex-start; margin-bottom: 30px; }
        .progress-step { display: flex; flex-direction: column; align-items: center; flex: 1; }
        .progress-dot { width: 30px; height: 30px; border-radius: 50%; background: var(--primary); color: #fff; font-size: 12px; font-weight: 700; display: flex; align-items: center; justify-content: center; position: relative; z-index: 1; box-shadow: 0 3px 10px rgba(34, 197, 94, 0.35); }
        .progress-dot.inactive { background: #e5e7eb; color: #9ca3af; box-shadow: none; }
        .progress-connector { flex: 1; height: 2px; background: var(--primary-mid); margin-top: 15px; }
        .progress-connector.inactive { background: #e5e7eb; }
        .progress-label { font-size: 11px; color: #6b7280; margin-top: 7px; font-weight: 500; white-space: nowrap; }
        .progress-label.active { color: var(--primary-dark); font-weight: 700; }
        .section-divider { border: none; border-top: 1.5px solid #f3f4f6; margin: 26px 0; }
        .section-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.1px; color: #9ca3af; margin-bottom: 14px; }
        .form-group { display: flex; flex-direction: column; gap: 7px; margin-bottom: 4px; }
        .form-label { font-size: 13px; font-weight: 600; color: #374151; }
        .form-select { appearance: none; -webkit-appearance: none; background-color: #f9fafb; border: 1.5px solid #e5e7eb; border-radius: 10px; padding: 12px 40px 12px 15px; font-size: 14px; font-family: 'Inter', sans-serif; color: #111827; width: 100%; cursor: pointer; transition: border-color var(--transition), box-shadow var(--transition); background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2322c55e' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 13px center; }
        .form-select:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.15); background-color: #ffffff; }
        .form-select:hover { border-color: var(--primary); }
        .skills-section { margin-top: 26px; }
        .skills-grid { display: flex; flex-wrap: wrap; gap: 10px; }
        .skill-tag { display: inline-flex; align-items: center; gap: 7px; padding: 9px 18px; border-radius: 50px; border: 1.5px solid #e5e7eb; background: #f9fafb; color: #6b7280; font-size: 13px; font-weight: 600; cursor: pointer; user-select: none; transition: all var(--transition); }
        .skill-tag:hover { border-color: var(--primary); color: var(--primary-dark); background: var(--primary-light); transform: translateY(-1px); }
        .skill-tag.selected { background: var(--primary); border-color: var(--primary-dark); color: #ffffff; box-shadow: 0 4px 14px rgba(34, 197, 94, 0.35); transform: translateY(-1px); }
        .skill-icon { font-size: 15px; }
        .btn-group { display: flex; align-items: center; gap: 14px; margin-top: 34px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; height: 48px; padding: 0 28px; border-radius: var(--radius-btn); font-size: 14px; font-weight: 600; font-family: 'Inter', sans-serif; letter-spacing: 0.2px; cursor: pointer; border: none; transition: all var(--transition); white-space: nowrap; }
        .btn-primary { background: linear-gradient(135deg, #22c55e, #16a34a); color: #ffffff; box-shadow: 0 6px 20px rgba(34, 197, 94, 0.35); }
        .btn-primary:hover { background: linear-gradient(135deg, #16a34a, #15803d); box-shadow: 0 10px 28px rgba(34, 197, 94, 0.50); transform: translateY(-2px); }
        .btn-primary:active { transform: translateY(0); }
        .info-strip { margin-top: 26px; background: linear-gradient(135deg, #f0fdf4, #dcfce7); border: 1px solid #bbf7d0; border-radius: 12px; padding: 14px 18px; display: flex; align-items: flex-start; gap: 12px; font-size: 13px; color: #166534; line-height: 1.6; }
        .info-strip-icon { font-size: 20px; flex-shrink: 0; margin-top: 1px; }
        .info-strip strong { color: #15803d; }
        @media (max-width: 600px) { .main-card { padding: 28px 18px; } .btn-group { flex-direction: column; align-items: stretch; } .btn { width: 100%; } }
    </style>
</head>

<body>

    <%-- Include common navbar header --%>
    <jsp:include page="../common/header.jsp" />
    <%-- User pill include --%>
    <jsp:include page="../common/userbuttom.jsp" />

    <style>
        /* ... (Giữ nguyên Post-Header Overrides) ... */
        header.glass-header-nav, .glass-header-nav { background: linear-gradient(90deg, #0f2027 0%, #134e4a 50%, #0b3d2e 100%) !important; backdrop-filter: blur(16px) !important; -webkit-backdrop-filter: blur(16px) !important; border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important; box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1) !important; position: fixed !important; top: 0 !important; left: 0 !important; width: 100% !important; z-index: 50 !important; }
        .user-pill, .site-header-wrapper div.fixed, div.fixed.bottom-6.left-6 { position: fixed !important; bottom: 20px !important; left: 20px !important; top: auto !important; right: auto !important; z-index: 9999 !important; margin: 0 !important; width: auto !important; height: auto !important; }
        .user-pill .animate-border { position: relative !important; display: inline-flex !important; padding: 4px !important; border-radius: 999px !important; background: rgba(255, 255, 255, 0.15) !important; backdrop-filter: blur(10px) !important; -webkit-backdrop-filter: blur(10px) !important; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.25) !important; border: 1px solid rgba(255, 255, 255, 0.25) !important; overflow: hidden !important; transition: transform 0.3s ease !important; }
        .user-pill .animate-border:hover { transform: translateY(-5px) !important; }
        @keyframes rotateGlow { from { transform: translate(-50%, -50%) rotate(0deg); } to { transform: translate(-50%, -50%) rotate(360deg); } }
        .user-pill .animate-border::before { content: '' !important; display: block !important; position: absolute !important; top: 50% !important; left: 50% !important; width: 150% !important; height: 150% !important; background: radial-gradient(circle, rgba(34, 197, 94, 0.6) 0%, transparent 65%) !important; animation: rotateGlow 6s linear infinite !important; z-index: -1 !important; }
        #userMenuButton { background: transparent !important; border: none !important; border-radius: 999px !important; padding: 6px 18px 6px 6px !important; gap: 12px !important; box-shadow: none !important; }
        #userMenuButton p { color: #0f172a !important; font-weight: 700 !important; letter-spacing: -0.2px !important; }
        #userMenuButton span.text-primary, #userMenuButton span[class*="text-green"] { color: #16a34a !important; font-weight: 800 !important; font-size: 10px !important; }
        #userDropdown { position: absolute !important; bottom: calc(100% + 15px) !important; top: auto !important; left: 0 !important; right: auto !important; transform-origin: bottom left !important; background: rgba(255, 255, 255, 0.95) !important; backdrop-filter: blur(20px) !important; border: 1px solid rgba(255, 255, 255, 0.2) !important; box-shadow: 0 -10px 50px rgba(0, 0, 0, 0.3) !important; }
    </style>

    <div class="personal-page" style="padding-top: 100px;">

        <section class="hero-section">
            <div class="hero-badge">Start Your Learning Journey</div>
            <h1 class="hero-title">Create <span>Personalized</span> Roadmap</h1>
            <p class="hero-subtitle">
                Target your major and skills you want to develop — AI will build an optimal learning roadmap tailored just for you.
            </p>
        </section>

        <div class="main-card">

            <div class="card-title">
                <div class="card-title-icon">🎯</div>
                Info & Goals
            </div>

            <div class="progress-wrapper">
                <div class="progress-step">
                    <div class="progress-dot">1</div>
                    <span class="progress-label active">Information</span>
                </div>
                <div class="progress-connector"></div>
                <div class="progress-step">
                    <div class="progress-dot">2</div>
                    <span class="progress-label active">Skills</span>
                </div>
                <div class="progress-connector inactive"></div>
                <div class="progress-step">
                    <div class="progress-dot inactive">3</div>
                    <span class="progress-label">Roadmap</span>
                </div>
            </div>

            <hr class="section-divider">

            <form id="personalForm" action="${pageContext.request.contextPath}/roadmap" method="GET">
                <p class="section-label">Learning Goals</p>
                <div class="form-group">
                    <label class="form-label" for="major">🎓 Target Major</label>
                    <select class="form-select" id="major" name="major" required>
                        <option value="" selected disabled>-- Select Major --</option>
                        <option value="se">Software Engineering</option>
                        <option value="ai">Artificial Intelligence</option>
                        <option value="ds">Data Science</option>
                        <option value="is">Information Systems</option>
                        <option value="cs">Computer Science</option>
                        <option value="ns">Network & Security</option> 
                    </select>
                </div>

                <hr class="section-divider">

                <div class="skills-section">
                    <p class="section-label">Skills You Already Have</p>
                    <div class="skills-grid" id="skillsGrid">
                        <div class="skill-tag" data-skill="c" onclick="toggleSkill(this)">
                            <span class="skill-icon">⚙️</span> C Programming
                        </div>
                        <div class="skill-tag" data-skill="java" onclick="toggleSkill(this)">
                            <span class="skill-icon">☕</span> Java OOP
                        </div>
                        <div class="skill-tag" data-skill="python" onclick="toggleSkill(this)">
                            <span class="skill-icon">🐍</span> Python
                        </div>
                        <div class="skill-tag" data-skill="js" onclick="toggleSkill(this)">
                            <span class="skill-icon">✨</span> JavaScript
                        </div>
                        <div class="skill-tag" data-skill="html" onclick="toggleSkill(this)">
                            <span class="skill-icon">🌐</span> HTML & CSS
                        </div>
                    </div>
                    <input type="hidden" id="selectedSkills" name="skills" value="">
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary" id="btnCreate">
                        🤖 Generate AI Roadmap
                    </button>
                </div>
            </form>

            <div class="info-strip">
                <span class="info-strip-icon">💡</span>
                <span>
                    <strong>Tip:</strong> Select multiple skills to help AI understand your background better and create the most suitable roadmap for your current level.
                </span>
            </div>
        </div>
    </div>

    <footer class="bg-white border-t border-emerald-100 pt-24 pb-12">
        <div class="max-w-canvas mx-auto px-8 lg:px-12">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-16 mb-24">
                <div class="lg:col-span-2">
                    <div class="flex items-center gap-2 mb-8">
                        <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-[#101b0d]">
                            <span class="material-symbols-outlined text-xl font-bold">terminal</span>
                        </div>
                        <h2 class="text-xl font-black tracking-tight">IT-LEARN</h2>
                    </div>
                    <p class="text-gray-500 dark:text-gray-400 text-base leading-relaxed mb-8 max-w-sm">
                        Accompanying thousands of students on their journey to becoming professional software engineers with practical curriculum.
                    </p>
                    <div class="flex gap-4">
                        <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                            <span class="material-symbols-outlined text-xl">social_leaderboard</span>
                        </a>
                        <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                            <span class="material-symbols-outlined text-xl">terminal</span>
                        </a>
                        <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                            <span class="material-symbols-outlined text-xl">smart_display</span>
                        </a>
                    </div>
                </div>
                <div>
                    <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Courses</h4>
                    <ul class="space-y-4">
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Frontend Development</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Backend Development</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Mobile Development</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Data Science &amp; AI</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">DevOps &amp; Cloud</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Resources</h4>
                    <ul class="space-y-4">
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Tech Blog</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Learning Community</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Free Materials</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">YouTube Channel</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">IT Podcast</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Quick Links</h4>
                    <ul class="space-y-4">
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">About Us</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Careers</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Terms of Service</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Privacy Policy</a></li>
                        <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Contact</a></li>
                    </ul>
                </div>
            </div>
            <div class="pt-12 border-t border-gray-100 dark:border-white/5 flex flex-col md:flex-row justify-between items-center gap-6">
                <p class="text-sm text-gray-500">© 2024 DevLearn Academy. Built for the tech community.</p>
                <div class="flex items-center gap-8">
                    <span class="text-sm text-gray-500 flex items-center gap-2">
                        <span class="material-symbols-outlined text-lg">language</span> English
                    </span>
                    <span class="text-sm text-gray-500 flex items-center gap-2">
                        <span class="material-symbols-outlined text-lg">support_agent</span> 1900 1234
                    </span>
                </div>
            </div>
        </div>
    </footer>

    <script>
        function toggleSkill(el) {
            el.classList.toggle('selected');
            syncSkillsInput();
        }
        function syncSkillsInput() {
            var selected = [];
            document.querySelectorAll('.skill-tag.selected').forEach(function (tag) {
                selected.push(tag.getAttribute('data-skill'));
            });
            document.getElementById('selectedSkills').value = selected.join(',');
        }
        
        // JS bây giờ có thể tóm được form vì anh đã thêm id="personalForm" ở trên
        document.getElementById('personalForm').addEventListener('submit', function () {
            syncSkillsInput();
        });
    </script>
</body>
</html>