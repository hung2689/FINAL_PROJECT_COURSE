<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US"/>
<!DOCTYPE html>
<html class="light" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Desktop Course Explorer - IT Academy</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <style type="text/tailwindcss">
            .course-card{

height:100%;

display:flex;

flex-direction:column;

}
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
                        <button ac class="px-6 py-2 rounded-full bg-primary text-[#132210] text-sm font-bold hover:bg-[#2dd111] transition-colors">
                            Đăng nhập
                        </button>
                    </div>
                </div>
            </header>
<div class="max-w-[1400px] mx-auto w-full
grid grid-cols-12 gap-4 px-6">
                <aside class=" col-span-3
 sidebar-fixed border-r-0 bg-[#fcfdfc] p-8 overflow-y-auto custom-scrollbar hidden xl:block">
                    <div class="space-y-10">
                        <div>
                            <h3 class="text-xs font-bold uppercase tracking-widest text-[#599a4c] mb-6">Danh mục</h3>
                            <form action="${pageContext.request.contextPath}/shop"
method="get">

                         <div class="space-y-2">

<label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">

<input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4"
type="checkbox" name="categoryId" value="1"/>

<span class="text-sm font-medium text-gray-700 group-hover:text-black">

Software Engineering

</span>

</label>


<label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">

<input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4"
type="checkbox" name="categoryId" value="2"/>

<span class="text-sm font-medium text-gray-700 group-hover:text-black">

Mathematics

</span>

</label>


<label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">

<input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4"
type="checkbox" name="categoryId" value="3"/>

<span class="text-sm font-medium text-gray-700 group-hover:text-black">

Foreign Languages

</span>

</label>


<label class="flex items-center gap-3 p-2 rounded-lg hover:bg-white cursor-pointer transition-all group">

<input class="rounded border-gray-300 text-primary focus:ring-primary h-4 w-4"
type="checkbox" name="categoryId" value="4"/>

<span class="text-sm font-medium text-gray-700 group-hover:text-black">

Free Courses

</span>

</label>
<button
type="submit"
class="mt-4 bg-primary text-white px-4 py-2 rounded">

Lọc khóa học

</button>

</div>

</form>
                            
   </div>            
                       
                <h3 class="text-xs font-bold uppercase tracking-widest text-[#599a4c] mb-6">

Giá khóa học

</h3>

<form action="${pageContext.request.contextPath}/shop"
method="get">

<div class="space-y-4">

<div class="px-2">

<input
type="range"
id="priceRange"
name="maxPrice"
min="0"
max="${maxCoursePrice}"
value="${param.maxPrice != null ? param.maxPrice : maxCoursePrice}"
class="w-full cursor-pointer accent-green-500">


<div class="mt-3 text-xs font-bold text-gray-500">

<span id="currentPrice"
class="block text-right">

$<fmt:formatNumber
value="${param.maxPrice != null ?
param.maxPrice :
maxCoursePrice}"
minFractionDigits="2"
maxFractionDigits="2"/>

</span>

</div>

</div>


