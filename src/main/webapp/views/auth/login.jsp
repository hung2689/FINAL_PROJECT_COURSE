<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="mode" value="${not empty mode ? mode : param.mode}" />

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>DevLearn - Sign In</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                rel="stylesheet" />
            <script id="tailwind-config">
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "primary": "#10B981",
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
            left: 50%;
            transform: translate(-50%, -50%);
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

            <script>
                document.addEventListener("DOMContentLoaded", () => {
                    const inputs = document.querySelectorAll(".otp-input");
                    const form = document.querySelector("#otpForm");
                    const otpHidden = document.getElementById("otpValue");

                    if (inputs.length && form && otpHidden) {
                        // Auto jump + paste
                        inputs.forEach((input, index) => {
                            input.addEventListener("input", () => {
                                input.value = input.value.replace(/\D/g, "");
                                if (input.value && index < inputs.length - 1) {
                                    inputs[index + 1].focus();
                                }
                            });

                            input.addEventListener("keydown", (e) => {
                                if (e.key === "Backspace" && !input.value && index > 0) {
                                    inputs[index - 1].focus();
                                }
                            });

                            input.addEventListener("paste", (e) => {
                                e.preventDefault();
                                const paste = e.clipboardData.getData("text").replace(/\D/g, "");
                                paste.split("").forEach((char, i) => {
                                    if (inputs[i])
                                        inputs[i].value = char;
                                });
                                inputs[Math.min(paste.length, inputs.length) - 1]?.focus();
                            });
                        });

                        form.addEventListener("submit", () => {
                            let otp = "";
                            inputs.forEach(input => {
                                otp += input.value;
                            });
                            otpHidden.value = otp;
                        });
                    }
                });
            </script>
        </head>

        <body class="min-h-screen font-display text-white flex flex-col items-center justify-center p-4 md:p-8 pt-24">
            <div class="glow-bg hidden lg:block"></div>
            <jsp:include page="../common/header.jsp" />

            <c:if test="${empty mode}">
                <main class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in mt-16">
                    <div class="glass-card p-8 md:p-10">
                        <div class="text-center mb-8">
                            <h2 class="text-3xl font-bold text-white mb-2">Sign In</h2>
                            <p class="text-slate-300 text-sm">Access your account to continue learning.</p>
                        </div>

                        <!-- Social Buttons -->
                        <div class="mb-8">
                            <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=392403100271-apt84m1lcgr7l581fhpkfbginiak48jv.apps.googleusercontent.com&redirect_uri=http://localhost:8080/CourseITProject/login-google&response_type=code&scope=openid%20email%20profile&prompt=select_account"
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

                        <div class="relative mb-8 text-center text-sm">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-white/10"></div>
                            </div>
                            <span
                                class="relative bg-transparent px-4 text-zinc-400 font-medium tracking-widest text-xs uppercase"
                                style="background-color: transparent;">OR CONTINUE WITH</span>
                        </div>

                        <form action="login" method="POST" class="space-y-5">
                            <div class="relative">
                                <input type="text" id="input" name="input" required class="glass-input peer"
                                    autocomplete="off" />
                                <label for="input" class="floating-label">Username or Email</label>
                            </div>

                            <div class="relative">
                                <input type="password" id="password" name="password" required
                                    class="glass-input peer pr-12" autocomplete="current-password" />
                                <label for="password" class="floating-label">Password</label>
                                <button type="button"
                                    class="absolute right-4 top-1/2 -translate-y-1/2 text-zinc-400 hover:text-white transition-colors"
                                    onclick="togglePassword('password', this)">
                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                </button>
                            </div>

                            <div class="flex items-center justify-between pt-2">
                                <div class="flex items-center gap-3">
                                    <input id="remember" name="remember" type="checkbox"
                                        class="w-4 h-4 rounded border-white/20 bg-white/5 text-emerald-500 focus:ring-emerald-500/50 focus:ring-offset-0 cursor-pointer" />
                                    <label for="remember" class="text-sm text-zinc-300 cursor-pointer">Remember
                                        me</label>
                                </div>
                                <a href="login?mode=forgot"
                                    class="text-emerald-400 hover:text-emerald-300 text-sm font-semibold hover:underline transition-colors">Forgot
                                    password?</a>
                            </div>

                            <c:if test="${not empty error}">
                                <div
                                    class="bg-red-500/10 border border-red-500/30 rounded-xl p-3 flex items-start gap-3 animate-shake mt-4">
                                    <span class="material-symbols-outlined text-red-500 text-xl">error</span>
                                    <div>
                                        <p class="text-red-500 font-bold text-sm">Sign in failed</p>
                                        <p class="text-red-400 text-xs">${error}</p>
                                    </div>
                                </div>
                            </c:if>

                            <button type="submit"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 mt-6 flex items-center justify-center gap-2">
                                Sign In
                                <span class="material-symbols-outlined">arrow_forward</span>
                            </button>
                        </form>

                        <p class="text-center text-zinc-400 mt-8 text-sm">
                            Don't have an account?
                            <a href="register?action=register"
                                class="text-emerald-400 font-semibold hover:text-emerald-300 hover:underline transition-colors ml-1">Sign
                                up</a>
                        </p>
                    </div>
                </main>
            </c:if>

            <c:if test="${mode == 'forgot'}">
                <main class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in mt-16">
                    <div class="glass-card p-8 md:p-10">
                        <div class="text-center mb-8">
                            <h2 class="text-3xl font-bold text-white mb-2">Forgot password?</h2>
                            <p class="text-slate-300 text-sm">Enter your email to retrieve your password</p>
                        </div>

                        <form action="forget" method="POST" class="space-y-5">
                            <div class="relative">
                                <input type="email" id="email" name="email" required class="glass-input peer"
                                    autocomplete="off" />
                                <label for="email" class="floating-label">Email Address</label>
                            </div>

                            <c:if test="${not empty errorForget}">
                                <div
                                    class="bg-red-500/10 border border-red-500/30 rounded-xl p-3 flex items-start gap-3 animate-shake mt-4">
                                    <span class="material-symbols-outlined text-red-500 text-xl">error</span>
                                    <div>
                                        <p class="text-red-500 font-bold text-sm">Failed to send email</p>
                                        <p class="text-red-400 text-xs">${errorForget}</p>
                                    </div>
                                </div>
                            </c:if>

                            <button type="submit"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 mt-6 flex items-center justify-center gap-2">
                                Send reset link
                                <span class="material-symbols-outlined">arrow_forward</span>
                            </button>
                        </form>
                        <div class="mt-6 text-center">
                            <a href="login?action=login"
                                class="text-zinc-400 hover:text-white transition-colors text-sm flex justify-center items-center gap-1">
                                <span class="material-symbols-outlined text-sm">arrow_back</span>
                                Back to sign in
                            </a>
                        </div>
                    </div>
                </main>
            </c:if>

            <c:if test="${mode == 'reset'}">
                <main class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in mt-16">
                    <div class="glass-card p-8 md:p-10">
                        <div class="text-center mb-8">
                            <h2 class="text-3xl font-bold text-white mb-2">Create new password</h2>
                            <p class="text-slate-300 text-sm">Enter your new password to sign in</p>
                        </div>

                        <form action="reset" method="POST" class="space-y-5">
                            <div class="relative">
                                <input type="password" id="password" name="password" required
                                    class="glass-input peer pr-12" autocomplete="new-password" />
                                <label for="password" class="floating-label">New Password</label>
                                <button type="button"
                                    class="absolute right-4 top-1/2 -translate-y-1/2 text-zinc-400 hover:text-white transition-colors"
                                    onclick="togglePassword('password', this)">
                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                </button>
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

                            <c:if test="${not empty errorPass}">
                                <div
                                    class="bg-red-500/10 border border-red-500/30 rounded-xl p-3 flex items-start gap-3 animate-shake mt-4">
                                    <span class="material-symbols-outlined text-red-500 text-xl">error</span>
                                    <div>
                                        <p class="text-red-500 font-bold text-sm">Password Error</p>
                                        <p class="text-red-400 text-xs">${errorPass}</p>
                                    </div>
                                </div>
                            </c:if>

                            <button type="submit"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 mt-6 flex items-center justify-center gap-2">
                                Update Password
                                <span class="material-symbols-outlined">arrow_forward</span>
                            </button>
                        </form>
                    </div>
                </main>
            </c:if>

            <c:if test="${mode == 'otp'}">
                <main class="w-full max-w-[420px] mx-auto z-10 relative animate-fade-in mt-16">
                    <div class="glass-card p-8 md:p-10 text-center">
                        <div class="mb-8">
                            <h2 class="text-3xl font-bold text-white mb-2">Enter verification code</h2>
                            <p class="text-slate-300 text-sm">Please enter the 6-digit code sent to your email</p>
                        </div>

                        <form id="otpForm" action="${pageContext.request.contextPath}/otpverify" method="POST"
                            class="space-y-8">
                            <div class="flex justify-between gap-2">
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                                <input
                                    class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-xl glass-input px-0 focus:ring-emerald-500/30 focus:border-emerald-400"
                                    maxlength="1" type="text" />
                            </div>

                            <div class="text-zinc-400 text-sm">
                                <span class="material-symbols-outlined text-sm align-middle">timer</span>
                                Resend code in
                                <span id="countdown" class="text-emerald-400 font-semibold ml-1">01:00</span>
                            </div>

                            <button type="submit"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 mt-6 flex items-center justify-center">
                                Verify Email
                            </button>

                            <c:if test="${not empty otpError}">
                                <p class="text-red-400 text-sm mt-4">${otpError}</p>
                            </c:if>

                            <div class="text-center space-y-3 mt-6">
                                <a href="forget?action=forget"
                                    class="text-emerald-400 hover:text-emerald-300 hover:underline transition-colors text-sm block">Change
                                    email address</a>
                                <a href="login?action=login"
                                    class="text-zinc-400 hover:text-white transition-colors text-sm flex justify-center items-center gap-1">
                                    <span class="material-symbols-outlined text-sm">arrow_back</span>
                                    Back to sign in
                                </a>
                            </div>

                            <input type="hidden" name="otp" id="otpValue">
                        </form>
                    </div>
                </main>

                <script>
                    let timeLeft = 60;
                    const countdownEl = document.getElementById("countdown");
                    const timer = setInterval(() => {
                        let minutes = Math.floor(timeLeft / 60);
                        let seconds = timeLeft % 60;
                        countdownEl.textContent = String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');
                        if (timeLeft <= 0) {
                            clearInterval(timer);
                            countdownEl.textContent = "00:00";
                            // could show resend button here
                        }
                        timeLeft--;
                    }, 1000);
                </script>
            </c:if>

            <c:if test="${mode == 'success'}">
                <main class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in mt-16">
                    <div class="glass-card p-10 text-center flex flex-col items-center gap-6">
                        <!-- Icon success -->
                        <div
                            class="w-20 h-20 rounded-full bg-emerald-500/20 flex items-center justify-center shadow-[0_0_30px_rgba(16,185,129,0.3)]">
                            <span class="material-symbols-outlined text-emerald-400 text-5xl">check_circle</span>
                        </div>

                        <div class="space-y-2">
                            <h2 class="text-white text-3xl font-bold tracking-tight">Successfully created!</h2>
                            <p class="text-slate-300 text-sm leading-relaxed max-w-sm mx-auto">
                                Your password has been updated.<br>
                                You can use your new password to sign in now.
                            </p>
                        </div>

                        <div class="w-full flex flex-col gap-4 mt-4">
                            <a href="login?action=login"
                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 flex items-center justify-center gap-2">
                                Sign In Now
                                <span class="material-symbols-outlined">arrow_forward</span>
                            </a>

                            <a href="home"
                                class="text-zinc-400 hover:text-white transition-colors text-sm mt-2 flex justify-center items-center gap-1">
                                <span class="material-symbols-outlined text-sm">arrow_back</span>
                                Back to home
                            </a>
                        </div>
                    </div>
                </main>
            </c:if>

            <script>
                // Set inputs to valid if they have value on load (browser autofill)
                document.addEventListener('DOMContentLoaded', () => {
                    document.querySelectorAll('.glass-input').forEach(input => {
                        if (input.value) {
                            input.setAttribute('valid', 'true');
                        }
                    })
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
            </script>
        </body>

        </html>