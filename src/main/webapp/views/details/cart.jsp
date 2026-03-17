<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Shopping Cart | DevLearn</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
        rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
        rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { "primary": "#10B981" },
                    fontFamily: { "display": ["Inter", "sans-serif"] }
                }
            }
        }
    </script>
    <style>
        body {
            font-family: "Inter", sans-serif;
            background: #f8fffc;
        }

        .toggle-checkbox:checked {
            right: 0;
            border-color: #10B981;
        }

 
                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(24px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
                    .animate-card {
                        animation: fadeInUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) both;
                    }
                    .animate-delay-1 { animation-delay: 0.08s; }
                    .animate-delay-2 { animation-delay: 0.18s; }
                </style>
            </head>

            <body class="text-slate-800 flex flex-col min-h-screen">

                <jsp:include page="../common/header.jsp" />

                <main class="flex-grow pt-[120px] pb-20">
                    <div class="max-w-[1200px] mx-auto px-6 lg:px-12">

                        <h1 class="text-3xl font-black tracking-tight mb-8 animate-card">Shopping Cart</h1>
                        <c:set var="totalPrice" value="0" />

                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                            <div class="lg:col-span-2 space-y-6 animate-card animate-delay-1">
                                <c:choose>
                                    <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
                                        <div
                                            class="flex flex-col items-center justify-center py-24 bg-[#0B1120]/5 rounded-2xl border border-slate-200/50 shadow-sm text-center">
                                            <div class="relative mb-4">
                                                <span
                                                    class="material-symbols-outlined text-[80px] text-slate-300">inbox</span>
                                                <div
                                                    class="absolute -top-2 -right-3 bg-slate-200 rounded-full w-8 h-8 flex items-center justify-center">
                                                    <span
                                                        class="material-symbols-outlined text-[16px] text-white">more_horiz</span>
                                                </div>
                                            </div>
                                            <p class="text-slate-400 text-sm mb-4">No data</p>
                                            <h2 class="text-xl font-bold text-slate-700 mb-8">Your cart is empty</h2>
                                            <a href="${pageContext.request.contextPath}/shop"
                                                class="px-8 py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-emerald-600 transition-colors shadow-lg shadow-emerald-500/30">
                                                Explore Courses
                                            </a>
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <h2 class="text-lg font-bold">Cart (${sessionScope.cartSize} items)</h2>
                                        <c:forEach var="entry" items="${sessionScope.cart}">
                                            <c:set var="course" value="${entry.value}" />
                                            <c:set var="totalPrice" value="${totalPrice + course.price}" />

                                            <div
                                                class="flex flex-col sm:flex-row gap-6 p-5 bg-white rounded-2xl border border-emerald-100 shadow-sm hover:shadow-md transition-shadow relative group">
                                                <div
                                                    class="w-full sm:w-40 aspect-video sm:aspect-square flex-shrink-0 bg-slate-50 rounded-xl overflow-hidden relative">
                                                    <img src="${empty course.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : course.thumbnailUrl}"
                                                        alt="course" class="w-full h-full object-cover">
                                                </div>
                                                <div class="flex flex-col flex-grow">
                                                    <div class="flex justify-between items-start">
                                                        <div>
                                                            <h3
                                                                class="text-lg font-bold leading-tight mb-1 pr-10 text-slate-900">
                                                                ${course.title}</h3>
                                                            <p class="text-[13px] text-slate-500 mb-1">Instructor: <span
                                                                    class="text-primary font-medium">DevLearn
                                                                    Expert</span></p>
                                                            <div class="flex items-center text-yellow-400 mb-3">
                                                                <span
                                                                    class="text-[13px] font-bold text-slate-700 mr-1 mt-0.5">4.5</span>
                                                                <span class="material-symbols-outlined"
                                                                    style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                    style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                    style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                    style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                                <span class="material-symbols-outlined"
                                                                    style="font-size: 15px; font-variation-settings: 'FILL' 1;">star_half</span>
                                                            </div>
                                                        </div>
                                                        <span class="text-lg font-black text-slate-900">
                                                            <c:choose>
                                                                <c:when test="${course.price == null || course.price <= 0}">Free</c:when>
                                                                <c:otherwise>$
                                                                    <fmt:formatNumber value="${course.price}"
                                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </div>
 

