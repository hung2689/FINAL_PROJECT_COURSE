<%-- 
    Document   : login
    Created on : Feb 5, 2026, 1:18:03 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="mode" value="${not empty mode ? mode : param.mode}" />


<!DOCTYPE html>
<html class="dark" lang="vi"><head>

        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>IT Academy | Generic Icon Social Login Refinement</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#7bf425",
                            "background-light": "#f7f8f5",
                            "background-dark": "#061a02",
                            "social-text": "#3c4043",
                            "social-border": "#dadce0"
                        },
                        fontFamily: {
                            "display": ["Space Grotesk", "sans-serif"]
                        },
                        borderRadius: {
                            "DEFAULT": "1rem",
                            "lg": "2rem",
                            "xl": "3rem",
                            "full": "9999px"
                        },
                    },
                },
            }
        </script>
        <style type="text/tailwindcss">
            body {
                font-family: 'Space Grotesk', sans-serif;
                background-color: #061a02;
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.03);
                backdrop-filter: blur(24px);
                -webkit-backdrop-filter: blur(24px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            }
            .glass-button {
                background: rgba(123, 244, 37, 0.05);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 1px solid rgba(123, 244, 37, 0.2);
            }
            .glass-button:hover {
                background: rgba(123, 244, 37, 0.12);
            }
            .neon-glow {
                box-shadow: 0 0 20px rgba(123, 244, 37, 0.4);
            }
            .bg-gradient-mesh {
                background: radial-gradient(circle at 20% 20%, #172210 0%, transparent 40%),
                    radial-gradient(circle at 80% 80%, #7bf42533 0%, transparent 40%),
                    linear-gradient(135deg, #061a02 0%, #1a2e0a 100%);
            }
            .mountain-silhouette {
                mask-image: linear-gradient(to top, black 20%, transparent 100%);
                -webkit-mask-image: linear-gradient(to top, black 20%, transparent 100%);
            }
        </style>

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
    <body class="bg-background-light dark:bg-background-dark min-h-screen flex flex-col overflow-x-hidden font-display selection:bg-primary selection:text-background-dark">
        <div class="fixed inset-0 z-0 bg-gradient-mesh pointer-events-none">
            <div class="absolute bottom-0 w-full h-1/2 opacity-20 mountain-silhouette">
                <svg class="absolute bottom-0 w-full h-full fill-primary/20" viewBox="0 0 1440 320">
                <path d="M0,224L48,213.3C96,203,192,181,288,181.3C384,181,480,203,576,224C672,245,768,267,864,245.3C960,224,1056,160,1152,144C1248,128,1344,160,1392,176L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
                </svg>
            </div>
            <div class="absolute top-1/4 left-1/4 w-2 h-2 bg-primary rounded-full blur-sm animate-pulse opacity-40"></div>
            <div class="absolute top-3/4 right-1/3 w-3 h-3 bg-primary rounded-full blur-md animate-pulse opacity-20"></div>
            <div class="absolute top-1/2 right-10 w-1.5 h-1.5 bg-primary rounded-full blur-none animate-pulse opacity-60"></div>
        </div>
        <header class="relative z-10 w-full px-6 lg:px-12 py-6 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="size-10 bg-primary/20 rounded-lg flex items-center justify-center border border-primary/30">
                    <span class="material-symbols-outlined text-primary font-bold">terminal</span>
                </div>
                <h1 class="text-white text-xl font-bold tracking-tight">Dev<span class="text-primary">Learn</span></h1>
            </div>
            <nav class="hidden md:flex items-center gap-10">
                <a class="text-white/70 hover:text-primary text-sm font-medium transition-colors" href="#">Khóa học</a>
                <a class="text-white/70 hover:text-primary text-sm font-medium transition-colors" href="#">Lộ trình</a>
                <a class="text-white/70 hover:text-primary text-sm font-medium transition-colors" href="#">Cộng đồng</a>
            </nav>
            <div class="flex gap-4">
                <button class="px-6 py-2.5 rounded-full border border-white/10 text-white text-sm font-semibold hover:bg-white/5 transition-all">
                    Đăng nhập
                </button>
                <a href="register?action=register">
                    <button     class="px-6 py-2.5 rounded-full bg-primary text-background-dark text-sm font-bold hover:brightness-110 transition-all">
                        Đăng ký
                    </button>
                </a>
            </div>
        </header>
        <c:if test="${empty mode  }">
            <main class="relative z-10 flex-1 flex items-center justify-center p-6">
                <div class="glass-card w-full max-w-[480px] p-10 rounded-xl flex flex-col gap-8">
                    <div class="text-center space-y-2">
                        <h2 class="text-white text-4xl font-bold tracking-tight">Đăng nhập</h2>
                        <p class="text-white/50 text-base">Nhập thông tin để bắt đầu học tập.</p>
                    </div>


                    <form action="login" method="POST" class="space-y-6">
                        <div class="space-y-2">
                            <label class="block text-white/80 text-sm font-medium ml-4">Tên đăng nhập hoặc Email</label>
                            <div class="relative group">
                                <div class="absolute inset-y-0 left-5 flex items-center pointer-events-none text-white/30 group-focus-within:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">person</span>
                                </div>
                                <input required name="input" class="w-full h-14 pl-12 pr-5 bg-white/5 border border-white/10 rounded-full text-white placeholder:text-white/20 focus:outline-none focus:ring-2 focus:ring-primary/40 focus:border-primary transition-all text-base" placeholder="example@email.com" type="text"/>
                            </div>
                        </div>
                        <div class="space-y-2">
                            <div class="flex justify-between items-center ml-4">
                                <label class="text-white/80 text-sm font-medium">Mật khẩu</label>
                                <a class="text-primary text-xs hover:underline decoration-primary/30" href="login?mode=forgot">Quên mật khẩu?</a>
                            </div>
                            <div class="relative group">
                                <div class="absolute inset-y-0 left-5 flex items-center pointer-events-none text-white/30 group-focus-within:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">lock</span>
                                </div>
                                <input required name="password" class="w-full h-14 pl-12 pr-5 bg-white/5 border border-white/10 rounded-full text-white placeholder:text-white/20 focus:outline-none focus:ring-2 focus:ring-primary/40 focus:border-primary transition-all text-base" placeholder="••••••••" type="password"/>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 px-2">
                            <label class="flex items-center cursor-pointer group">
                                <div class="relative flex items-center">
                                    <input name="remember" class="peer hidden" type="checkbox"/>
                                    <div class="w-5 h-5 border-2 border-white/20 rounded-md bg-white/5 peer-checked:bg-primary peer-checked:border-primary transition-all"></div>
                                    <span class="material-symbols-outlined absolute text-[16px] text-background-dark scale-0 peer-checked:scale-100 transition-transform left-0.5 pointer-events-none">check</span>
                                </div>
                                <span class="text-white/60 text-sm ml-3 group-hover:text-white transition-colors">Ghi nhớ đăng nhập</span>
                            </label>
                        </div>
                        <button class="w-full h-14 bg-gradient-to-r from-primary to-[#5ec21d] text-background-dark font-bold text-lg rounded-full neon-glow hover:brightness-110 active:scale-[0.98] transition-all flex items-center justify-center gap-2" type="submit">
                            Đăng nhập
                            <span class="material-symbols-outlined">arrow_forward</span>
                        </button>
                    </form>


                    <c:if test="${not empty error}">
                        <div class="relative flex items-start gap-3 p-4 rounded-xl 
                             bg-red-500/10 border border-red-500/30 
                             text-red-400 text-sm animate-shake">

                            <span class="material-symbols-outlined text-red-400 text-xl">
                                error
                            </span>

                            <div class="flex-1">
                                <p class="font-semibold">Đăng nhập thất bại</p>
                                <p class="text-red-300/80">${error}</p>
                            </div>
                        </div>
                    </c:if>

                    <div class="flex flex-col items-center gap-6">
                        <div class="flex items-center w-full gap-4">
                            <div class="h-px bg-white/10 flex-1"></div>
                            <span class="text-white/20 text-[10px] font-medium uppercase tracking-widest whitespace-nowrap">hoặc tiếp tục với</span>
                            <div class="h-px bg-white/10 flex-1"></div>
                        </div>
                        <div class="flex flex-col gap-3 w-full">
                            <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=392403100271-apt84m1lcgr7l581fhpkfbginiak48jv.apps.googleusercontent.com&redirect_uri=http://localhost:8080/CourseITProject/login-google&response_type=code&scope=openid%20email%20profile&prompt=select_account"
                               class="w-full h-14 flex items-center justify-center gap-4 rounded-full glass-button transition-all group active:scale-[0.99]">


                                <div class="flex items-center justify-center w-8 h-8 bg-white rounded-full shadow-lg group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-background-dark text-[20px]">search</span>
                                </div>
                                <span class="text-white/90 text-sm font-semibold tracking-wide">Đăng nhập với Google</span>

                            </a>
                            <button class="w-full h-14 flex items-center justify-center gap-4 rounded-full glass-button transition-all group active:scale-[0.99]">
                                <div class="flex items-center justify-center w-8 h-8 bg-white rounded-full shadow-lg group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-background-dark text-[20px]">groups</span>
                                </div>
                                <span class="text-white/90 text-sm font-semibold tracking-wide">Đăng nhập với Facebook</span>
                            </button>
                        </div>
                        <p class="text-white/50 text-sm">
                            Chưa có tài khoản? 
                            <a class="text-primary font-bold hover:underline ml-1" href="register?action=register">Đăng ký ngay</a>
                        </p>
                    </div>
                </div>
            </main>
        </c:if>


        <c:if test="${mode == 'forgot' }">
            <main class="relative z-10 flex-1 flex items-center justify-center p-6">
                <div class="glass-card w-full max-w-[480px] p-10 rounded-xl flex flex-col gap-8">
                    <div class="text-center space-y-2">
                        <h2 class="text-white text-4xl font-bold tracking-tight">Quên mật khẩu ?</h2>
                        <p class="text-white/50 text-base">Nhập email để lấy lại mật khẩu</p>
                    </div>


                    <form action="forget" method="POST" class="space-y-6">
                        <div class="space-y-2">
                            <label class="block text-white/80 text-sm font-medium ml-4">Nhập email</label>
                            <div class="relative group">
                                <div class="absolute inset-y-0 left-5 flex items-center pointer-events-none text-white/30 group-focus-within:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">person</span>
                                </div>
                                <input required name="email" class="w-full h-14 pl-12 pr-5 bg-white/5 border border-white/10 rounded-full text-white placeholder:text-white/20 focus:outline-none focus:ring-2 focus:ring-primary/40 focus:border-primary transition-all text-base" placeholder="example@email.com" type="text"/>
                            </div>
                        </div>


                        <button class="w-full h-14 bg-gradient-to-r from-primary to-[#5ec21d] text-background-dark font-bold text-lg rounded-full neon-glow hover:brightness-110 active:scale-[0.98] transition-all flex items-center justify-center gap-2" type="submit">
                            Gửi yêu cầu
                            <span class="material-symbols-outlined">arrow_forward</span>
                        </button>
                    </form>

                    <c:if test="${not empty errorForget}">
                        <div class="relative flex items-start gap-3 p-4 rounded-xl 
                             bg-red-500/10 border border-red-500/30 
                             text-red-400 text-sm animate-shake">

                            <span class="material-symbols-outlined text-red-400 text-xl">
                                error
                            </span>

                            <div class="flex-1">
                                <p class="font-semibold">Gửi email thất bại</p>
                                <p class="text-red-300/80">${errorForget}</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </main>


        </c:if>



        <c:if test="${mode == 'reset' }">
            <main class="relative z-10 flex-1 flex items-center justify-center p-6">
                <div class="glass-card w-full max-w-[480px] p-10 rounded-xl flex flex-col gap-8">
                    <div class="text-center space-y-2">
                        <h2 class="text-white text-4xl font-bold tracking-tight">Tạo mật khẩu mới</h2>
                        <p class="text-white/50 text-base">Nhập mật khẩu mới để đăng nhập</p>
                    </div>


                    <form action="reset" method="POST" class="space-y-6">
                        <div class="space-y-2">
                            <label class="block text-white/80 text-sm font-medium ml-4">Nhập mật khẩu mới</label>
                            <div class="relative group">
                                <div class="absolute inset-y-0 left-5 flex items-center pointer-events-none text-white/30 group-focus-within:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">person</span>
                                </div>
                                <input required name="password" class="w-full h-14 pl-12 pr-5 bg-white/5 border border-white/10 rounded-full text-white placeholder:text-white/20 focus:outline-none focus:ring-2 focus:ring-primary/40 focus:border-primary transition-all text-base" placeholder="••••••••" type="password"/>
                            </div>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-white/80 text-sm font-medium ml-4">Xác nhận mật khẩu</label>
                            <div class="relative group">
                                <div class="absolute inset-y-0 left-5 flex items-center pointer-events-none text-white/30 group-focus-within:text-primary transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">person</span>
                                </div>
                                <input required name="repassword" class="w-full h-14 pl-12 pr-5 bg-white/5 border border-white/10 rounded-full text-white placeholder:text-white/20 focus:outline-none focus:ring-2 focus:ring-primary/40 focus:border-primary transition-all text-base" placeholder="••••••••" type="password"/>
                            </div>
                        </div>

                        <button class="w-full h-14 bg-gradient-to-r from-primary to-[#5ec21d] text-background-dark font-bold text-lg rounded-full neon-glow hover:brightness-110 active:scale-[0.98] transition-all flex items-center justify-center gap-2" type="submit">
                            Gửi yêu cầu
                            <span class="material-symbols-outlined">arrow_forward</span>
                        </button>
                    </form>

                    <c:if test="${not empty errorPass}">
                        <div class="relative flex items-start gap-3 p-4 rounded-xl 
                             bg-red-500/10 border border-red-500/30 
                             text-red-400 text-sm animate-shake">

                            <span class="material-symbols-outlined text-red-400 text-xl">
                                error
                            </span>

                            <div class="flex-1">
                                <p class="font-semibold">Lỗi mật khẩu</p>
                                <p class="text-red-300/80">${errorPass}</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </main>


        </c:if>


        <c:if test="${mode == 'otp' }">
            <main class="relative z-10 flex-1 flex items-center justify-center p-6">
                <div class="glass-card w-full max-w-[420px] p-10 rounded-2xl flex flex-col gap-8">

                    <!-- Title -->
                    <div class="text-center space-y-2">
                        <h2 class="text-white text-3xl font-bold">Nhập mã xác thực</h2>
                        <p class="text-white/50 text-sm">
                            Vui lòng nhập mã 6 chữ số đã được gửi
                        </p>
                    </div>

                    <!-- OTP FORM -->
                    <form action="${pageContext.request.contextPath}/otpverify" method="POST" class="space-y-8">

                        <!-- OTP INPUT -->
                        <div class="flex justify-between gap-2">
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-white/20 text-white
                                   focus:border-primary focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-white/20 text-white
                                   focus:border-primary focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-primary text-white
                                   focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-white/20 text-white
                                   focus:border-primary focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-white/20 text-white
                                   focus:border-primary focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                            <input class="otp-input w-12 h-14 text-center text-2xl font-bold rounded-full 
                                   bg-white/5 border border-white/20 text-white
                                   focus:border-primary focus:ring-2 focus:ring-primary/40 outline-none"
                                   maxlength="1" type="text"/>
                        </div>

                        <!-- COUNTDOWN -->
                        <div class="text-center text-white/50 text-sm">
                            <span class="material-symbols-outlined text-sm align-middle">timer</span>
                            Gửi lại mã sau
                            <span id="countdown" class="text-white font-semibold ml-1">01:00</span>
                        </div>

                        <!-- SUBMIT -->
                        <button
                            class="w-full h-14 rounded-full bg-gradient-to-r from-primary to-[#5ec21d]
                            text-background-dark font-bold text-lg neon-glow
                            hover:brightness-110 active:scale-[0.98] transition-all">
                            Xác thực Email
                        </button>

                        <!-- ERROR -->
                        <c:if test="${not empty otpError}">
                            <p class="text-center text-red-400 text-sm">${otpError}</p>
                        </c:if>

                        <!-- ACTIONS -->
                        <div class="text-center space-y-3 text-sm">
                            <a href="forget?action=forget" class="text-primary hover:underline">Thay đổi địa chỉ email</a>
                            <div>
                                <a href="login?action=login" class="text-white/40 hover:text-white flex justify-center gap-1">
                                    <span class="material-symbols-outlined text-sm">arrow_back</span>
                                    Quay lại đăng nhập
                                </a>
                            </div>
                        </div>

                        <input type="hidden" name="otp" id="otpValue">
                    </form>
                </div>
            </main>

        </c:if>


        <c:if test="${mode == 'success' }">
            <main class="relative z-10 flex-1 flex items-center justify-center p-6">
                <div class="glass-card w-full max-w-[480px] p-10 rounded-2xl flex flex-col gap-8 text-center">

                    <!-- Icon success -->
                    <div class="flex justify-center">
                        <div class="w-20 h-20 rounded-full
                             bg-[#83FF28]/15
                             flex items-center justify-center
                             shadow-[0_0_30px_rgba(131,255,40,0.35)]">
                            <span class="material-symbols-outlined
                                  text-[#83FF28]
                                  text-5xl">
                                check_circle
                            </span>
                        </div>
                    </div>


                    <!-- Title & description -->
                    <div class="space-y-3">
                        <h2 class="text-white text-3xl font-bold tracking-tight">
                            Tạo mới thành công
                        </h2>
                        <p class="text-white/60 text-sm leading-relaxed">
                            Mật khẩu của bạn đã được cập nhật.<br>
                            Bạn có thể sử dụng mật khẩu mới để đăng nhập ngay bây giờ.
                        </p>
                    </div>

                    <!-- Action -->
                    <div class="flex flex-col gap-4">
                        <a href="login?action=login"
                           class="group w-full flex items-center justify-center gap-2
                           rounded-xl px-6 py-4
                           bg-[#83FF28] text-[#0b1206] font-semibold text-lg
                           transition-all duration-300
                           hover:bg-[#6eea12]
                           hover:shadow-[0_0_25px_rgba(131,255,40,0.6)]
                           active:scale-95">
                            Đăng nhập ngay
                            <span class="material-symbols-outlined text-xl transition-transform group-hover:translate-x-1">
                                arrow_forward
                            </span>
                        </a>


                        <a href="home"
                           class="text-white/40 hover:text-white text-sm transition">
                            ← Quay về trang chủ
                        </a>
                    </div>

                </div>
            </main>



        </c:if>

        <div class="relative z-10 w-full p-8 flex justify-center opacity-30 pointer-events-none">
            <div class="flex gap-12 grayscale opacity-50">
                <img class="h-6" data-alt="Đối tác 1" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA2LCsEw_JH3fFrqP73dBcIeaVRyus5E3nyeTxGq4nbs5L-IJKkoLTOWnBQPAPonn-Ws9dynRvshSlhgBIun9npEciq0qRoh9LUFuMc7u9u8qfCpyhYfOEiecaG3KXQd7sC8TGht4-lZ-5LYgxqHZafgGBF9Vks2HumHIevXfOBeBm_rT9txAnttPWWdS_C72B5Fa2YNYqChSomMeZYfkguSRiflW60SfrSiYsgoZRBpLL2X1-HC7Zyeon2SphutHD-ZrYIxAySF0I"/>
                <img class="h-6" data-alt="Đối tác 2" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBi1zKmhL71B7-LRRDqb2AJl_SRh9ZczWP8EkoVemkGoVP5OkOtK8zn0o6eSAachxYMkskRuO1-3hFeBrG8_4EwjIelCdRcl4nZ_IH-FvLhvzDYonX4jR_Usu0wkpO5KDK-PCJ-ajXhB9MHLUFYvOFRsIIm-ME9aHQjyeLvlg17EL1BKrFAIewl4nPWutdTX24gr-IO0SkCZRnL5uj0r5ttImgu1MJjzXjtoAHPrjdgXuzQP2fkbRRBC90hjV32HDdWiVcuHVWHMAI"/>
                <img class="h-6" data-alt="Đối tác 3" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCzoD7ZE73_id8QLRsXQHABC_gwZQ4-XOJvvomLkmAmyYZvVqFyN2xbC1xl-VbhJ-I6yFY3ltE71bM4bhrCsgR-iPY_HlbygWqPPGrwjGKOCN-UhVYtjqLqjxpg8CHsKFTcuefm1K0DrIFoa4MantHkNWxkBjYVfB9a4kZfwtgLEAdXbhfwjPEmIF_NzsVTQsq4LWSReyVJKhNz_t0BLlkrWcX45JS05v_58v_Ehv_CaH7BMIkZqVLeSRVY1VhtX3iaTo10NTaL5dM"/>
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