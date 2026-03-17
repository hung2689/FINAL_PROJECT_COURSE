<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<style>
    /* Global Glass Header CSS */
    .glass-header-nav {
        background: rgba(15, 23, 42, 0.65);
        background-image: linear-gradient(135deg, rgba(15, 23, 42, 0.85) 0%, rgba(6, 78, 59, 0.5) 50%, rgba(15, 23, 42, 0.85) 100%);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    }
</style>

<header class="fixed top-0 left-0 w-full z-50 glass-header-nav">
    <div class="max-w-[1200px] w-full mx-auto px-6 lg:px-12 py-4 flex items-center justify-between">

        <div class="flex items-center gap-12">
            <a href="${pageContext.request.contextPath}/home"
               class="flex items-center gap-2 group cursor-pointer" style="text-decoration: none;">
                <div class="w-10 h-10 rounded-xl flex items-center justify-center text-[#101b0d] transition-transform group-hover:scale-105 duration-300"
                     style="background: #10B981; box-shadow: 0 4px 20px rgba(16, 185, 129, 0.25);">
                    <span class="material-symbols-outlined text-2xl font-bold">terminal</span>
                </div>
                <h2 class="text-2xl font-black tracking-tight text-white m-0">DevLearn</h2>
            </a>

            <nav class="hidden lg:flex items-center gap-8">
                <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                   href="${pageContext.request.contextPath}/home">Home</a>
                <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                   href="${pageContext.request.contextPath}/shop">Courses</a>
                <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                   href="#">Learning Paths</a>
             
           <div class="relative group z-50">
                    <button type="button"
                            class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300 inline-flex items-center gap-1">
                        About DevLearn
                        <span class="material-symbols-outlined text-sm">expand_more</span>
                    </button>
                    <div
                            class="absolute left-0 mt-2 w-56 rounded-xl bg-slate-900/95 border border-white/10 shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                        
                     
                            
                        <a href="${pageContext.request.contextPath}/mentors"
                           class="block px-4 py-2 text-sm text-white/80 hover:bg-slate-800 hover:text-[#10B981]">Our
                            Mentors</a>

                        <a href="${pageContext.request.contextPath}/teacher-jobs"
                           class="block px-4 py-2 text-sm text-white/80 hover:bg-slate-800 hover:text-[#10B981]">Teacher
                            Recruitment</a>

                    </div>
                </div>
            </nav>
        </div>

        <div class="flex items-center gap-5">
            <%--=====CART ICON: logged-in → full dropdown | guest → redirect to login=====--%>
            <c:choose>
                <c:when test="${sessionScope.USER != null}">
                    <%-- Logged in: show cart icon with live dropdown --%>
                    <div class="relative group">
                        <a href="${pageContext.request.contextPath}/cart"
                           class="relative flex items-center justify-center w-[42px] h-[42px] rounded-full border border-white/20 bg-white/5 text-white/90 hover:text-[#10B981] hover:border-[#10B981]/50 hover:bg-[#10B981]/10 transition-all duration-300"
                           style="text-decoration: none;">
                            <span class="material-symbols-outlined text-[22px]">shopping_cart</span>
                            <span
                                class="absolute -top-1 -right-1 flex h-[18px] w-[18px] items-center justify-center rounded-full bg-[#10B981] text-[10px] font-bold text-slate-900 ring-2 ring-slate-900 shadow-sm">
                                ${sessionScope.cartSize != null ? sessionScope.cartSize : '0'}
                            </span>
                        </a>

                        <div
                            class="absolute right-0 top-full pt-3 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform origin-top-right scale-95 group-hover:scale-100 z-[100] w-[340px]">
                            <div
                                class="bg-white rounded-2xl shadow-[0_20px_50px_-12px_rgba(0,0,0,0.25)] border border-slate-100 overflow-hidden relative">
                                <div
                                    class="absolute -top-1.5 right-4 w-4 h-4 bg-white border-t border-l border-slate-100 transform rotate-45 z-0">
                                </div>
                                <div class="relative z-10 flex flex-col max-h-[400px]">
                                    <div class="px-5 py-3.5 border-b border-slate-100 bg-slate-50">
                                        <p
                                            class="text-[13px] font-bold text-slate-600 uppercase tracking-wider">
                                            Cart (${sessionScope.cartSize != null ?
                                                    sessionScope.cartSize : '0'} items)</p>
                                    </div>

                                    <div class="overflow-y-auto custom-scrollbar flex-1 bg-white">
                                        <c:choose>
                                            <c:when
                                                test="${empty sessionScope.cart or sessionScope.cartSize == 0}">
                                                <div
                                                    class="p-10 text-center flex flex-col items-center justify-center">
                                                    <div class="relative mb-3">
                                                        <span
                                                            class="material-symbols-outlined text-6xl text-slate-200">inbox</span>
                                                    </div>
                                                    <p class="text-[15px] font-bold text-slate-700">Your
                                                        cart is empty</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="entry" items="${sessionScope.cart}">
                                                    <c:set var="c" value="${entry.value}" />
                                                    <a href="${pageContext.request.contextPath}/course?id=${c.courseId}"
                                                       class="flex gap-4 p-4 border-b border-slate-50 hover:bg-emerald-50/50 transition-colors block"
                                                       style="text-decoration: none;">
                                                        <div
                                                            class="w-16 h-16 rounded-xl overflow-hidden bg-slate-100 flex-shrink-0 border border-slate-200/60">
                                                            <img src="${empty c.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : c.thumbnailUrl }"
                                                                 class="w-full h-full object-cover"
                                                                 alt="Course">
                                                        </div>
                                                        <div
                                                            class="flex-1 min-w-0 flex flex-col justify-center">
                                                            <h4
                                                                class="text-[14px] font-bold text-slate-800 truncate mb-1">
                                                                ${c.title}</h4>
                                                            <div
                                                                class="flex items-center text-yellow-400 mb-1">
                                                                <span class="material-symbols-outlined"
                                                                      style="font-size: 14px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                      style="font-size: 14px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                      style="font-size: 14px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                      style="font-size: 14px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                      style="font-size: 14px; font-variation-settings: 'FILL' 1;">star_half</span>
                                                                <span
                                                                    class="text-[11px] text-slate-500 font-medium ml-1 mt-0.5">4.5</span>
                                                            </div>
                                                            <p
                                                                class="text-[#10B981] font-bold text-[14px]">
                                                                <c:choose>
                                                                    <c:when test="${c.price eq 0}">Free
                                                                    </c:when>
                                                                    <c:otherwise>$
                                                                        <fmt:formatNumber
                                                                            value="${c.price}"
                                                                            minFractionDigits="2"
                                                                            maxFractionDigits="2" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    </a>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="p-4 border-t border-slate-100 bg-white">
                                        <a href="${pageContext.request.contextPath}/cart"
                                           class="w-full flex items-center justify-center gap-2 py-2.5 bg-[#10B981] text-white text-sm font-bold rounded-xl hover:bg-[#059669] transition-colors shadow-sm"
                                           style="text-decoration: none;">
                                            <span
                                                class="material-symbols-outlined text-[18px]">shopping_cart</span>
                                            View Cart
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- Guest: cart icon redirects to login --%>
                    <a href="${pageContext.request.contextPath}/login"
                       title="Please login to use cart feature"
                       class="relative flex items-center justify-center w-[42px] h-[42px] rounded-full border border-white/20 bg-white/5 text-white/90 hover:text-[#10B981] hover:border-[#10B981]/50 hover:bg-[#10B981]/10 transition-all duration-300"
                       style="text-decoration: none;">
                        <span class="material-symbols-outlined text-[22px]">shopping_cart</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<style>
    @keyframes slideInToast {
        from {
            transform: translateX(100%) scale(0.9);
            opacity: 0;
        }

        to {
            transform: translateX(0) scale(1);
            opacity: 1;
        }
    }

    .toast-animate-in {
        animation: slideInToast 0.4s cubic-bezier(0.22, 1, 0.36, 1) forwards;
    }

    .toast-animate-out {
        opacity: 0;
        transform: translateX(100%);
        pointer-events: none;
    }
