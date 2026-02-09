<%-- 
    Document   : complete-profile
    Created on : Feb 8, 2026, 10:37:10 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                            "display": ["Inter"]
                        },
                        borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                    },
                },
            }
        </script>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark min-h-screen flex items-center justify-center p-6">
        <div class="w-full max-w-[640px]">
            <!-- Main Onboarding Card -->
            <div class="glass-card rounded-xl shadow-2xl p-8 md:p-12 flex flex-col items-center">
                <!-- Progress & Avatar -->
                <div class="relative mb-8">
                    <div class="size-24 rounded-full p-1 ring-4 ring-primary ring-offset-2 overflow-hidden bg-white">
                        <img alt="Google Profile Avatar" class="w-full h-full object-cover rounded-full" data-alt="User circular Google profile avatar portrait" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCB_pz9rvA8wGPfQK3U7ZErVbom6W3yoqnuFk_e4569Qa3w6w-qnpuzlJmh1uXixS_NLXZ3wSn1PsIaRRiV815lkUUOmoleV1ZFFM5EpW0aE0GWYu4dq9uV2U39WqpKYy8a7U39DrVvuIc1yDJRI1rXTn0NxKT_ylD9Nt37QFPFKGXZ43SiCkho8f1ebc5PIMplQntOOJjztZmCmeRytC5iV6ovKmBsdfVK25rB23DoMNYmRPHV-EizJnuLuC1TvCCGpjg5gf_n0nk"/>
                    </div>
                    <div class="absolute -bottom-2 left-1/2 -translate-x-1/2 bg-primary text-white text-[10px] font-bold px-3 py-1 rounded-full uppercase tracking-wider">
                        Google
                    </div>
                </div>
                <!-- Header -->
                <div class="text-center mb-10">
                    <h1 class="text-3xl font-bold text-[#101b0d] tracking-tight mb-2">Hoàn tất hồ sơ của bạn</h1>
                    <p class="text-[#599a4c] text-base">Chỉ còn một bước nữa để bắt đầu sử dụng hệ thống</p>
                    <div class="mt-6 w-full max-w-[240px] mx-auto">

                        <div class="h-1.5 w-full bg-primary/20 rounded-full overflow-hidden">
                            <div class="h-full bg-primary rounded-full" style="width: 100%;"></div>
                        </div>
                    </div>
                </div>
                <!-- Form -->
                <form action="${pageContext.request.contextPath}/complete-profile" method="POST" class="w-full space-y-6">
                    <!-- Prefilled Email (Read-only) -->
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-[#101b0d]">Địa chỉ Email</label>
                        <div class="relative">
                            <input class="w-full bg-[#f0f4f0] border-transparent text-[#599a4c] rounded-lg py-3.5 px-4 cursor-not-allowed text-sm focus:ring-0" readonly="" type="email" value="${USER.email}"/>
                            <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-[#599a4c]/50 text-xl">lock</span>
                        </div>

                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Username -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-[#101b0d]">Tên đăng nhập <span class="text-red-500">*</span></label>
                            <input required name="username" class="w-full bg-white border-[#e9f3e7] focus:border-primary focus:ring-primary/20 rounded-lg py-3.5 px-4 text-sm transition-all shadow-sm" placeholder="your_username" type="text"/>
                            <c:choose>
                                <c:when test="${not empty ERROR}">
                                    <p class="text-[11px] text-red-500 font-medium">
                                        ${ERROR}
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-[11px] text-[#599a4c] font-medium">
                                        Tên dùng để đăng nhập
                                    </p>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <!-- Full Name -->
                        <div class="space-y-2">
                            <label class="block text-sm font-semibold text-[#101b0d]">Họ và tên</label>
                            <input required name="fullname" class="w-full bg-white border-[#e9f3e7] focus:border-primary focus:ring-primary/20 rounded-lg py-3.5 px-4 text-sm transition-all shadow-sm" type="text" value=""/>
                        </div>
                    </div>
                    <!-- Role Selection -->
                    <div class="space-y-4 pt-2">
                        <label class="block text-sm font-semibold text-[#101b0d]">Tôi muốn tham gia với tư cách:</label>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Learner Card -->
                            <label class="relative group cursor-pointer">
                                <input checked="" class="peer sr-only" name="role" type="radio" value="STUDENT"/>
                                <div class="h-full border-2 border-[#e9f3e7] rounded-xl p-5 peer-checked:border-primary peer-checked:bg-primary/5 transition-all hover:border-primary/50 bg-white/50">
                                    <div class="flex items-center gap-3 mb-2">
                                        <div class="size-10 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                            <span class="material-symbols-outlined">school</span>
                                        </div>
                                        <span class="font-bold text-[#101b0d]">Học viên</span>
                                    </div>
                                    <p class="text-xs text-[#599a4c] leading-relaxed">Truy cập khóa học, làm bài tập và nhận tài liệu học tập.</p>
                                    <div class="absolute top-4 right-4 text-primary opacity-0 peer-checked:opacity-100 transition-opacity">
                                        <span class="material-symbols-outlined text-lg">check_circle</span>
                                    </div>
                                </div>
                            </label>
                            <!-- Instructor Card -->
                            <label class="relative group cursor-pointer">
                                <input class="peer sr-only" name="role" type="radio" value="TEACHER"/>
                                <div class="h-full border-2 border-[#e9f3e7] rounded-xl p-5 peer-checked:border-primary peer-checked:bg-primary/5 transition-all hover:border-primary/50 bg-white/50">
                                    <div class="flex items-center gap-3 mb-2">
                                        <div class="size-10 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                            <span class="material-symbols-outlined">auto_stories</span>
                                        </div>
                                        <span class="font-bold text-[#101b0d]">Giảng viên</span>
                                    </div>
                                    <p class="text-xs text-[#599a4c] leading-relaxed">Tạo nội dung giảng dạy, quản lý học viên và lớp học.</p>
                                    <div class="absolute top-4 right-4 text-primary opacity-0 peer-checked:opacity-100 transition-opacity">
                                        <span class="material-symbols-outlined text-lg">check_circle</span>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                    <!-- Action Button -->
                    <div class="pt-6">
                        <button class="w-full bg-primary hover:bg-[#2ed60f] text-white font-bold py-4 rounded-lg transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2 text-lg active:scale-[0.98]" type="submit">
                            Hoàn tất &amp; Bắt đầu
                            <span class="material-symbols-outlined">arrow_forward</span>
                        </button>
                        <p class="text-center text-xs text-[#101b0d]/40 mt-6">
                            Bằng cách tiếp tục, bạn đồng ý với <a class="underline hover:text-primary" href="#">Điều khoản dịch vụ</a> và <a class="underline hover:text-primary" href="#">Chính sách bảo mật</a> của chúng tôi.
                        </p>
                    </div>
                </form>
            </div>
            <!-- Background decorative elements -->
            <div class="fixed top-[-10%] left-[-10%] w-[40%] h-[40%] bg-primary/5 rounded-full blur-[100px] -z-10"></div>
            <div class="fixed bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-primary/10 rounded-full blur-[100px] -z-10"></div>
        </div>
    </body></html>