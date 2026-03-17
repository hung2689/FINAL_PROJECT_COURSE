<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Our Mentors | DevLearn</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { "primary": "#10B981", "mentor-gold": "#F59E0B" },
                    fontFamily: { "display": ["Inter", "sans-serif"] }
                }
            }
        }
    </script>
    <style>
        /* CSS cho hiệu ứng trượt ngang vô tận */
        @keyframes scroll {
            0% { transform: translateX(0); }
            /* Dịch chuyển đúng 50% chiều dài (vì chúng ta nhân đôi danh sách card) */
            100% { transform: translateX(calc(-50% - 16px)); } 
        }
        .animate-scroll {
            animation: scroll 35s linear infinite;
            display: flex;
            width: max-content;
        }
        /* Dừng trượt khi đưa chuột vào */
        .animate-scroll:hover {
            animation-play-state: paused;
        }
        /* Ẩn thanh cuộn mặc định */
        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        /* Hiệu ứng Modal mờ ảo giống hình mẫu */
        .modal-blur {
            backdrop-filter: blur(8px);
            background-color: rgba(15, 23, 42, 0.9);
        }

        /* Tùy chỉnh màu hover cho icon MXH */
        .social-icon svg {
            transition: all 0.3s ease;
        }
        .icon-fb:hover svg {
            color: #1877F2; /* Xanh Facebook */
            transform: scale(1.1);
        }
        .icon-ig:hover svg {
            color: #E4405F; /* Đỏ hồng Instagram */
            transform: scale(1.1);
        }
    </style>