</style>

<c:if test="${not empty sessionScope.toastType}">
    <div id="toastNotification"
         class="fixed top-[90px] right-8 z-[100] toast-animate-in transition-all duration-300">
        <c:if test="${sessionScope.toastType == 'success'}">
            <div
                class="relative bg-[#f0fdf4] border border-[#bbf7d0] shadow-[0_10px_40px_-10px_rgba(34,197,94,0.3)] rounded-2xl px-5 py-3.5 flex items-center gap-3 min-w-[320px]">
                <button onclick="closeToast()"
                        class="absolute -top-2.5 -left-2.5 w-6 h-6 bg-white border border-[#bbf7d0] rounded-full flex items-center justify-center text-[#22c55e] hover:bg-[#22c55e] hover:text-white transition-colors shadow-sm">
                    <span class="material-symbols-outlined text-[14px] font-bold">close</span>
                </button>
                <div
                    class="w-6 h-6 rounded-full bg-[#16a34a] flex items-center justify-center text-white flex-shrink-0">
                    <span class="material-symbols-outlined text-[16px] font-bold">check</span>
                </div>
                <span class="text-[#15803d] font-bold text-[15px]">${sessionScope.toastMsg}</span>
            </div>
        </c:if>

        <c:if test="${sessionScope.toastType == 'error'}">
            <div
                class="relative bg-[#fff1f2] border border-[#fecaca] shadow-[0_10px_40px_-10px_rgba(239,68,68,0.3)] rounded-2xl px-5 py-3.5 flex items-center gap-3 min-w-[320px]">
                <button onclick="closeToast()"
                        class="absolute -top-2.5 -left-2.5 w-6 h-6 bg-white border border-[#fecaca] rounded-full flex items-center justify-center text-[#ef4444] hover:bg-[#ef4444] hover:text-white transition-colors shadow-sm">
                    <span class="material-symbols-outlined text-[14px] font-bold">close</span>
                </button>
                <div
                    class="w-6 h-6 rounded-full bg-[#dc2626] flex items-center justify-center text-white flex-shrink-0">
                    <span class="material-symbols-outlined text-[16px] font-bold">priority_high</span>
                </div>
                <span class="text-[#b91c1c] font-bold text-[15px]">${sessionScope.toastMsg}</span>
            </div>
        </c:if>
    </div>

    <script>
        const toastEl = document.getElementById('toastNotification');
        let toastTimeout;
        function closeToast() {
            if (toastEl) {
                toastEl.classList.add('toast-animate-out');
                setTimeout(() => {
                    if (toastEl.parentNode)
                        toastEl.remove();
                }, 300);
            }
        }
        if (toastEl) {
            toastTimeout = setTimeout(closeToast, 3000);
            toastEl.addEventListener('mouseenter', () => clearTimeout(toastTimeout));
            toastEl.addEventListener('mouseleave', () => {
                toastTimeout = setTimeout(closeToast, 2000);
            });
        }
    </script>
    <c:remove var="toastType" scope="session" />
    <c:remove var="toastMsg" scope="session" />
</c:if>