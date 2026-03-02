<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html class="light" lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Desktop Course Explorer - IT Academy</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style type="text/tailwindcss">
        :root {
            --primary: #37ec13;
            --primary-hover: #2dd111;
            --bg-main: #ffffff;
            --bg-sidebar: #fcfdfc;
            --text-main: #101b0d;
        }
        body {
            font-family: "Inter", sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
        }
        .custom-scrollbar::-webkit-scrollbar { width: 4px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #d3e7cf; border-radius: 10px; }
        
        .course-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .course-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }
        .sidebar-fixed {
            height: calc(100vh - 73px);
            position: sticky;
            top: 73px;
        }
        
        /* Custom range slider */
        input[type=range] {
            -webkit-appearance: none;
            width: 100%;
            background: transparent;
        }
        input[type=range]::-webkit-slider-thumb {
            -webkit-appearance: none;
            height: 16px;
            width: 16px;
            border-radius: 50%;
            background: var(--primary);
            cursor: pointer;
            margin-top: -6px;
        }
        input[type=range]::-webkit-slider-runnable-track {
            width: 100%;
            height: 4px;
            cursor: pointer;
            background: #e5e7eb;
            border-radius: 2px;
        }
        .range-progress {
            position: absolute;
            height: 4px;
            background: var(--primary);
            border-radius: 2px;
            pointer-events: none;
        }
    </style>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#37ec13",
                    },
                },
            },
        }
    </script>
</head>
<body class="min-h-screen">
    <div class="flex flex-col">
        <header class="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-gray-100 px-8 py-4">
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
                        <a class="text-sm font-medium text-gray-600 hover:text-primary transition-colors" href="#">Lộ trình</a>
                        <a class="text-sm font-medium text-gray-600 hover:text-primary transition-colors" href="#">Cộng đồng</a>
                        <a class="text-sm font-medium text-gray-600 hover:text-primary transition-colors" href="#">Giảng viên</a>
                    </nav>
                </div>
                <div class="flex items-center gap-6">
                    <button class="flex items-center gap-2 text-sm font-medium text-gray-600 hover:text-primary">
                        <span class="material-symbols-outlined text-xl">shopping_cart</span>
                        <span>Giỏ hàng</span>
                    </button>
                    <button class="px-6 py-2 rounded-full bg-primary text-white text-sm font-bold hover:bg-[#2dd111] transition-colors shadow-sm">
                        Đăng nhập
                    </button>
                </div>
            </div>
        </header>

        <div class="max-w-[1600px] mx-auto w-full grid grid-cols-12 gap-6 px-6">
            <aside class="col-span-3 sidebar-fixed bg-white py-8 pr-6 overflow-y-auto custom-scrollbar hidden xl:block">
                <form action="${pageContext.request.contextPath}/shop" method="get" id="filterForm">
                    <div class="mb-8">
    <h3 class="text-xs font-bold uppercase tracking-widest text-primary mb-4">Danh mục</h3>
    <form action="${pageContext.request.contextPath}/shop" method="get">
        <div class="space-y-1">
            <label class="flex items-center gap-3 p-2 -ml-2 rounded-lg hover:bg-green-50 cursor-pointer transition-all group">
                <input id="checkAllCat" class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox"/>
                <span class="text-sm font-medium text-gray-900 group-hover:text-black">ALL </span>
            </label>
            <label class="flex items-center gap-3 p-2 -ml-2 rounded-lg hover:bg-green-50 cursor-pointer transition-all group">
                <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox" name="categoryId" value="1"/>
                <span class="text-sm font-medium text-gray-600 group-hover:text-black">Software Engineering</span>
            </label>

            <label class="flex items-center gap-3 p-2 -ml-2 rounded-lg hover:bg-green-50 cursor-pointer transition-all group">
                <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox" name="categoryId" value="2"/>
                <span class="text-sm font-medium text-gray-600 group-hover:text-black">Mathematics</span>
            </label>

            <label class="flex items-center gap-3 p-2 -ml-2 rounded-lg hover:bg-green-50 cursor-pointer transition-all group">
                <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox" name="categoryId" value="3"/>
                <span class="text-sm font-medium text-gray-600 group-hover:text-black">Foreign Languages</span>
            </label>

            <label class="flex items-center gap-3 p-2 -ml-2 rounded-lg hover:bg-green-50 cursor-pointer transition-all group">
                <input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4" type="checkbox" name="categoryId" value="4"/>
                <span class="text-sm font-medium text-gray-600 group-hover:text-black">Free Courses</span>
            </label>

            <button type="submit" class="mt-4 w-full bg-primary text-white px-4 py-2.5 rounded-lg text-sm font-medium hover:bg-[#2dd111] transition-colors shadow-sm">
                Lọc khóa học
            </button>
        </div>
    </form>
