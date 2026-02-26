<%-- 
    Document   : home
    Created on : Feb 11, 2026, 2:11:15 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>DevLearn | Nền tảng học tập trực tuyến</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#37ec13",
                            "background-light": "#f8faf8",
                            "background-dark": "#0d140b",
                        },
                        fontFamily: {
                            "display": ["Inter", "sans-serif"]
                        },
                        maxWidth: {
                            "canvas": "1440px",
                        }
                    },
                },
            }
        </script>
        <style type="text/tailwindcss">
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            @layer base {
                body {
                    @apply antialiased;
                }
            }
        </style>  
ì    </head>
    <body class="bg-background-light dark:bg-background-dark font-display text-[#1a2e16] dark:text-gray-100 transition-colors duration-300">
        <div class="relative flex min-h-screen w-full flex-col">
            <header class="sticky top-0 z-50 w-full bg-white/80 dark:bg-background-dark/80 backdrop-blur-xl border-b border-gray-100 dark:border-white/10">
                <div class="max-w-canvas mx-auto px-8 lg:px-12 py-5 flex items-center justify-between">
                    <div class="flex items-center gap-12">
                        <div class="flex items-center gap-2 group cursor-pointer">
                            <div class="w-10 h-10 bg-primary rounded-xl flex items-center justify-center text-[#101b0d] shadow-lg shadow-primary/20">
                                <span class="material-symbols-outlined text-2xl font-bold">terminal</span>
                            </div>
                            <h2 class="text-2xl font-black tracking-tight">DevLearn</h2>
                        </div>
                        <nav class="hidden lg:flex items-center gap-8">
                            <a class="text-[15px] font-medium text-gray-600 dark:text-gray-300 hover:text-primary transition-colors" href="#">Trang chủ</a>
                            <a class="text-[15px] font-medium text-gray-600 dark:text-gray-300 hover:text-primary transition-colors" href="#">Khóa học</a>
                            <a class="text-[15px] font-medium text-gray-600 dark:text-gray-300 hover:text-primary transition-colors" href="#">Lộ trình</a>
                            <a class="text-[15px] font-medium text-gray-600 dark:text-gray-300 hover:text-primary transition-colors" href="#">Cộng đồng</a>
                            <a class="text-[15px] font-medium text-gray-600 dark:text-gray-300 hover:text-primary transition-colors" href="#">Về chúng tôi</a>
                        </nav>
                    </div>
                    <div class="flex items-center gap-4">
                        <button class="text-[15px] font-semibold px-6 py-2.5 rounded-xl hover:bg-gray-100 dark:hover:bg-white/5 transition-all">
                            Đăng nhập
                        </button>
                        <button class="bg-primary text-[#101b0d] text-[15px] font-bold px-8 py-2.5 rounded-xl shadow-lg shadow-primary/10 hover:opacity-90 hover:-translate-y-0.5 transition-all">
                            Bắt đầu ngay
                        </button>
                    </div>
                </div>
            </header>
            <main class="flex-1">
                <section class="relative overflow-hidden pt-12 lg:pt-20 pb-20 lg:pb-32">
                    <div class="max-w-canvas mx-auto px-8 lg:px-12">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
                            <div class="max-w-2xl">
                                <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 text-primary text-xs font-bold uppercase tracking-wider mb-8">
                                    <span class="relative flex h-2 w-2">
                                        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-primary opacity-75"></span>
                                        <span class="relative inline-flex rounded-full h-2 w-2 bg-primary"></span>
                                    </span>
                                    Mới: Khóa học AI cho người mới
                                </div>
                                <h1 class="text-5xl lg:text-7xl font-black leading-[1.1] mb-8 tracking-tight">
                                    Chinh phục thế giới <span class="text-primary italic">Lập trình</span> một cách bài bản.
                                </h1>
                                <p class="text-lg lg:text-xl text-gray-500 dark:text-gray-400 mb-10 leading-relaxed">
                                    Nền tảng học tập trực tuyến chuẩn quốc tế dành riêng cho sinh viên IT. Học từ chuyên gia, thực hành thực tế và nhận chứng chỉ uy tín để bắt đầu sự nghiệp.
                                </p>
                                <div class="flex flex-wrap gap-4 mb-12">
                                    <button class="h-16 px-10 bg-primary text-[#101b0d] text-lg font-bold rounded-2xl shadow-xl shadow-primary/20 hover:scale-105 transition-all flex items-center gap-3">
                                        Khám phá khóa học
                                        <span class="material-symbols-outlined">arrow_forward</span>
                                    </button>
                                    <button class="h-16 px-10 border-2 border-gray-200 dark:border-white/10 text-lg font-bold rounded-2xl hover:bg-gray-50 dark:hover:bg-white/5 transition-all">
                                        Xem lộ trình học tập
                                    </button>
                                </div>
                                <div class="flex items-center gap-6">
                                    <div class="flex -space-x-4">
                                        <div class="w-12 h-12 rounded-full border-4 border-white dark:border-background-dark bg-cover bg-center" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuACBh-IBngIxMyAwu71Ae1YhcjmMoVn0nVXnDZwL4dxAvI3gUCGJiFXXltAZaSVw5pMftBU8nMiQCDdoesMrDYs37yJVlUL9e5hWSoyec9AfaSbxXkCW0VJ0M_L81DBJ2g8aD8Kq0Y1ox8tjOLy31dElDOAFbXWjtid2ZnPunZpF2Xn5iK-rBi5I2Qgoglqtu29VQt95g-az1eZzduTJaq5YB7rgzPPczCgZyI6SLJ1zzq8AZM23jRQ84v0TFfeCeOQxaK9Ivy84wc')"></div>
                                        <div class="w-12 h-12 rounded-full border-4 border-white dark:border-background-dark bg-cover bg-center" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC0dTCRRoa1DJxK8VJw4ZY6iY8b2pnKVefT9G4dd0MdbNqiHhrKHi4lGW_x4ZCyA5HVIZ8HmeY_7HEDUgi4lpNcAE0WU1xuXYgjxTWQvWb6iN0DYdlCWzws1vAZjt5qE8p61CBcaZoS9tV7AZlF_XG4-wneutR0N469EZiy6aNdGVWCp2xIAxcQkLOE-WWbcA2e8n-udbkmfQW5Cl9m4cKllWZRCgvSeDK2qnl_vCC9VYY_FRY3tdxCcgjW7cHyNJzMIOUD5CPUI0g')"></div>
                                        <div class="w-12 h-12 rounded-full border-4 border-white dark:border-background-dark bg-cover bg-center" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDEnulu-c3qozuR9uL_C-zfGR_cDAfUpRRfDVxAiTqY_AwLfMdslUhX-d5y3UtOZk8pk_nVJHoiZ42VgRRi2f694b6tHrkB5t8Il3yEGoq3VesBaaR30gI53EHIUDiOKzKgYAwaxqmKBs1kXp3wni6ETeNyacAZf6P2hnKsO_asgprZi60eMZBx0JwGCHydu24oLP07ih8-TFF7aEW4f9lBMPpFNMpoi46-Rsb_tSsmBGPOUBAZWNOP4_IsWreW_nc59tlRfYvWsNI')"></div>
                                        <div class="w-12 h-12 rounded-full border-4 border-white dark:border-background-dark bg-gray-900 flex items-center justify-center text-[10px] font-bold text-white">+5K</div>
                                    </div>
                                    <div class="h-8 w-px bg-gray-200 dark:bg-white/10"></div>
                                    <div class="text-sm font-medium text-gray-500">
                                        <span class="text-[#101b0d] dark:text-white font-bold block">15,000+ Học viên</span>
                                        Đang học tập mỗi ngày
                                    </div>
                                </div>
                            </div>
                            <div class="relative lg:block hidden">
                                <div class="absolute -top-20 -right-20 w-[500px] h-[500px] bg-primary/10 rounded-full blur-[100px] -z-10"></div>
                                <div class="relative rounded-[2.5rem] overflow-hidden shadow-[0_32px_64px_-16px_rgba(0,0,0,0.15)] border border-white/20">
                                    <img alt="Learning Experience" class="w-full aspect-square object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZcsCMLMIk29IPDdH0it_8eCThOwXvEvWkVyO-xfp5rcuMvvcUKqtabD5VcKsSV8UT6MHy7Sg9mB1p_vXzPzbA_XANbTxipd7rf9iZgZ5sxDABLcUermRqq2lIN7SfeB6HboxJVJRDLf75Q8bgSSHCrLLxB6ZUzFB71bVvetAeL-MzWrjjfO9kGG4sZXOTc7V3LVfY3VvH-m8igYtqzS_HpkP233vXP2lUCSUhi9AaGgDuz7P_7AfzKXyeD0r9YlH6dGIgCoAeHQw"/>
                                    <div class="absolute bottom-8 left-8 right-8 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md p-6 rounded-2xl shadow-2xl border border-white/20">
                                        <div class="flex items-center gap-4">
                                            <div class="w-12 h-12 bg-primary rounded-xl flex items-center justify-center text-[#101b0d]">
                                                <span class="material-symbols-outlined text-2xl font-bold">verified_user</span>
                                            </div>
                                            <div>
                                                <p class="font-bold text-lg leading-tight">Chứng chỉ uy tín</p>
                                                <p class="text-sm text-gray-500">Được 200+ đối tác công nghệ chấp nhận</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="py-12 bg-white dark:bg-[#111c0f] border-y border-gray-100 dark:border-white/5">
                    <div class="max-w-canvas mx-auto px-8 lg:px-12">
                        <div class="grid grid-cols-2 lg:grid-cols-4 gap-8">
                            <div class="flex flex-col items-center text-center lg:items-start lg:text-left gap-2">
                                <span class="text-3xl font-black text-primary">120+</span>
                                <span class="text-sm font-semibold uppercase tracking-widest text-gray-400">Khóa học chuyên sâu</span>
                            </div>
                            <div class="flex flex-col items-center text-center lg:items-start lg:text-left gap-2">
                                <span class="text-3xl font-black text-primary">50+</span>
                                <span class="text-sm font-semibold uppercase tracking-widest text-gray-400">Mentor kinh nghiệm</span>
                            </div>
                            <div class="flex flex-col items-center text-center lg:items-start lg:text-left gap-2">
                                <span class="text-3xl font-black text-primary">24/7</span>
                                <span class="text-sm font-semibold uppercase tracking-widest text-gray-400">Hỗ trợ kỹ thuật</span>
                            </div>
                            <div class="flex flex-col items-center text-center lg:items-start lg:text-left gap-2">
                                <span class="text-3xl font-black text-primary">100%</span>
                                <span class="text-sm font-semibold uppercase tracking-widest text-gray-400">Thực hành thực tế</span>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="py-24 lg:py-32">
                    <div class="max-w-canvas mx-auto px-8 lg:px-12">
                        <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                            <div class="max-w-xl">
                                <h2 class="text-4xl font-black mb-4 tracking-tight">Khóa học tiêu biểu</h2>
                                <p class="text-gray-500 dark:text-gray-400 text-lg">Được thiết kế để giúp bạn bắt đầu từ con số 0 đến khi có thể đi làm tại các tập đoàn lớn.</p>
                            </div>
                            <a class="inline-flex items-center gap-2 text-primary font-bold group" href="#">
                                Xem tất cả khóa học
                                <span class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                            </a>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-8">
                            <div class="group bg-white dark:bg-[#162514] rounded-[2rem] overflow-hidden border border-gray-100 dark:border-white/5 hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.1)] transition-all duration-300">
                                <div class="aspect-[16/10] overflow-hidden relative">
                                    <img alt="Frontend" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBEjm4VjPhoCQ6tOGL2KtgOlyXPhr_oZbJ6jnm19qhcDmg8jv9N1i6sPt0ry60SkKF6Y3RF9xN7CJC4c-d1gG7eRXkt8DVKvAUsfQFiaTkS-LvvGtOZr0cU8zRh7tu_72EmNtJ73LhE-AB26mBLD1BTOhpWnhAb_v3PCPMe0H1GQZIrEYtplvu_vHDsYM6PnmtoXirCXmNFza9oMxi-rX5cYt0xsdu0tKYFjPpxaC381LHzrjiOjgQ8TIzgqSvwG-CpDUW86UFsH6c"/>
                                    <div class="absolute top-4 left-4">
                                        <span class="bg-primary text-[#101b0d] text-[10px] font-black uppercase px-3 py-1.5 rounded-full">Frontend</span>
                                    </div>
                                </div>
                                <div class="p-8">
                                    <h3 class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors">HTML, CSS &amp; Tailwind cho người mới</h3>
                                    <p class="text-sm text-gray-500 dark:text-gray-400 mb-6 line-clamp-2">Nắm vững nền tảng xây dựng giao diện web hiện đại với kỹ thuật thực chiến.</p>
                                    <div class="flex items-center justify-between pt-6 border-t border-gray-100 dark:border-white/5">
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-primary text-xl">schedule</span>
                                            <span class="text-xs font-bold">42 Giờ</span>
                                        </div>
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-yellow-500 text-xl">star</span>
                                            <span class="text-xs font-bold">4.9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="group bg-white dark:bg-[#162514] rounded-[2rem] overflow-hidden border border-gray-100 dark:border-white/5 hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.1)] transition-all duration-300">
                                <div class="aspect-[16/10] overflow-hidden relative">
                                    <img alt="JavaScript" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDMTC0xBHYjO3A5wwDiTxSayNTasspRX9s3bs42qMl_nYmTmZsg9QxAg4IXaaw6IZwowUroIsZLoQzNTDp4SSNrcA1ASUEabpBYygb9n7CoYHKwMSFtJar7lMeKlZAfZTsDef9FySEBhYUkaazfAEuab2YH_7AhmeHElFauIv5j7T-GIizlBthF84bGxQ1pfPTIl_i_U1OEAR1cevQQmMLBtyM9k9Nrzm6Kt1msicvg5MsU8sfd3Nddh_MIKIGfh_jmn1nwZQ3BJ5w"/>
                                    <div class="absolute top-4 left-4">
                                        <span class="bg-primary text-[#101b0d] text-[10px] font-black uppercase px-3 py-1.5 rounded-full">Logic</span>
                                    </div>
                                </div>
                                <div class="p-8">
                                    <h3 class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors">JavaScript Nâng Cao &amp; ES6+</h3>
                                    <p class="text-sm text-gray-500 dark:text-gray-400 mb-6 line-clamp-2">Làm chủ ngôn ngữ quan trọng nhất của Web với các dự án thực tế phức tạp.</p>
                                    <div class="flex items-center justify-between pt-6 border-t border-gray-100 dark:border-white/5">
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-primary text-xl">schedule</span>
                                            <span class="text-xs font-bold">58 Giờ</span>
                                        </div>
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-yellow-500 text-xl">star</span>
                                            <span class="text-xs font-bold">4.8</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="group bg-white dark:bg-[#162514] rounded-[2rem] overflow-hidden border border-gray-100 dark:border-white/5 hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.1)] transition-all duration-300">
                                <div class="aspect-[16/10] overflow-hidden relative">
                                    <img alt="Python" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAjJHyA051Ck1cHgkWnCOUmRGs9Ma9cMQJjdHMqgfYVFTczHfeWNLJ5FLo6X7Fya5zoe9AjokmNucevcAO5rToBSQONQUJcYiT3X77HBTMU9CgmC-_Wg0ldNrSEZ6zGXjemsJ-pPer-vcznZw8bYEIRukjesjcKTqpXwc3XuAvJjvYwCTljQfw2u5gci9jMKkgL3txMgQCO_7BDXiPFP2_ZYSmxsc1f9MVAmxo2TR6b2Z0C2dAqCJhs5c6S7hsst0kqihUu_Dwq4iQ"/>
                                    <div class="absolute top-4 left-4">
                                        <span class="bg-primary text-[#101b0d] text-[10px] font-black uppercase px-3 py-1.5 rounded-full">Backend</span>
                                    </div>
                                </div>
                                <div class="p-8">
                                    <h3 class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors">Python &amp; Phân tích dữ liệu</h3>
                                    <p class="text-sm text-gray-500 dark:text-gray-400 mb-6 line-clamp-2">Bắt đầu hành trình Data Science với ngôn ngữ Python mạnh mẽ và trực quan.</p>
                                    <div class="flex items-center justify-between pt-6 border-t border-gray-100 dark:border-white/5">
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-primary text-xl">schedule</span>
                                            <span class="text-xs font-bold">65 Giờ</span>
                                        </div>
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-yellow-500 text-xl">star</span>
                                            <span class="text-xs font-bold">5.0</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="group bg-white dark:bg-[#162514] rounded-[2rem] overflow-hidden border border-gray-100 dark:border-white/5 hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.1)] transition-all duration-300">
                                <div class="aspect-[16/10] overflow-hidden relative">
                                    <div class="w-full h-full bg-gray-200 dark:bg-gray-800 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-5xl text-gray-400">terminal</span>
                                    </div>
                                    <div class="absolute top-4 left-4">
                                        <span class="bg-primary text-[#101b0d] text-[10px] font-black uppercase px-3 py-1.5 rounded-full">New</span>
                                    </div>
                                </div>
                                <div class="p-8">
                                    <h3 class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors">Fullstack React &amp; Node.js</h3>
                                    <p class="text-sm text-gray-500 dark:text-gray-400 mb-6 line-clamp-2">Lộ trình học tập để trở thành một kĩ sư phần mềm toàn diện trong 6 tháng.</p>
                                    <div class="flex items-center justify-between pt-6 border-t border-gray-100 dark:border-white/5">
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-primary text-xl">schedule</span>
                                            <span class="text-xs font-bold">120 Giờ</span>
                                        </div>
                                        <div class="flex items-center gap-1.5">
                                            <span class="material-symbols-outlined text-yellow-500 text-xl">star</span>
                                            <span class="text-xs font-bold">4.9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="pb-24 lg:pb-32 px-8 lg:px-12">
                    <div class="max-w-canvas mx-auto bg-[#101b0d] rounded-[3rem] p-12 lg:p-24 relative overflow-hidden text-center flex flex-col items-center">
                        <div class="absolute top-0 right-0 w-[400px] h-[400px] bg-primary/20 rounded-full blur-[120px]"></div>
                        <div class="absolute bottom-0 left-0 w-[300px] h-[300px] bg-primary/10 rounded-full blur-[100px]"></div>
                        <h2 class="text-4xl lg:text-6xl font-black text-white mb-8 max-w-4xl leading-tight z-10">
                            Sẵn sàng bứt phá sự nghiệp lập trình của bạn?
                        </h2>
                        <p class="text-lg lg:text-xl text-gray-400 mb-12 max-w-2xl z-10">
                            Hơn 15.000 học viên đã tin tưởng. Đăng ký ngay hôm nay để nhận ưu đãi 40% cho gói thành viên Premium.
                        </p>
                        <div class="flex flex-col sm:flex-row gap-4 z-10">
                            <button class="h-16 px-12 bg-primary text-[#101b0d] text-lg font-bold rounded-2xl shadow-2xl shadow-primary/20 hover:scale-105 transition-all">
                                Bắt đầu học miễn phí
                            </button>
                            <button class="h-16 px-12 border-2 border-white/20 text-white text-lg font-bold rounded-2xl hover:bg-white/10 transition-all">
                                Liên hệ tư vấn
                            </button>
                        </div>
                    </div>
                </section>
            </main>
            <footer class="bg-white dark:bg-[#080d07] pt-24 pb-12 border-t border-gray-100 dark:border-white/5">
                <div class="max-w-canvas mx-auto px-8 lg:px-12">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-16 mb-24">
                        <div class="lg:col-span-2">
                            <div class="flex items-center gap-2 mb-8">
                                <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-[#101b0d]">
                                    <span class="material-symbols-outlined text-xl font-bold">terminal</span>
                                </div>
                                <h2 class="text-xl font-black tracking-tight">IT-LEARN</h2>
                            </div>
                            <p class="text-gray-500 dark:text-gray-400 text-base leading-relaxed mb-8 max-w-sm">
                                Đồng hành cùng hàng ngàn sinh viên Việt Nam trên con đường trở thành những kĩ sư phần mềm chuyên nghiệp với giáo trình thực chiến.
                            </p>
                            <div class="flex gap-4">
                                <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                                    <span class="material-symbols-outlined text-xl">social_leaderboard</span>
                                </a>
                                <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                                    <span class="material-symbols-outlined text-xl">terminal</span>
                                </a>
                                <a class="w-10 h-10 rounded-full border border-gray-200 dark:border-white/10 flex items-center justify-center text-gray-400 hover:bg-primary hover:border-primary hover:text-[#101b0d] transition-all" href="#">
                                    <span class="material-symbols-outlined text-xl">smart_display</span>
                                </a>
                            </div>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Khóa học</h4>
                            <ul class="space-y-4">
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Lập trình Frontend</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Lập trình Backend</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Lập trình Di động</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Data Science &amp; AI</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">DevOps &amp; Cloud</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Nguồn tài nguyên</h4>
                            <ul class="space-y-4">
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Blog công nghệ</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Cộng đồng học tập</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Tài liệu miễn phí</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Kênh Youtube</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Podcast IT</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Liên kết nhanh</h4>
                            <ul class="space-y-4">
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Về chúng tôi</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Tuyển dụng</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Điều khoản</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Bảo mật</a></li>
                                <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Liên hệ</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="pt-12 border-t border-gray-100 dark:border-white/5 flex flex-col md:flex-row justify-between items-center gap-6">
                        <p class="text-sm text-gray-500">© 2024 IT-Learn Academy. Được thiết kế cho cộng đồng IT Việt Nam.</p>
                        <div class="flex items-center gap-8">
                            <span class="text-sm text-gray-500 flex items-center gap-2">
                                <span class="material-symbols-outlined text-lg">language</span> Tiếng Việt
                            </span>
                            <span class="text-sm text-gray-500 flex items-center gap-2">
                                <span class="material-symbols-outlined text-lg">support_agent</span> 1900 1234
                            </span>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

    </body></html>