<!-- ⭐ BUTTON -->
<button
type="submit"
class="w-full mt-4 bg-primary
text-white py-2 rounded-lg
hover:bg-[#2dd111]">

Lọc theo giá

</button>

</div>

</form>      




                        </div>
                    </div>
                </aside>
                <main class="col-span-9 pl-6 pr-2 py-8">
                    <div class="mb-12 space-y-8">
<form action="${pageContext.request.contextPath}/shop"
      method="get"
      class="relative group max-w-4xl">

<span class="material-symbols-outlined
absolute left-6 top-1/2 -translate-y-1/2
text-gray-400 text-2xl
group-focus-within:text-primary
transition-colors">

search

</span>

<input
    
name="keyword"
value="${param.keyword}"
id="searchInput"
class="w-full h-16 pl-16 pr-6 bg-white
border-2 border-[#e9f3e7]
rounded-2xl text-lg
focus:ring-4 focus:ring-primary/10
focus:border-primary
outline-none transition-all shadow-sm"

placeholder="Tìm kiếm khóa học lập trình, AI, dữ liệu..."
type="text"/>
<!-- ⭐ BOX GỢI Ý -->
<div id="suggestBox"

class="absolute top-full left-0 w-full
bg-white border border-gray-200
rounded-xl shadow-lg mt-2
hidden z-50">

</div>
</form>
                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                            <div>
                                <h2 class="text-4xl font-extrabold tracking-tight mb-2">Khám phá khóa học</h2>
                                <p class="text-[#599a4c] font-medium">Hiện có <span class="text-black font-bold">${totalCourse}</span> khóa học chất lượng dành cho bạn</p>
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
                  <div  id="courseContainer"
                      class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 2xl:grid-cols-4 gap-8 items-stretch ">

<c:choose>

<c:when test="${empty courses}">

<h2>Không có khóa học</h2>

</c:when>

<c:otherwise>
<c:forEach var="c" items="${courses}">

<div class="course-card
bg-white rounded-2xl
border border-[#e9f3e7]
overflow-hidden
flex flex-col h-full">

<div class="w-full h-44 overflow-hidden flex-shrink-0">

<img
class="w-full h-full object-cover"
src="${empty c.thumbnailUrl ?
pageContext.request.contextPath.concat('/assets/images/default-course.jpg')
: c.thumbnailUrl}"
alt="${c.title}">

</div>

<div class="p-6 flex flex-col flex-1">

<span
class="text-[10px] font-bold text-primary
bg-primary/10 px-2 py-1
rounded w-fit mb-3">

${c.categoryId.name}

</span>

<h3
class="font-bold text-lg
leading-snug
line-clamp-2
min-h-[56px]">

${c.title}

</h3>

<div
class="flex items-center justify-between
mt-auto pt-4
border-t border-gray-100">

<span class="text-xl font-black text-[#4FAF9F]">

<c:choose>

<c:when test="${c.price eq 0}">
Miễn phí
</c:when>

<c:otherwise>

$<fmt:formatNumber
value="${c.price}"
minFractionDigits="2"
maxFractionDigits="2"/>

</c:otherwise>

</c:choose>

</span>

<a href="addToCart?id=${c.courseId}"
class="p-2 rounded-lg border-2 border-primary hover:bg-primary/25 transition">

<span class="material-symbols-outlined text-primary">

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
<!-- ⭐ PAGINATION BEAUTIFUL -->
<div class="flex justify-center items-center gap-2 mt-10">

<c:if test="${totalPage > 1}">

    <!-- Previous -->
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/shop?page=${currentPage - 1}"
           class="px-4 py-2 rounded-lg border border-gray-300 hover:bg-primary hover:text-white transition">

            ←

        </a>
    </c:if>


    <!-- Page Number -->
    <c:forEach begin="1" end="${totalPage}" var="i">

        <a href="${pageContext.request.contextPath}/shop?page=${i}"

           class="px-4 py-2 rounded-lg border transition
           ${i == currentPage ?
           'bg-primary text-white border-primary font-bold'
           :
           'border-gray-300 hover:bg-primary hover:text-white'}">

            ${i}

        </a>

    </c:forEach>


    <!-- Next -->
    <c:if test="${currentPage < totalPage}">
        <a href="${pageContext.request.contextPath}/shop?page=${currentPage + 1}"

           class="px-4 py-2 rounded-lg border border-gray-300 hover:bg-primary hover:text-white transition">

            →

        </a>
    </c:if>

</c:if>

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
                        <span class="text-gray-400 text-sm ml-4">© 2026 Nền tảng học lập trình trực tuyến hàng đầu.</span>
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

<script>

const input =
document.getElementById("searchInput");

const suggestBox =
document.getElementById("suggestBox");


input.addEventListener("keyup",function(){

let keyword=this.value;

if(keyword.length===0){

suggestBox.classList.add("hidden");

return;

}

fetch(

"${pageContext.request.contextPath}/searchSuggest?keyword="
+keyword

)

.then(res=>res.json())

.then(data=>{

suggestBox.innerHTML="";

if(data.length===0){

suggestBox.classList.add("hidden");

return;

}

data.forEach(title=>{

let div=document.createElement("div");

div.className=

"px-4 py-3 hover:bg-green-100 cursor-pointer";

div.innerText=title;


// click auto search

div.onclick=function(){

input.value=title;

input.form.submit();

};

suggestBox.appendChild(div);

});

suggestBox.classList.remove("hidden");

});

});


// click ra ngoài thì ẩn

document.addEventListener("click",(e)=>{

if(!suggestBox.contains(e.target)
&& e.target!==input){

suggestBox.classList.add("hidden");

}

});

</script>
<script>

const slider =
document.getElementById("priceRange");

const priceText =
document.getElementById("currentPrice");


// format tiền đẹp
function formatMoney(x){

return "$"+
Number(x).toLocaleString(
"en-US",
{
minimumFractionDigits:2,
maximumFractionDigits:2
});

}


// load lần đầu
priceText.innerText =
formatMoney(slider.value);


// chỉ update text khi kéo
slider.addEventListener("input",function(){

priceText.innerText =
formatMoney(this.value);

});

</script>

    </body></html>