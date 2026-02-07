<%-- 
    Document   : registerOtp
    Created on : Feb 4, 2026, 10:47:47 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!DOCTYPE html>

<html class="light" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Xác thực OTP Email | DevLearn</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/registerOtp.css">

        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#37ec13",
                            "background-light": "#f6f8f6",
                            "background-dark": "#132210",
                        },
                        fontFamily: {
                            "display": ["Inter", "sans-serif"]
                        },
                        borderRadius: {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                    },
                },
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", () => {

                const inputs = document.querySelectorAll(".otp-input");

                inputs.forEach((input, index) => {

                    input.addEventListener("input", () => {
                        input.value = input.value.replace(/[^0-9]/g, "");

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

                        const lastIndex = Math.min(paste.length, inputs.length) - 1;
                        if (lastIndex >= 0)
                            inputs[lastIndex].focus();
                    });

                });

            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", () => {

                const inputs = document.querySelectorAll(".otp-input");
                const form = document.querySelector("form");
                const otpHidden = document.getElementById("otpValue");

                // Auto jump + paste (giữ nguyên code cũ của bạn)
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

            });
        </script>



    </head>
    <body class="bg-background-light dark:bg-background-dark font-display min-h-screen">
        <div class="flex flex-col lg:flex-row min-h-screen w-full">
            <!-- Left Panel (40%) -->
            <div class="relative w-full lg:w-[40%] bg-gradient-dark flex flex-col justify-between p-12 overflow-hidden">
                <!-- Tech Grid Pattern Overlay -->
                <div class="absolute inset-0 tech-grid"></div>
                <div class="relative z-10">
                    <div class="flex items-center gap-3 text-white mb-20">
                        <div class="size-8 text-primary">
                            <svg fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                            <path d="M42.1739 20.1739L27.8261 5.82609C29.1366 7.13663 28.3989 10.1876 26.2002 13.7654C24.8538 15.9564 22.9595 18.3449 20.6522 20.6522C18.3449 22.9595 15.9564 24.8538 13.7654 26.2002C10.1876 28.3989 7.13663 29.1366 5.82609 27.8261L20.1739 42.1739C21.4845 43.4845 24.5355 42.7467 28.1133 40.548C30.3042 39.2016 32.6927 37.3073 35 35C37.3073 32.6927 39.2016 30.3042 40.548 28.1133C42.7467 24.5355 43.4845 21.4845 42.1739 20.1739Z" fill="currentColor"></path>
                            </svg>
                        </div>
                        <span class="text-2xl font-bold tracking-tight">DevLearn</span>
                    </div>
                    <div class="max-w-md">
                        <h1 class="text-white text-5xl font-bold leading-tight mb-6">
                            Xác thực <span class="text-primary">Email</span>
                        </h1>
                        <p class="text-gray-400 text-lg leading-relaxed">
                            Chúng tôi đã gửi mã xác thực 6 chữ số đến địa chỉ email của bạn. Vui lòng kiểm tra hộp thư đến hoặc thư rác.
                        </p>
                    </div>
                </div>
                <div class="relative z-10 flex items-center gap-2 text-gray-500 text-sm">
                    <span class="material-symbols-outlined text-sm">verified_user</span>
                    <span>Nền tảng đào tạo lập trình hàng đầu</span>
                </div>
            </div>
            <div class="w-full lg:w-[60%] flex items-center justify-center p-8 bg-background-light dark:bg-background-dark">
                <c:choose>

                    <c:when test="${not empty registerSuccess}">
                        <div class="text-center py-10">
                            <div class="mb-6">
                                <span class="material-symbols-outlined text-green-500 text-6xl">
                                    check_circle
                                </span>
                            </div>

                            <h2 class="text-2xl font-bold text-green-600 mb-3">
                                Register Successful 🎉
                            </h2>

                            <p class="text-zinc-500 mb-8">
                                Your account has been created successfully.<br>
                                Please login to continue.
                            </p>

                            <a href="${pageContext.request.contextPath}/login"
                               class="inline-block w-full bg-primary text-zinc-900 py-4 rounded-lg font-bold text-lg hover:opacity-90 transition-all shadow-lg shadow-primary/20">
                                Back to Login
                            </a>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="max-w-md w-full">
                            <div class="bg-white dark:bg-zinc-900 shadow-xl rounded-xl p-10 border border-gray-100 dark:border-zinc-800">
                                <div class="text-center mb-10">
                                    <h2 class="text-zinc-900 dark:text-white text-2xl font-bold mb-2">Nhập mã xác thực</h2>
                                    <p class="text-zinc-500 dark:text-zinc-400">Vui lòng nhập mã 6 chữ số đã được gửi</p>
                                </div>
                                <form  form action="${pageContext.request.contextPath}/otpRegister" method="POST">
                                    <div class="flex justify-between gap-2 mb-8">
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-gray-200 dark:border-zinc-700 rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors" maxlength="1" placeholder="-" type="text"  />
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-gray-200 dark:border-zinc-700 rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors" maxlength="1" placeholder="-" type="text"        />
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-primary rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors outline-none" maxlength="1" placeholder="-" type="text"/>
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-gray-200 dark:border-zinc-700 rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors" maxlength="1" placeholder="-" type="text"/>
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-gray-200 dark:border-zinc-700 rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors" maxlength="1" placeholder="-" type="text"/>
                                        <input class="otp-input w-12 h-14 sm:w-14 sm:h-16 text-center text-2xl font-bold border-2 border-gray-200 dark:border-zinc-700 rounded-lg focus:border-primary focus:ring-0 bg-transparent dark:text-white transition-colors" maxlength="1" placeholder="-" type="text"/>
                                    </div>
                                    <div class="text-center mb-8">
                                        <p class="text-sm text-zinc-500 flex items-center justify-center gap-1">
                                            <span class="material-symbols-outlined text-sm">timer</span>
                                            Gửi lại mã sau
                                            <span id="countdown" class="font-bold text-zinc-900 dark:text-white">01:00</span>
                                        </p>
                                        <button id="resendBtn"
                                                class="hidden text-primary font-semibold hover:underline mt-2"
                                                onclick="window.location.href = 'resend-otp'">
                                            Resend OTP
                                        </button>

                                    </div>

                                    <button class="w-full bg-gradient-to-r from-primary to-[#2cc50f] text-zinc-900 py-4 rounded-lg font-bold text-lg hover:opacity-90 transition-all shadow-lg shadow-primary/20 mb-6">
                                        Xác thực Email
                                    </button>
                                    <div class="flex flex-col gap-4 text-center">
                                        <a class="text-primary hover:underline text-sm font-medium" href="#">Thay đổi địa chỉ email</a>
                                        <a class="text-primary hover:underline text-sm font-medium" style="color: red" href="#">${otpError}</a>
                                        <div class="border-t border-gray-100 dark:border-zinc-800 pt-4">
                                            <button class="text-zinc-400 hover:text-zinc-600 dark:hover:text-zinc-300 text-sm flex items-center justify-center gap-1 mx-auto">
                                                <span class="material-symbols-outlined text-sm">arrow_back</span>
                                                Quay lại đăng nhập
                                            </button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="otp" id="otpValue">

                                </form>
                            </div>
                            <div class="mt-8 text-center">
                                <p class="text-zinc-400 text-xs">
                                    © 2024 DevLearn E-learning Platform. Mọi quyền được bảo lưu.
                                </p>
                            </div>
                        </div>
                    </c:otherwise>

                </c:choose>




            </div>
        </div>
        <script>
            let timeLeft = 60; // 60 giây
            const countdownEl = document.getElementById("countdown");

            const timer = setInterval(() => {
                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;

                countdownEl.textContent =
                        String(minutes).padStart(2, '0') + ":" +
                        String(seconds).padStart(2, '0');

                if (timeLeft <= 0) {
                    clearInterval(timer);
                    countdownEl.textContent = "00:00";
                    document.getElementById("resendBtn").classList.remove("hidden");
                }

                timeLeft--;
            }, 1000);
        </script>

    </body></html>
