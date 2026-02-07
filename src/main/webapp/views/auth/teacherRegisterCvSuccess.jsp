<%-- 
    Document   : teacherRegisterCvSuccess
    Created on : Feb 6, 2026, 5:07:48 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Application Submitted - EduMint</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#39e633",
                            "background-light": "#f6f8f6",
                            "background-dark": "#122111",
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
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            .success-glow {
                box-shadow: 0 0 30px 5px rgba(57, 230, 51, 0.3);
            }
            .mint-gradient {
                background: linear-gradient(180deg, #F4FAF4 0%, #ECF7EC 100%);
            }
            .dark .mint-gradient {
                background: linear-gradient(180deg, #122111 0%, #0d1a0d 100%);
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark min-h-screen">
        <div class="relative flex h-screen w-full flex-col mint-gradient overflow-x-hidden">
            <div class="layout-container flex h-full grow flex-col">
                <!-- Navigation -->
                <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-black/5 px-10 py-4 bg-white/50 backdrop-blur-sm dark:bg-background-dark/50 dark:border-white/5">
                    <div class="flex items-center gap-4 text-[#111811] dark:text-white">
                        <div class="size-8 text-primary">
                            <svg fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                            <g clip-path="url(#clip0_6_319)">
                            <path d="M8.57829 8.57829C5.52816 11.6284 3.451 15.5145 2.60947 19.7452C1.76794 23.9758 2.19984 28.361 3.85056 32.3462C5.50128 36.3314 8.29667 39.7376 11.8832 42.134C15.4698 44.5305 19.6865 45.8096 24 45.8096C28.3135 45.8096 32.5302 44.5305 36.1168 42.134C39.7033 39.7375 42.4987 36.3314 44.1494 32.3462C45.8002 28.361 46.2321 23.9758 45.3905 19.7452C44.549 15.5145 42.4718 11.6284 39.4217 8.57829L24 24L8.57829 8.57829Z" fill="currentColor"></path>
                            </g>
                            <defs>
                            <clippath id="clip0_6_319"><rect fill="white" height="48" width="48"></rect></clippath>
                            </defs>
                            </svg>
                        </div>
                        <h2 class="text-[#111811] dark:text-white text-xl font-bold leading-tight tracking-tight">DevLearn</h2>
                    </div>
                    <div class="flex flex-1 justify-end gap-8">
                        <div class="flex items-center gap-9">
                            <a class="text-[#111811] dark:text-gray-300 text-sm font-medium leading-normal hover:text-primary transition-colors" href="#">Courses</a>
                            <a class="text-[#111811] dark:text-gray-300 text-sm font-medium leading-normal hover:text-primary transition-colors" href="#">Instructors</a>
                            <a class="text-[#111811] dark:text-gray-300 text-sm font-medium leading-normal hover:text-primary transition-colors" href="#">Support</a>
                        </div>
                        <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-full size-10 border border-primary/20 shadow-sm" data-alt="User profile avatar of a professional instructor" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBk-xeoCb585Q1RmaKvfd3GVVu0sATKzf_BxRnJpILtel68omyyBqSOnQGXcvltNrjXQvEEUyPRjW9XFVuRWrEIF-aRMnSiHu93thoGZwskeZYyWvReD_NvSgeQMFxXB3FU5cbykbNBXlD1gRY_8rs0qyjrzspeIDhdcqzcfYmETS--3o061T6jehFJcE40HRY0S4QybOuVM-HiyrycoUZLSZcFQ7Tdia3uaKhkc9SSNxwMG4tm4PQudWIN_2ERpL50dQeAs7CaRiY");'></div>
                    </div>
                </header>
                <!-- Success Content -->
                <main class="flex-1 flex flex-col items-center justify-center p-6 @container">
                    <div class="max-w-[560px] w-full bg-white dark:bg-background-dark/40 backdrop-blur-md p-10 md:p-16 rounded-2xl shadow-xl border border-white dark:border-white/10 flex flex-col items-center text-center">
                        <!-- Glow Success Icon -->
                        <div class="mb-8 relative">
                            <div class="size-24 rounded-full bg-primary/10 flex items-center justify-center success-glow">
                                <span class="material-symbols-outlined text-primary !text-5xl font-bold">check_circle</span>
                            </div>
                        </div>
                        <!-- Title -->
                        <h1 class="text-[#111811] dark:text-white text-3xl md:text-4xl font-bold leading-tight mb-4 font-display">
                            Application Submitted Successfully
                        </h1>
                        <!-- Status Badge -->
                        <div class="mb-6">
                            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 border border-primary/20">
                                <span class="size-2 rounded-full bg-primary animate-pulse"></span>
                                <span class="text-primary text-sm font-semibold uppercase tracking-wider">Review Pending</span>
                            </div>
                        </div>
                        <!-- Description -->
                        <p class="text-[#4b5563] dark:text-gray-400 text-lg leading-relaxed mb-10 max-w-md">
                            Your profile will be reviewed within <strong>1–2 business days</strong>. We will notify you via email once your account is verified.
                        </p>
                        <!-- Primary Action -->
                        <div class="w-full space-y-4">

                            <a href="${pageContext.request.contextPath}/shop"
                               class="w-full bg-primary hover:bg-primary/90 text-[#111811] font-bold py-4 px-8 rounded-lg transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2">
                                <span>Return to Dashboard</span>
                                <span class="material-symbols-outlined !text-xl">dashboard</span>
                            </a>


                            <p class="text-sm text-gray-500 dark:text-gray-500">
                                Need help? <a class="text-primary hover:underline underline-offset-4" href="#">Contact our support team</a>
                            </p>
                        </div>
                    </div>
                    <!-- Subtle Decorative Background Element -->
                    <div class="mt-12 opacity-50 select-none pointer-events-none hidden md:block">
                        <div class="flex gap-4 items-center text-primary/40 font-display font-medium uppercase tracking-widest text-xs">
                            <span>Application</span>
                            <span class="material-symbols-outlined !text-sm">arrow_forward</span>
                            <span>Verification</span>
                            <span class="material-symbols-outlined !text-sm">arrow_forward</span>
                            <span class="text-primary/100">Success</span>
                        </div>
                    </div>
                </main>
                <!-- Footer Small -->
                <footer class="py-6 px-10 text-center">
                    <p class="text-[#111811]/40 dark:text-white/20 text-xs">
                        © 2024 EduMint Learning Systems. All rights reserved.
                    </p>
                </footer>
            </div>
        </div>
    </body></html>