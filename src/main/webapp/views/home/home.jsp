<%-- Document : home Created on : Feb 11, 2026, 2:11:15 PM Author : ASUS --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <fmt:setLocale value="en_US" />
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>DevLearn | Online Learning Platform</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                    rel="stylesheet" />
                <script id="tailwind-config">
                    tailwind.config = {
                        darkMode: "class",
                        theme: {
                            extend: {
                                colors: {
                                    "primary": "#10B981", /* Emerald */
                                    "background-light": "#0F172A",
                                    "background-dark": "#0F172A",
                                },
                                fontFamily: {
                                    "display": ["Inter", "sans-serif"]
                                },
                                maxWidth: {
                                    "canvas": "1200px",
                                }
                            },
                        },

                    }
                },
            },
        }
    </script>
    <style type="text/tailwindcss">
        .slider-wrapper {
            overflow-x: auto;
            scroll-behavior: smooth;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .slider-wrapper::-webkit-scrollbar {
            display: none;
        }

        .slider-track {
            display: flex;
            gap: 24px;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        @layer base {
            body {
                @apply antialiased;
            }
        }

        /* Hero Section Element Animations */
        .animate-fade-up {
            animation: heroFadeUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) both !important;
        }

        .delay-1 { animation-delay: 0.1s !important; }
        .delay-2 { animation-delay: 0.3s !important; }
        .delay-3 { animation-delay: 0.5s !important; }

        @keyframes heroFadeUp {
            0% {
                opacity: 0;
                transform: translateY(40px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body class="font-display transition-colors duration-300" style="background: linear-gradient(135deg, #f8fffc, #e6f7f1); color: #0f172a;">
    <div class="relative flex min-h-screen w-full flex-col">
        
        <jsp:include page="../common/header.jsp" />
        
        <main class="flex-1">
            <section class="relative min-h-screen flex items-center justify-center overflow-hidden">
                <div class="absolute inset-0 -z-10" style="background: radial-gradient(circle at 50% 65%, rgba(16,185,129,0.2) 0%, rgba(16,185,129,0.1) 20%, transparent 60%), linear-gradient(135deg, #0f172a 0%, #064e3b 40%, #000000 100%);">
                </div>

                <div class="absolute inset-0 overflow-hidden pointer-events-none z-0">
                    <div class="absolute inset-0 bg-[linear-gradient(rgba(16,185,129,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(16,185,129,0.03)_1px,transparent_1px)] bg-[size:3rem_3rem] [mask-image:radial-gradient(ellipse_60%_60%_at_50%_65%,#000_70%,transparent_100%)] opacity-50">
                    </div>
                </div>


                            <div
                                class="max-w-canvas mx-auto px-6 lg:px-12 relative z-10 text-center flex flex-col items-center pt-20">
                                <!-- Status Pill -->
                                <div
                                    class="inline-flex items-center gap-2 px-5 py-2 rounded-full bg-white/5 border border-white/10 text-emerald-400 text-sm font-semibold tracking-wide mb-8 backdrop-blur-md shadow-[0_0_20px_rgba(16,185,129,0.15)] animate-fade-up delay-1">
                                    <span class="relative flex h-2 w-2">
                                        <span
                                            class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                                        <span class="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
                                    </span>
                                    Learn Programming Smarter with AI
                                </div>

                                <!-- Headline -->
                                <h1
                                    class="text-6xl md:text-7xl lg:text-[5.5rem] font-black leading-[1.1] tracking-tighter mb-8 text-white max-w-5xl mx-auto drop-shadow-2xl animate-fade-up delay-2">
                                    Build Your Future <br class="hidden md:block" /> with a Modern
                                    <span
                                        class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 to-teal-400 drop-shadow-[0_0_40px_rgba(20,184,166,0.3)]">Digital
                                        Learning Platform</span>
                                </h1>

                                <!-- Primary CTA -->
 
                              <div class="flex flex-col sm:flex-row items-center gap-6 justify-center w-full relative z-20">
    <a href="${pageContext.request.contextPath}/learningpaths" 
       class="relative w-full sm:w-auto h-[4.5rem] px-12 bg-gradient-to-r from-emerald-500 to-emerald-600 text-white text-xl font-bold rounded-full shadow-[0_0_40px_rgba(16,185,129,0.4)] hover:shadow-[0_0_60px_rgba(16,185,129,0.6)] hover:scale-105 transition-all duration-300 flex items-center justify-center group"
       style="text-decoration: none;">
       
        <span class="relative z-10 flex items-center gap-3">
            Explore Learning Paths
            <span class="material-symbols-outlined font-bold transform transition-transform group-hover:translate-x-2">
                arrow_forward
            </span>
        </span>
        
    </a>
</div>
                             </div>
                        </section>

                        <!-- Stats Section -->
                        <section class="py-16 relative z-10 border-t border-emerald-100">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="bg-white rounded-3xl shadow-2xl border border-emerald-100 py-12">
                                    <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="text-4xl font-black text-primary">120+</span>
                                            <span
                                                class="text-sm font-semibold uppercase tracking-widest text-slate-500">Advanced
                                                Courses</span>
                                        </div>
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="text-4xl font-black text-primary">50+</span>
                                            <span
                                                class="text-sm font-semibold uppercase tracking-widest text-slate-500">Experienced
                                                Mentors</span>
                                        </div>
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="text-4xl font-black text-primary">24/7</span>
                                            <span
                                                class="text-sm font-semibold uppercase tracking-widest text-slate-500">Technical
                                                Support</span>
                                        </div>
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="text-4xl font-black text-primary">100%</span>
                                            <span
                                                class="text-sm font-semibold uppercase tracking-widest text-slate-500">Hands-on
                                                Practice</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Course Slider: Learn Without Limits -->
                        <section class="py-12 lg:py-10">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                                    <div class="max-w-xl">
                                        <h2
                                            class="text-4xl font-black tracking-tight bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">
                                            Learn Without Limits</h2>
                                    </div>
                                    <a class="inline-flex items-center gap-2 text-primary font-bold group" href="#">
                                        View All Courses
                                        <span
                                            class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="slider relative">
                                    <!-- Prev -->
                                    <button
                                        class="slider-prev absolute left-0 -translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <!-- Next -->
                                    <button
                                        class="slider-next absolute right-0 translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                    <div class="slider-wrapper overflow-x-auto snap-x snap-mandatory w-full relative">
                                        <div
                                            class="slider-track flex gap-6 transition-transform duration-500 ease-in-out">
                                            <c:forEach var="c" items="${FREE}">
                                                <div
                                                    class="group w-[280px] lg:w-[calc(25%-18px)] flex-shrink-0 snap-start flex flex-col bg-white rounded-[2rem] overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'">
                                                    <div class="aspect-[16/10] overflow-hidden relative">
                                                        <img alt="Frontend"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            src="${c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-6 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span
                                                                class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">${c.categoryId
                                                                != null ? c.categoryId.name : 'No Category'}</span>
                                                            <span class="text-xs text-gray-400">• 12 Hours</span>
                                                        </div>
                                                        <h3
                                                            class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                            ${c.title}</h3>
                                                        <div class="flex items-center gap-2 mb-6">
                                                            <div class="flex text-yellow-400">
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-gray-500">4.8
                                                                (1.2k)</span>
                                                        </div>
                                                        <div
                                                            class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                            <span class="text-xl font-black text-emerald-400">
                                                                <c:choose>
                                                                    <c:when test="${c.price == null || c.price <= 0}">Free</c:when>
                                                                    <c:otherwise>$<fmt:formatNumber value="${c.price}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${c.price == null || c.price <= 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                            Join
                                                                        </button>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               class="paid-course-cart-btn group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90"
                                                                               data-course-id="${c.courseId}">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                            <button type="button" disabled
                                                                                    onclick="event.stopPropagation()"
                                                                                    class="paid-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                                    data-course-id="${c.courseId}">
                                                                                Enrolled
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a onclick="event.stopPropagation()"
                                                                               href="${pageContext.request.contextPath}/login"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                </div>
                                                <span class="text-xs font-bold text-gray-500">4.8 (1.2k)</span>
                                            </div>
                                            <div class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                <c:choose>
                                                    <c:when test="${c.price <= 0.20 || empty c.price}">
                                                        <span class="text-xl font-black text-emerald-400">Free</span>
                                                        <button type="button" onclick="enrollFreeCourseAjax(event, this, ${c.courseId});"
                                                            class="group/cart px-4 py-1.5 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 font-bold text-primary">
                                                            Join
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-xl font-black text-emerald-400">$${c.price}</span>
                                                        <button type="button" onclick="addToCartAjax(event, this, ${c.courseId});"
                                                            class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                            <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        </section>

                        <!-- Course Slider: Master Software Development -->
                        <section class="py-12 lg:py-10">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                                    <div class="max-w-xl">
                                        <h2
                                            class="text-4xl font-black tracking-tight bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">
                                            Master Software Development</h2>
                                    </div>
                                    <a class="inline-flex items-center gap-2 text-primary font-bold group" href="#">
                                        View All Courses
                                        <span
                                            class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="slider relative">
                                    <!-- Prev -->
                                    <button
                                        class="slider-prev absolute left-0 -translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <!-- Next -->
                                    <button
                                        class="slider-next absolute right-0 translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                    <div class="slider-wrapper overflow-x-auto snap-x snap-mandatory w-full relative">
                                        <div
                                            class="slider-track flex gap-6 transition-transform duration-500 ease-in-out">
                                            <c:forEach var="c" items="${SOFT}">
                                                <div
                                                    class="group w-[280px] lg:w-[calc(25%-18px)] flex-shrink-0 snap-start flex flex-col bg-white rounded-[2rem] overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'">
                                                    <div class="aspect-[16/10] overflow-hidden relative">
                                                        <img alt="Frontend"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            src="${c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-6 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span
                                                                class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">${c.categoryId
                                                                != null ? c.categoryId.name : 'No Category'}</span>
                                                            <span class="text-xs text-gray-400">• 12 Hours</span>
                                                        </div>
                                                        <h3
                                                            class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                            ${c.title}</h3>
                                                        <div class="flex items-center gap-2 mb-6">
                                                            <div class="flex text-yellow-400">
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-gray-500">4.8
                                                                (1.2k)</span>
                                                        </div>
                                                        <div
                                                            class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                            <span class="text-xl font-black text-emerald-400">
                                                                <c:choose>
                                                                    <c:when test="${c.price == null || c.price <= 0}">Free</c:when>
                                                                    <c:otherwise>$<fmt:formatNumber value="${c.price}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${c.price == null || c.price <= 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                            Join
                                                                        </button>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               class="paid-course-cart-btn group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90"
                                                                               data-course-id="${c.courseId}">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                            <button type="button" disabled
                                                                                    onclick="event.stopPropagation()"
                                                                                    class="paid-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                                    data-course-id="${c.courseId}">
                                                                                Enrolled
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a onclick="event.stopPropagation()"
                                                                               href="${pageContext.request.contextPath}/login"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                </div>
                                                <span class="text-xs font-bold text-gray-500">4.8 (1.2k)</span>
                                            </div>
                                            <div class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                <c:choose>
                                                    <c:when test="${c.price <= 0.20 || empty c.price}">
                                                        <span class="text-xl font-black text-emerald-400">Free</span>
                                                        <button type="button" onclick="enrollFreeCourseAjax(event, this, ${c.courseId});"
                                                            class="group/cart px-4 py-1.5 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 font-bold text-primary">
                                                            Join
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-xl font-black text-emerald-400">$${c.price}</span>
                                                        <button type="button" onclick="addToCartAjax(event, this, ${c.courseId});"
                                                            class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                            <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        </section>

                        <!-- Course Slider: Unlock the Logic -->
                        <section class="py-12 lg:py-10">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                                    <div class="max-w-xl">
                                        <h2
                                            class="text-4xl font-black tracking-tight bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">
                                            Unlock the Logic</h2>
                                    </div>
                                    <a class="inline-flex items-center gap-2 text-primary font-bold group" href="#">
                                        View All Courses
                                        <span
                                            class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="slider relative">
                                    <!-- Prev -->
                                    <button
                                        class="slider-prev absolute left-0 -translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <!-- Next -->
                                    <button
                                        class="slider-next absolute right-0 translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                    <div class="slider-wrapper overflow-x-auto snap-x snap-mandatory w-full relative">
                                        <div
                                            class="slider-track flex gap-6 transition-transform duration-500 ease-in-out">
                                            <c:forEach var="c" items="${MATH}">
                                                <div
                                                    class="group w-[280px] lg:w-[calc(25%-18px)] flex-shrink-0 snap-start flex flex-col bg-white rounded-[2rem] overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'">
                                                    <div class="aspect-[16/10] overflow-hidden relative">
                                                        <img alt="Frontend"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            src="${c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-6 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span
                                                                class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">${c.categoryId
                                                                != null ? c.categoryId.name : 'No Category'}</span>
                                                            <span class="text-xs text-gray-400">• 12 Hours</span>
                                                        </div>
                                                        <h3
                                                            class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                            ${c.title}</h3>
                                                        <div class="flex items-center gap-2 mb-6">
                                                            <div class="flex text-yellow-400">
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-gray-500">4.8
                                                                (1.2k)</span>
                                                        </div>
                                                        <div
                                                            class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                            <span class="text-xl font-black text-emerald-400">
                                                                <c:choose>
                                                                    <c:when test="${c.price == null || c.price <= 0}">Free</c:when>
                                                                    <c:otherwise>$<fmt:formatNumber value="${c.price}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${c.price == null || c.price <= 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                            Join
                                                                        </button>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               class="paid-course-cart-btn group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90"
                                                                               data-course-id="${c.courseId}">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                            <button type="button" disabled
                                                                                    onclick="event.stopPropagation()"
                                                                                    class="paid-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                                    data-course-id="${c.courseId}">
                                                                                Enrolled
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a onclick="event.stopPropagation()"
                                                                               href="${pageContext.request.contextPath}/login"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                </div>
                                                <span class="text-xs font-bold text-gray-500">4.8 (1.2k)</span>
                                            </div>
                                            <div class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                <c:choose>
                                                    <c:when test="${c.price <= 0.20 || empty c.price}">
                                                        <span class="text-xl font-black text-emerald-400">Free</span>
                                                        <button type="button" onclick="enrollFreeCourseAjax(event, this, ${c.courseId});"
                                                            class="group/cart px-4 py-1.5 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 font-bold text-primary">
                                                            Join
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-xl font-black text-emerald-400">$${c.price}</span>
                                                        <button type="button" onclick="addToCartAjax(event, this, ${c.courseId});"
                                                            class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                            <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        </section>

                        <!-- Course Slider: Break Language Barriers -->
                        <section class="py-12 lg:py-10">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                                    <div class="max-w-xl">
                                        <h2
                                            class="text-4xl font-black tracking-tight bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">
                                            Break Language Barriers</h2>
                                    </div>
                                    <a class="inline-flex items-center gap-2 text-primary font-bold group" href="#">
                                        View All Courses
                                        <span
                                            class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="slider relative">
                                    <!-- Prev -->
                                    <button
                                        class="slider-prev absolute left-0 -translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <!-- Next -->
                                    <button
                                        class="slider-next absolute right-0 translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                    <div class="slider-wrapper overflow-x-auto snap-x snap-mandatory w-full relative">
                                        <div
                                            class="slider-track flex gap-6 transition-transform duration-500 ease-in-out">
                                            <c:forEach var="c" items="${FOREIGN}">
                                                <div
                                                    class="group w-[280px] lg:w-[calc(25%-18px)] flex-shrink-0 snap-start flex flex-col bg-white rounded-[2rem] overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'">
                                                    <div class="aspect-[16/10] overflow-hidden relative">
                                                        <img alt="Frontend"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            src="${c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-6 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span
                                                                class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">${c.categoryId
                                                                != null ? c.categoryId.name : 'No Category'}</span>
                                                            <span class="text-xs text-gray-400">• 12 Hours</span>
                                                        </div>
                                                        <h3
                                                            class="text-xl font-bold mb-3 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                            ${c.title}</h3>
                                                        <div class="flex items-center gap-2 mb-6">
                                                            <div class="flex text-yellow-400">
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-gray-500">4.8
                                                                (1.2k)</span>
                                                        </div>
                                                        <div
                                                            class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                            <span class="text-xl font-black text-emerald-400">
                                                                <c:choose>
                                                                    <c:when test="${c.price == null || c.price <= 0}">Free</c:when>
                                                                    <c:otherwise>$<fmt:formatNumber value="${c.price}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${c.price == null || c.price <= 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                            Join
                                                                        </button>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               class="paid-course-cart-btn group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90"
                                                                               data-course-id="${c.courseId}">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                            <button type="button" disabled
                                                                                    onclick="event.stopPropagation()"
                                                                                    class="paid-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                                    data-course-id="${c.courseId}">
                                                                                Enrolled
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a onclick="event.stopPropagation()"
                                                                               href="${pageContext.request.contextPath}/login"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                                                <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                </div>
                                                <span class="text-xs font-bold text-gray-500">4.8 (1.2k)</span>
                                            </div>
                                            <div class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                <c:choose>
                                                    <c:when test="${c.price <= 0.20 || empty c.price}">
                                                        <span class="text-xl font-black text-emerald-400">Free</span>
                                                        <button type="button" onclick="enrollFreeCourseAjax(event, this, ${c.courseId});"
                                                            class="group/cart px-4 py-1.5 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 font-bold text-primary">
                                                            Join
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-xl font-black text-emerald-400">$${c.price}</span>
                                                        <button type="button" onclick="addToCartAjax(event, this, ${c.courseId});"
                                                            class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90">
                                                            <span class="material-symbols-outlined text-primary text-xl transition-all duration-300">shopping_cart</span>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="pb-24 lg:pb-32 px-8 lg:px-12">
                <div class="max-w-canvas mx-auto rounded-[3rem] p-12 lg:p-24 relative overflow-hidden text-center flex flex-col items-center" style="background: linear-gradient(135deg, #ecfdf5, #d1fae5);">
                    <div class="absolute top-0 right-0 w-[400px] h-[400px] bg-primary/20 rounded-full blur-[120px]">
                    </div>
                    <div class="absolute bottom-0 left-0 w-[300px] h-[300px] bg-primary/10 rounded-full blur-[100px]">
                    </div>
                    <h2 class="text-4xl lg:text-6xl font-black text-[#0f172a] mb-8 max-w-4xl leading-tight z-10">
                        Ready to accelerate your programming career?
                    </h2>
                    <p class="text-lg lg:text-xl text-[#475569] mb-12 max-w-2xl z-10">
                        Over 15,000 students trust us. Sign up today to get 40% off Premium memberships.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 z-10">
                        <button class="h-16 px-12 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white text-lg font-bold rounded-2xl shadow-xl shadow-emerald-500/20 hover:shadow-emerald-500/40 hover:scale-105 transition-all">
                            Start Learning for Free
                        </button>
                        <button class="h-16 px-12 border-2 border-emerald-300 text-[#0f172a] text-lg font-bold rounded-2xl hover:bg-emerald-100 transition-all">
                            Contact Us
                        </button>
                    </div>
                </div>
            </section>
        </main>

        <footer class="bg-white border-t border-emerald-100 pt-24 pb-12">
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
                            Accompanying thousands of students on their journey to becoming professional
                            software engineers with practical curriculum.
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
                        <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Courses</h4>
                        <ul class="space-y-4">
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Frontend Development</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Backend Development</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Mobile Development</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Data Science &amp; AI</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">DevOps &amp; Cloud</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Resources</h4>
                        <ul class="space-y-4">
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Tech Blog</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Learning Community</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Free Materials</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">YouTube Channel</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">IT Podcast</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-sm uppercase tracking-widest mb-8">Quick Links</h4>
                        <ul class="space-y-4">
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">About Us</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Careers</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Terms of Service</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Privacy Policy</a></li>
                            <li><a class="text-gray-500 hover:text-primary transition-colors text-[15px]" href="#">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <div class="pt-12 border-t border-gray-100 dark:border-white/5 flex flex-col md:flex-row justify-between items-center gap-6">
                    <p class="text-sm text-gray-500">© 2024 DevLearn Academy. Built for the tech community.</p>
                    <div class="flex items-center gap-8">
                        <span class="text-sm text-gray-500 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg">language</span> English
                        </span>
                        <span class="text-sm text-gray-500 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg">support_agent</span> 1900 1234
                        </span>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <jsp:include page="../common/userbuttom.jsp" />

    <script>
        // 1. Code xử lý CSS cho header khi scroll
        const navLinks = document.querySelectorAll('.nav-link');
        window.addEventListener('scroll', () => {
            const isScrolled = window.scrollY > 50;
            navLinks.forEach(link => {
                if (isScrolled) {
                    link.classList.remove('text-white/80');
                    link.classList.add('text-slate-700');
                } else {
                    link.classList.remove('text-slate-700');
                    link.classList.add('text-white/80');
                }
            });
        });

        // 2. Code xử lý kéo thả (slider) của bạn
        window.addEventListener("load", function () {
            const sliders = document.querySelectorAll(".slider");
            sliders.forEach(function (slider) {
                const track = slider.querySelector(".slider-track");
                const prevBtn = slider.querySelector(".slider-prev");
                const nextBtn = slider.querySelector(".slider-next");
                const wrapper = slider.querySelector(".slider-wrapper");
                let currentIndex = 0;

                function getCards() { return track.querySelectorAll(":scope > div"); }

                function getCardWidth() {
                    const cards = getCards();
                    if (!cards.length) return 0;
                    const style = window.getComputedStyle(track);
                    const gap = parseFloat(style.columnGap);
                    return cards[0].getBoundingClientRect().width + gap;
                }

                function getVisibleCards() { return Math.floor(wrapper.clientWidth / getCardWidth()); }

                function getMaxIndex() {
                    const cardWidth = getCardWidth();
                    if (cardWidth === 0) return 0;
                    const maxScroll = track.scrollWidth - wrapper.clientWidth;
                    return Math.ceil(maxScroll / cardWidth);
                }

                function updateSlider() {
                    wrapper.scrollTo({ left: currentIndex * getCardWidth(), behavior: "smooth" });
                }

                nextBtn.addEventListener("click", function () {
                    const maxIndex = getMaxIndex();
                    if (currentIndex < maxIndex) currentIndex++;
                    else currentIndex = 0;
                    updateSlider();
                });

                prevBtn.addEventListener("click", function () {
                    const maxIndex = getMaxIndex();
                    if (currentIndex > 0) currentIndex--;
                    else currentIndex = maxIndex;
                    updateSlider();
                });
            });
        });

        // 3. CODE AJAX XỬ LÝ THÊM VÀO GIỎ HÀNG KHÔNG LOAD TRANG (Chỉ nhảy số)
        function addToCartAjax(event, btnElement, courseId) {
            event.preventDefault();
            event.stopPropagation();

            let card = btnElement.closest('.group');
            let title = card.querySelector('h3') ? card.querySelector('h3').innerText : 'Khóa học';
            let priceSpan = card.querySelector('.mt-auto span.text-emerald-400');
            let priceText = priceSpan ? priceSpan.innerText : '$0.00';
            let imgEl = card.querySelector('img');
            let imageSrc = imgEl ? imgEl.src : '';

            fetch('${pageContext.request.contextPath}/addToCart?id=' + courseId + '&ajax=true')
                .then(response => {
                    if (!response.ok) throw new Error("Lỗi kết nối Server");
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success') {
                        let cartBadge = document.querySelector('a[href*="/cart"] span.absolute');
                        if (cartBadge) {
                            cartBadge.innerText = data.cartSize;
                        }

                        let listContainer = document.querySelector('.group .absolute.right-0.top-full .overflow-y-auto');
                        let headerText = document.querySelector('.group .absolute.right-0.top-full p');
                        
                        if (headerText) {
                            headerText.innerText = 'CART (' + data.cartSize + ' ITEMS)';
                        }

                        if (listContainer) {
                            let emptyMsg = listContainer.querySelector('.p-10.text-center');
                            if (emptyMsg) emptyMsg.remove();

                            let finalImageSrc = imageSrc ? imageSrc : '${pageContext.request.contextPath}/assets/images/default-course.jpg';

                            let newItemHtml = `
                                <a href="${pageContext.request.contextPath}/course-detail?id=` + courseId + `"
                                   class="flex gap-4 p-4 border-b border-slate-50 hover:bg-emerald-50/50 transition-colors block"
                                   style="text-decoration: none;">
                                    <div class="w-16 h-16 rounded-xl overflow-hidden bg-slate-100 flex-shrink-0 border border-slate-200/60">
                                        <img src="` + finalImageSrc + `" class="w-full h-full object-cover" alt="Course">
                                    </div>
                                    <div class="flex-1 min-w-0 flex flex-col justify-center">
                                        <h4 class="text-[14px] font-bold text-slate-800 truncate mb-1">` + title + `</h4>
                                        <p class="text-[#10B981] font-bold text-[14px]">` + priceText + `</p>
                                    </div>
                                </a>
                            `;
                            listContainer.insertAdjacentHTML('beforeend', newItemHtml);
                        }

                        showDynamicToast('success', 'Add successful!');

                    } else if (data.status === 'error') {
                        showDynamicToast('error', data.message || 'This course is already in your cart!');
                    }
                })
                .catch(err => {
                    console.error('Lỗi khi thêm giỏ hàng:', err);
                    showDynamicToast('error', 'Đã có lỗi xảy ra!');
                });
        }

        // 4. HÀM MỚI: XỬ LÝ ĐĂNG KÝ (ENROLL) KHÓA HỌC FREE
        function enrollFreeCourseAjax(event, btnElement, courseId) {
            event.preventDefault();
            event.stopPropagation();

            // LƯU Ý: Hiện tại mình đang gọi tạm vào "/enroll" (bạn cần có Servlet xử lý đường dẫn này).
            // Nếu bạn dùng đường dẫn khác để lưu data đăng ký thì nhớ sửa url nhé.
            fetch('${pageContext.request.contextPath}/enroll?id=' + courseId + '&ajax=true')
                .then(response => {
                    if (!response.ok) throw new Error("Lỗi kết nối Server");
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success') {
                        // Đổi chữ nút thành Enrolled
                        btnElement.innerText = 'Enrolled';
                        
                        // Đổi màu sắc để báo hiệu đã Enroll (gỡ class cũ, đắp class mới)
                        btnElement.classList.remove('text-primary', 'hover:bg-emerald-500/20', 'hover:border-emerald-400', 'active:scale-90', 'bg-emerald-500/10', 'border-emerald-500/30');
                        btnElement.classList.add('text-slate-500', 'bg-slate-100', 'border-slate-300', 'cursor-not-allowed');
                        
                        // Vô hiệu hóa nút để không bấm lại được nữa
                        btnElement.disabled = true;

                        showDynamicToast('success', 'Successfully enrolled in course!');
                    } else {
                        // Nếu backend báo lỗi
                        showDynamicToast('error', data.message || 'Enrollment failed!');
                    }
                })
                .catch(err => {
                    console.error('Lỗi khi enroll khóa học free:', err);
                    showDynamicToast('error', 'Không thể đăng ký. Hãy check Console (F12) hoặc xem Backend đã có API /enroll chưa nhé!');
                });
        }

        // 5. Hàm vẽ UI thông báo (Toast)
        function showDynamicToast(type, message) {
            let oldToast = document.getElementById('dynamicAjaxToast');
            if (oldToast) oldToast.remove();

            let bgClass = type === 'success' ? 'bg-[#f0fdf4]' : 'bg-[#fff1f2]';
            let borderClass = type === 'success' ? 'border-[#bbf7d0]' : 'border-[#fecaca]';
            let shadowClass = type === 'success' ? 'shadow-[0_10px_40px_-10px_rgba(34,197,94,0.3)]' : 'shadow-[0_10px_40px_-10px_rgba(239,68,68,0.3)]';
            let textClass = type === 'success' ? 'text-[#22c55e]' : 'text-[#ef4444]';
            let iconBgClass = type === 'success' ? 'bg-[#16a34a]' : 'bg-[#dc2626]';
            let iconName = type === 'success' ? 'check' : 'priority_high';
            let msgColorClass = type === 'success' ? 'text-[#15803d]' : 'text-[#b91c1c]';

            const toastHtml = `
                <div id="dynamicAjaxToast" class="fixed top-[90px] right-8 z-[100] toast-animate-in transition-all duration-300">
                    <div class="relative \${bgClass} border \${borderClass} \${shadowClass} rounded-2xl px-5 py-3.5 flex items-center gap-3 min-w-[320px]">
                        <button onclick="this.closest('#dynamicAjaxToast').remove()" class="absolute -top-2.5 -left-2.5 w-6 h-6 bg-white border \${borderClass} rounded-full flex items-center justify-center \${textClass} hover:\${bgClass} transition-colors shadow-sm">
                            <span class="material-symbols-outlined text-[14px] font-bold">close</span>
                        </button>
                        <div class="w-6 h-6 rounded-full \${iconBgClass} flex items-center justify-center text-white flex-shrink-0">
                            <span class="material-symbols-outlined text-[16px] font-bold">\${iconName}</span>
                        </div>
                        <span class="\${msgColorClass} font-bold text-[15px]">\${message}</span>
                    </div>
                </div>
            `;
            
            document.body.insertAdjacentHTML('beforeend', toastHtml);
            
            setTimeout(() => {
                let el = document.getElementById('dynamicAjaxToast');
                if (el) {
                    el.classList.add('toast-animate-out');
                    setTimeout(() => { if (el.parentNode) el.remove(); }, 300);
                }
            }, 3000);
        }
    </script>
