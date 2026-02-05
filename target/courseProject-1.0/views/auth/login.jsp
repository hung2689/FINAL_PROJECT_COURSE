<%-- 
    Document   : login
    Created on : Feb 5, 2026, 1:18:03 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>

<html class="light" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Desktop Login Portal | IT E-learning</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                            "text-main": "#101b0d",
                            "text-muted": "#599a4c",
                            "border-color": "#d3e7cf"
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

    </head>
    <body class="bg-background-light dark:bg-background-dark min-h-screen font-display">
        <div class="flex min-h-screen flex-row overflow-hidden">
            <!-- Left Side: Illustration & Brand -->
            <div class="hidden lg:flex lg:w-1/2 flex-col justify-center items-center bg-primary/10 dark:bg-primary/5 p-12 relative">
                <div class="absolute top-12 left-12 flex items-center gap-2">
                    <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-white">
                        <span class="material-symbols-outlined font-bold">terminal</span>
                    </div>
                    <span class="text-2xl font-bold text-text-main dark:text-white tracking-tight">DevLearn</span>
                </div>
                <div class="w-full max-w-lg">
                    <div class="w-full aspect-[4/3] rounded-2xl overflow-hidden shadow-2xl mb-12">
                        <div class="w-full h-full bg-center bg-no-repeat bg-cover" data-alt="Modern 3D illustration of IT students coding and collaborating" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDAz4inAIMNE7Dxrc4PmNBGZCRB6NZl7taT5eKKJbfh0P6pXUPcvtgHidC3zP_VsXY_0Sje_BtD46zDZoxjj-uNO6GETHoCY4qlTPKLooVun6R4NdZqvbdHjKI5FNHjO7MsJTc43Hyg048nYVRwf8R62IzLi-t8UiGgMX3PNTKhKOpdD9yFkcERn5LBm4opke-hPLru7LwXTlGdkJaS3XtReoUgPmmNZ1s9xHMRBgf36hQlVN1UJ3D0hJCzzT9IyGwTW0UOGmw4tWk");'>
                        </div>
                    </div>
                    <div class="space-y-4 text-center lg:text-left">
                        <h2 class="text-4xl font-bold text-text-main dark:text-white leading-tight">Learning without limits</h2>
                        <p class="text-lg text-text-muted dark:text-primary/70">Explore a professional IT learning roadmap with a community of over 50,000 talented learners.</p>
                    </div>
                </div>
            </div>
            <!-- Right Side: Login Form -->
            <div class="w-full lg:w-1/2 flex flex-col justify-center items-center p-6 sm:p-12 bg-background-light dark:bg-background-dark">
                <div class="w-full max-w-[480px]">
                    <!-- PageHeading Section -->
                    <div class="mb-8">
                        <h1 class="text-[#101b0d] dark:text-white tracking-tight text-[32px] font-bold leading-tight">Welcome back!</h1>
                        <p class="text-[#599a4c] dark:text-primary/80 text-base font-normal mt-2">Sign in to continue your IT journey.</p>
                    </div>
                    <!-- Form Container -->
                    <form class="space-y-6" action="login" method="POST" novalidate>
                        <!-- TextField: Email -->
                        <div class="flex flex-col gap-2">
                            <label class="text-[#101b0d] dark:text-white text-base font-medium leading-normal">
                                Email or Username
                            </label>
                            <input required name="input" class="form-input flex w-full rounded-lg text-[#101b0d] dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/20 border border-[#d3e7cf] dark:border-white/10 bg-white dark:bg-white/5 focus:border-primary h-14 placeholder:text-[#599a4c]/50 p-[15px] text-base font-normal leading-normal transition-all" placeholder="example@edu.vn" type="text"/>
                        </div>
                        <!-- TextField: Password -->
                        <div class="flex flex-col gap-2">
                            <label class="text-[#101b0d] dark:text-white text-base font-medium leading-normal">
                                Password
                            </label>
                            <div class="flex w-full items-stretch rounded-lg">
                                <input required name="password" class="form-input flex w-full min-w-0 flex-1 rounded-lg rounded-r-none border-r-0 text-[#101b0d] dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/20 border border-[#d3e7cf] dark:border-white/10 bg-white dark:bg-white/5 focus:border-primary h-14 placeholder:text-[#599a4c]/50 p-[15px] text-base font-normal leading-normal transition-all" placeholder="••••••••" type="password"/>
                                <button class="text-[#599a4c] flex border border-[#d3e7cf] dark:border-white/10 border-l-0 bg-white dark:bg-white/5 items-center justify-center px-4 rounded-r-lg hover:text-primary transition-colors" type="button">
                                    <span class="material-symbols-outlined">visibility</span>
                                </button>
                            </div>
                        </div>
                        <!-- Checklist & Forgot Link -->
                        <div class="flex items-center justify-between py-1">
                            <label class="flex items-center gap-x-3 cursor-pointer group">
                                <input name="remember" value="1" class="h-5 w-5 rounded border-[#d3e7cf] dark:border-white/20 border-2 bg-transparent text-primary checked:bg-primary checked:border-primary focus:ring-0 focus:ring-offset-0 transition-all custom-checkbox" type="checkbox"/>
                                <span class="text-[#101b0d] dark:text-white/80 text-sm font-normal select-none">Remember me</span>
                            </label>
                            <a class="text-primary hover:text-primary/80 text-sm font-medium transition-colors" href="#">Forgot your password?</a>
                        </div>
                        <!-- Submit Button -->
                        <button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-4 px-6 rounded-lg shadow-lg shadow-primary/20 transition-all active:scale-[0.98] flex justify-center items-center gap-2" type="submit">
                            Sign in
                            <span class="material-symbols-outlined text-xl">arrow_forward</span>
                        </button>
                    </form>
                    <c:if test="${not empty error}">
                        <div class="mt-4 text-sm text-red-600       rounded-lg px-4 py-3">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Footer -->
                    <div class="mt-10 pt-8 border-t border-[#d3e7cf] dark:border-white/5 text-center">
                        <p class="text-[#599a4c] dark:text-white/60 text-base">
                            New here? Create an account
                            <a class="text-primary font-bold hover:underline ml-1" href="register?action=register">Sign up now</a>
                        </p>
                    </div>
                    <!-- Trust Badges (Optional for IT portal) -->
                    <div class="mt-12 flex justify-center items-center gap-6 opacity-40 grayscale">
                        <span class="material-symbols-outlined text-3xl">security</span>
                        <span class="material-symbols-outlined text-3xl">shield</span>
                        <span class="material-symbols-outlined text-3xl">verified_user</span>
                    </div>
                </div>
            </div>
        </div>
    </body></html>
