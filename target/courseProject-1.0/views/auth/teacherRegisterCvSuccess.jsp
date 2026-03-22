<%-- Document : teacherRegisterCvSuccess Created on : Feb 6, 2026 Author : ASUS --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>DevLearn - Application Submitted</title>

            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                rel="stylesheet" />

            <script>
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: { "primary": "#10B981" },
                            fontFamily: { "display": ["Inter", "sans-serif"] },
                            maxWidth: { "canvas": "1200px" }
                        }
                    }
                }
            </script>

            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }

                .animate-fade-in {
                    animation: fadeIn 0.7s ease-out forwards;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(16px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            </style>
        </head>

        <body class="min-h-screen font-display text-white flex flex-col"
            style="background: linear-gradient(135deg, #0f172a 0%, #064e3b 50%, #000000 100%); position: relative;">

            <!-- Radial glow -->
            <div style="position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);
                width:700px;height:700px;
                background:radial-gradient(circle,rgba(16,185,129,0.15) 0%,transparent 60%);
                border-radius:50%;pointer-events:none;z-index:0;"></div>

            <!-- Header -->
            <jsp:include page="../common/header.jsp" />

            <!-- Main -->
            <main class="flex-1 flex flex-col items-center justify-center px-4 pt-28 pb-16 z-10 relative">
                <div class="w-full max-w-[520px] mx-auto animate-fade-in">

                    <!-- Card -->
                    <div
                        class="bg-white/10 backdrop-blur-xl border border-white/20 rounded-3xl shadow-2xl p-10 md:p-14 flex flex-col items-center text-center">

                        <!-- Success icon -->
                        <div
                            class="w-24 h-24 rounded-full bg-emerald-500/20 flex items-center justify-center shadow-[0_0_40px_rgba(16,185,129,0.3)] mb-8">
                            <span class="material-symbols-outlined text-emerald-400"
                                style="font-size:3.5rem;">task_alt</span>
                        </div>

                        <!-- Title -->
                        <h1 class="text-3xl md:text-4xl font-bold text-white leading-tight mb-4 tracking-tight">
                            Application Submitted!
                        </h1>

                        <!-- Status badge -->
                        <div class="mb-6">
                            <div
                                class="inline-flex items-center gap-2 px-5 py-2 rounded-full bg-white/5 border border-emerald-400/30 backdrop-blur-md">
                                <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                                <span class="text-emerald-400 text-sm font-semibold tracking-wider uppercase">Review
                                    Pending</span>
                            </div>
                        </div>

                        <!-- Description -->
                        <p class="text-slate-300 text-base leading-relaxed mb-10 max-w-sm">
                            Your application will be reviewed within <strong class="text-white">1–2 business
                                days</strong>.
                            We will notify you via email once your account is verified.
                        </p>

                        <!-- Progress trail -->
                        <div class="flex items-center gap-3 text-xs font-medium uppercase tracking-widest mb-10">
                            <span class="text-emerald-400">Application</span>
                            <span class="material-symbols-outlined text-slate-500 text-sm">arrow_forward</span>
                            <span class="text-emerald-400">Verification</span>
                            <span class="material-symbols-outlined text-slate-500 text-sm">arrow_forward</span>
                            <span class="text-white font-bold">Active</span>
                        </div>

                        <!-- Actions -->
                        <div class="w-full space-y-4">
                            <a href="${pageContext.request.contextPath}/home"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 flex items-center justify-center gap-2">
                                Go to Home
                                <span class="material-symbols-outlined">home</span>
                            </a>
                            <p class="text-sm text-zinc-400">
                                Need help?
                                <a class="text-emerald-400 hover:text-emerald-300 hover:underline transition-colors ml-1"
                                    href="#">Contact our support team</a>
                            </p>
                        </div>
                    </div>

                    <!-- Footer note -->
                    <p class="text-center text-zinc-500 text-xs mt-6">
                        &copy; 2024 DevLearn E-learning Platform. All rights reserved.
                    </p>
                </div>
            </main>

            <jsp:include page="../common/userbuttom.jsp" />

        </body>

        </html>