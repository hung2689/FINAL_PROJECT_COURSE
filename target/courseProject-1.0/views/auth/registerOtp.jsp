<%-- Document : registerOtp Created on : Feb 4, 2026 Author : ASUS --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>DevLearn - Email Verification</title>

                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
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

                    /* Remove number input spinners */
                    .otp-input::-webkit-outer-spin-button,
                    .otp-input::-webkit-inner-spin-button {
                        -webkit-appearance: none;
                    }

                    .otp-input[type=number] {
                        -moz-appearance: textfield;
                    }
                </style>

                <script>
                    document.addEventListener("DOMContentLoaded", () => {
                        const inputs = document.querySelectorAll(".otp-input");
                        const form = document.getElementById("otpForm");
                        const otpHidden = document.getElementById("otpValue");

                        inputs.forEach((input, index) => {
                            input.addEventListener("input", () => {
                                input.value = input.value.replace(/[^0-9]/g, "");
                                if (input.value && index < inputs.length - 1) inputs[index + 1].focus();
                            });
                            input.addEventListener("keydown", (e) => {
                                if (e.key === "Backspace" && !input.value && index > 0) inputs[index - 1].focus();
                            });
                            input.addEventListener("paste", (e) => {
                                e.preventDefault();
                                const paste = e.clipboardData.getData("text").replace(/\D/g, "");
                                paste.split("").forEach((char, i) => { if (inputs[i]) inputs[i].value = char; });
                                inputs[Math.min(paste.length, inputs.length) - 1]?.focus();
                            });
                        });

                        if (form && otpHidden) {
                            form.addEventListener("submit", () => {
                                otpHidden.value = Array.from(inputs).map(i => i.value).join("");
                            });
                        }
                    });
                </script>
            </head>

            <body
                class="min-h-screen font-display text-slate-800 flex flex-col items-center justify-center p-4 md:p-8 pt-8"
                style="background: linear-gradient(135deg, #0f172a 0%, #064e3b 50%, #000000 100%); position: relative;">

                <!-- Glow background -->
                <div style="position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);width:600px;height:600px;
                background:radial-gradient(circle,rgba(16,185,129,0.15) 0%,transparent 60%);
                border-radius:50%;pointer-events:none;z-index:0;"></div>

                <c:choose>

                    <%-- ── SUCCESS STATE ── --%>
                        <c:when test="${not empty registerSuccess}">
                            <div class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in">
                                <div
                                    class="bg-white/10 backdrop-blur-xl border border-white/20 rounded-3xl shadow-2xl p-10 text-center flex flex-col items-center gap-6">

                                    <div
                                        class="w-20 h-20 rounded-full bg-emerald-500/20 flex items-center justify-center shadow-[0_0_30px_rgba(16,185,129,0.3)]">
                                        <span
                                            class="material-symbols-outlined text-emerald-400 text-5xl">check_circle</span>
                                    </div>

                                    <div class="space-y-2">
                                        <h2 class="text-3xl font-bold text-white tracking-tight">Account Created!</h2>
                                        <p class="text-slate-300 text-sm leading-relaxed max-w-sm mx-auto">
                                            Your account has been created successfully.<br />Please sign in to continue.
                                        </p>
                                    </div>

                                    <div class="w-full flex flex-col gap-3 mt-2">
                                        <a href="${pageContext.request.contextPath}/login"
                                            class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 flex items-center justify-center gap-2">
                                            Sign In Now
                                            <span class="material-symbols-outlined">arrow_forward</span>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/home"
                                            class="text-zinc-400 hover:text-white transition-colors text-sm flex justify-center items-center gap-1 mt-1">
                                            <span class="material-symbols-outlined text-sm">arrow_back</span>
                                            Back to home
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:when>

                        <%-- ── OTP FORM STATE ── --%>
                            <c:otherwise>
                                <div class="w-full max-w-[480px] mx-auto z-10 relative animate-fade-in">

                                    <!-- Heading above card -->
                                    <div class="text-center mb-8">
                                        <div
                                            class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-emerald-500/20 border border-emerald-400/30 shadow-[0_0_20px_rgba(16,185,129,0.2)] mb-5">
                                            <span
                                                class="material-symbols-outlined text-emerald-400 text-4xl">mark_email_read</span>
                                        </div>
                                        <h2 class="text-3xl font-bold text-white mb-2">Email Verification</h2>
                                        <p class="text-slate-300 text-sm leading-relaxed max-w-xs mx-auto">
                                            We have sent a 6-digit verification code to your email address. Please check
                                            your inbox or spam folder.
                                        </p>
                                    </div>

                                    <!-- Card -->
                                    <div
                                        class="bg-white/10 backdrop-blur-xl border border-white/20 rounded-3xl shadow-2xl p-8 md:p-10">

                                        <form id="otpForm" action="${pageContext.request.contextPath}/otpRegister"
                                            method="POST" class="space-y-7">

                                            <!-- 6 OTP input boxes — fixed square size, centered -->
                                            <div class="flex justify-center gap-3">
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric"
                                                    autocomplete="one-time-code" />
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric" />
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric" />
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric" />
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric" />
                                                <input
                                                    class="otp-input w-12 h-12 text-center text-2xl font-bold rounded-xl bg-white/5 border border-white/20 text-white outline-none transition-all duration-200 focus:border-emerald-400 focus:ring-2 focus:ring-emerald-500/30 focus:bg-white/10 hover:border-white/40"
                                                    maxlength="1" type="text" inputmode="numeric" />
                                            </div>

                                            <!-- Countdown -->
                                            <div class="flex items-center justify-center gap-2 text-zinc-400 text-sm">
                                                <span
                                                    class="material-symbols-outlined text-base text-emerald-400">timer</span>
                                                <span>Resend code in</span>
                                                <span id="countdown"
                                                    class="text-emerald-400 font-semibold ml-1">01:00</span>
                                            </div>

                                            <!-- Resend button (shown after countdown) -->
                                            <div class="text-center -mt-3">
                                                <button id="resendBtn" type="button"
                                                    class="hidden text-emerald-400 hover:text-emerald-300 hover:underline text-sm font-semibold transition-colors"
                                                    onclick="window.location.href='resend-otp'">
                                                    Resend OTP
                                                </button>
                                            </div>

                                            <!-- Error message -->
                                            <c:if test="${not empty otpError}">
                                                <div
                                                    class="bg-red-500/10 border border-red-500/30 rounded-xl p-3 flex items-start gap-3">
                                                    <span
                                                        class="material-symbols-outlined text-red-500 text-xl flex-shrink-0">error</span>
                                                    <p class="text-red-400 text-sm">${otpError}</p>
                                                </div>
                                            </c:if>

                                            <!-- Submit -->
                                            <button type="submit"
                                                class="w-full bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold text-lg py-4 rounded-xl shadow-xl hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 flex items-center justify-center gap-2">
                                                Verify Email
                                                <span class="material-symbols-outlined">arrow_forward</span>
                                            </button>

                                            <input type="hidden" name="otp" id="otpValue" />
                                        </form>

                                        <!-- Footer links -->
                                        <div class="text-center space-y-3 mt-6 pt-6 border-t border-white/10">
                                            <a href="#"
                                                class="text-emerald-400 hover:text-emerald-300 hover:underline transition-colors text-sm block font-medium">
                                                Change email address
                                            </a>
                                            <a href="${pageContext.request.contextPath}/login"
                                                class="text-zinc-400 hover:text-white transition-colors text-sm flex justify-center items-center gap-1">
                                                <span class="material-symbols-outlined text-sm">arrow_back</span>
                                                Back to Login
                                            </a>
                                        </div>
                                    </div>

                                    <p class="text-center text-zinc-500 text-xs mt-6">
                                        &copy; 2024 DevLearn E-learning Platform. All rights reserved.
                                    </p>
                                </div>
                            </c:otherwise>

                </c:choose>

                <script>
                    let timeLeft = 60;
                    const countdownEl = document.getElementById("countdown");
                    const resendBtn = document.getElementById("resendBtn");

                    const timer = setInterval(() => {
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        countdownEl.textContent =
                            String(minutes).padStart(2, '0') + ":" +
                            String(seconds).padStart(2, '0');
                        if (timeLeft <= 0) {
                            clearInterval(timer);
                            countdownEl.textContent = "00:00";
                            if (resendBtn) resendBtn.classList.remove("hidden");
                        }
                        timeLeft--;
                    }, 1000);
                </script>

            </body>

            </html>