</div>

              
      <div class="mb-8">
    <h3 class="text-xs font-bold uppercase tracking-widest text-primary mb-4">Giá khóa học</h3>
    
    <form action="${pageContext.request.contextPath}/shop" method="get">
        <div class="mb-6 px-1">
            
            <div class="relative w-full h-6 flex items-center">
                <div class="range-progress z-0 absolute left-0" id="rangeProgress" style="width: 100%; top: 50%; transform: translateY(-50%);"></div>
                
                <input 
                    type="range" 
                    id="priceRange" 
                    name="maxPrice" 
                    min="0" 
                    max="${maxCoursePrice}"
                    step="0.01"
                    value="${param.maxPrice != null ? param.maxPrice : maxCoursePrice}" 
                    class="w-full absolute top-1/2 -translate-y-1/2 left-0 cursor-pointer z-10 m-0"
                >
            </div>

            <div class="flex justify-between items-center mt-2 text-xs font-medium text-gray-500">
                <span>$0.00</span>
                
                <span id="currentPrice" class="font-bold text-gray-800 text-[14px]">
                    $<fmt:formatNumber 
                        value="${param.maxPrice != null ? param.maxPrice : maxCoursePrice}" 
                        minFractionDigits="2" 
                        maxFractionDigits="2"/>
                </span>
                
                <span>
                    $<fmt:formatNumber 
                        value="${maxCoursePrice}" 
                        minFractionDigits="2" 
                        maxFractionDigits="2"/>
                </span>
            </div>
            
        </div>

       
    </form>
</div>

                    <button type="submit" class="w-full bg-primary text-white py-2.5 rounded-lg hover:bg-[#2dd111] font-medium transition hidden">
                        Lọc kết quả
                    </button>
                </form>
            </aside>