</head>
<body class="bg-[#F8FFFC] font-['Inter'] text-slate-700 flex flex-col min-h-screen relative overflow-x-hidden">

    <jsp:include page="../common/header.jsp" />

    <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-[#10B981]/10 rounded-full blur-[150px] -z-10 pointer-events-none"></div>

    <main class="flex-grow pt-[120px] pb-24 overflow-hidden">
        <div class="max-w-[1200px] mx-auto px-6 lg:px-12">

            <div class="text-center max-w-3xl mx-auto mb-16">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#10B981]/10 border border-[#10B981]/20 text-[#10B981] text-sm font-bold mb-6">
                    <span class="material-symbols-outlined text-[16px]">groups</span>
                    DevLearn Team
                </div>
                <h1 class="text-4xl md:text-5xl font-black text-slate-900 mb-6 leading-tight">
                    Meet Our Mentors <br />
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-[#10B981] to-[#059669]">Guiding You Every Step</span>
                </h1>
                <p class="text-lg text-slate-600 leading-relaxed">
                    Top industry experts are always by your side on your journey to mastering technology. They are not just instructors, but passionate companions.
                </p>
            </div>

        </div>
        
        <div class="w-full relative py-8 mb-20 hide-scrollbar overflow-hidden">
            
            <div class="absolute inset-y-0 left-0 w-32 bg-gradient-to-r from-[#F8FFFC] to-transparent z-10 pointer-events-none"></div>
            <div class="absolute inset-y-0 right-0 w-32 bg-gradient-to-l from-[#F8FFFC] to-transparent z-10 pointer-events-none"></div>

            <div class="animate-scroll gap-8 pl-8 flex">
                
                <div onclick="openModal('duyhung')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506735/cv/ntusbx9xffljz5tfiwod" 
                         onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506735/cv/ntusbx9xffljz5tfiwod';" 
                         alt="Duy Hung" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>

                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5">
                            <p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">
                                "I believe education is the foundation of all progress. At DevLearn, we don't just teach programming; we shape your future."
                            </p>
                        </div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div>
                                <h4 class="text-white font-bold text-[18px]">Mentor Duy Hung</h4>
                                <p class="text-[14px] text-[#10B981] font-medium mt-0.5">CEO, Founder</p>
                            </div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('quangnhat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="${pageContext.request.contextPath}/anh/lenhat.jpg" 
                         alt="Quang Nhat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>

                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5">
                            <p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">
                                "A great system is highly stable and automated. I will guide you through implementing standard software lifecycle processes."
                            </p>
                        </div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div>
                                <h4 class="text-white font-bold text-[18px]">Mentor Quang Nhat</h4>
                                <p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Engineering / DevOps</p>
                            </div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('doannhat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                     <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp" 
                         onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp';" 
                         alt="Doan Nhat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>

                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5">
                            <p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">
                                "Code shouldn't just work; it must be clean and optimized. Let's sharpen your logical thinking to solve any programming challenge."
                            </p>
                        </div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div>
                                <h4 class="text-white font-bold text-[18px]">Mentor Doan Nhat</h4>
                                <p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Developer</p>
                            </div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('tandat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu" 
                         onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu';" 
                         alt="Tan Dat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>

                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5">
                            <p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">
                                "My approach is purely practical, helping you deeply understand core concepts and confidently join real-world software projects."
                            </p>
                        </div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div>
                                <h4 class="text-white font-bold text-[18px]">Mentor Tan Dat</h4>
                                <p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Developer</p>
                            </div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('ngocanh')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="${pageContext.request.contextPath}/anh/ngocanh.jpg" 
                         alt="Ngoc Anh" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>

                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5">
                            <p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">
                                "Understanding hardware and computer architecture empowers you to write robust code. I will help you master the fundamentals from the ground up."
                            </p>
                        </div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div>
                                <h4 class="text-white font-bold text-[18px]">Mentor Ngoc Anh</h4>
                                <p class="text-[14px] text-[#10B981] font-medium mt-0.5">Computer Engineer</p>
                            </div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('duyhung')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506735/cv/ntusbx9xffljz5tfiwod" onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506735/cv/ntusbx9xffljz5tfiwod';" alt="Duy Hung" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>
                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5"><p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">"I believe education is the foundation of all progress. At DevLearn, we don't just teach programming; we shape your future."</p></div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div><h4 class="text-white font-bold text-[18px]">Mentor Duy Hung</h4><p class="text-[14px] text-[#10B981] font-medium mt-0.5">CEO, Founder</p></div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('quangnhat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="${pageContext.request.contextPath}/anh/lenhat.jpg" alt="Quang Nhat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>
                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5"><p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">"A great system is highly stable and automated. I will guide you through implementing standard software lifecycle processes."</p></div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div><h4 class="text-white font-bold text-[18px]">Mentor Quang Nhat</h4><p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Engineering / DevOps</p></div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('doannhat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                  <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp" 
                         onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp';" 
                         alt="Doan Nhat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>
                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5"><p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">"Code shouldn't just work; it must be clean and optimized. Let's sharpen your logical thinking to solve any programming challenge."</p></div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div><h4 class="text-white font-bold text-[18px]">Mentor Doan Nhat</h4><p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Developer</p></div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('tandat')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu" onerror="this.onerror=null;this.src='https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu';" alt="Tan Dat" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>
                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5"><p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">"My approach is purely practical, helping you deeply understand core concepts and confidently join real-world software projects."</p></div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div><h4 class="text-white font-bold text-[18px]">Mentor Tan Dat</h4><p class="text-[14px] text-[#10B981] font-medium mt-0.5">Software Developer</p></div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

                <div onclick="openModal('ngocanh')" class="w-[350px] h-[450px] flex-shrink-0 rounded-2xl flex flex-col relative overflow-hidden group hover:-translate-y-2 shadow-[0_8px_30px_rgb(0,0,0,0.08)] hover:shadow-2xl hover:shadow-[#10B981]/20 transition-all duration-500 cursor-pointer border border-emerald-900/20">
                    <img src="${pageContext.request.contextPath}/anh/ngocanh.jpg" alt="Ngoc Anh" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-[#0B1120] via-[#0B1120]/80 to-transparent"></div>
                    <div class="absolute inset-0 bg-[#10B981]/20 group-hover:bg-transparent transition-colors duration-500"></div>
                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#10B981] to-emerald-400 opacity-90 z-20"></div>
                    <div class="relative z-10 flex flex-col h-full p-7">
                        <div class="mt-auto mb-5"><p class="text-[15px] text-slate-200 leading-relaxed relative z-10 italic">"Understanding hardware and computer architecture empowers you to write robust code. I will help you master the fundamentals from the ground up."</p></div>
                        <div class="border-t border-white/20 pt-4 flex justify-between items-end">
                            <div><h4 class="text-white font-bold text-[18px]">Mentor Ngoc Anh</h4><p class="text-[14px] text-[#10B981] font-medium mt-0.5">Computer Engineer</p></div>
                            <span class="material-symbols-outlined text-white/50 group-hover:text-[#10B981] transition-colors">arrow_outward</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
   
        <div class="max-w-[1200px] mx-auto px-6 lg:px-12 mt-10">
            <div class="text-center bg-white border border-emerald-100 rounded-3xl p-12 shadow-[0_8px_30px_rgb(0,0,0,0.04)]">
                <h2 class="text-2xl md:text-3xl font-black text-slate-900 mb-4">Join the DevLearn Team?</h2>
                <p class="text-slate-600 mb-8 max-w-2xl mx-auto">We are always looking for passionate experts to join our team. If you love teaching and sharing knowledge, let's connect.</p>
                <div class="flex justify-center gap-4">
                    <a href="${pageContext.request.contextPath}/shop" class="px-8 py-3.5 bg-white border-2 border-[#10B981] text-[#10B981] font-bold rounded-xl hover:bg-emerald-50 transition-colors" style="text-decoration: none;">
                        Explore Courses
                    </a>
                </div>
            </div>
        </div>

    </main>

    <div id="profileModal" class="fixed inset-0 z-[100] hidden items-center justify-center p-4 sm:p-6 modal-blur transition-opacity duration-300">
        <div class="absolute inset-0 cursor-pointer" onclick="closeModal()"></div>
        
        <div id="modalBox" class="relative z-10 w-full max-w-4xl bg-[#1C1C1C] rounded-2xl overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.5)] scale-95 opacity-0 transition-all duration-300 border border-white/10">
            
            <button onclick="closeModal()" class="absolute top-6 right-6 w-10 h-10 flex items-center justify-center rounded-full bg-white/10 border border-white/20 text-slate-300 hover:bg-white/20 hover:text-white transition-colors z-20">
                <span class="material-symbols-outlined text-[24px]">close</span>
            </button>

            <div class="bg-[#0A101D] p-8 md:p-12 flex flex-col md:flex-row items-center md:items-end gap-8 md:gap-12 relative overflow-hidden">
                
                <div class="relative flex-shrink-0 z-10 md:ml-4">
                    <div class="absolute -inset-4 bg-gradient-to-r from-emerald-400 via-purple-500 to-sky-400 blur-2xl opacity-60 z-0"
                         style="border-radius: 140px 140px 30px 140px;"></div>

                    <img id="modalImg" src="" alt="Mentor Profile" 
                         class="w-48 h-[260px] md:w-64 md:h-[340px] object-cover shadow-[0_15px_40px_rgba(0,0,0,0.5)] relative z-10"
                         style="border-radius: 140px 140px 30px 140px;">
                </div>

                <div class="flex-grow text-center md:text-left pb-2 md:pb-6 relative z-10">
                    <h2 class="text-3xl md:text-4xl font-black text-mentor-gold flex items-center justify-center md:justify-start gap-4">
                        <span id="nameText">Tên Mentor</span>
                        <div id="socialLinks" class="flex gap-2 ml-2">
                            <a id="modalFacebook" href="#" target="_blank" class="social-icon icon-fb text-slate-400">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                                </svg>
                            </a>
                            <a id="modalInstagram" href="#" target="_blank" class="social-icon icon-ig text-slate-400">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z"/>
                                </svg>
                            </a>
                        </div>
                    </h2>
                    <p id="modalTitle" class="text-white text-lg md:text-xl font-light mt-3 tracking-wide opacity-90"></p>
                </div>
            </div>

            <div class="px-8 md:px-12 py-10 text-slate-300 text-[16px] md:text-[18px] leading-relaxed font-light space-y-6 overflow-y-auto max-h-[350px] hide-scrollbar" id="modalBio">
            </div>
            
            <div class="px-8 md:px-12 py-6 bg-white/5 border-t border-white/5 flex items-center justify-between">
                <p class="text-sm text-slate-500 italic">© DevLearn Industry Experts</p>
                <a href="${pageContext.request.contextPath}/shop" class="text-[#10B981] font-bold hover:text-white flex items-center gap-2 transition-colors">
                    Explore My Courses <span class="material-symbols-outlined text-sm">arrow_forward</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        
        // DỮ LIỆU CHI TIẾT
        const mentorData = {
            duyhung: {
                name: "Pham Duy Hung",
                title: "CEO & Founder",
                img: "https://res.cloudinary.com/dssmrnzag/image/upload/v1773506735/cv/ntusbx9xffljz5tfiwod",
                fallback: "https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506735/cv/ntusbx9xffljz5tfiwod",
                facebook: "https://www.facebook.com/duyhung.pham.7503314", // Thay bằng link thật
                instagram: "https://www.instagram.com/dy_hung_89?fbclid=IwY2xjawQmCtNleHRuA2FlbQIxMABicmlkETFkOEVqVGNTSFVGMVVKV2ZXc3J0YwZhcHBfaWQQMjIyMDM5MTc4ODIwMDg5MgABHkFXA2nmTf0kQUVkegJzQUVSHPoRe4f7fKuox6cUE6hiXe9yAxS3HInTqwnM_aem_dmt1s3LnGWbynTAqdgiLTQ", // Thay bằng link thật
                bio: `
                    <p><strong>Duy Hung</strong> is the visionary leader and founder of DevLearn. With a background in executive management and technology strategy, he established this platform to revolutionize how programming is taught to the next generation.</p>
                    <p>He is a firm believer that high-quality tech education should be accessible and practical. His leadership ensures that every course at DevLearn meets global industry standards, preparing students for real-world engineering challenges.</p>
                `
            },
            quangnhat: {
                name: "Le Quang Nhat",
                title: "Software Engineering / DevOps",
                img: "${pageContext.request.contextPath}/anh/lenhat.jpg",
                fallback: "",
                facebook: "https://www.facebook.com/nhatbabyy", // Thay bằng link thật

                bio: `
                    <p><strong>Quang Nhat</strong> specializes in the intricate world of DevOps and System Architecture. He brings a wealth of experience in managing high-scale cloud infrastructures and CI/CD pipelines.</p>
                    <p>His mentoring focuses on stability, automation, and system reliability. Students in his classes learn how to transition from simply writing code to building robust, deployable systems that power modern enterprises.</p>
                `
            },
            doannhat: {
                name: "Tran Phuoc Doan Nhat",
                title: "Software Developer",
                img: "https://res.cloudinary.com/dssmrnzag/image/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp", 
                fallback: "https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506757/cv/rvgkfavgsapi1i6bpmrp",
                facebook: "https://www.facebook.com/oannhat.713686/", // Thay bằng link thật
                instagram: "https://www.instagram.com/nhattpd_2109/", // Thay bằng link thật
                bio: `
                    <p><strong>Doan Nhat</strong> is a Senior Software Developer with a deep passion for backend ecosystems and performance optimization. He is an expert in modern Java frameworks and microservices architecture.</p>
                    <p>Nhat teaches students the importance of writing clean, testable code. His approach combines heavy technical theory with intense live-coding sessions, ensuring students master every logic gate and database query.</p>
                `
            },
            tandat: {
                name: "Nguyen Huu Tan Dat",
                title: "Software Developer",
                img: "https://res.cloudinary.com/dssmrnzag/image/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu",
                fallback: "https://res.cloudinary.com/dssmrnzag/raw/upload/v1773506782/cv/rzyukj2qgr4eng2kvysu",
                facebook: "https://www.facebook.com/share/1C2Rfc5bWD/?mibextid=wwXIfr", // Thay bằng link thật
                instagram: "https://www.instagram.com/_nhtd2512?igsh=bDB4a3g0NjFzdWtv&utm_source=qr", // Thay bằng link thật
                bio: `
                    <p><strong>Tan Dat</strong> is recognized for his practical and results-oriented approach to software development. Having led multiple full-stack projects, he understands what the market truly demands from developers.</p>
                    <p>In his courses, Dat focuses on "building projects from day one." He mentors students through the entire development cycle, from UI design to API integration, fostering a mindset of continuous delivery and quality assurance.</p>
                `
            },
            ngocanh: {
                name: "Tran Ngoc Anh",
                title: "Computer Engineer",
                img: "${pageContext.request.contextPath}/anh/ngocanh.jpg",
                fallback: "",
                facebook: "https://www.facebook.com/tran.ngoc.anh.981427", // Thay bằng link thật
                instagram: "https://www.instagram.com/anh205_z/", // Thay bằng link thật
                bio: `
                    <p><strong>Ngoc Anh</strong> brings a unique low-level perspective to DevLearn. As a Computer Engineer, she has a profound understanding of how software interacts with hardware at the most fundamental level.</p>
                    <p>Her mentoring covers embedded systems, hardware-software integration, and system programming. She empowers students to write efficient, low-latency code by mastering computer architecture and memory management fundamentals.</p>
                `
            }
        };
    
      
        function openModal(id) {
            const data = mentorData[id];
            if(!data) return;

            document.getElementById('nameText').innerText = data.name;
            document.getElementById('modalTitle').innerText = data.title;
            document.getElementById('modalBio').innerHTML = data.bio;
            
            // Cập nhật link MXH
            const fbLink = document.getElementById('modalFacebook');
            const igLink = document.getElementById('modalInstagram');
            
            if (data.facebook) {
                fbLink.href = data.facebook;
                fbLink.style.display = 'inline-block';
            } else {
                fbLink.style.display = 'none';
            }

            if (data.instagram) {
                igLink.href = data.instagram;
                igLink.style.display = 'inline-block';
            } else {
                igLink.style.display = 'none';
            }

            const img = document.getElementById('modalImg');
            img.src = data.img;
            if(data.fallback) {
                img.onerror = () => { img.onerror = null; img.src = data.fallback; };
            }

            const modal = document.getElementById('profileModal');
            const box = document.getElementById('modalBox');

            modal.classList.remove('hidden');
            modal.classList.add('flex');
            
            setTimeout(() => {
                box.classList.remove('scale-95', 'opacity-0');
                box.classList.add('scale-100', 'opacity-100');
            }, 50);

            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            const modal = document.getElementById('profileModal');
            const box = document.getElementById('modalBox');

            box.classList.remove('scale-100', 'opacity-100');
            box.classList.add('scale-95', 'opacity-0');

            setTimeout(() => {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
                document.body.style.overflow = 'auto';
            }, 300);
        }
    </script>
    <jsp:include page="../common/userbuttom.jsp" />
    <jsp:include page="../common/footer.jsp" />
</body>
</html>