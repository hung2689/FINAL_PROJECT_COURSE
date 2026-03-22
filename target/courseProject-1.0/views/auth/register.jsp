<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>DevLearn - Create Account</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                rel="stylesheet" />

            <style type="text/tailwindcss">
                @layer utilities {
            .glass-card {
                @apply bg-white/10 backdrop-blur-xl border border-white/20 rounded-3xl shadow-2xl;
            }
            .glass-input {
                @apply bg-white/5 border border-white/20 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 rounded-xl px-4 pt-6 pb-2 text-white outline-none transition-all duration-300 w-full;
            }
            .floating-label {
                @apply absolute left-4 top-4 text-zinc-400 text-sm transition-all duration-300 pointer-events-none peer-focus:text-xs peer-focus:-translate-y-2 peer-focus:text-emerald-400 peer-valid:text-xs peer-valid:-translate-y-2;
            }
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #064e3b 50%, #000000 100%);
            position: relative;
        }

        /* Subtle Noise Background */
        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.05'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
        }

        /* Radial Glow behind card */
        .glow-bg {
            position: absolute;
            top: 50%;
            right: 25%;
            transform: translate(50%, -50%);
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(16, 185, 129, 0.15) 0%, transparent 60%);
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }

        /* Fade-in Animation */
        .animate-fade-in {
            animation: fadeIn 0.8s ease-out forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
        </head>

        <body class="min-h-screen flex items-center justify-center p-4 md:p-8 text-white">
            <div class="glow-bg hidden lg:block"></div>

            <div
                class="w-full max-w-[1200px] mx-auto flex flex-col lg:flex-row items-center gap-12 lg:gap-20 z-10 relative animate-fade-in">

                <!-- Left Column: Branding -->
                <div class="w-full lg:w-1/2 flex flex-col gap-8 lg:pr-8 text-center lg:text-left">
                    <div class="flex items-center gap-3 justify-center lg:justify-start">
                        <div
                            class="w-12 h-12 bg-emerald-500 rounded-xl flex items-center justify-center shadow-[0_0_20px_rgba(16,185,129,0.4)]">
                            <span class="material-icons text-zinc-900 font-bold text-2xl">terminal</span>
                        </div>
                        <span class="text-3xl font-bold tracking-tight text-white">DevLearn</span>
                    </div>

                    <h1 class="font-bold text-5xl leading-tight">
                        Master the art of <br class="hidden lg:block" />
                        <span
                            class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-[#39FF14]">coding</span>
                        with us.
                    </h1>

                    <p class="text-lg text-slate-300 leading-relaxed max-w-lg mx-auto lg:mx-0">
                        Join 50,000+ developers building the future with cloud, AI and full-stack.
                    </p>

                    <ul class="space-y-4 mt-4 hidden md:block">
                        <li class="flex items-center gap-3 text-slate-200">
                            <div
                                class="w-6 h-6 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                                <span class="material-symbols-outlined text-sm">check</span>
                            </div>
                            <span class="text-lg">Project-based learning</span>
                        </li>
                        <li class="flex items-center gap-3 text-slate-200">
                            <div
                                class="w-6 h-6 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                                <span class="material-symbols-outlined text-sm">check</span>
                            </div>
                            <span class="text-lg">Industry mentors</span>
                        </li>
                        <li class="flex items-center gap-3 text-slate-200">
                            <div
                                class="w-6 h-6 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-400">
                                <span class="material-symbols-outlined text-sm">check</span>
                            </div>
                            <span class="text-lg">Career roadmap</span>
                        </li>
                    </ul>
                </div>

                <!-- Right Column: Form Card -->
                <div class="w-full lg:w-1/2 max-w-md lg:max-w-xl mx-auto">
                    <div class="glass-card p-8 md:p-10">
                        <h2 class="text-3xl font-bold mb-8 text-center">Create your account</h2>

                        <!-- Social Buttons -->
                        <div class="mb-8">
                            <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=392403100271-apt84m1lcgr7l581fhpkfbginiak48jv.apps.googleusercontent.com&redirect_uri=http://localhost:9999/CourseITProject/login-google&response_type=code&scope=openid%20email%20profile&prompt=select_account"
                                class="flex items-center justify-center gap-3 w-full py-3 px-6 bg-white text-zinc-800 rounded-full font-medium shadow-md hover:shadow-lg hover:scale-[1.02] transition-all duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48"
                                    class="w-5 h-5 flex-shrink-0">
                                    <path fill="#EA4335"
                                        d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z" />
                                    <path fill="#4285F4"
                                        d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z" />
                                    <path fill="#FBBC05"
                                        d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z" />
                                    <path fill="#34A853"
                                        d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.31-8.16 2.31-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z" />
                                    <path fill="none" d="M0 0h48v48H0z" />
                                </svg>
                                Sign in with Google
                            </a>
                        </div>

                        <!-- Divider -->
                        <div class="relative mb-8 text-center text-sm">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-white/10"></div>
                            </div>
                            <span
                                class="relative bg-transparent px-4 text-zinc-400 font-medium tracking-widest text-xs uppercase"
                                style="background-color: transparent;">OR CONTINUE WITH</span>
                        </div>

                        <!-- Form -->
                        <form action="register" method="POST" class="space-y-5">

                            <div class="relative">
                                <input type="text" id="username" name="username" required class="glass-input peer"
                                    autocomplete="off" />
                                <label for="username" class="floating-label">Username</label>
                            </div>

                            <div class="relative">
                                <input type="text" id="fullname" name="fullname" required class="glass-input peer"
                                    autocomplete="off" />
                                <label for="fullname" class="floating-label">Full Name</label>
                            </div>

                            <div class="relative">
                                <input type="email" id="email" name="email" required class="glass-input peer"
                                    autocomplete="off" />
                                <label for="email" class="floating-label">Email</label>
                            </div>

                            <div class="relative">
                                <input type="password" id="password" name="password" required
                                    class="glass-input peer pr-12" autocomplete="new-password"
                                    oninput="checkStrength(this.value)" />
                                <label for="password" class="floating-label">Password</label>
                                <button type="button"
                                    class="absolute right-4 top-1/2 -translate-y-1/2 text-zinc-400 hover:text-white transition-colors"
                                    onclick="togglePassword('password', this)">
                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                </button>
                            </div>

                            <!-- Password Strength Bar -->
                            <div class="w-full h-1.5 bg-white/10 rounded-full overflow-hidden mt-1 opacity-0 transition-opacity duration-300"
                                id="strength-container">
                                <div id="strength-bar" class="h-full bg-red-500 w-0 transition-all duration-300"></div>
                            </div>

                            <div class="relative">
                                <input type="password" id="repassword" name="repassword" required
                                    class="glass-input peer pr-12" autocomplete="new-password" />
                                <label for="repassword" class="floating-label">Confirm Password</label>
                                <button type="button"
                                    class="absolute right-4 top-1/2 -translate-y-1/2 text-zinc-400 hover:text-white transition-colors"
                                    onclick="togglePassword('repassword', this)">
                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                </button>
                            </div>

                            <!-- Terms -->
                            <div class="flex items-start gap-3 pt-2">
                                <div class="flex items-center h-5">
                                    <input id="terms" name="terms" type="checkbox" required
                                        class="w-4 h-4 rounded border-white/20 bg-white/5 text-emerald-500 focus:ring-emerald-500/50 focus:ring-offset-0 cursor-pointer" />
                                </div>
                                <label for="terms" class="text-sm text-zinc-300 cursor-pointer">
                                    I agree to the <a href="#"
                                        class="text-emerald-400 hover:text-emerald-300 hover:underline transition-colors">Terms
                                        of Service</a> and <a href="#"
                                        class="text-emerald-400 hover:text-emerald-300 hover:underline transition-colors">Privacy
                                        Policy</a>
                                </label>
                            </div>

                            <!-- Error Msg -->
                            <c:if test="${not empty userError}">
                                <p
                                    class="text-red-400 text-sm text-center bg-red-500/10 py-2 rounded-lg border border-red-500/20">
                                    ${userError}
                                </p>
                            </c:if>

                            <button type="submit"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 mt-6">
                                Create Account
                            </button>
                        </form>

                        <!-- Footer -->
                        <p class="text-center text-zinc-400 mt-8 text-sm">
                            Already have an account?
                            <a href="login?action=login"
                                class="text-emerald-400 font-semibold hover:text-emerald-300 hover:underline transition-colors ml-1">Sign
                                in</a>
                        </p>
                    </div>
                </div>
            </div>

            <script>
                // Set inputs to valid if they have value on load (browser autofill)
                document.addEventListener('DOMContentLoaded', () => {
                    document.querySelectorAll('.glass-input').forEach(input => {
                        if (input.value) {
                            input.setAttribute('valid', 'true');
                        }
                    })
                });

                const selects = document.querySelectorAll('select.glass-input');
                selects.forEach(select => {
                    select.addEventListener('change', () => {
                        if (select.value) {
                            select.classList.remove('[&:not(:valid)]:text-transparent');
                        }
                    });
                });

                // Toggle Password Visibility
                function togglePassword(inputId, btn) {
                    const input = document.getElementById(inputId);
                    const icon = btn.querySelector('span');

                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.textContent = 'visibility_off';
                    } else {
                        input.type = 'password';
                        icon.textContent = 'visibility';
                    }
                }

                // Password Strength Checker
                function checkStrength(password) {
                    const container = document.getElementById('strength-container');
                    const bar = document.getElementById('strength-bar');

                    if (!password) {
                        container.style.opacity = '0';
                        return;
                    }

                    container.style.opacity = '1';
                    let strength = 0;

                    if (password.length >= 8) strength += 25;
                    if (password.match(/[a-z]+/)) strength += 25;
                    if (password.match(/[A-Z]+/)) strength += 25;
                    if (password.match(/[0-9!@#$%^&*()]+/)) strength += 25;

                    bar.style.width = strength + '%';

                    if (strength <= 25) {
                        bar.className = 'h-full transition-all duration-300 bg-red-500';
                    } else if (strength <= 50) {
                        bar.className = 'h-full transition-all duration-300 bg-orange-500';
                    } else if (strength <= 75) {
                        bar.className = 'h-full transition-all duration-300 bg-yellow-500';
                    } else {
                        bar.className = 'h-full transition-all duration-300 bg-emerald-500';
                    }
                }
            </script>
        </body>

        </html>