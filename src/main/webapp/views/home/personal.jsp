<%-- Learning Paths – DevLearn --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Paths | DevLearn</title>
    <meta name="description" content="Create a personalized AI learning roadmap tailored to your major and skills on DevLearn.">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "primary": "#10B981",
                        "background-light": "#0F172A",
                        "background-dark": "#0F172A",
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"]
                    },
                    maxWidth: {
                        "canvas": "1200px",
                    }
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        /* major card */
        .major-card { transition: all 0.3s ease; }
        .major-card:hover { transform: translateY(-6px); }
        .major-card.selected {
            border-color: #10B981 !important;
            background: linear-gradient(135deg, #ecfdf5, #d1fae5) !important;
            box-shadow: 0 8px 30px rgba(16,185,129,0.15);
        }
        .major-card.selected .major-check { display: flex; }
        /* skill pill */
        .skill-pill { transition: all 0.2s ease; }
        .skill-pill:hover {
            border-color: #a7f3d0;
            background: #f0fdf4;
            transform: translateY(-1px);
        }
        .skill-pill.selected {
            background: linear-gradient(135deg, #10B981, #059669) !important;
            border-color: transparent !important;
            color: #fff !important;
            box-shadow: 0 4px 16px rgba(16,185,129,0.3);
            transform: translateY(-1px);
        }
        /* hide native select */
        .hidden-select { display: none !important; }
        /* animate entrance */
        .animate-fade-up {
            animation: fadeUpAnim 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
        }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        @keyframes fadeUpAnim {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body class="font-display antialiased" style="background: linear-gradient(135deg, #f8fffc, #e6f7f1); color: #0f172a;">
    <div class="relative flex min-h-screen w-full flex-col">

        <jsp:include page="../common/header.jsp" />

        <main class="flex-1">

            <!-- ═══ HERO SECTION ══════════════════════════════════════════ -->
            <section class="relative min-h-[480px] flex items-center justify-center overflow-hidden">
                <div class="absolute inset-0 -z-10"
                     style="background: radial-gradient(circle at 50% 65%, rgba(16,185,129,0.2) 0%, rgba(16,185,129,0.1) 20%, transparent 60%),
                            linear-gradient(135deg, #0f172a 0%, #064e3b 40%, #000000 100%);">
                </div>
                <div class="absolute inset-0 overflow-hidden pointer-events-none z-0">
                    <div class="absolute inset-0 bg-[linear-gradient(rgba(16,185,129,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(16,185,129,0.03)_1px,transparent_1px)] bg-[size:3rem_3rem] [mask-image:radial-gradient(ellipse_60%_60%_at_50%_65%,#000_70%,transparent_100%)] opacity-50"></div>
                </div>

                <div class="max-w-canvas mx-auto px-6 lg:px-12 relative z-10 text-center flex flex-col items-center py-28">

                    <div class="inline-flex items-center gap-2 px-5 py-2 rounded-full bg-white/5 border border-white/10 text-emerald-400 text-sm font-semibold tracking-wide mb-8 backdrop-blur-md shadow-[0_0_20px_rgba(16,185,129,0.15)] animate-fade-up delay-1">
                        <span class="relative flex h-2 w-2">
                            <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                            <span class="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                        </span>
                        AI-Powered Roadmap Generator
                    </div>

                    <h1 class="text-4xl md:text-5xl lg:text-6xl font-black leading-[1.1] tracking-tighter mb-6 text-white max-w-3xl mx-auto drop-shadow-2xl animate-fade-up delay-2">
                        Build Your
                        <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-400">Personalized Roadmap</span>
                    </h1>

                    <p class="text-lg text-white/60 max-w-xl mx-auto leading-relaxed animate-fade-up delay-3">
                        Tell us your major and existing skills — our AI will craft the optimal learning path just for you.
                    </p>
                </div>
            </section>

            <!-- ═══ STATS BAR ═════════════════════════════════════════════ -->
            <section class="py-10 relative z-10 border-t border-emerald-100">
                <div class="max-w-canvas mx-auto px-8 lg:px-12">
                    <div class="bg-white rounded-3xl shadow-2xl border border-emerald-100 py-10 animate-fade-up delay-2">
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
                            <div class="flex flex-col items-center gap-2">
                                <span class="text-3xl font-black text-primary">12K+</span>
                                <span class="text-xs font-semibold uppercase tracking-widest text-slate-500">Roadmaps Created</span>
                            </div>
                            <div class="flex flex-col items-center gap-2">
                                <span class="text-3xl font-black text-primary">6</span>
                                <span class="text-xs font-semibold uppercase tracking-widest text-slate-500">Supported Majors</span>
                            </div>
                            <div class="flex flex-col items-center gap-2">
                                <span class="text-3xl font-black text-primary">98%</span>
                                <span class="text-xs font-semibold uppercase tracking-widest text-slate-500">Satisfaction Rate</span>
                            </div>
                            <div class="flex flex-col items-center gap-2">
                                <span class="text-3xl font-black text-primary">24/7</span>
                                <span class="text-xs font-semibold uppercase tracking-widest text-slate-500">AI Always Ready</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ═══ MAIN FORM SECTION ═════════════════════════════════════ -->
            <section class="py-12 lg:py-16">
                <div class="max-w-[860px] mx-auto px-6 lg:px-12">

                    <!-- Card chính chứa form -->
                    <div class="bg-white rounded-[2rem] shadow-xl border border-emerald-100 overflow-hidden animate-fade-up delay-3">

                        <!-- Tabs Header -->
                        <div class="border-b border-slate-100 px-8 pt-8 pb-0">
                            <div class="flex items-center gap-6 mb-0">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white text-xs font-bold shadow-lg shadow-emerald-200">
                                        <span class="material-symbols-outlined" style="font-size:16px; font-variation-settings: 'FILL' 1;">check</span>
                                    </div>
                                    <span class="text-sm font-bold text-primary">Set Goals</span>
                                </div>
                                <div class="w-12 h-[2px] bg-emerald-200 rounded"></div>
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-slate-400 text-xs font-bold">2</div>
                                    <span class="text-sm font-semibold text-slate-400">Major</span>
                                </div>
                                <div class="w-12 h-[2px] bg-slate-200 rounded"></div>
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-slate-400 text-xs font-bold">3</div>
                                    <span class="text-sm font-semibold text-slate-400">Roadmap</span>
                                </div>
                            </div>
                            <!-- Tab switcher -->
                            <div class="flex mt-6">
                                <button id="tabMajor" onclick="switchTab('major')"
                                    class="px-6 py-3 text-sm font-bold border-b-2 border-primary text-primary transition-all">
                                    Set Goals
                                </button>
                                <button id="tabSkills" onclick="switchTab('skills')"
                                    class="px-6 py-3 text-sm font-bold border-b-2 border-transparent text-slate-400 hover:text-slate-600 transition-all">
                                    Major
                                </button>
                            </div>
                        </div>

                        <!-- Form Body -->
                        <div class="p-8 lg:p-10">
                            <form id="personalForm" action="${pageContext.request.contextPath}/roadmap" method="GET">

                                <!-- Hidden select for form submit -->
                                <select class="hidden-select" id="majorSelect" name="major" required>
                                    <option value="" disabled selected></option>
                                    <option value="se">Software Engineering</option>
                                    <option value="ai">Artificial Intelligence</option>
                                    <option value="ds">Data Science</option>
                                    <option value="is">Information Systems</option>
                                    <option value="cs">Computer Science</option>
                                    <option value="ns">Network &amp; Security</option>
                                </select>

                                <!-- ── TAB 1: MAJOR ─────────────────────── -->
                                <div id="panelMajor">

                                    <!-- Major dropdown -->
                                    <div class="mb-8">
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Target Major</label>
                                        <div class="relative">
                                            <select id="majorDropdown" class="w-full appearance-none bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 text-sm text-slate-600 font-medium focus:outline-none focus:ring-2 focus:ring-emerald-200 focus:border-emerald-400 transition-all cursor-pointer" onchange="selectMajorFromDropdown(this.value)">
                                                <option value="" disabled selected>Select a major</option>
                                                <option value="se">Software Engineering</option>
                                                <option value="ai">Artificial Intelligence</option>
                                                <option value="ds">Data Science</option>
                                                <option value="is">Information Systems</option>
                                                <option value="cs">Computer Science</option>
                                                <option value="ns">Network &amp; Security</option>
                                            </select>
                                            <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" style="font-size:20px">expand_more</span>
                                        </div>
                                    </div>

                                    <!-- Major Cards -->
                                    <div class="mb-2">
                                        <p class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4 flex items-center gap-2">
                                            <span class="material-symbols-outlined" style="font-size:14px">school</span>
                                            Or quick select
                                        </p>
                                    </div>

                                    <div class="grid grid-cols-2 md:grid-cols-3 gap-4" id="majorGrid">
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="se" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">💻</div>
                                            <h3 class="text-sm font-bold text-slate-800">Software Eng.</h3>
                                            <p class="text-xs text-slate-400 mt-1">Build real-world systems</p>
                                        </div>
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="ai" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">🤖</div>
                                            <h3 class="text-sm font-bold text-slate-800">Artificial Intelligence</h3>
                                            <p class="text-xs text-slate-400 mt-1">ML, Deep Learning & more</p>
                                        </div>
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="ds" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">📊</div>
                                            <h3 class="text-sm font-bold text-slate-800">Data Science</h3>
                                            <p class="text-xs text-slate-400 mt-1">Analytics & visualization</p>
                                        </div>
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="is" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">🗄️</div>
                                            <h3 class="text-sm font-bold text-slate-800">Info. Systems</h3>
                                            <p class="text-xs text-slate-400 mt-1">Business & tech bridge</p>
                                        </div>
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="cs" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">🔬</div>
                                            <h3 class="text-sm font-bold text-slate-800">Computer Science</h3>
                                            <p class="text-xs text-slate-400 mt-1">Theory & algorithms</p>
                                        </div>
                                        <div class="major-card relative bg-slate-50 border-2 border-slate-100 rounded-2xl p-5 cursor-pointer hover:shadow-lg" data-value="ns" onclick="pickMajor(this)">
                                            <div class="major-check absolute top-3 right-3 w-6 h-6 rounded-full bg-primary hidden items-center justify-center shadow-md">
                                                <span class="material-symbols-outlined text-white" style="font-size:16px">check</span>
                                            </div>
                                            <div class="text-3xl mb-3">🔐</div>
                                            <h3 class="text-sm font-bold text-slate-800">Network & Security</h3>
                                            <p class="text-xs text-slate-400 mt-1">Cybersecurity & infra</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- ── SKILLS ─────────────────────── -->
                                <div class="mt-10 pt-8 border-t border-slate-100">
                                    <div class="flex items-center justify-between mb-5">
                                        <p class="text-xs font-bold uppercase tracking-widest text-slate-400 flex items-center gap-2">
                                            <span class="material-symbols-outlined" style="font-size:14px">psychology</span>
                                            Skills You Have (<span id="skillCount">0</span>)
                                        </p>
                                    </div>

                                    <div class="flex flex-wrap gap-3" id="skillsGrid">
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="c" onclick="toggleSkill(this)">C programming</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="java" onclick="toggleSkill(this)">Java OOP</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="python" onclick="toggleSkill(this)">Python</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="js" onclick="toggleSkill(this)">JavaScript</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="html" onclick="toggleSkill(this)">HTML & CSS</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="sql" onclick="toggleSkill(this)">SQL / Database</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="react" onclick="toggleSkill(this)">React / Next.js</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="git" onclick="toggleSkill(this)">Git / GitHub</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="web" onclick="toggleSkill(this)">Web Development</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="mobile" onclick="toggleSkill(this)">Mobile Dev</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="docker" onclick="toggleSkill(this)">Docker</div>
                                        <div class="skill-pill inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-slate-200 bg-white text-sm font-semibold text-slate-600 cursor-pointer select-none" data-skill="linux" onclick="toggleSkill(this)">Linux</div>
                                    </div>

                                    <input type="hidden" id="selectedSkills" name="skills" value="">
                                </div>

                                <!-- ── CTA ─────────────────────────── -->
                                <div class="mt-10 flex flex-col sm:flex-row items-center gap-4">
                                    <button type="submit" id="btnCreate"
                                        class="w-full sm:w-auto h-14 px-10 bg-gradient-to-r from-emerald-500 to-emerald-600 text-white text-base font-bold rounded-2xl shadow-xl shadow-emerald-500/20 hover:shadow-emerald-500/40 hover:scale-[1.02] transition-all flex items-center justify-center gap-3 group">
                                        <span class="material-symbols-outlined" style="font-size:20px">auto_awesome</span>
                                        Generate AI Roadmap
                                        <span class="material-symbols-outlined transition-transform group-hover:translate-x-1" style="font-size:18px">arrow_forward</span>
                                    </button>
                                </div>

                                <!-- Tip -->
                                <div class="mt-6 flex items-start gap-3 px-5 py-4 rounded-2xl bg-emerald-50 border border-emerald-100">
                                    <span class="material-symbols-outlined text-primary flex-shrink-0" style="font-size:20px">lightbulb</span>
                                    <p class="text-sm text-emerald-800 leading-relaxed">
                                        <strong class="font-bold">Tip:</strong> Select multiple skills so the AI can better understand your current level and create a more accurate roadmap.
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ═══ CTA BANNER ════════════════════════════════════════════ -->
            <section class="pb-24 lg:pb-32 px-8 lg:px-12">
                <div class="max-w-canvas mx-auto rounded-[3rem] p-12 lg:p-24 relative overflow-hidden text-center flex flex-col items-center" style="background: linear-gradient(135deg, #ecfdf5, #d1fae5);">
                    <div class="absolute top-0 right-0 w-[400px] h-[400px] bg-primary/20 rounded-full blur-[120px]"></div>
                    <div class="absolute bottom-0 left-0 w-[300px] h-[300px] bg-primary/10 rounded-full blur-[100px]"></div>
                    <h2 class="text-3xl lg:text-5xl font-black text-[#0f172a] mb-6 max-w-3xl leading-tight z-10">
                        Ready to start your learning journey?
                    </h2>
                    <p class="text-lg text-[#475569] mb-10 max-w-2xl z-10">
                        Over 12,000 students already trust us. Create your personalized roadmap today — completely free.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 z-10">
                        <a href="${pageContext.request.contextPath}/shop"
                           class="h-14 px-10 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white text-base font-bold rounded-2xl shadow-xl shadow-emerald-500/20 hover:shadow-emerald-500/40 hover:scale-105 transition-all flex items-center justify-center gap-2"
                           style="text-decoration: none;">
                            <span class="material-symbols-outlined">play_arrow</span>
                            Explore Courses
                        </a>
                        <a href="${pageContext.request.contextPath}/home"
                           class="h-14 px-10 border-2 border-emerald-300 text-[#0f172a] text-base font-bold rounded-2xl hover:bg-emerald-100 transition-all flex items-center justify-center"
                           style="text-decoration: none;">
                            Back to Home
                        </a>
                    </div>
                </div>
            </section>

        </main>

        <jsp:include page="../common/footer.jsp" />
    </div>

    <jsp:include page="../common/userbuttom.jsp" />

    <script>
        /* ── Major selection ──────────────────── */
        function pickMajor(card) {
            document.querySelectorAll('.major-card').forEach(c => c.classList.remove('selected'));
            card.classList.add('selected');
            const val = card.dataset.value;
            document.getElementById('majorSelect').value = val;
            document.getElementById('majorDropdown').value = val;
        }

        function selectMajorFromDropdown(val) {
            document.getElementById('majorSelect').value = val;
            document.querySelectorAll('.major-card').forEach(c => {
                c.classList.toggle('selected', c.dataset.value === val);
            });
        }

        /* ── Skill toggle ─────────────────────── */
        function toggleSkill(el) {
            el.classList.toggle('selected');
            syncSkills();
        }

        function syncSkills() {
            const arr = [];
            document.querySelectorAll('.skill-pill.selected').forEach(t => arr.push(t.dataset.skill));
            document.getElementById('selectedSkills').value = arr.join(',');
            document.getElementById('skillCount').textContent = arr.length;
        }

        /* ── Tab switching ────────────────────── */
        function switchTab(tab) {
            const tabMajor = document.getElementById('tabMajor');
            const tabSkills = document.getElementById('tabSkills');
            if (tab === 'major') {
                tabMajor.classList.add('border-primary', 'text-primary');
                tabMajor.classList.remove('border-transparent', 'text-slate-400');
                tabSkills.classList.remove('border-primary', 'text-primary');
                tabSkills.classList.add('border-transparent', 'text-slate-400');
            } else {
                tabSkills.classList.add('border-primary', 'text-primary');
                tabSkills.classList.remove('border-transparent', 'text-slate-400');
                tabMajor.classList.remove('border-primary', 'text-primary');
                tabMajor.classList.add('border-transparent', 'text-slate-400');
            }
        }

        /* ── Form validation ──────────────────── */
        document.getElementById('personalForm').addEventListener('submit', function(e) {
            syncSkills();
            if (!document.getElementById('majorSelect').value) {
                e.preventDefault();
                document.querySelectorAll('.major-card').forEach(c => {
                    c.style.borderColor = '#fca5a5';
                    setTimeout(() => { c.style.borderColor = ''; }, 1500);
                });
                document.getElementById('majorGrid').scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
    </script>

</body>
</html>