<body class="text-slate-800 flex flex-col min-h-screen">

    <jsp:include page="../common/header.jsp" />

    <main class="flex-grow pt-[120px] pb-20">
        <div class="max-w-[1200px] mx-auto px-6 lg:px-12">

            <h1 class="text-3xl font-black tracking-tight mb-8">Shopping Cart</h1>
            <c:set var="totalPrice" value="0" />

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <div class="lg:col-span-2 space-y-6">
                    <c:choose>
                        <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
                            <div class="flex flex-col items-center justify-center py-24 bg-[#0B1120]/5 rounded-2xl border border-slate-200/50 shadow-sm text-center">
                                <div class="relative mb-4">
                                    <span class="material-symbols-outlined text-[80px] text-slate-300">inbox</span>
                                    <div class="absolute -top-2 -right-3 bg-slate-200 rounded-full w-8 h-8 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-[16px] text-white">more_horiz</span>
                                    </div>
                                </div>
                                <p class="text-slate-400 text-sm mb-4">No data</p>
                                <h2 class="text-xl font-bold text-slate-700 mb-8">Your cart is empty</h2>
                                <a href="${pageContext.request.contextPath}/shop"
                                    class="px-8 py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-emerald-600 transition-colors shadow-lg shadow-emerald-500/30">
                                    Explore Courses
                                </a>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <h2 class="text-lg font-bold">Cart (${sessionScope.cartSize} items)</h2>
                            <c:forEach var="entry" items="${sessionScope.cart}">
                                <c:set var="course" value="${entry.value}" />
                                <c:set var="totalPrice" value="${totalPrice + course.price}" />

                                <div class="flex flex-col sm:flex-row gap-6 p-5 bg-white rounded-2xl border border-emerald-100 shadow-sm hover:shadow-md transition-shadow relative group">
                                    <div class="w-full sm:w-40 aspect-video sm:aspect-square flex-shrink-0 bg-slate-50 rounded-xl overflow-hidden relative">
                                        <img src="${empty course.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : course.thumbnailUrl}"
                                            alt="course" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex flex-col flex-grow">
                                        <div class="flex justify-between items-start">
                                            <div>
                                                <h3 class="text-lg font-bold leading-tight mb-1 pr-10 text-slate-900">${course.title}</h3>
                                                <p class="text-[13px] text-slate-500 mb-1">Instructor: <span class="text-primary font-medium">DevLearn Expert</span></p>
                                                <div class="flex items-center text-yellow-400 mb-3">
                                                    <span class="text-[13px] font-bold text-slate-700 mr-1 mt-0.5">4.5</span>
                                                    <span class="material-symbols-outlined" style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                    <span class="material-symbols-outlined" style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                    <span class="material-symbols-outlined" style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                    <span class="material-symbols-outlined" style="font-size: 15px; font-variation-settings: 'FILL' 1;">star</span>
                                                    <span class="material-symbols-outlined" style="font-size: 15px; font-variation-settings: 'FILL' 1;">star_half</span>
                                                </div>
                                            </div>
                                            <span class="text-lg font-black text-slate-900">
                                                <c:choose>
                                                    <c:when test="${course.price eq 0}">Free</c:when>
                                                    <c:otherwise>$<fmt:formatNumber value="${course.price}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="absolute bottom-5 right-5 delete-container">
                                        <button type="button" onclick="toggleDeletePopup('popup-${course.courseId}')"
                                            class="text-slate-300 hover:text-red-500 transition-colors focus:outline-none">
                                            <span class="material-symbols-outlined text-[24px]">delete</span>
                                        </button>
                                        <div id="popup-${course.courseId}" class="hidden absolute bottom-full right-0 mb-3 w-[300px] bg-white rounded-xl shadow-[0_10px_40px_-10px_rgba(0,0,0,0.25)] border border-slate-100 p-4 z-50 transform origin-bottom-right transition-all">
                                            <div class="absolute -bottom-2 right-2 w-4 h-4 bg-white border-b border-r border-slate-100 transform rotate-45"></div>
                                            <div class="relative z-10">
                                                <div class="flex items-center gap-2 mb-4">
                                                    <span class="material-symbols-outlined text-red-500 text-[24px]">help</span>
                                                    <p class="text-[15px] font-medium text-slate-700 m-0">Remove this course from cart?</p>
                                                </div>
                                                <div class="flex justify-end gap-2">
                                                    <button type="button" onclick="toggleDeletePopup('popup-${course.courseId}')"
                                                        class="px-4 py-1.5 bg-white border border-slate-200 text-slate-600 text-[14px] rounded-lg hover:bg-slate-50 transition-colors focus:outline-none">No</button>
                                                    <a href="${pageContext.request.contextPath}/removeFromCart?id=${course.courseId}"
                                                        class="px-5 py-1.5 bg-blue-500 text-white text-[14px] rounded-lg hover:bg-blue-600 font-medium transition-colors"
                                                        style="text-decoration:none;">Yes</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="lg:col-span-1">
                    <div class="sticky top-[120px] bg-white p-6 rounded-2xl border border-emerald-100 shadow-[0_8px_30px_rgb(0,0,0,0.04)]">
                        <div class="flex justify-between items-end mb-6 pb-6 border-b border-slate-100">
                            <span class="text-lg font-bold text-slate-700">Total:</span>
                            <span class="text-2xl font-black text-slate-900">
                                $<fmt:formatNumber value="${totalPrice}" minFractionDigits="2" maxFractionDigits="2" />
                            </span>
                        </div>

                        <div class="mb-6">
                            <label class="block text-[13px] font-bold text-slate-700 mb-2">Promo Code</label>
                            <div class="flex gap-2">
                                <input type="text" placeholder="Enter promo code"
                                    class="w-full bg-slate-50 border border-slate-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition-all">
                                <button class="bg-slate-800 text-white px-5 py-2.5 rounded-lg text-sm font-bold hover:bg-slate-700 whitespace-nowrap transition-colors">Apply</button>
                            </div>
                        </div>

                        <div class="flex items-center justify-between mb-8 pb-6 border-b border-slate-100">
                            <div>
                                <p class="text-[13px] font-bold text-slate-700">Use Reward Points: 0</p>
                                <p class="text-[11px] text-slate-400 mt-0.5">Total: 0 pts <span class="ml-1">(100 pts = $1.00)</span></p>
                            </div>
                            <div class="relative inline-block w-10 mr-2 align-middle select-none transition duration-200 ease-in">
                                <input type="checkbox" name="toggle" id="toggle"
                                    class="toggle-checkbox absolute block w-5 h-5 rounded-full bg-white border-4 appearance-none cursor-pointer transition-transform duration-200 ease-in-out z-10 top-0 left-0 border-slate-300" />
                                <label for="toggle" class="toggle-label block overflow-hidden h-5 rounded-full bg-slate-300 cursor-pointer transition-colors duration-200 ease-in-out"></label>
                            </div>
                        </div>


                        <c:if test="${not empty suggestedCourses}">
                            <div class="mt-20 pt-10 border-t border-slate-100">
                                <div class="flex items-center justify-between mb-8">
                                    <h2 class="text-2xl font-black">Suggested Courses</h2>
                                </div>
                                <div class="relative group/slider">
                                    <button id="btnSlideLeft"
                                        class="absolute -left-5 top-1/2 -translate-y-1/2 w-11 h-11 bg-white rounded-full flex items-center justify-center text-slate-400 hover:text-primary shadow-[0_4px_15px_rgba(0,0,0,0.1)] border border-slate-100 z-10 opacity-0 group-hover/slider:opacity-100 transition-all duration-300 transform scale-90 hover:scale-110">
                                        <span class="material-symbols-outlined text-[24px]">chevron_left</span>
                                    </button>
                                    <div id="suggestedSlider"
                                        class="flex gap-6 overflow-x-auto snap-x snap-mandatory pb-6"
                                        style="scrollbar-width: none; -ms-overflow-style: none;">
                                        <style>
                                            #suggestedSlider::-webkit-scrollbar {
                                                display: none;
                                            }
                                        </style>
                                        <c:forEach var="sc" items="${suggestedCourses}">
                                            <div
                                                class="snap-start flex-shrink-0 w-full sm:w-[calc(50%-12px)] lg:w-[calc(25%-18px)]">
                                                <div
                                                    class="bg-white rounded-2xl border border-emerald-100 overflow-hidden hover:-translate-y-1 hover:shadow-lg transition-all duration-300 flex flex-col group h-full">
                                                    <a href="${pageContext.request.contextPath}/course?id=${sc.courseId}"
                                                        class="aspect-video bg-slate-100 relative overflow-hidden block">
                                                        <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                            src="${empty sc.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : sc.thumbnailUrl}"
                                                            alt="${sc.title}">
                                                    </a>
                                                    <div class="p-5 flex flex-col flex-1">
                                                        <a href="${pageContext.request.contextPath}/course?id=${sc.courseId}"
                                                            class="font-bold text-[14px] leading-snug mb-2 line-clamp-2 text-slate-900 hover:text-primary transition-colors"
                                                            style="text-decoration:none;">${sc.title}</a>
                                                        <div class="flex items-center text-yellow-400 mb-4">
                                                            <span
                                                                class="text-[12px] text-slate-600 font-bold mr-1">5.0</span>
                                                            <span class="material-symbols-outlined text-[13px]"
                                                                style="font-variation-settings: 'FILL' 1;">star</span>
                                                            <span class="text-[11px] text-slate-400 ml-1">(0)</span>
                                                        </div>
                                                        <div class="flex justify-between items-end mt-auto">
                                                            <div>
                                                                <p class="text-primary font-black text-lg">
                                                                    <c:choose>
                                                                        <c:when test="${sc.price == null || sc.price <= 0}">Free</c:when>
                                                                        <c:otherwise>$
                                                                            <fmt:formatNumber value="${sc.price}"
                                                                                minFractionDigits="2"
                                                                                maxFractionDigits="2" />
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                            </div>
                                                            <%-- Add to Cart: logged-in → real action | guest → redirect
                                                                to login --%>
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.USER != null}">
                                                                        <a href="${pageContext.request.contextPath}/addToCart?id=${sc.courseId}"
                                                                            class="w-8 h-8 rounded-lg border border-primary text-primary flex items-center justify-center hover:bg-emerald-50 transition-colors"
                                                                            title="Add to Cart">
                                                                            <span
                                                                                class="material-symbols-outlined text-[18px]">add_shopping_cart</span>
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="${pageContext.request.contextPath}/login"
                                                                            class="w-8 h-8 rounded-lg border border-primary text-primary flex items-center justify-center hover:bg-emerald-50 transition-colors"
                                                                            title="Please login to use cart feature">
                                                                            <span
                                                                                class="material-symbols-outlined text-[18px]">add_shopping_cart</span>
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                        </div>

                                                    </div>
                                                    <c:choose>
                                                        <c:when test="${sessionScope.USER != null}">
                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${sc.courseId}"
                                                                class="w-8 h-8 rounded-lg border border-primary text-primary flex items-center justify-center hover:bg-emerald-50 transition-colors" title="Add to Cart">
                                                                <span class="material-symbols-outlined text-[18px]">add_shopping_cart</span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/login"
                                                                class="w-8 h-8 rounded-lg border border-primary text-primary flex items-center justify-center hover:bg-emerald-50 transition-colors" title="Please login to use cart feature">
                                                                <span class="material-symbols-outlined text-[18px]">add_shopping_cart</span>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <button id="btnSlideRight"
                                class="absolute -right-5 top-[40%] -translate-y-1/2 w-11 h-11 bg-white rounded-full flex items-center justify-center text-slate-400 hover:text-primary shadow-[0_4px_15px_rgba(0,0,0,0.1)] border border-slate-100 z-10 transition-all duration-300 transform scale-90 hover:scale-110 opacity-0 pointer-events-none">
                                <span class="material-symbols-outlined text-[24px]">chevron_right</span>
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="w-full bg-red-50 border border-red-200 text-red-600 rounded-xl p-6 text-center shadow-sm">
                            <span class="material-symbols-outlined text-4xl mb-2">error</span>
                            <h3 class="font-bold text-lg mb-1">Không nhận được dữ liệu khóa học!</h3>
                            <p class="text-sm text-red-500 max-w-lg mx-auto">
                                Biến <strong>suggestedCourses</strong> đang bị null. Hãy đảm bảo bạn truy cập trang này qua Servlet (VD: <em>http://localhost:8080/ten-project/cart</em>), không được chạy trực tiếp file JSP trên trình duyệt. Nếu đã chạy qua Servlet, hãy kiểm tra lại kết nối Database.
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </main>

    <script>
        // Xử lý Popup xóa sản phẩm trong giỏ hàng
        function toggleDeletePopup(popupId) {
            document.querySelectorAll('[id^="popup-"]').forEach(p => { if (p.id !== popupId) p.classList.add('hidden'); });
            const popup = document.getElementById(popupId);
            if (popup) popup.classList.toggle('hidden');
        }
        document.addEventListener('click', function (e) { 
            if (!e.target.closest('.delete-container')) { 
                document.querySelectorAll('[id^="popup-"]').forEach(p => p.classList.add('hidden')); 
            } 
        });

        // Xử lý Slider cho mục Suggested Courses
        document.addEventListener('DOMContentLoaded', function () {
            const slider = document.getElementById('suggestedSlider');
            const btnLeft = document.getElementById('btnSlideLeft');
            const btnRight = document.getElementById('btnSlideRight');

            if (slider && btnLeft && btnRight) {
                const updateButtons = () => {
                    const maxScrollLeft = slider.scrollWidth - slider.clientWidth;
                    
                    if (slider.scrollLeft <= 5) {
                        btnLeft.classList.add('opacity-0', 'pointer-events-none');
                        btnLeft.classList.remove('opacity-100');
                    } else {
                        btnLeft.classList.remove('opacity-0', 'pointer-events-none');
                        btnLeft.classList.add('opacity-100');
                    }

                    if (Math.ceil(slider.scrollLeft) >= maxScrollLeft - 5) {
                        btnRight.classList.add('opacity-0', 'pointer-events-none');
                        btnRight.classList.remove('opacity-100');
                    } else {
                        btnRight.classList.remove('opacity-0', 'pointer-events-none');
                        btnRight.classList.add('opacity-100');
                    }
                };

                btnRight.addEventListener('click', function (e) { 
                    e.preventDefault(); 
                    const scrollAmount = slider.children[0].clientWidth + 24; 
                    slider.scrollBy({ left: scrollAmount, behavior: 'smooth' }); 
                });

                btnLeft.addEventListener('click', function (e) { 
                    e.preventDefault(); 
                    const scrollAmount = slider.children[0].clientWidth + 24; 
                    slider.scrollBy({ left: -scrollAmount, behavior: 'smooth' }); 
                });

                let isDown = false;
                let startX;
                let scrollLeft;

                slider.addEventListener('mousedown', (e) => {
                    isDown = true;
                    slider.classList.remove('scroll-smooth', 'snap-x', 'snap-mandatory'); 
                    startX = e.pageX - slider.offsetLeft;
                    scrollLeft = slider.scrollLeft;
                });

                slider.addEventListener('mouseleave', () => {
                    isDown = false;
                    slider.classList.add('scroll-smooth', 'snap-x', 'snap-mandatory');
                });

                slider.addEventListener('mouseup', () => {
                    isDown = false;
                    slider.classList.add('scroll-smooth', 'snap-x', 'snap-mandatory');
                });

                slider.addEventListener('mousemove', (e) => {
                    if (!isDown) return;
                    e.preventDefault();
                    const x = e.pageX - slider.offsetLeft;
                    const walk = (x - startX) * 2;
                    slider.scrollLeft = scrollLeft - walk;
                });

                slider.addEventListener('scroll', updateButtons);
                window.addEventListener('resize', updateButtons);
                setTimeout(updateButtons, 100);
            }
        });
    </script>
     <jsp:include page="../common/footer.jsp" />
</body>
</html>