<main class="col-span-12 xl:col-span-9 py-8">
<form action="${pageContext.request.contextPath}/shop" method="get" class="relative group w-full">
        <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-gray-400 text-2xl group-focus-within:text-primary transition-colors">
            search
        </span>
        <input 
            name="keyword" 
            value="${param.keyword}" 
            id="searchInput" 
            class="w-full h-[52px] pl-14 pr-6 bg-white border border-gray-200 rounded-xl text-[15px] focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition-all shadow-sm" 
            placeholder="Tìm kiếm khóa học lập trình, AI, dữ liệu..." 
            type="text"
            autocomplete="off"
        />
        <div id="suggestBox" class="absolute top-full left-0 w-full bg-white border border-gray-200 rounded-xl shadow-lg mt-1 hidden z-50 overflow-hidden">
        </div>
    </form>

    <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
        <div>
            <h2 class="text-[32px] font-extrabold tracking-tight mb-1 text-gray-900">Khám phá khóa học</h2>
            <p class="text-[#599a4c] font-medium text-[15px]">Hiện có <span class="text-black font-bold">${totalCourse}</span> khóa học chất lượng dành cho bạn</p>
        </div>
        
  <div class="flex items-center">
        <div class="flex items-center bg-white px-4 py-2.5 rounded-xl border border-gray-200 shadow-sm hover:border-gray-300 transition-colors focus-within:ring-2 focus-within:ring-primary/20 focus-within:border-primary">
            <span class="text-[11px] font-bold text-gray-400 uppercase tracking-wider mr-2 whitespace-nowrap">Sắp xếp theo:</span>
            
            <select id="sortSelect" onchange="updateSort(this.value)" class="bg-transparent border-none text-[14px] font-semibold text-gray-800 p-0 pr-7 focus:ring-0 cursor-pointer outline-none appearance-none bg-no-repeat bg-right" style="background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%20viewBox%3D%220%200%2024%2024%22%20fill%3D%22none%22%20stroke%3D%22%234b5563%22%20stroke-width%3D%222%22%20stroke-linecap%3D%22round%22%20stroke-linejoin%3D%22round%22%3E%3Cpolyline%20points%3D%226%209%2012%2015%2018%209%22%3E%3C%2Fpolyline%3E%3C%2Fsvg%3E'); background-size: 16px;">
                <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                <option value="popular" ${param.sort == 'popular' ? 'selected' : ''}>Phổ biến nhất</option>
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Giá: Thấp đến Cao</option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Giá: Cao đến Thấp</option>
            </select>
        </div>
    </div>
    </div>

    <div id="courseContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 items-stretch">
        <c:choose>
            <c:when test="${empty courses}">
                <div class="col-span-full py-16 flex flex-col items-center justify-center text-center bg-white rounded-2xl border border-gray-100">
                    <span class="material-symbols-outlined text-6xl text-gray-300 mb-4">search_off</span>
                    <h3 class="text-lg font-bold text-gray-700">Không tìm thấy khóa học nào</h3>
                    <p class="text-gray-500 mt-1">Vui lòng thử lại với từ khóa hoặc bộ lọc khác.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${courses}">
                    <div class="course-card bg-white rounded-2xl border border-gray-100 overflow-hidden flex flex-col h-full">
                        <div class="w-full h-40 overflow-hidden flex-shrink-0 bg-gray-50 relative">
                            <img class="w-full h-full object-cover" 
                                 src="${empty c.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : c.thumbnailUrl}" 
                                 alt="${c.title}">
                        </div>
                        <div class="p-5 flex flex-col flex-1">
                            <span class="text-[11px] font-bold text-primary bg-green-50 px-2.5 py-1 rounded-md w-fit mb-3">
                                ${empty c.categoryId.name ? 'Free Course' : c.categoryId.name}
                            </span>
                            <h3 class="font-bold text-[15px] text-gray-900 leading-snug line-clamp-2 min-h-[44px]">
                                ${c.title}
                            </h3>
                            <div class="flex items-center justify-between mt-auto pt-4 border-t border-gray-50">
                                <span class="text-lg font-bold text-primary">
                                    <c:choose>
                                        <c:when test="${c.price eq 0}">
                                            Miễn phí
                                        </c:when>
                                        <c:otherwise>
                                            $<fmt:formatNumber value="${c.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <a href="addToCart?id=${c.courseId}" class="p-1.5 rounded-md border-2 border-primary hover:bg-green-50 transition group flex items-center justify-center">
                                    <span class="material-symbols-outlined text-primary text-[20px] group-hover:scale-110 transition-transform">
                                        shopping_cart
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
   <c:set var="queryParams" value=""/>
    <c:if test="${not empty param.keyword}">
        <c:set var="queryParams" value="${queryParams}&keyword=${param.keyword}"/>
    </c:if>
    <c:if test="${not empty param.maxPrice}">
        <c:set var="queryParams" value="${queryParams}&maxPrice=${param.maxPrice}"/>
    </c:if>
    <c:if test="${not empty param.categoryId}">
        <c:set var="queryParams" value="${queryParams}&categoryId=${param.categoryId}"/>
    </c:if>
    <c:if test="${not empty param.sort}">
        <c:set var="queryParams" value="${queryParams}&sort=${param.sort}"/>
    </c:if>
  
    <div class="flex justify-center items-center gap-1.5 mt-12">
        <c:if test="${totalPage > 1}">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/shop?page=${currentPage - 1}${queryParams}" class="w-8 h-8 flex items-center justify-center rounded border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-primary transition text-sm">
                    &larr;
                </a>
            </c:if>

            <c:forEach begin="1" end="${totalPage}" var="i">
                <a href="${pageContext.request.contextPath}/shop?page=${i}${queryParams}" 
                   class="w-8 h-8 flex items-center justify-center rounded border transition text-sm font-medium
                   ${i == currentPage ? 'bg-primary text-white border-primary shadow-sm' : 'border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-primary'}">
                    ${i}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPage}">
                <a href="${pageContext.request.contextPath}/shop?page=${currentPage + 1}${queryParams}" class="w-8 h-8 flex items-center justify-center rounded border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-primary transition text-sm">
                    &rarr;
                </a>
            </c:if>
        </c:if>
    </div>
