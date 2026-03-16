<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>My Courses – DevLearn</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <style>
        body { font-family: 'Inter', sans-serif; }
        .course-card { transition: transform 0.3s ease; }
        .course-card:hover { transform: translateY(-4px); }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-card {
            animation: fadeInUp 0.5s ease-out backwards;
        }
        .animate-card:nth-child(2) { animation-delay: 0.08s; }
        .animate-card:nth-child(3) { animation-delay: 0.16s; }
        .animate-card:nth-child(4) { animation-delay: 0.24s; }
        .animate-card:nth-child(5) { animation-delay: 0.32s; }
    </style>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <jsp:include page="../common/header.jsp" />

    <div class="max-w-6xl mx-auto px-4 pt-28 pb-20 flex gap-8">
  
<%-- ── SIDEBAR (DÀNH RIÊNG CHO TRANG MY COURSES) ── --%>
       <%-- ── SIDEBAR ── --%>
        <aside class="w-64 flex-shrink-0 hidden md:block">
            <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden sticky top-28">
                <div class="p-6 border-b border-slate-100 bg-gradient-to-br from-emerald-50 to-teal-50">
                    
                    <div class="w-16 h-16 rounded-full bg-emerald-100 flex items-center justify-center mx-auto mb-3">
                        <span class="material-symbols-outlined text-3xl text-emerald-600">person</span>
                    </div>
                    
                    <p class="text-center font-bold text-slate-800 truncate text-[15px]">
                        ${sessionScope.USER.fullName != null ? sessionScope.USER.fullName : sessionScope.USER.username}
                    </p>
                    <p class="text-center text-[13px] text-slate-500 truncate mt-1">
                        ${sessionScope.USER.email}
                    </p>
                    
                </div>
                <nav class="p-3 space-y-1">
                    <a href="${pageContext.request.contextPath}/student?action=profile" class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">manage_accounts</span>
                        My Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=password" class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">lock</span>
                        Change Password
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=courses" class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-semibold bg-emerald-50 text-emerald-700">
                        <span class="material-symbols-outlined text-lg">menu_book</span>
                        My Courses
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=billing" class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">receipt_long</span>
                        Billing
                    </a>
                </nav>
            </div>
        </aside>

        <%-- MAIN CONTENT --%>
