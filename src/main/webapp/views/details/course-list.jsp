<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Explore Courses | DevLearn</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet" />
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#10B981",
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
            input[type=range] {
                -webkit-appearance: none;
                width: 100%;
                background: transparent;
            }
            input[type=range]::-webkit-slider-thumb {
                -webkit-appearance: none;
                height: 18px;
                width: 18px;
                border-radius: 50%;
                background: #10B981;
                cursor: pointer;
                margin-top: -7px;
                box-shadow: 0 0 10px rgba(16,185,129,0.4);
            }
            input[type=range]::-webkit-slider-runnable-track {
                width: 100%;
                height: 4px;
                cursor: pointer;
                background: #e2e8f0;
                border-radius: 2px;
            }
            .range-fill {
                position: absolute;
                height: 4px;
                background: linear-gradient(90deg, #10B981, #14b8a6);
                border-radius: 2px;
                pointer-events: none;
                top: 50%;
                transform: translateY(-50%);
            }
            @keyframes cardIn {
                from {
                    opacity: 0;
                    transform: translateY(24px) scale(0.97);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }
            .card-animate {
                animation: cardIn 0.4s cubic-bezier(0.22, 1, 0.36, 1) forwards;
            }
            .card-hidden {
                opacity: 0;
                transform: translateY(24px) scale(0.97);
            }
        </style>
    </head>

    <body class="font-display" style="background: linear-gradient(135deg, #f8fffc, #e6f7f1); color: #0f172a;">
        <div class="relative flex min-h-screen w-full flex-col">

            <jsp:include page="../common/header.jsp" />

            <main class="flex-1 pt-[100px]">

                <section class="pb-10">
                    <div class="max-w-canvas mx-auto px-6 lg:px-12">
                        <div class="flex gap-8">

                            <aside class="hidden lg:block w-[260px] flex-shrink-0">
                                <div class="sticky top-[100px] space-y-6">
                                    <div class="bg-white rounded-2xl border border-emerald-100 p-5 shadow-sm">
                                        <h3 class="text-xs font-bold uppercase tracking-widest text-primary mb-4 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-base">category</span> Categories
                                        </h3>
                                        <form id="categoryForm" action="${pageContext.request.contextPath}/shop" method="get">
                                            <input type="hidden" name="keyword" value="${param.keyword}" />
                                            <input type="hidden" name="maxPrice" value="${param.maxPrice}" />
                                            <input type="hidden" name="sort" value="${param.sort}" />
                                            <div class="space-y-1" id="categoryFilters">
                                                <label class="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-emerald-50 cursor-pointer transition-all group">
                                                    <input class="rounded-full border-emerald-300 text-primary focus:ring-primary/30 h-4 w-4 transition"
                                                        type="radio" name="categoryId" value="" ${empty param.categoryId ? 'checked' : '' } />
                                                    <span class="text-sm font-semibold text-slate-800 group-hover:text-primary transition-colors">All Courses</span>
                                                </label>
                                                <label class="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-emerald-50 cursor-pointer transition-all group">
                                                    <input class="rounded-full border-emerald-300 text-primary focus:ring-primary/30 h-4 w-4 transition"
                                                        type="radio" name="categoryId" value="1" ${param.categoryId=='1' ? 'checked' : '' } />
                                                    <span class="text-sm font-medium text-slate-600 group-hover:text-primary transition-colors">Software Engineering</span>
                                                </label>
                                                <label class="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-emerald-50 cursor-pointer transition-all group">
                                                    <input class="rounded-full border-emerald-300 text-primary focus:ring-primary/30 h-4 w-4 transition"
                                                        type="radio" name="categoryId" value="2" ${param.categoryId=='2' ? 'checked' : '' } />
                                                    <span class="text-sm font-medium text-slate-600 group-hover:text-primary transition-colors">Mathematics</span>
                                                </label>
                                                <label class="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-emerald-50 cursor-pointer transition-all group">
                                                    <input class="rounded-full border-emerald-300 text-primary focus:ring-primary/30 h-4 w-4 transition"
                                                        type="radio" name="categoryId" value="3" ${param.categoryId=='3' ? 'checked' : '' } />
                                                    <span class="text-sm font-medium text-slate-600 group-hover:text-primary transition-colors">Foreign Languages</span>
                                                </label>
                                                <label class="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-emerald-50 cursor-pointer transition-all group">
                                                    <input class="rounded-full border-emerald-300 text-primary focus:ring-primary/30 h-4 w-4 transition"
                                                        type="radio" name="categoryId" value="4" ${param.categoryId=='4' ? 'checked' : '' } />
                                                    <span class="text-sm font-medium text-slate-600 group-hover:text-primary transition-colors">Free Courses</span>
                                                </label>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="bg-white rounded-2xl border border-emerald-100 p-5 shadow-sm">
                                        <h3 class="text-xs font-bold uppercase tracking-widest text-primary mb-4 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-base">payments</span> Price Range
                                        </h3>
                                        <div class="px-1">
                                            <div class="relative w-full h-6 flex items-center">
                                                <div class="range-fill absolute left-0" id="rangeFill" style="width:100%;"></div>
                                                <input type="range" id="priceRange" min="0" max="${maxCoursePrice}" step="0.01"
                                                       value="${param.maxPrice != null ? param.maxPrice : maxCoursePrice}"
                                                       class="w-full absolute top-1/2 -translate-y-1/2 left-0 cursor-pointer z-10 m-0" />
                                            </div>
                                            <div class="flex justify-between items-center mt-3">
                                                <span class="text-xs font-medium text-slate-400">$0</span>
                                                <span id="priceDisplay" class="text-sm font-bold text-emerald-600 bg-emerald-50 px-3 py-1 rounded-full">
                                                    $<fmt:formatNumber value="${param.maxPrice != null ? param.maxPrice : maxCoursePrice}" minFractionDigits="2" maxFractionDigits="2" />
                                                </span>
                                                <span class="text-xs font-medium text-slate-400">
                                                    $<fmt:formatNumber value="${maxCoursePrice}" minFractionDigits="2" maxFractionDigits="2" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </aside>

                            <div class="flex-1 min-w-0">
                                <div class="flex flex-col sm:flex-row gap-4 mb-8">
                                    <form action="${pageContext.request.contextPath}/shop" method="get" class="relative group flex-1" id="searchForm">
                                        <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-xl group-focus-within:text-primary transition-colors">search</span>
                                        <input name="keyword" value="${param.keyword}" id="searchInput"
                                               class="w-full h-12 pl-12 pr-5 bg-white border border-emerald-100 rounded-2xl text-sm focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition-all shadow-sm"
                                               placeholder="Search courses..." type="text" autocomplete="off" />
                                        <div id="suggestBox" class="absolute top-full left-0 w-full bg-white border border-emerald-100 rounded-2xl shadow-xl mt-1 hidden z-50 overflow-hidden">
                                        </div>
                                    </form>
                                    <div class="flex items-center bg-white h-12 px-4 rounded-2xl border border-emerald-100 shadow-sm">
                                        <span class="material-symbols-outlined text-slate-400 text-lg mr-2">sort</span>
                                        <select id="sortSelect" onchange="updateSort(this.value)" class="bg-transparent border-none text-sm font-semibold text-slate-700 p-0 pr-6 focus:ring-0 cursor-pointer outline-none">
                                            <option value="newest" ${param.sort=='newest' ? 'selected' : '' }>Newest</option>
                                            <option value="popular" ${param.sort=='popular' ? 'selected' : '' }>Most Popular</option>
                                            <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>Price: Low → High</option>
                                            <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>Price: High → Low</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between mb-6">
                                    <p class="text-sm text-slate-500">
                                        Showing <span class="font-bold text-slate-800" id="visibleCount">${totalCourse}</span> courses
                                    </p>
                                </div>

                                <div id="courseGrid" class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                                    <c:choose>
                                        <c:when test="${empty courses}">
                                            <div class="col-span-full py-20 flex flex-col items-center justify-center text-center bg-white rounded-2xl border border-emerald-100">
                                                <span class="material-symbols-outlined text-6xl text-emerald-200 mb-4">search_off</span>
                                                <h3 class="text-lg font-bold text-slate-700 mb-1">No courses found</h3>
                                                <p class="text-slate-400 text-sm">Try different keywords or filters.</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="c" items="${courses}" varStatus="idx">
                                                <div class="course-card card-animate group flex flex-col bg-white rounded-2xl overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                     onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'"
                                                     data-cat="${c.categoryId.categoryId}"
                                                     data-price="${c.price}"
                                                     style="animation-delay: ${idx.index * 60}ms;">
                                                    <div class="aspect-[16/10] overflow-hidden relative bg-slate-50">
                                                        <img alt="${c.title}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                             src="${empty c.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-5 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span class="text-[10px] font-bold text-primary bg-primary/10 px-2.5 py-1 rounded">${empty c.categoryId.name ? 'Free Course' : c.categoryId.name}</span>
                                                        </div>
                                                        <h3 class="text-base font-bold mb-3 leading-snug group-hover:text-primary transition-colors line-clamp-2 min-h-[44px]">
                                                            ${c.title}</h3>
                                                        <div class="flex items-center gap-2 mb-4">
                                                            <div class="flex text-yellow-400">
                                                                <span class="material-symbols-outlined text-sm">star</span>
                                                                <span class="material-symbols-outlined text-sm">star</span>
                                                                <span class="material-symbols-outlined text-sm">star</span>
                                                                <span class="material-symbols-outlined text-sm">star</span>
                                                                <span class="material-symbols-outlined text-sm">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-slate-400">4.8</span>
                                                        </div>
                                                        
                                                        <div class="flex mt-auto items-center justify-between pt-3 border-t border-slate-100">
                                                            <span class="text-xl font-black text-emerald-400">
                                                                <c:choose>
 
                                                                    <c:when test="${c.price == null || c.price <= 0}">Free</c:when>
                                                                    <c:otherwise>$
                                                                        <fmt:formatNumber value="${c.price}"
                                                                                          minFractionDigits="2"
                                                                                          maxFractionDigits="2" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <%-- Action Button: Add to Cart (non-free) or Join/Enrolled (free) --%>
                                                            <c:choose>
                                                                <c:when test="${c.price == null || c.price <= 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2.5 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2.5 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2.5 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                            Join
                                                                        </button>
                                                                    </c:if>
 
                                                                </c:when>
                                                                
                                                                <%-- Khóa có phí -> Dùng Giỏ hàng --%>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
 
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               title="Add to Cart"
                                                                               class="paid-course-cart-btn group/cart p-2.5 rounded-xl border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 flex items-center justify-center"
                                                                               data-course-id="${c.courseId}">
                                                                                <span
                                                                                    class="material-symbols-outlined text-primary text-lg">shopping_cart</span>
                                                                            </a>
                                                                            <button type="button" disabled
                                                                                    onclick="event.stopPropagation()"
                                                                                    class="paid-course-enrolled-btn hidden px-4 py-2.5 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                                    data-course-id="${c.courseId}">
                                                                                Enrolled
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a onclick="event.stopPropagation()"
                                                                               href="${pageContext.request.contextPath}/login"
                                                                               title="Please login to use cart feature"
                                                                               class="group/cart p-2.5 rounded-xl border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 flex items-center justify-center">
                                                                                <span
                                                                                    class="material-symbols-outlined text-primary text-lg">shopping_cart</span>
 
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div id="pagination" class="flex justify-center items-center gap-2 mt-12">
                                    <c:if test="${totalPage > 1}">
                                        <c:if test="${currentPage > 1}">
                                            <a href="${pageContext.request.contextPath}/shop?page=${currentPage - 1}${queryParams}"
                                               class="w-10 h-10 flex items-center justify-center rounded-xl bg-white border border-emerald-200 text-slate-500 hover:bg-emerald-50 hover:text-primary hover:border-emerald-400 transition-all shadow-sm">
                                                <span class="material-symbols-outlined text-lg">chevron_left</span>
                                            </a>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <a href="${pageContext.request.contextPath}/shop?page=${i}${queryParams}"
                                               class="w-10 h-10 flex items-center justify-center rounded-xl border transition-all text-sm font-bold shadow-sm
                                               ${i == currentPage ? 'bg-gradient-to-r from-emerald-500 to-emerald-600 text-white border-emerald-500 shadow-emerald-500/20' : 'bg-white border-emerald-200 text-slate-500 hover:bg-emerald-50 hover:text-primary hover:border-emerald-400'}">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPage}">
                                            <a href="${pageContext.request.contextPath}/shop?page=${currentPage + 1}${queryParams}"
                                               class="w-10 h-10 flex items-center justify-center rounded-xl bg-white border border-emerald-200 text-slate-500 hover:bg-emerald-50 hover:text-primary hover:border-emerald-400 transition-all shadow-sm">
                                                <span class="material-symbols-outlined text-lg">chevron_right</span>
                                            </a>
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

            <footer class="bg-white border-t border-emerald-100 pt-24 pb-12 mt-12">
                <div class="max-w-canvas mx-auto px-8 lg:px-12">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-16 mb-24">
                        <div class="lg:col-span-2">
                            <div class="flex items-center gap-2 mb-8">
                                <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-[#101b0d]">
                                    <span class="material-symbols-outlined text-xl font-bold">terminal</span>
                                </div>
                                <h2 class="text-xl font-black tracking-tight">IT-LEARN</h2>
                            </div>
                            <p class="text-gray-500 text-base leading-relaxed mb-8 max-w-sm">Accompanying thousands of students on their journey to becoming professional software engineers with practical curriculum.</p>
                        </div>
                        </div>
                </div>
            </footer>
        </div>

        <jsp:include page="../common/userbuttom.jsp" />

        <script>
            (function () {
                // ... (Phần logic lọc giá/search của bạn giữ nguyên) ...
                const priceSlider = document.getElementById('priceRange');
                const priceDisplay = document.getElementById('priceDisplay');
                const rangeFill = document.getElementById('rangeFill');
                const categoryForm = document.getElementById('categoryForm');

                function fmt(v) { return '$' + Number(v).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}); }
                function updateRangeFill() {
                    if (!priceSlider || !rangeFill) return;
                    const pct = ((priceSlider.value - priceSlider.min) / (priceSlider.max - priceSlider.min)) * 100;
                    rangeFill.style.width = pct + '%';
                    if (priceDisplay) priceDisplay.textContent = fmt(priceSlider.value);
                }
                if (categoryForm) {
                    const radios = categoryForm.querySelectorAll('input[name="categoryId"]');
                    radios.forEach(radio => {
                        radio.addEventListener('change', function () {
                            const p = new URLSearchParams(window.location.search);
                            p.set('categoryId', this.value); p.set('page', '1');
                            window.location.search = p.toString();
                        });
                    });
                }
                if (priceSlider) {
                    priceSlider.addEventListener('input', updateRangeFill);
                    priceSlider.addEventListener('change', function () {
                        const p = new URLSearchParams(window.location.search);
                        p.set('maxPrice', this.value); p.set('page', '1');
                        window.location.search = p.toString();
                    });
                    updateRangeFill();
                }

                /* ── BỔ SUNG: AJAX ACTIONS (Add to cart & Enroll) ── */
                window.addToCartAjax = function(event, btnElement, courseId) {
                    event.preventDefault(); event.stopPropagation();
                    let card = btnElement.closest('.course-card');
                    let title = card.querySelector('h3').innerText;
                    let priceText = card.querySelector('.text-emerald-400').innerText;
                    let imageSrc = card.querySelector('img').src;

                    fetch('${pageContext.request.contextPath}/addToCart?id=' + courseId + '&ajax=true')
                        .then(r => r.json())
                        .then(data => {
                            if(data.status === 'success') {
                                let badge = document.querySelector('a[href*="/cart"] span.absolute');
                                if(badge) badge.innerText = data.cartSize;
                                showDynamicToast('success', 'Add successful!');
                            } else { showDynamicToast('error', data.message); }
                        });
                };

                window.enrollFreeCourseAjax = function(event, btnElement, courseId) {
                    event.preventDefault(); event.stopPropagation();
                    fetch('${pageContext.request.contextPath}/enroll?id=' + courseId + '&ajax=true')
                        .then(r => r.json())
                        .then(data => {
                            if(data.status === 'success') {
                                btnElement.innerText = 'Enrolled';
                                btnElement.classList.remove('text-primary', 'bg-emerald-500/10', 'border-emerald-500/30');
                                btnElement.classList.add('text-slate-500', 'bg-slate-100', 'border-slate-300', 'cursor-not-allowed');
                                btnElement.disabled = true;
                                showDynamicToast('success', 'Enroll successful!');
                            } else { showDynamicToast('error', data.message); }
                        });
                };

                function showDynamicToast(type, message) {
                    let old = document.getElementById('dynamicAjaxToast');
                    if(old) old.remove();
                    const toast = `
                        <div id="dynamicAjaxToast" class="fixed top-[90px] right-8 z-[100] transition-all duration-300">
                            <div class="relative bg-white border rounded-2xl px-5 py-3.5 flex items-center gap-3 shadow-xl min-w-[300px]">
                                <div class="w-6 h-6 rounded-full flex items-center justify-center text-white \${type==='success'?'bg-emerald-500':'bg-red-500'}">
                                    <span class="material-symbols-outlined text-sm">\${type==='success'?'check':'priority_high'}</span>
                                </div>
                                <span class="font-bold text-slate-700 text-sm">\${message}</span>
                            </div>
                        </div>`;
                    document.body.insertAdjacentHTML('beforeend', toast);
                    setTimeout(() => { document.getElementById('dynamicAjaxToast')?.remove(); }, 3000);
                }

                window.updateSort = function (v) {
                    const p = new URLSearchParams(window.location.search);
                    p.set('sort', v); p.set('page', '1');
                    window.location.search = p.toString();
                };

                /* ── Enrollment Logic ── */
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

                    // Loading state
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