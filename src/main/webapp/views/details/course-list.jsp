<%-- 
    Document   : shop
    Created on : Feb 5, 2026, 11:18:21 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Desktop Course Explorer - IT Academy</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <style type="text/tailwindcss">
            :root {
                --primary: #37ec13;
                --primary-hover: #2dd111;
                --bg-main: #ffffff;
                --bg-sidebar: #fcfdfc;
                --border-color: #e9f3e7;
                --text-main: #101b0d;
                --text-muted: #599a4c;
            }
            body {
                font-family: "Inter", sans-serif;
                background-color: var(--bg-main);
                color: var(--text-main);
            }
            .custom-scrollbar::-webkit-scrollbar {
                width: 4px;
            }
            .custom-scrollbar::-webkit-scrollbar-track {
                background: transparent;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb {
                background: #d3e7cf;
                border-radius: 10px;
            }
            .course-card {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .course-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.05), 0 8px 10px -6px rgb(0 0 0 / 0.05);
                border-color: var(--primary);
            }
            .sidebar-fixed {
                height: calc(100vh - 73px);
                position: sticky;
                top: 73px;
            }
        </style>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#37ec13",
                        },
                    },
                },
            }
        </script>
    </head>
    <body class="min-h-screen">
        <div class="flex flex-col">
            <header class="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-[#e9f3e7] px-8 py-4">
                <div class="max-w-[1600px] mx-auto flex items-center justify-between">
                    <div class="flex items-center gap-12">
                        <div class="flex items-center gap-2">
                            <div class="size-8 text-primary">
                                <svg fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                                <path d="M4 4H17.3334V17.3334H30.6666V30.6666H44V44H4V4Z" fill="currentColor"></path>
                                </svg>
                            </div>
                            <h1 class="text-xl font-bold tracking-tight">IT Academy</h1>
                        </div>
                        <nav class="hidden lg:flex items-center gap-8">
                            <a class="text-sm font-semibold text-primary" href="#">Khóa học</a>
                            <a class="text-sm font-medium hover:text-primary transition-colors" href="#">Lộ trình</a>
                            <a class="text-sm font-medium hover:text-primary transition-colors" href="#">Cộng đồng</a>
                            <a class="text-sm font-medium hover:text-primary transition-colors" href="#">Giảng viên</a>
                        </nav>
                    </div>
                    <div class="flex items-center gap-6">
                        <button class="flex items-center gap-2 text-sm font-medium text-gray-600 hover:text-primary">
                            <span class="material-symbols-outlined text-xl">shopping_cart</span>
                            <span>Giỏ hàng</span>
                        </button>
                        <div class="h-8 w-[1px] bg-gray-200"></div>
                        <button class="px-6 py-2 rounded-full bg-primary text-[#132210] text-sm font-bold hover:bg-[#2dd111] transition-colors">
                            Đăng nhập
                        </button>
                    </div>
                </div>
            </header>
            <div class="max-w-[1600px] mx-auto w-full flex">
                <aside class="w-80 sidebar-fixed border-r border-[#e9f3e7] bg-[#fcfdfc] p-8 overflow-y-auto custom-scrollbar hidden xl:block">
                    <div class="space-y-10">
                        <div>
                            <h3 class="text-xs font-bold uppercase tracking-widest text-[#599a4c] mb-6">Danh mục</h3>
                            <div class="space-y-2">
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">
                                    <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                    <span class="text-sm font-medium text-gray-700 group-hover:text-black">Web Development</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">
                                    <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                    <span class="text-sm font-medium text-gray-700 group-hover:text-black">Mobile Development</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">
                                    <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                    <span class="text-sm font-medium text-gray-700 group-hover:text-black">Artificial Intelligence</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">
                                    <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                    <span class="text-sm font-medium text-gray-700 group-hover:text-black">Cloud Computing</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">
                                    <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                    <span class="text-sm font-medium text-gray-700 group-hover:text-black">Cyber Security</span>
                                </label>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xs font-bold uppercase tracking-widest text-[#599a4c] mb-6">Cấp độ</h3>
                            <div class="grid grid-cols-1 gap-2">
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                    <input class="text-primary focus:ring-primary h-4 w-4 border-gray-300" name="level" type="radio"/>
                                    <span class="text-sm font-medium text-gray-700">Tất cả trình độ</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                    <input class="text-primary focus:ring-primary h-4 w-4 border-gray-300" name="level" type="radio"/>
                                    <span class="text-sm font-medium text-gray-700">Cơ bản (Basic)</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                    <input class="text-primary focus:ring-primary h-4 w-4 border-gray-300" name="level" type="radio"/>
                                    <span class="text-sm font-medium text-gray-700">Trung cấp (Intermediate)</span>
                                </label>
                                <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                    <input class="text-primary focus:ring-primary h-4 w-4 border-gray-300" name="level" type="radio"/>
                                    <span class="text-sm font-medium text-gray-700">Nâng cao (Advanced)</span>
                                </label>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xs font-bold uppercase tracking-widest text-[#599a4c] mb-6">Giá khóa học</h3>
                            <div class="space-y-4">
                                <div class="px-2">
                                    <input class="w-full accent-primary h-1.5 bg-gray-200 rounded-lg cursor-pointer" type="range"/>
                                    <div class="flex justify-between mt-3 text-xs font-bold text-gray-500">
                                        <span>0đ</span>
                                        <span>5.000.000đ</span>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                        <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                        <span class="text-sm font-medium text-gray-700">Miễn phí</span>
                                    </label>
                                    <label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all">
                                        <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                                        <span class="text-sm font-medium text-gray-700">Có phí</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </aside>
                <main class="flex-1 p-8 lg:p-12 min-h-screen">
                    <div class="mb-12 space-y-8">
                        <div class="relative group max-w-4xl">
                            <span class="material-symbols-outlined absolute left-6 top-1/2 -translate-y-1/2 text-gray-400 text-2xl group-focus-within:text-primary transition-colors">search</span>
                            <input class="w-full h-16 pl-16 pr-6 bg-white border-2 border-[#e9f3e7] rounded-2xl text-lg focus:ring-4 focus:ring-primary/10 focus:border-primary outline-none transition-all shadow-sm" placeholder="Tìm kiếm khóa học lập trình, AI, dữ liệu..." type="text"/>
                        </div>
                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                            <div>
                                <h2 class="text-4xl font-extrabold tracking-tight mb-2">Khám phá khóa học</h2>
                                <p class="text-[#599a4c] font-medium">Hiện có <span class="text-black font-bold">128</span> khóa học chất lượng dành cho bạn</p>
                            </div>
                            <div class="flex items-center gap-4">
                                <div class="flex items-center bg-gray-50 px-4 py-2.5 rounded-xl border border-[#e9f3e7]">
                                    <span class="text-xs font-bold text-gray-400 uppercase tracking-tighter mr-3">Sắp xếp theo:</span>
                                    <select class="bg-transparent border-none text-sm font-bold p-0 focus:ring-0 cursor-pointer">
                                        <option>Mới nhất</option>
                                        <option>Phổ biến nhất</option>
                                        <option>Giá: Thấp đến Cao</option>
                                        <option>Giá: Cao đến Thấp</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 2xl:grid-cols-4 gap-8">
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="React Development" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAuMIqD2-J9ATR8iX3IJfJyfcWRKoNYwwBzL_B3la5aAUA9pxKQ3BWBMX8XLW4q9maz7goAaP6uqfUkdzyTIl4newZ6a0p50eIiUSZVDz2itkolBUJH6H-MeHNtTrgaENEV1cwGlKO-FUKC8-CRgpbYbfRJmDxOmxg2HnXb3OpvXwmWWpG9mjYGF1u4SRAmHXvpaXQ7TXrhpdyRh6BT5bMqWjpJFzGc8kmJkUWK4w63OYgfUNKF-E1RBOL83ee07MvkKRvLN4LGJL8"/>
                                <div class="absolute top-4 left-4">
                                    <span class="bg-white/90 backdrop-blur-sm text-[#101b0d] text-[10px] font-bold px-3 py-1.5 rounded-full uppercase tracking-widest shadow-sm">Bán chạy</span>
                                </div>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">WEB DEV</span>
                                    <span class="text-xs text-gray-400">• 12 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">Fullstack React &amp; Next.js Professional Course</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star_half</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">4.8 (1.2k)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">1.490.000đ</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="Machine Learning" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBjz7Mxr5spspE6laLFdBMLgS54Pktiz6ce65gnzHxINp_RcsYDTkOZXL7OX-iKXR7wiKgc9WMH1ssMG3LcCpF4THBAZdRotx2ISDRLhH2bRwvH1KYRn1ibLhXwDzBqNrq0ZLeJw3-qGiCG4qno89kb13JRGhILzFbCCCKJg64833udQcjmkYMyewPICwKhA7xVepx5ixKoQyBYptFQWWtULkYMb8XTqnMYZ8VXrvAARYzC4aQGCNCGy4xVVGV3Pwnum8yzChTF4YI"/>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">AI &amp; DATA</span>
                                    <span class="text-xs text-gray-400">• 32 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">Lập trình AI: Từ Zero đến Machine Learning Engineer</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">5.0 (845)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">2.150.000đ</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="Cloud Architecture" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCannDqcR1P8pxyiIUmhNUor4TSkXTfB51IRMhJjjyHum-jb9HPDY2ETMkHdEH7xHRB3D3TQP-LgFzOl5BO4hPIXb4HnaNW5d_Riyf2Yyjz3QEllQxwpbS4qdkYDBh1gleUWRbKgZq_UQYhEh2MLDkhT-e6KLkorL5gufcwaD3KOxbaHWUfDMJcoE-qbjHp54po24bkyB75FTJxzCtgdRyJNnb4vnsQe3n8qz31GuX9kvFLPbQMbKUCZ-FKQ6KXeI84Znk3mXh4HTc"/>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">CLOUD</span>
                                    <span class="text-xs text-gray-400">• 24 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">AWS Certified Solutions Architect Associate 2024</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star_outline</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">4.1 (532)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">Miễn phí</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="Cyber Security" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCzHO2myTkeXBbVeSyXfsTzNAIRxzPX5B2RZ7a46KW1Y20jcD_89pARcnDx3kuN2EHzsq1Ae7UT12gBKODneGrZahRwzOiF_0jNXmvu92RhETVOLZQyQW2ui-E7rztnvoOAQ6CeHSGzxSKswwahAJ8NR8_XIixt0SKroglcF3ZjlsU2cwSAOGM286O_7-Tp2ZtMychzioeTWyUmfv6L_tYXqzioj2LbHp9a4EdbQAga7i_fHD3PlELDlBL2fRFz-mCEeTIZnjjElOw"/>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">SECURITY</span>
                                    <span class="text-xs text-gray-400">• 45 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">Ethical Hacking &amp; Network Defense Bootcamp</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star_half</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">4.6 (392)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">3.250.000đ</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="UI/UX Design" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYduvP5hiGcR8CMf1b2KCXKSptVN4z_cyAGAzQmMgY5dumKRH9bE5VIvY0tCshVQSKCoGc4Advgw7cLOltAu4LgtoRC-ODs61oDIYH5I3iSS-yLdcBMfD9KBOGBOxLkkybt_andd4HON3nIpwY6dplcqKbxpPWPbyZwYr9Ex3lnKD0zWBt1jhwuRMv6WIpsYSpIFYGTy8xHXfLivOqscKq3Tv8Rovbn1wMXBhOwlx24WDHHLPK0O_vq4gHeQscwd_1LYgHlLfvN8Q"/>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">UI/UX</span>
                                    <span class="text-xs text-gray-400">• 18 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">Thiết kế UI/UX hiện đại với Figma &amp; Framer</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">4.9 (210)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">890.000đ</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="course-card bg-white rounded-2xl border border-[#e9f3e7] overflow-hidden flex flex-col h-full group">
                            <div class="aspect-[16/10] relative overflow-hidden">
                                <img alt="JS Masterclass" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD2AVo3GsF6Ywx9BrEHw7VPluGBWS7JXMaK58s1fA-ii4-LAxrPT-ZjuzLzhNy3o3sgGRaijE-or-lqOD1siI0RxAe5tD1adFZQm_dN__MS42PqC10S9JoxBuimN7VDqCaHVGivzS8xOQn5Q7HvltvNXK43dqA3LmVkT9JGePlO1HB2VwsMUJj8cbJDsGayHYBZLv8D9BWTyjXGbR4U--ewfh7cjoWOqSysJK58BLt1EjlBEZyS5oP4fm3bI7-j4THVuag_CHAmZss"/>
                            </div>
                            <div class="p-6 flex flex-col flex-1">
                                <div class="flex items-center gap-2 mb-3">
                                    <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">PROGRAMMING</span>
                                    <span class="text-xs text-gray-400">• 50 Giờ</span>
                                </div>
                                <h3 class="text-lg font-bold leading-tight mb-4 flex-1">Javascript Masterclass: Zero to Senior Hero</h3>
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="flex text-yellow-400">
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star</span>
                                        <span class="material-symbols-outlined text-sm">star_half</span>
                                    </div>
                                    <span class="text-xs font-bold text-gray-500">4.7 (2.4k)</span>
                                </div>
                                <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                    <span class="text-xl font-black text-primary">1.250.000đ</span>
                                    <button class="text-sm font-bold text-gray-700 hover:text-primary transition-colors flex items-center gap-1">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mt-20 flex justify-center items-center gap-4">
                        <button class="size-12 flex items-center justify-center rounded-xl border-2 border-[#e9f3e7] hover:border-primary hover:text-primary transition-all disabled:opacity-30 disabled:pointer-events-none" disabled="">
                            <span class="material-symbols-outlined">chevron_left</span>
                        </button>
                        <div class="flex items-center gap-2">
                            <button class="size-12 flex items-center justify-center rounded-xl bg-primary text-[#132210] font-bold">1</button>
                            <button class="size-12 flex items-center justify-center rounded-xl border-2 border-transparent hover:border-[#e9f3e7] font-bold">2</button>
                            <button class="size-12 flex items-center justify-center rounded-xl border-2 border-transparent hover:border-[#e9f3e7] font-bold">3</button>
                            <span class="px-2 text-gray-400 font-bold">...</span>
                            <button class="size-12 flex items-center justify-center rounded-xl border-2 border-transparent hover:border-[#e9f3e7] font-bold">12</button>
                        </div>
                        <button class="size-12 flex items-center justify-center rounded-xl border-2 border-[#e9f3e7] hover:border-primary hover:text-primary transition-all">
                            <span class="material-symbols-outlined">chevron_right</span>
                        </button>
                    </div>
                </main>
            </div>
            <footer class="border-t border-[#e9f3e7] bg-white px-8 py-12 mt-12">
                <div class="max-w-[1600px] mx-auto flex flex-col md:flex-row justify-between items-center gap-8">
                    <div class="flex items-center gap-3">
                        <div class="size-6 text-primary">
                            <svg fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 4H17.3334V17.3334H30.6666V30.6666H44V44H4V4Z" fill="currentColor"></path>
                            </svg>
                        </div>
                        <span class="font-bold">IT Academy</span>
                        <span class="text-gray-400 text-sm ml-4">© 2024 Nền tảng học lập trình trực tuyến hàng đầu.</span>
                    </div>
                    <div class="flex gap-8 text-sm font-medium text-gray-500">
                        <a class="hover:text-primary transition-colors" href="#">Điều khoản</a>
                        <a class="hover:text-primary transition-colors" href="#">Bảo mật</a>
                        <a class="hover:text-primary transition-colors" href="#">Liên hệ</a>
                        <a class="hover:text-primary transition-colors" href="#">Trợ giúp</a>
                    </div>
                </div>
            </footer>
        </div>

    </body></html>