</body>


                <jsp:include page="../common/userbuttom.jsp" />

                <script>
                    const navLinks = document.querySelectorAll('.nav-link');
                    window.addEventListener('scroll', () => {
                        const isScrolled = window.scrollY > 50;
                        navLinks.forEach(link => {
                            if (isScrolled) {
                                link.classList.remove('text-white/80');
                                link.classList.add('text-slate-700');
                            } else {
                                link.classList.remove('text-slate-700');
                                link.classList.add('text-white/80');
                            }
                        });
                    });

                    window.addEventListener("load", function () {
                        const sliders = document.querySelectorAll(".slider");

                        sliders.forEach(function (slider) {
                            const track = slider.querySelector(".slider-track");
                            const prevBtn = slider.querySelector(".slider-prev");
                            const nextBtn = slider.querySelector(".slider-next");
                            const wrapper = slider.querySelector(".slider-wrapper");
                            let currentIndex = 0;

                            function getCards() {
                                return track.querySelectorAll(":scope > div");
                            }

                            function getCardWidth() {
                                const cards = getCards();
                                if (!cards.length) return 0;
                                const style = window.getComputedStyle(track);
                                const gap = parseFloat(style.columnGap);
                                return cards[0].getBoundingClientRect().width + gap;
                            }

                            function getVisibleCards() {
                                return Math.floor(wrapper.clientWidth / getCardWidth());
                            }

                            function getMaxIndex() {
                                const cardWidth = getCardWidth();
                                if (cardWidth === 0) return 0;
                                const maxScroll = track.scrollWidth - wrapper.clientWidth;
                                return Math.ceil(maxScroll / cardWidth);
                            }

                            function updateSlider() {
                                wrapper.scrollTo({
                                    left: currentIndex * getCardWidth(),
                                    behavior: "smooth"
                                });
                            }

                            nextBtn.addEventListener("click", function () {
                                const maxIndex = getMaxIndex();
                                if (currentIndex < maxIndex) {
                                    currentIndex++;
                                } else {
                                    currentIndex = 0;
                                }
                                updateSlider();
                            });

                            prevBtn.addEventListener("click", function () {
                                const maxIndex = getMaxIndex();
                                if (currentIndex > 0) {
                                    currentIndex--;
                                } else {
                                    currentIndex = maxIndex;
                                }
                                updateSlider();
                            });
                        });
                    });
                </script>

                <script>
                    /* ── Enrollment Logic ── */
                    (function() {
                        const isLoggedIn = ${sessionScope.USER != null};
                        if (isLoggedIn) {
                            // Check enrollment for FREE courses
                            const freeCourseBtns = document.querySelectorAll('.free-course-btn');
                            freeCourseBtns.forEach(btn => {
                                const courseId = btn.getAttribute('data-course-id');
                                fetch('${pageContext.request.contextPath}/api/courses/' + courseId + '/enrollment-status')
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.enrolled) {
                                            const enrolledBtn = btn.parentElement.querySelector('.free-course-enrolled-btn');
                                            btn.classList.add('hidden');
                                            enrolledBtn.classList.remove('hidden');
                                        } else {
                                            btn.classList.remove('hidden');
                                        }
                                    })
                                    .catch(e => {
                                        console.error('Status check error:', e);
                                        btn.classList.remove('hidden');
                                    });
                            });

                            // Check enrollment for PAID courses
                            const paidCartBtns = document.querySelectorAll('.paid-course-cart-btn');
                            paidCartBtns.forEach(btn => {
                                const courseId = btn.getAttribute('data-course-id');
                                fetch('${pageContext.request.contextPath}/api/courses/' + courseId + '/enrollment-status')
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.enrolled) {
                                            const enrolledBtn = btn.parentElement.querySelector('.paid-course-enrolled-btn');
                                            btn.classList.add('hidden');
                                            enrolledBtn.classList.remove('hidden');
                                        }
                                    })
                                    .catch(e => console.error('Paid status check error:', e));
                            });
                        }

                        window.handleEnrollment = function(btn, courseId, isLogged) {
                            if (!isLogged) {
                                window.location.href = '${pageContext.request.contextPath}/login';
                                return;
                            }

                            const originalText = btn.innerHTML;
                            btn.innerHTML = '<span class="material-symbols-outlined animate-spin text-sm">progress_activity</span>';
                            btn.disabled = true;

                            fetch('${pageContext.request.contextPath}/api/courses/' + courseId + '/enroll', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                }
                            })
                            .then(r => {
                                if (r.ok || r.status === 401) {
                                    return r.json();
                                } else {
                                    throw new Error('API failed');
                                }
                            })
                            .then(data => {
                                if (data.error && data.error === 'User not logged in') {
                                    window.location.href = '${pageContext.request.contextPath}/login';
                                    return;
                                }
                                if (data.enrolled) {
                                    const enrolledBtn = btn.parentElement.querySelector('.free-course-enrolled-btn');
                                    btn.classList.add('hidden');
                                    enrolledBtn.classList.remove('hidden');
                                } else {
                                    btn.innerHTML = originalText;
                                    btn.disabled = false;
                                    alert('Enrollment failed');
                                }
                            })
                            .catch(e => {
                                console.error('Enroll error:', e);
                                btn.innerHTML = originalText;
                                btn.disabled = false;
                                alert('Something went wrong during enrollment');
                            });
                        };
                    })();
                </script>
            </body>

            </html>