<%-- MAIN CONTENT --%>
        <main class="flex-1 min-w-0">
            <div class="flex items-start justify-between mb-8">
                <div>
                    <h1 class="text-[22px] font-extrabold text-slate-800">Các khoá học đã tham gia</h1>
                    <p class="text-sm text-slate-400 mt-1">Your enrolled learning journey</p>
                </div>
                <span class="px-4 py-1.5 bg-emerald-50 text-emerald-600 rounded-full text-xs font-bold border border-emerald-100 flex items-center gap-1.5 shadow-sm">
                    <span class="material-symbols-outlined text-[16px]">history_edu</span>
                    ${totalRecords} this page
                </span>
            </div>

            <c:choose>
                <c:when test="${empty enrollments}">
                    <div class="bg-white p-16 text-center rounded-2xl border border-slate-100 shadow-sm">
                        <div class="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-4 border border-slate-100">
                            <span class="material-symbols-outlined text-4xl text-slate-300">menu_book</span>
                        </div>
                        <p class="font-bold text-slate-500 text-lg">Bạn chưa có khóa học nào</p>
                        <a href="${pageContext.request.contextPath}/shop" class="mt-6 inline-flex items-center gap-2 px-6 py-2.5 bg-emerald-500 text-white rounded-xl font-bold shadow-lg shadow-emerald-200 hover:bg-emerald-600 transition-colors">
                            Khám phá ngay
                        </a>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach var="e" items="${enrollments}">
                            <div class="course-card animate-card bg-white p-5 rounded-2xl shadow-sm border border-slate-100 flex gap-6 items-start">
                                
                                <%-- THUMBNAIL (Cột trái - vuông vắn giống mẫu) --%>
                                <div class="w-32 h-32 bg-slate-100 rounded-xl overflow-hidden flex-shrink-0 border border-slate-100">
                                    <c:choose>
                                        <c:when test="${not empty e.courseId}">
                                            <img src="${e.courseId.thumbnailUrl}" 
                                                 class="w-full h-full object-cover" 
                                                 onerror="this.src='https://placehold.co/400x400?text=Course'"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://placehold.co/400x400?text=No+Image" class="w-full h-full object-cover"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <%-- INFO (Cột giữa) --%>
                                <div class="flex-1 py-1">
                                    <h3 class="font-bold text-slate-800 text-[17px] leading-tight mb-1">
                                        <c:out value="${not empty e.courseId ? e.courseId.title : 'Khóa học không tồn tại'}" />
                                    </h3>
                                    
                                    <p class="text-[13px] text-slate-500 mb-4">
                                        Enrolled: ${not empty e.formattedEnrollmentDate ? e.formattedEnrollmentDate : 'Chưa xác định'}
                                    </p>
                                    
                                    <div class="mb-3 max-w-sm">
                                        <p class="text-[13px] text-slate-500 mb-1.5">Tiến độ: 0/— bài</p>
                                        <div class="w-full bg-slate-100 rounded-full h-1.5">
                                            <div class="bg-slate-300 h-1.5 rounded-full" style="width: 0%"></div>
                                        </div>
                                    </div>

                                    <div class="flex items-center gap-0.5 text-yellow-400">
                                        <span class="material-symbols-outlined" style="font-size: 16px; font-variation-settings: 'FILL' 1;">star</span>
                                        <span class="material-symbols-outlined" style="font-size: 16px; font-variation-settings: 'FILL' 1;">star</span>
                                        <span class="material-symbols-outlined" style="font-size: 16px; font-variation-settings: 'FILL' 1;">star</span>
                                        <span class="material-symbols-outlined" style="font-size: 16px; font-variation-settings: 'FILL' 1;">star</span>
                                        <span class="material-symbols-outlined" style="font-size: 16px; font-variation-settings: 'FILL' 0;">star_half</span>
                                        <span class="text-[13px] font-bold text-slate-500 ml-1.5">4.5</span>
                                    </div>
                                </div>

                                <%-- ACTION & PRICE (Cột phải) --%>
                                <div class="flex flex-col items-end justify-between min-w-[160px] h-[120px] py-1">
                                    <div class="flex items-center gap-3">
                                        <span class="px-2 py-1 bg-slate-100 text-slate-500 rounded text-[10px] font-bold uppercase tracking-wider">
                                            ${not empty e.courseId.level ? e.courseId.level : 'BEGINNER'}
                                        </span>
                                        <span class="text-lg font-black text-slate-800">
                                            <fmt:formatNumber value="${e.courseId.price * 25000}" pattern="#,###"/> đ
                                        </span>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/learn?id=${e.courseId.courseId}" 
                                       class="px-5 py-1.5 mt-auto bg-slate-100 text-slate-500 font-bold rounded-full text-xs border border-slate-200 hover:bg-emerald-500 hover:text-white hover:border-emerald-500 transition-all shadow-sm" 
                                       style="text-decoration: none;">
                                        Active
                                    </a>
                                </div>
                                
                            </div>
                        </c:forEach>
                    </div>

                    <%-- PAGINATION --%>
                    <c:if test="${totalPages > 1}">
                        <div class="mt-10 flex justify-center gap-2">
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <a href="${pageContext.request.contextPath}/student?action=courses&page=${p}" 
                                   class="w-10 h-10 flex items-center justify-center rounded-xl border font-bold transition-all ${p == currentPage ? 'bg-emerald-500 text-white border-emerald-500 shadow-md shadow-emerald-200' : 'bg-white text-slate-600 hover:bg-emerald-50 border-slate-200'}">
                                    ${p}
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
                <jsp:include page="../common/userbuttom.jsp" />
</body>
</html>