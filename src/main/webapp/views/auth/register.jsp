<%-- 
    Document   : register
    Created on : Feb 4, 2026, 8:32:35 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>DevLearn - Authentication Portal</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#37ec13",
                            "background-light": "#f6f8f6",
                            "background-dark": "#132210",
                        },
                        fontFamily: {
                            display: ["Inter", "sans-serif"]
                        },
                        borderRadius: {
                            DEFAULT: "0.25rem",
                            lg: "0.5rem",
                            xl: "0.75rem",
                            full: "9999px"
                        }
                    }
                }
            }
        </script>

    </head>
    <body class="bg-background-light dark:bg-background-dark font-display min-h-screen flex items-center justify-center p-6">
        <div class="w-full max-w-5xl flex flex-col md:flex-row bg-white dark:bg-zinc-900 rounded-xl shadow-2xl overflow-hidden border border-zinc-200 dark:border-zinc-800">
            <!-- Sidebar / Visual Section -->
            <div class="hidden md:flex md:w-1/2 bg-zinc-900 relative overflow-hidden flex-col justify-between p-12">
                <div class="relative z-10">
                    <div class="flex items-center gap-2 mb-8">
                        <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center shadow-[0_0_20px_rgba(55,236,19,0.4)]">
                            <span class="material-icons text-zinc-900 font-bold">terminal</span>
                        </div>
                        <span class="text-2xl font-bold text-white tracking-tight">DevLearn</span>
                    </div>
                    <h2 class="text-4xl font-bold text-white leading-tight mb-6">Master the art of <span class="text-primary">coding</span> with us.</h2>
                    <p class="text-zinc-400 text-lg leading-relaxed">Join 50,000+ IT students learning cloud architecture, full-stack development, and AI engineering.</p>
                </div>
                <div class="relative z-10 flex flex-col gap-6">
                    <div class="flex items-center gap-4">
                        <div class="flex -space-x-3">
                            <img class="w-10 h-10 rounded-full border-2 border-zinc-900 object-cover" data-alt="User profile avatar of a male student" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCgYHFWnemRC59oDvfdcK65KhNu21njaDtg_XBQNXGhblfR-IubgA06M9gcXAXEJwz7Or3G29HpNfhD0-tpb4vEKotDNDguzoSwEzP25pp0WoPljFCi2sopA0MBEavLf7wKQCirJNLRVp5RRkNt9VId_-UoCtz4Tvdl11QyUL-yoGHbyCacAlQW_N5FmuK9-U9DrhIX2gQrXUSQXWhULmX8flgehToTsKSdFddXO4H3rwxGA9_HsTRfAFBokl1o64SZkP41rzgRqpY"/>
                            <img class="w-10 h-10 rounded-full border-2 border-zinc-900 object-cover" data-alt="User profile avatar of a female student" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCtra0VjaqP25sFM7q8xzN_o2I4jThfjZhMkP-G430EUta_gABoeY_C0wvAxzDcrVjK8rW9dmLfOallFEzWG2FQteeOYymMZ07464deSqbAnGxaNmTNyXT95qPoRsapos0iKYB4qEEAbav20IlHder2Aq2ef1XHgfI6erSjuz2ercMf_3k_VB95y82nhiu8HrGZ25y-6nf0dJxquiWcj7mq4ya1VCTGgatxWnVnYXKd5lLwFHCi2bnjx_CXPVlG_KFcCP7s2Vq5S9s"/>
                            <img class="w-10 h-10 rounded-full border-2 border-zinc-900 object-cover" data-alt="User profile avatar of a student" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBE1Xs5kZDZEo_XxxA6OMdhCrJQEdMuF_oaCJ2Kxz0-oa--HYD8jfqsLsO5roCkN99eZkixQKN9EKHzrrTabtjL8oeRQaQB8pR_D61gBrk15rxBb0x4BeJPEI26bgA3iNQRSDs4cPKlKiW0culmH8FuERLoN_lFIsaKRv0k6R__dYRBK0l6MyDErbcrwZB_PLh-nLpnIxBwiQyHrX0jHyM-e4i9Kg2pE0ILoiluE9LQmhcYMXQbEomAEuKqBei8keRw6WG5gU6eYYY"/>
                        </div>
                        <p class="text-sm text-zinc-400">Trusted by students worldwide</p>
                    </div>
                </div>
                <!-- Abstract Background Pattern -->
                <div class="absolute inset-0 opacity-10">
                    <div class="absolute -right-20 -top-20 w-96 h-96 bg-primary rounded-full blur-[120px]"></div>
                    <div class="absolute -left-20 -bottom-20 w-96 h-96 bg-primary rounded-full blur-[120px]"></div>
                    <div class="absolute inset-0" style="background-image: radial-gradient(circle at 2px 2px, #37ec13 1px, transparent 0); background-size: 40px 40px;"></div>
                </div>
            </div>
            <!-- Form Section -->
            <div class="w-full md:w-1/2 p-8 md:p-16 flex flex-col justify-center">
                <!-- Header Links (Desktop only) -->
                <div class="flex justify-end mb-8 text-sm">
                    <p class="text-zinc-500 dark:text-zinc-400">Already a member? <a class="text-primary font-semibold hover:underline" href="login?action=login">Sign In</a></p>
                </div>
                <div class="max-w-md mx-auto w-full">
                    <div class="mb-10 text-center md:text-left">
                        <h1 class="text-3xl font-bold text-zinc-900 dark:text-white mb-2">Create an account</h1>
                        <p class="text-zinc-500 dark:text-zinc-400">Start your 14-day free trial and explore our courses.</p>
                    </div>
                    <!-- Auth Buttons -->
                    <div class="grid grid-cols-2 gap-4 mb-8">
                        <button class="flex items-center justify-center gap-2 py-2.5 px-4 border border-zinc-200 dark:border-zinc-700 rounded-lg hover:bg-zinc-50 dark:hover:bg-zinc-800 transition-colors duration-200">
                            <img alt="Google" class="w-5 h-5" src="https://lh3.googleusercontent.com/aida-public/AB6AXuASt5OhKTm5RGy6OW7req_MBwEt-kQfaYENmTaUgG4RjBq0KZW3_3FlJCv1DIDAEgDEr7FRaB9UnUZb0KUgZ9v8ZxuxuEBBXPZXkRj4-nYn-l17Sdh4McHLZS9AOqhug2FeinOiGD_2l7jRgrHdXWO__0YwgDsPi_RZmvulq31JDZoiQEiSoRnUI6FDE9S51yMlO1LGi4eBDPa-NC76dpD-JaUcZdfpFNqJ-DKSv4791ZK6RTTj5AkIOl69K92KTYVsBb0PTXPvD9I"/>
                            <span class="text-sm font-medium text-zinc-700 dark:text-zinc-300">Google</span>
                        </button>
                        <button class="flex items-center justify-center gap-2 py-2.5 px-4 border border-zinc-200 dark:border-zinc-700 rounded-lg hover:bg-zinc-50 dark:hover:bg-zinc-800 transition-colors duration-200">
                            <img alt="GitHub" class="w-5 h-5 dark:invert" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCV6qJR6kgWap5jLvuZoRuxoNh6R8uo9AK-9gcX9nTITtWEK35eI2ig-9YPenI3PrLM7KPTgqj8oRJHY57wXpN17BnmXwLciSzL0V36FguStq-qv00X31gREnrPpRAqxM1a7oN7fswQqwFWEbGCzx0WfMVgRFAMPZXe7shq70nOJydAcLpwJB_nbO29TCry5vsDTQAdZNvilM-6Vl_Gy7KigxuEC4J-Zd9KPHklckzVSQwZo5FUpMlWTbD5_GeYevQMx_4Fj5FSim8"/>
                            <span class="text-sm font-medium text-zinc-700 dark:text-zinc-300">GitHub</span>
                        </button>
                    </div>
                    <div class="relative mb-8">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-zinc-200 dark:border-zinc-700"></div>
                        </div>
                        <div class="relative flex justify-center text-sm uppercase">
                            <span class="bg-white dark:bg-zinc-900 px-4 text-zinc-500 dark:text-zinc-400">Or continue with</span>
                        </div>
                    </div>
                    <form class="space-y-5" action="register" method="POST">
                        <div>
                            <label class="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-1.5"  for="username">User Name</label>
                            <input required class="w-full px-4 py-3 rounded-lg border border-zinc-200 dark:border-zinc-700 bg-white dark:bg-zinc-800 text-zinc-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-zinc-400" id="username" name="username" placeholder="John Doe" type="text"/>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-1.5" for="fullname">Full Name</label>
                            <input required class="w-full px-4 py-3 rounded-lg border border-zinc-200 dark:border-zinc-700 bg-white dark:bg-zinc-800 text-zinc-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-zinc-400" id="fullname" name="fullname" placeholder="John Doe" type="text"/>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-1.5" for="email">Email address</label>
                            <input required class="w-full px-4 py-3 rounded-lg border border-zinc-200 dark:border-zinc-700 bg-white dark:bg-zinc-800 text-zinc-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-zinc-400" id="email" name="email" placeholder="name@university.edu" type="email"/>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-1.5" for="password">Password</label>
                            <input required class="w-full px-4 py-3 rounded-lg border border-zinc-200 dark:border-zinc-700 bg-white dark:bg-zinc-800 text-zinc-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-zinc-400" id="password" name="password" placeholder="••••••••" type="password"/>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-zinc-700 dark:text-zinc-300 mb-1.5" for="role">
                                You are joining as:
                            </label>
                            <select required
                                id="role"
                                name="role"
                                class="w-full px-4 py-3 rounded-lg border border-zinc-200 dark:border-zinc-700 
                                bg-white dark:bg-zinc-800 
                                text-zinc-900 dark:text-white 
                                focus:ring-2 focus:ring-primary focus:border-primary 
                                outline-none transition-all"
                                >
                                <option value="" disabled selected>-- Select your role --</option>
                                <option value="TEACHER">Teacher</option>
                                <option value="STUDENT">Student</option>
                            </select>
                        </div>
                        <div class="flex items-start gap-3 pt-2">
                            <div class="flex items-center h-5">
                                <input class="w-4 h-4 text-primary border-zinc-300 rounded focus:ring-primary accent-primary" id="terms" name="terms" type="checkbox"/>
                            </div>
                            <label class="text-sm text-zinc-500 dark:text-zinc-400" for="terms">
                                I agree to the <a class="text-primary hover:underline font-medium" href="#">Terms of Service</a> and <a class="text-primary hover:underline font-medium" href="#">Privacy Policy</a>.
                            </label>  

                        </div>
                        <button class="w-full bg-primary hover:bg-primary/90 text-zinc-900 font-bold py-3.5 rounded-lg shadow-lg shadow-primary/20 transition-all duration-200 transform active:scale-[0.98] mt-4" type="submit">
                            Create Account
                        </button>
                    </form>
                    <c:if test="${not empty userError}">
                        <p class="mt-3 text-sm text-red-500 text-center">
                            ${userError}
                        </p>
                    </c:if>

                    <p class="mt-8 text-center text-sm text-zinc-500 dark:text-zinc-400 md:hidden">
                        Already a member? <a class="text-primary font-semibold hover:underline" href="#">Log In</a>
                    </p>
                    <div class="mt-12 pt-8 border-t border-zinc-100 dark:border-zinc-800 flex flex-wrap justify-center gap-6 text-xs text-zinc-400">
                        <a class="hover:text-primary transition-colors" href="#">Documentation</a>
                        <a class="hover:text-primary transition-colors" href="#">Help Center</a>
                        <a class="hover:text-primary transition-colors" href="#">Security</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Mode Toggle Floating Button -->
        <div class="fixed bottom-6 right-6">
            <button class="p-3 bg-white dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-full shadow-lg text-zinc-600 dark:text-zinc-300 hover:text-primary dark:hover:text-primary transition-colors" onclick="document.documentElement.classList.toggle('dark')">
                <span class="material-icons block dark:hidden">dark_mode</span>
                <span class="material-icons hidden dark:block">light_mode</span>
            </button>
        </div>
    </body>
</html>