</main>
     
        </div>
    </div>
    <footer class="border-t border-gray-200 bg-white px-8 py-10 mt-auto">
    <div class="max-w-[1600px] mx-auto flex flex-col md:flex-row justify-between items-center gap-8">
        <div class="flex items-center gap-3">
            <div class="size-6 text-primary">
                <svg fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                    <path d="M4 4H17.3334V17.3334H30.6666V30.6666H44V44H4V4Z" fill="currentColor"></path>
                </svg>
            </div>
            <span class="font-bold text-gray-900 text-lg">IT Academy</span>
            <span class="hidden sm:inline text-gray-400 text-sm ml-4">© 2026 Nền tảng học lập trình trực tuyến hàng đầu.</span>
        </div>
        
        <div class="flex flex-wrap justify-center gap-6 md:gap-8 text-sm font-medium text-gray-500">
            <a class="hover:text-primary transition-colors" href="#">Điều khoản</a>
            <a class="hover:text-primary transition-colors" href="#">Bảo mật</a>
            <a class="hover:text-primary transition-colors" href="#">Liên hệ</a>
            <a class="hover:text-primary transition-colors" href="#">Trợ giúp</a>
        </div>

        <span class="sm:hidden text-gray-400 text-xs text-center">© 2026 IT Academy.</span>
    </div>
</footer>
<script>
    // ==========================================
    // 1. XỬ LÝ SLIDER GIÁ (PRICE RANGE) TỰ ĐỘNG LỌC
    // ==========================================
    const slider = document.getElementById("priceRange");
    const priceText = document.getElementById("currentPrice");
    const rangeProgress = document.getElementById("rangeProgress");

    function formatMoney(x) {
        return "$" + Number(x).toLocaleString("en-US", {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    function updateSliderUI() {
        if(!slider) return;
        const min = slider.min || 0;
        const max = slider.max || 100;
        const val = slider.value;
        
        if (rangeProgress && max > min) {
            const percentage = ((val - min) / (max - min)) * 100;
            rangeProgress.style.width = percentage + "%";
        }
        if(priceText) {
            priceText.innerText = formatMoney(val);
        }
    }

    if(slider) {
        slider.addEventListener("input", updateSliderUI);
        slider.addEventListener("change", function() {
            this.form.submit(); 
        });
        updateSliderUI();
    }

    // ==========================================
    // 2. XỬ LÝ THANH TÌM KIẾM (SEARCH SUGGEST)
    // ==========================================
    const input = document.getElementById("searchInput");
    const suggestBox = document.getElementById("suggestBox");

    if(input && suggestBox) {
        input.addEventListener("keyup", function() {
            let keyword = this.value.trim();
            if (keyword.length === 0) {
                suggestBox.classList.add("hidden");
                return;
            }
            
            fetch("${pageContext.request.contextPath}/searchSuggest?keyword=" + encodeURIComponent(keyword))
            .then(res => res.json())
            .then(data => {
                suggestBox.innerHTML = ""; 
                if (data.length === 0) {
                    suggestBox.classList.add("hidden");
                    return;
                }
                data.forEach(title => {
                    let div = document.createElement("div");
                    div.className = "px-4 py-3 hover:bg-green-50 cursor-pointer text-sm font-medium text-gray-700 border-b border-gray-50 last:border-0 transition-colors";
                    div.innerText = title;
                    div.onclick = function() {
                        input.value = title;
                        input.form.submit();
                    };
                    suggestBox.appendChild(div);
                });
                suggestBox.classList.remove("hidden");
            })
            .catch(err => console.error("Lỗi fetch search suggest:", err));
        });

        // Click ra ngoài thì ẩn box gợi ý
        document.addEventListener("click", (e) => {
            if (!suggestBox.contains(e.target) && e.target !== input) {
                suggestBox.classList.add("hidden");
            }
        });
    }

    // ==========================================
    // 3. XỬ LÝ SẮP XẾP KHÓA HỌC (SORT)
    // ==========================================
    function updateSort(sortValue) {
        const urlParams = new URLSearchParams(window.location.search);
        urlParams.set('sort', sortValue);
        urlParams.set('page', '1'); // Đưa về trang 1 khi đổi sắp xếp
        window.location.search = urlParams.toString();
    }
</script>

</body>
</html>