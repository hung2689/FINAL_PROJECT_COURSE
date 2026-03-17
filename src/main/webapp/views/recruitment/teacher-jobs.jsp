<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teach at DevLearn - Join Our Instructor Team</title>
    <meta name="description" content="Become an instructor at DevLearn. Share your expertise, inspire thousands of learners, and grow your career in tech education.">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#10B981" },
                    fontFamily: { display: ["Inter", "sans-serif"] },
                    maxWidth: { canvas: "1200px" }
                }
            }
        }
    </script>
    <style>
        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body { font-family: 'Inter', sans-serif; }

        /* Animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up { animation: fadeInUp 0.75s cubic-bezier(0.16,1,0.3,1) both; }
        .d1 { animation-delay: .08s; }
        .d2 { animation-delay: .22s; }
        .d3 { animation-delay: .38s; }
        .d4 { animation-delay: .54s; }

        @keyframes floatY {
            0%,100% { transform: translateY(0); }
            50%      { transform: translateY(-10px); }
        }
        .float { animation: floatY 3s ease-in-out infinite; }

        @keyframes ping {
            75%,100% { transform: scale(2); opacity: 0; }
        }
        .dot-ping { animation: ping 1.3s cubic-bezier(0,0,0.2,1) infinite; }

        @keyframes spinRing {
            to { transform: rotate(360deg); }
        }
        .spin-ring { animation: spinRing 22s linear infinite; }

        /* Hero */
        .hero-bg {
            background-color: #edfcf4;
            background-image: radial-gradient(circle, rgba(16,185,129,.16) 1.4px, transparent 1.4px);
            background-size: 26px 26px;
        }

        /* Pill badge */
        .pill {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 5px 13px; border-radius: 9999px;
            font-size: 11.5px; font-weight: 700; letter-spacing: .04em;
        }

        /* CTA buttons */
        .btn-primary {
            background: linear-gradient(130deg,#10B981,#059669);
            box-shadow: 0 6px 22px rgba(16,185,129,.38);
            transition: all .25s ease; color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(130deg,#059669,#047857);
            box-shadow: 0 10px 30px rgba(16,185,129,.5);
            transform: translateY(-2px);
        }
        .btn-outline {
            border: 2px solid #6ee7b7; color: #065f46;
            transition: all .22s ease;
        }
        .btn-outline:hover { background: #ecfdf5; border-color: #10B981; transform: translateY(-1px); }

        /* Illustrated card */
        .card-shadow { filter: drop-shadow(0 24px 40px rgba(16,185,129,.18)) drop-shadow(0 4px 14px rgba(0,0,0,.07)); }

        /* Wave divider */
        .wave-wrap { line-height: 0; }

        /* Job cards */
        .job-card { transition: all .28s cubic-bezier(.4,0,.2,1); }
        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 18px 44px -10px rgba(16,185,129,.17);
            border-color: rgba(16,185,129,.4) !important;
        }

        /* Apply button */
        .apply-btn {
            background: linear-gradient(130deg,#10B981,#059669);
            transition: all .22s ease;
        }
        .apply-btn:hover {
            background: linear-gradient(130deg,#059669,#047857);
            box-shadow: 0 8px 20px -4px rgba(16,185,129,.45);
            transform: translateY(-1px);
        }

        /* Benefits section */
        .benefit-card { transition: all .28s ease; }
        .benefit-card:hover { transform: translateY(-4px); box-shadow: 0 14px 32px -8px rgba(16,185,129,.15); }

        /* ===========================
           MARQUEE — Infinite scroll
        =========================== */
        @keyframes marqueeScroll {
            from { transform: translateX(0); }
            to   { transform: translateX(-50%); }
        }

        .marquee-outer {
            position: relative;
            width: 100%;
            overflow: hidden;
            -webkit-mask-image: linear-gradient(to right, transparent 0%, #000 8%, #000 92%, transparent 100%);
            mask-image: linear-gradient(to right, transparent 0%, #000 8%, #000 92%, transparent 100%);
        }

        .marquee-track {
            display: flex;
            gap: 20px;
            width: max-content;
            animation: marqueeScroll var(--marquee-speed, 40s) linear infinite;
            will-change: transform;
        }

        .marquee-outer:hover .marquee-track {
            animation-play-state: paused;
        }

        .marquee-item {
            flex-shrink: 0;
            width: 340px;
            height: 240px;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 8px 28px rgba(0,0,0,0.12);
            transition: transform .3s ease, box-shadow .3s ease;
        }

        .marquee-item:hover {
            transform: scale(1.03);
            box-shadow: 0 16px 40px rgba(0,0,0,0.18);
        }

        .marquee-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
    </style>
</head>

<body class="min-h-screen flex flex-col" style="background:#fff; color:#0f172a;">
    <jsp:include page="/views/common/header.jsp"/>

    <main class="flex-1">

        <!-- ====== HERO ====== -->
        <section class="hero-bg relative overflow-hidden pt-20">

            <div class="absolute -top-28 -right-28 w-[500px] h-[500px] rounded-full pointer-events-none"
                 style="background:radial-gradient(circle,rgba(16,185,129,.22) 0%,rgba(209,250,229,.25) 55%,transparent 75%);"></div>

            <div class="max-w-canvas w-full mx-auto px-6 lg:px-12">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-10 items-center py-16 lg:py-20">

                    <!-- Left: Copy -->
                    <div class="space-y-7">

                        <!-- Pills -->
                        <div class="fade-in-up d1 flex flex-wrap gap-2">
                            <span class="pill bg-emerald-50 text-emerald-700 border border-emerald-200">
                                <span class="relative flex h-2 w-2">
                                    <span class="dot-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                                    <span class="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                                </span>
                                Now Hiring
                            </span>
                            <span class="pill bg-rose-50 text-rose-500 border border-rose-200">
                                <span class="material-symbols-outlined" style="font-size:14px;font-variation-settings:'FILL' 1;">local_fire_department</span>
                                Teaching Roles Open
                            </span>
                            <span class="pill bg-amber-50 text-amber-600 border border-amber-200">
                                <span class="material-symbols-outlined" style="font-size:14px;font-variation-settings:'FILL' 1;">emoji_events</span>
                                Top Employer 2025
                            </span>
                        </div>

                        <!-- Eyebrow -->
                        <p class="fade-in-up d1 text-slate-400 font-semibold uppercase tracking-[.2em] text-xs -mb-4">
                            DevLearn &middot; Teacher Recruitment
                        </p>

                        <!-- Headline -->
                        <h1 class="fade-in-up d2 text-[2.6rem] md:text-[3.2rem] font-black text-slate-900 leading-[1.06] tracking-tight">
                            Shape the Future<br/>
                            of <span class="text-emerald-600" style="text-decoration:underline wavy #10B981;text-underline-offset:7px;">Tech Education</span><br/>
                            with DevLearn
                        </h1>

                        <!-- Sub copy -->
                        <p class="fade-in-up d3 text-slate-500 text-[1.05rem] leading-relaxed max-w-lg">
                            Join our growing team of passionate instructors. Share your expertise,
                            inspire the next generation of developers, and build a rewarding
                            career in education &mdash; on your own schedule.
                        </p>

                        <!-- CTA -->
                        <div class="fade-in-up d4 flex flex-wrap items-center gap-3">
                            <a href="#job-list" class="btn-primary inline-flex items-center gap-2 px-7 py-3.5 rounded-xl font-bold text-sm">
                                <span class="material-symbols-outlined text-xl">work</span>
                                View Open Positions
                                <span class="material-symbols-outlined text-base">arrow_downward</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/home" class="btn-outline inline-flex items-center gap-2 px-6 py-3.5 rounded-xl font-bold text-sm">
                                <span class="material-symbols-outlined text-base">info</span>
                                Learn About DevLearn
                            </a>
                        </div>

                        <!-- Stats strip -->
                        <div class="fade-in-up d4 flex flex-wrap items-center gap-x-6 gap-y-3 pt-4 border-t border-slate-100">
                            <div>
                                <span class="text-2xl font-black text-emerald-600">50,000+</span>
                                <span class="text-xs text-slate-400 font-medium ml-1.5">active learners</span>
                            </div>
                            <div class="w-px h-6 bg-slate-200 hidden sm:block"></div>
                            <div>
                                <span class="text-2xl font-black text-emerald-600">120+</span>
                                <span class="text-xs text-slate-400 font-medium ml-1.5">courses</span>
                            </div>
                            <div class="w-px h-6 bg-slate-200 hidden sm:block"></div>
                            <div>
                                <span class="text-2xl font-black text-amber-500">4.9</span>
                                <span class="text-amber-400 font-black">&#9733;</span>
                                <span class="text-xs text-slate-400 font-medium ml-1">instructor rating</span>
                            </div>
                            <div class="w-px h-6 bg-slate-200 hidden sm:block"></div>
                            <div>
                                <span class="text-2xl font-black text-teal-600">200+</span>
                                <span class="text-xs text-slate-400 font-medium ml-1.5">applicants</span>
                            </div>
                        </div>
                    </div>

                    <!-- Right: Illustrated card -->
                    <div class="hidden lg:block relative min-h-[440px]">

                        <div class="absolute inset-0 flex items-center justify-center pointer-events-none">
                            <div class="w-[380px] h-[380px] rounded-full"
                                 style="background:linear-gradient(135deg,#d1fae5,#a7f3d0 50%,#6ee7b7);opacity:.3;filter:blur(4px);"></div>
                        </div>

                        <div class="spin-ring absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[315px] h-[315px] rounded-full border-[5px] border-dashed border-emerald-300/40 pointer-events-none"></div>

                        <div class="float card-shadow relative z-10 mx-auto w-[292px] mt-10">
                            <div class="bg-white rounded-3xl border border-slate-100 p-6">

                                <div class="flex items-center gap-3 mb-5 pb-4 border-b border-slate-50">
                                    <div class="w-11 h-11 rounded-2xl flex items-center justify-center flex-shrink-0"
                                         style="background:linear-gradient(135deg,#10B981,#059669);">
                                        <span class="material-symbols-outlined text-white text-xl">school</span>
                                    </div>
                                    <div>
                                        <p class="font-black text-slate-800 text-sm leading-tight">DevLearn Careers</p>
                                        <p class="text-[11px] text-slate-400 mt-0.5">Instructor Recruitment</p>
                                    </div>
                                    <span class="ml-auto text-[10px] font-black bg-emerald-100 text-emerald-700 px-2 py-1 rounded-lg tracking-wide">LIVE</span>
                                </div>

                                <div class="space-y-2.5 mb-5">
                                    <div class="flex items-center justify-between px-3.5 py-2.5 bg-emerald-50 border border-emerald-100 rounded-2xl">
                                        <div class="flex items-center gap-2.5">
                                            <div class="w-7 h-7 rounded-xl bg-emerald-100 flex items-center justify-center">
                                                <span class="material-symbols-outlined text-emerald-600" style="font-size:16px;">code</span>
                                            </div>
                                            <span class="text-xs font-semibold text-slate-700">Web Development</span>
                                        </div>
                                        <span class="text-[10px] font-black bg-emerald-500 text-white px-2.5 py-1 rounded-full">Full time</span>
                                    </div>
                                    <div class="flex items-center justify-between px-3.5 py-2.5 bg-orange-50 border border-orange-100 rounded-2xl">
                                        <div class="flex items-center gap-2.5">
                                            <div class="w-7 h-7 rounded-xl bg-orange-100 flex items-center justify-center">
                                                <span class="material-symbols-outlined text-orange-500" style="font-size:16px;">data_object</span>
                                            </div>
                                            <span class="text-xs font-semibold text-slate-700">Data Science</span>
                                        </div>
                                        <span class="text-[10px] font-black bg-orange-400 text-white px-2.5 py-1 rounded-full">Part time</span>
                                    </div>
                                    <div class="flex items-center justify-between px-3.5 py-2.5 bg-teal-50 border border-teal-100 rounded-2xl">
                                        <div class="flex items-center gap-2.5">
                                            <div class="w-7 h-7 rounded-xl bg-teal-100 flex items-center justify-center">
                                                <span class="material-symbols-outlined text-teal-600" style="font-size:16px;">psychology</span>
                                            </div>
                                            <span class="text-xs font-semibold text-slate-700">AI &amp; Machine Learning</span>
                                        </div>
                                        <span class="text-[10px] font-black bg-teal-500 text-white px-2.5 py-1 rounded-full">Full time</span>
                                    </div>
                                </div>

                                <div class="bg-slate-900 rounded-2xl px-4 py-3 flex items-center justify-between">
                                    <div>
                                        <p class="text-[9px] text-slate-500 uppercase tracking-widest mb-0.5">Flexible Schedule</p>
                                        <p class="text-emerald-400 font-black text-sm leading-tight">Teach on Your Terms</p>
                                    </div>
                                    <div class="w-9 h-9 rounded-xl bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-emerald-400" style="font-size:20px;">schedule</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Floating chip: Top Employer -->
                        <div class="float absolute top-4 right-2 bg-white border border-slate-100 shadow-xl rounded-2xl px-3.5 py-2.5 flex items-center gap-2.5 z-20" style="animation-delay:.6s;">
                            <div class="w-8 h-8 rounded-xl bg-amber-50 border border-amber-100 flex items-center justify-center flex-shrink-0">
                                <span class="material-symbols-outlined text-amber-500" style="font-size:16px;font-variation-settings:'FILL' 1;">emoji_events</span>
                            </div>
                            <div>
                                <p class="text-[11px] font-black text-slate-800 leading-none">Top Employer</p>
                                <p class="text-[10px] text-slate-400 mt-0.5">Vietnam 2024&#8211;2025</p>
                            </div>
                        </div>

                        <!-- Floating chip: applicants -->
                        <div class="float absolute bottom-6 left-0 bg-white border border-slate-100 shadow-xl rounded-2xl px-3.5 py-2.5 flex items-center gap-2.5 z-20" style="animation-delay:1.1s;">
                            <div class="flex -space-x-2 flex-shrink-0">
                                <span class="w-7 h-7 rounded-full border-2 border-white bg-emerald-400 flex items-center justify-center text-[10px] font-black text-white">T</span>
                                <span class="w-7 h-7 rounded-full border-2 border-white bg-teal-500 flex items-center justify-center text-[10px] font-black text-white">M</span>
                                <span class="w-7 h-7 rounded-full border-2 border-white bg-orange-400 flex items-center justify-center text-[10px] font-black text-white">A</span>
                                <span class="w-7 h-7 rounded-full border-2 border-white bg-slate-200 flex items-center justify-center text-[10px] font-bold text-slate-500">+</span>
                            </div>
                            <p class="text-[11px] font-semibold text-slate-600 whitespace-nowrap">200+ already applied</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Wave divider -->
            <div class="wave-wrap">
                <svg viewBox="0 0 1440 72" fill="none" xmlns="http://www.w3.org/2000/svg"
                     class="w-full block" style="height:72px;" preserveAspectRatio="none">
                    <path d="M0 36 C480 72 960 0 1440 36 L1440 72 L0 72 Z" fill="#ffffff"/>
                </svg>
            </div>
        </section>


        <!-- ====== WELCOME SECTION — Infinite photo carousel ====== -->
        <section class="py-20 bg-white overflow-hidden">

            <div class="max-w-canvas mx-auto px-6 lg:px-12 text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-black text-slate-900 uppercase tracking-wide mb-5">
                    Welcome to DevLearn
                </h2>
                <p class="text-slate-500 leading-relaxed max-w-2xl mx-auto text-[1.02rem]">
                    With the mission to become a <strong class="text-slate-700">leading technology education platform in Vietnam</strong>,
                    DevLearn is home to <strong class="text-slate-700">50,000+ learners</strong> and growing every day.
                    Join us &mdash; talented, passionate educators who want to make a real difference in aspiring developers' lives.
                </p>
            </div>

            <!-- Infinite scroll — Set A + Set B duplicated for seamless loop -->
            <div class="marquee-outer" style="--marquee-speed: 38s;">
                <div class="marquee-track">
                    <!-- Set A -->
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773505656/cv/ljevjwzdmgyc1doj79vm"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773505656/cv/ljevjwzdmgyc1doj79vm';"
                             alt="DevLearn event 1"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773505695/cv/fs848yvpxh6isjt2kwx6"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773505695/cv/fs848yvpxh6isjt2kwx6';"
                             alt="DevLearn event 2"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506735/cv/ntusbx9xffljz5tfiwod"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506735/cv/ntusbx9xffljz5tfiwod';"
                             alt="DevLearn event 3"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp';"
                             alt="DevLearn event 4"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu';"
                             alt="DevLearn event 5"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506805/cv/ewimwcimeutpn11nio05"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506805/cv/ewimwcimeutpn11nio05';"
                             alt="DevLearn event 6"/>
                    </div>
                    <div class="marquee-item">
                        <img src="${pageContext.request.contextPath}/anh/lenhat.jpg" alt="DevLearn event 7"/>
                    </div>
                    <!-- Set B (duplicate for seamless loop) -->
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773505656/cv/ljevjwzdmgyc1doj79vm"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773505656/cv/ljevjwzdmgyc1doj79vm';"
                             alt="DevLearn event 1"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773505695/cv/fs848yvpxh6isjt2kwx6"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773505695/cv/fs848yvpxh6isjt2kwx6';"
                             alt="DevLearn event 2"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506735/cv/ntusbx9xffljz5tfiwod"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506735/cv/ntusbx9xffljz5tfiwod';"
                             alt="DevLearn event 3"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp';"
                             alt="DevLearn event 4"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu';"
                             alt="DevLearn event 5"/>
                    </div>
                    <div class="marquee-item">
                        <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506805/cv/ewimwcimeutpn11nio05"
                             onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506805/cv/ewimwcimeutpn11nio05';"
                             alt="DevLearn event 6"/>
                    </div>
                    <div class="marquee-item">
                        <img src="${pageContext.request.contextPath}/anh/lenhat.jpg" alt="DevLearn event 7"/>
                    </div>
                </div>
            </div>

        </section>


        <!-- ====== JOB LISTINGS ====== -->
        <section id="job-list" class="py-16" style="background:#f8fffe;">
            <div class="max-w-canvas mx-auto px-4 lg:px-12">

                <div class="text-center mb-12">
                    <p class="text-emerald-600 font-bold text-xs uppercase tracking-[.2em] mb-3">Career Opportunities</p>
                    <h2 class="text-3xl md:text-4xl font-black text-slate-900 mb-3">
                        Latest <span class="text-emerald-600">Teaching Positions</span>
                    </h2>
                    <p class="text-slate-400 text-sm max-w-md mx-auto leading-relaxed">
                        Find the role that matches your expertise and teaching passion.
                    </p>
                </div>

                <!-- Filter bar -->
                <div class="bg-white border border-slate-100 rounded-2xl shadow-sm px-5 py-4 mb-8 flex flex-col md:flex-row gap-3 items-center">
                    <div class="relative flex-1 w-full md:max-w-xs">
                        <span class="material-symbols-outlined text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2 pointer-events-none" style="font-size:18px;">search</span>
                        <input type="text" id="searchInput" placeholder="Search positions..."
                               class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 bg-slate-50 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-emerald-400/40 focus:border-emerald-400 transition"
                               oninput="filterJobs()"/>
                    </div>
                    <select id="categoryFilter"
                            class="w-full md:w-56 px-3.5 py-2.5 rounded-xl border border-slate-200 bg-slate-50 text-sm text-slate-500 focus:outline-none focus:ring-2 focus:ring-emerald-400/40 focus:border-emerald-400 transition"
                            onchange="filterJobs()">
                        <option value="">All Categories</option>
                        <!-- Dynamically build unique category options from jobs -->
                        <c:set var="addedCategories" value="," />
                        <c:forEach var="j" items="${jobs}">
                            <c:if test="${not empty j.jobCategory and not fn:contains(addedCategories, fn:trim(j.jobCategory))}">
                                <option value="${fn:trim(j.jobCategory)}">${fn:trim(j.jobCategory)}</option>
                                <c:set var="addedCategories" value="${addedCategories}${fn:trim(j.jobCategory)}," />
                            </c:if>
                        </c:forEach>
                    </select>
                    <div class="ml-auto text-sm text-slate-400 whitespace-nowrap flex-shrink-0">
                        <span class="font-black text-slate-700 text-base" id="countNum">0</span> positions
                    </div>
                </div>

                <!-- Job cards -->
                <div class="space-y-4" id="jobListContainer">
                    <c:forEach var="job" items="${jobs}" varStatus="s">
                        <div class="job-card bg-white rounded-2xl border border-slate-100 px-6 py-5 shadow-sm"
                             data-title="${job.title}"
                             data-type="${not empty job.jobType ? job.jobType : 'Part time'}"
                             data-category="${not empty job.jobCategory ? fn:trim(job.jobCategory) : ''}">
                            <div class="flex flex-col md:flex-row items-start md:items-center gap-5 justify-between">

                                <div class="flex-1 min-w-0">
                                    <div class="flex flex-wrap items-center gap-2 mb-2.5">
                                        <c:choose>
                                            <c:when test="${job.jobType == 'Full time'}">
                                                <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                                    <span class="material-symbols-outlined text-sm" style="font-variation-settings:'FILL' 1;">check_circle</span>
                                                    Full time
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-bold bg-orange-50 text-orange-500 border border-orange-200">
                                                    <span class="material-symbols-outlined text-sm" style="font-variation-settings:'FILL' 1;">schedule</span>
                                                    Part time
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${not empty job.jobCategory}">
                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-semibold bg-slate-50 text-slate-500 border border-slate-200">
                                                <span class="material-symbols-outlined text-sm">category</span>
                                                ${job.jobCategory}
                                            </span>
                                        </c:if>
                                    </div>

                                    <h3 class="text-base md:text-lg font-bold text-slate-900 mb-2">${job.title}</h3>

                                    <div class="flex flex-wrap items-center gap-4 text-sm text-slate-400">
                                        <span class="inline-flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-base">location_on</span>
                                            <c:choose>
                                                <c:when test="${not empty job.location}">${job.location}</c:when>
                                                <c:otherwise>Hanoi, Vietnam</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="inline-flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-base">work</span>
                                            Instructor
                                        </span>
                                    </div>
                                </div>

                                <div class="flex-shrink-0 w-full md:w-auto flex justify-end">
                                    <a href="${pageContext.request.contextPath}/teacher-apply?jobId=${job.jobId}"
                                       class="apply-btn inline-flex items-center gap-2 px-6 py-2.5 rounded-full text-white text-sm font-bold w-full md:w-auto justify-center">
                                        <span class="material-symbols-outlined text-base">how_to_reg</span>
                                        Apply Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty jobs}">
                        <div class="text-center py-24">
                            <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-slate-100 mb-5">
                                <span class="material-symbols-outlined text-4xl text-slate-300">work_off</span>
                            </div>
                            <h3 class="text-xl font-bold text-slate-700 mb-2">No open positions right now</h3>
                            <p class="text-slate-400 text-sm">We're always looking for great talent. Check back soon!</p>
                        </div>
                    </c:if>

                    <div id="noResultState" class="hidden text-center py-24">
                        <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-slate-100 mb-5">
                            <span class="material-symbols-outlined text-4xl text-slate-300">search_off</span>
                        </div>
                        <h3 class="text-xl font-bold text-slate-700 mb-2">No results found</h3>
                        <p class="text-slate-400 text-sm">Try adjusting your search or filter.</p>
                    </div>
                </div>
            </div>
        </section>


        <!-- ====== WHY TEACH AT DEVLEARN ====== -->
        <section class="py-20 bg-white">
            <div class="max-w-canvas mx-auto px-4 lg:px-12">

                <div class="text-center mb-14">
                    <p class="text-emerald-600 font-bold text-xs uppercase tracking-[.2em] mb-3">Why Join Us</p>
                    <h2 class="text-3xl md:text-4xl font-black text-slate-900">
                        Why Teach at <span class="text-emerald-600">DevLearn</span>?
                    </h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-emerald-200">
                        <div class="w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition">
                            <span class="material-symbols-outlined text-emerald-600 text-2xl">monetization_on</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">Competitive Compensation</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Earn a competitive salary with performance bonuses and incentives based on your learners' success and course ratings.</p>
                    </div>

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-teal-200">
                        <div class="w-12 h-12 rounded-2xl bg-teal-50 border border-teal-100 flex items-center justify-center mb-5 group-hover:bg-teal-100 transition">
                            <span class="material-symbols-outlined text-teal-600 text-2xl">timer</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">Flexible Schedule</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Design your own teaching hours. Whether full-time or part-time, DevLearn adapts to your lifestyle and commitments.</p>
                    </div>

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-emerald-200">
                        <div class="w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition">
                            <span class="material-symbols-outlined text-emerald-600 text-2xl">groups</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">Massive Community</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Connect with 50,000+ motivated learners and a vibrant network of professional instructors across Vietnam and beyond.</p>
                    </div>

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-teal-200">
                        <div class="w-12 h-12 rounded-2xl bg-teal-50 border border-teal-100 flex items-center justify-center mb-5 group-hover:bg-teal-100 transition">
                            <span class="material-symbols-outlined text-teal-600 text-2xl">smart_toy</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">AI-Powered Platform</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Leverage our state-of-the-art LMS with AI grading, course builder tools, and real-time analytics to deliver outstanding lessons.</p>
                    </div>

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-emerald-200">
                        <div class="w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition">
                            <span class="material-symbols-outlined text-emerald-600 text-2xl">trending_up</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">Career Growth</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Build your personal brand, expand your professional network, and advance your career within a fast-growing edtech company.</p>
                    </div>

                    <div class="benefit-card bg-slate-50 border border-slate-100 rounded-2xl p-7 group hover:border-teal-200">
                        <div class="w-12 h-12 rounded-2xl bg-teal-50 border border-teal-100 flex items-center justify-center mb-5 group-hover:bg-teal-100 transition">
                            <span class="material-symbols-outlined text-teal-600 text-2xl">support_agent</span>
                        </div>
                        <h3 class="font-bold text-slate-900 text-base mb-2">Full Onboarding Support</h3>
                        <p class="text-slate-400 text-sm leading-relaxed">Our dedicated team supports you 24/7 &mdash; from your first day with thorough onboarding, resources, and mentoring.</p>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <jsp:include page="/views/common/userbuttom.jsp"/>

    <script>
        function updateCount() {
            const cards = document.querySelectorAll('#jobListContainer .job-card:not(.hidden)');
            document.getElementById('countNum').textContent = cards.length;
        }

        function filterJobs() {
            const s = (document.getElementById('searchInput').value || '').toLowerCase().trim();
            const cat = (document.getElementById('categoryFilter').value || '').trim();
            const cards = document.querySelectorAll('#jobListContainer .job-card');
            let v = 0;
            cards.forEach(c => {
                const matchSearch = !s || (c.dataset.title || '').toLowerCase().includes(s);
                const matchCategory = !cat || (c.dataset.category || '') === cat;
                const ok = matchSearch && matchCategory;
                c.classList.toggle('hidden', !ok);
                if (ok) v++;
            });
            document.getElementById('countNum').textContent = v;
            const nr = document.getElementById('noResultState');
            if (nr) nr.classList.toggle('hidden', v > 0);
        }

        window.addEventListener('DOMContentLoaded', updateCount);

        if ('IntersectionObserver' in window) {
            const io = new IntersectionObserver(entries => {
                entries.forEach(e => {
                    if (e.isIntersecting) {
                        e.target.style.opacity = '1';
                        e.target.style.transform = 'translateY(0)';
                        io.unobserve(e.target);
                    }
                });
            }, { threshold: 0.06 });

            document.querySelectorAll('.job-card').forEach((c, i) => {
                c.style.opacity = '0';
                c.style.transform = 'translateY(16px)';
                c.style.transition = `opacity .4s ease ${i * 55}ms, transform .4s ease ${i * 55}ms`;
                io.observe(c);
            });
        }
    </script>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>