<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>My Courses – DevLearn</title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@400,0&display=swap"
                    rel="stylesheet" />
                <script src="https://cdn.tailwindcss.com"></script>
                <script>
                    tailwind.config = {
                        theme: {
                            extend: {
                                colors: { primary: "#10B981" },
                                fontFamily: { display: ["Inter", "sans-serif"] },
                                maxWidth: { canvas: "1200px" }
                            }
                        }
                    }
                </script>
                <style>
                    * {
                        box-sizing: border-box;
                    }

                    body {
                        font-family: "Inter", sans-serif;
                    }

                    .material-symbols-outlined {
                        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    }

                    /* Elevated card */
                    .course-card {
                        background: #ffffff;
                        border-radius: 16px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                        overflow: hidden;
                    }

                    .course-card:hover {
                        transform: translateY(-6px);
                        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12);
                    }

                    /* Fade-in animation */
                    @keyframes fadeSlideUp {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .course-card {
                        animation: fadeSlideUp 0.4s ease both;
                    }

                    .course-card:nth-child(1) {
                        animation-delay: 0.05s;
                    }

                    .course-card:nth-child(2) {
                        animation-delay: 0.10s;
                    }

                    .course-card:nth-child(3) {
                        animation-delay: 0.15s;
                    }

                    .course-card:nth-child(4) {
                        animation-delay: 0.20s;
                    }

                    .course-card:nth-child(5) {
                        animation-delay: 0.25s;
                    }

                    /* Progress bar */
                    .progress-track {
                        height: 8px;
                        background: #e5e7eb;
                        border-radius: 10px;
                        overflow: hidden;
                    }

                    .progress-fill {
                        height: 100%;
                        border-radius: 10px;
                        background: linear-gradient(90deg, #10B981, #34d399);
                        width: 0;
                        transition: width 0.8s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    /* Sidebar active nav item */
                    .nav-active {
                        background: linear-gradient(135deg, #ecfdf5, #d1fae5);
                        color: #059669;
                        font-weight: 700;
                    }

                    /* Pagination */
                    .page-btn {
                        min-width: 38px;
                        height: 38px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 10px;
                        font-size: 0.875rem;
                        font-weight: 600;
                        transition: all 0.2s;
                    }

                    .page-btn:hover {
                        background: #d1fae5;
                        color: #059669;
                    }

                    .page-btn.active {
                        background: linear-gradient(135deg, #10B981, #059669);
                        color: #fff;
                        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.35);
                    }

                    .page-btn.disabled {
                        opacity: 0.4;
                        pointer-events: none;
                    }

                    /* Responsive card */
                    @media (max-width: 640px) {
                        .card-inner {
                            flex-direction: column !important;
                        }

                        .card-thumb {
                            width: 100% !important;
                            height: 180px !important;
                            border-radius: 0 !important;
                        }

                        .card-price-col {
                            flex-direction: row !important;
                            align-items: center !important;
                            gap: 12px;
                            border-top: 1px solid #f1f5f9;
                            padding-top: 12px;
                        }
                    }
                </style>
            </head>

            <body class="bg-gradient-to-br from-slate-50 via-white to-emerald-50 min-h-screen text-slate-800">

                <jsp:include page="../common/header.jsp" />

                <div class="max-w-6xl mx-auto px-4 pt-28 pb-20 flex gap-8">

                    <%-- ── SIDEBAR ── --%>
                        <aside class="w-64 flex-shrink-0 hidden md:block">
                            <div
                                class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden sticky top-28">
                                <div class="p-6 border-b border-slate-100"
                                    style="background: linear-gradient(135deg,#ecfdf5,#d1fae5);">
                                    <div
                                        class="w-16 h-16 rounded-full bg-white shadow flex items-center justify-center mx-auto mb-3">
                                        <span class="material-symbols-outlined text-3xl text-emerald-500">person</span>
                                    </div>
                                    <p class="text-center font-bold text-slate-800 truncate text-sm">
                                        ${not empty sessionScope.USER.fullName ? sessionScope.USER.fullName :
                                        sessionScope.USER.username}
                                    </p>
                                    <p class="text-center text-xs text-slate-500 truncate mt-0.5">
                                        ${sessionScope.USER.email}</p>
                                </div>
                                <nav class="p-3 space-y-1">
                                    <a href="${pageContext.request.contextPath}/student?action=profile"
                                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm text-slate-600 hover:bg-slate-50 transition-colors font-medium">
                                        <span class="material-symbols-outlined text-lg">manage_accounts</span>My Profile
                                    </a>
                                    <a href="${pageContext.request.contextPath}/student?action=password"
                                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm text-slate-600 hover:bg-slate-50 transition-colors font-medium">
                                        <span class="material-symbols-outlined text-lg">lock</span>Change Password
                                    </a>
                                    <a href="${pageContext.request.contextPath}/student?action=courses"
                                        class="nav-active flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm transition-colors">
                                        <span class="material-symbols-outlined text-lg">menu_book</span>My Courses
                                    </a>
                                </nav>
                            </div>
                        </aside>

                        <%-- ── MAIN ── --%>
                            <main class="flex-1 min-w-0">

                                <%-- Header row --%>
                                    <div class="flex items-center justify-between mb-6">
                                        <div>
                                            <h1 class="text-2xl font-extrabold text-slate-800 tracking-tight">Các khoá
                                                học đã tham gia</h1>
                                            <p class="text-sm text-slate-400 mt-0.5">Your enrolled learning journey</p>
                                        </div>
                                        <span
                                            class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold border"
                                            style="background:#ecfdf5; color:#059669; border-color:#a7f3d0;">
                                            <span class="material-symbols-outlined text-sm">library_books</span>
                                            ${empty enrollments ? 0 : enrollments.size()} this page
                                        </span>
                                    </div>

                                    <%-- ── CARD LIST ── --%>
                                        <c:choose>
                                            <c:when test="${empty enrollments}">
                                                <div class="course-card p-16 text-center">
                                                    <div class="w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4"
                                                        style="background:#f1f5f9;">
                                                        <span
                                                            class="material-symbols-outlined text-4xl text-slate-300">menu_book</span>
                                                    </div>
                                                    <p class="font-bold text-slate-500 text-lg">No courses yet</p>
                                                    <p class="text-sm text-slate-400 mt-1">Explore the catalog and
                                                        enroll in your first course!</p>
                                                    <a href="${pageContext.request.contextPath}/home"
                                                        class="inline-flex items-center gap-2 mt-6 px-6 py-2.5 rounded-xl text-white text-sm font-semibold"
                                                        style="background: linear-gradient(135deg,#10B981,#059669); box-shadow:0 4px 14px rgba(16,185,129,0.35);">
                                                        <span
                                                            class="material-symbols-outlined text-lg">explore</span>Browse
                                                        Courses
                                                    </a>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="space-y-4">
                                                    <c:forEach var="e" items="${enrollments}" varStatus="st">

                                                        <%-- Fake progress: 0/total for demo; replace if you have real
                                                            data --%>
                                                            <c:set var="progressPct" value="0" />
                                                            <c:if
                                                                test="${e.status == 'COMPLETED' || e.status == 'completed'}">
                                                                <c:set var="progressPct" value="100" />
                                                            </c:if>

                                                            <div class="course-card">
                                                                <%-- card-inner: horizontal layout --%>
                                                                    <div class="card-inner flex gap-5 p-5 items-start">

                                                                        <%-- THUMBNAIL --%>
                                                                            <div class="card-thumb flex-shrink-0 rounded-xl overflow-hidden bg-slate-100"
                                                                                style="width:160px; height:110px; border-radius:12px;">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not empty e.courseId.thumbnailUrl}">
                                                                                        <img src="${e.courseId.thumbnailUrl}"
                                                                                            alt="${e.courseId.title}"
                                                                                            style="width:100%;height:100%;object-fit:cover;display:block;" />
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div
                                                                                            style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,#1e293b,#0f172a);">
                                                                                            <span
                                                                                                class="material-symbols-outlined text-3xl text-emerald-400">menu_book</span>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>

                                                                            <%-- MIDDLE: info --%>
                                                                                <div class="flex-1 min-w-0">
                                                                                    <%-- Title + category badge --%>
                                                                                        <div
                                                                                            class="flex items-start gap-3 flex-wrap">
                                                                                            <h3 class="font-bold text-slate-800 text-base leading-tight"
                                                                                                style="flex:1; min-width:0;">
                                                                                                ${e.courseId.title}
                                                                                            </h3>
                                                                                            <c:if
                                                                                                test="${not empty e.courseId.level}">
                                                                                                <span
                                                                                                    class="flex-shrink-0 text-xs font-bold tracking-widest px-2.5 py-1 rounded"
                                                                                                    style="background:#f1f5f9;color:#475569;text-transform:uppercase;letter-spacing:.08em;">
                                                                                                    ${e.courseId.level}
                                                                                                </span>
                                                                                            </c:if>
                                                                                        </div>

                                                                                        <%-- Enrollment date --%>
                                                                                            <c:if
                                                                                                test="${e.enrollmentDate != null}">
                                                                                                <p
                                                                                                    class="text-xs text-slate-400 mt-1.5">
                                                                                                    Enrolled:
                                                                                                    <fmt:formatDate
                                                                                                        value="${e.enrollmentDate}"
                                                                                                        pattern="dd MMM yyyy" />
                                                                                                </p>
                                                                                            </c:if>

                                                                                            <%-- Progress --%>
                                                                                                <p
                                                                                                    class="text-xs text-slate-500 mt-3 mb-1.5 font-medium">
                                                                                                    Tiến độ: 0/— bài
                                                                                                </p>
                                                                                                <div class="progress-track"
                                                                                                    style="max-width:320px;">
                                                                                                    <div class="progress-fill"
                                                                                                        data-pct="${progressPct}">
                                                                                                    </div>
                                                                                                </div>

                                                                                                <%-- Rating --%>
                                                                                                    <div
                                                                                                        class="flex items-center gap-1.5 mt-2.5">
                                                                                                        <div
                                                                                                            class="flex">
                                                                                                            <c:forEach
                                                                                                                begin="1"
                                                                                                                end="4">
                                                                                                                <span
                                                                                                                    class="material-symbols-outlined text-yellow-400 text-sm"
                                                                                                                    style="font-variation-settings:'FILL' 1,'wght' 400;">star</span>
                                                                                                            </c:forEach>
                                                                                                            <span
                                                                                                                class="material-symbols-outlined text-yellow-300 text-sm"
                                                                                                                style="font-variation-settings:'FILL' 1,'wght' 400;">star_half</span>
                                                                                                        </div>
                                                                                                        <span
                                                                                                            class="text-xs font-semibold text-slate-500">4.5</span>
                                                                                                    </div>
                                                                                </div>

                                                                                <%-- RIGHT: price + status --%>
                                                                                    <div
                                                                                        class="card-price-col flex-shrink-0 flex flex-col items-end gap-2 text-right">

                                                                                        <%-- Price --%>
                                                                                            <c:choose>
                                                                                                <c:when
                                                                                                    test="${e.courseId.price != null && e.courseId.price == 0}">
                                                                                                    <span
                                                                                                        class="text-xl font-black"
                                                                                                        style="color:#10B981;">0
                                                                                                        đ</span>
                                                                                                </c:when>
                                                                                                <c:when
                                                                                                    test="${e.courseId.price != null}">
                                                                                                    <span
                                                                                                        class="text-xl font-black text-slate-800">
                                                                                                        ${e.courseId.price}
                                                                                                        đ
                                                                                                    </span>
                                                                                                </c:when>
                                                                                            </c:choose>

                                                                                            <%-- Status --%>
                                                                                                <c:choose>
                                                                                                    <c:when
                                                                                                        test="${e.status == 'ACTIVE' || e.status == 'active'}">
                                                                                                        <span
                                                                                                            class="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold"
                                                                                                            style="background:#ecfdf5;color:#059669;border:1px solid #a7f3d0;">
                                                                                                            <span
                                                                                                                class="w-1.5 h-1.5 rounded-full inline-block"
                                                                                                                style="background:#10B981;"></span>
                                                                                                            ACTIVE
                                                                                                        </span>
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${e.status == 'COMPLETED' || e.status == 'completed'}">
                                                                                                        <span
                                                                                                            class="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold"
                                                                                                            style="background:#f0f9ff;color:#0369a1;border:1px solid #bae6fd;">
                                                                                                            <span
                                                                                                                class="material-symbols-outlined text-sm">task_alt</span>
                                                                                                            DONE
                                                                                                        </span>
                                                                                                    </c:when>
                                                                                                    <c:otherwise>
                                                                                                        <span
                                                                                                            class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold"
                                                                                                            style="background:#f1f5f9;color:#64748b;border:1px solid #e2e8f0;">
                                                                                                            ${e.status}
                                                                                                        </span>
                                                                                                    </c:otherwise>
                                                                                                </c:choose>
                                                                                    </div>

                                                                    </div><%-- /card-inner --%>
                                                            </div><%-- /course-card --%>
                                                    </c:forEach>
                                                </div>

                                                <%-- ── PAGINATION ── --%>
                                                    <div class="mt-10">



                                                        <c:if test="${not empty totalPages && totalPages > 1}">
                                                            <div class="flex items-center justify-center gap-2">

                                                                <%-- Previous --%>
                                                                    <c:choose>
                                                                        <c:when test="${currentPage > 1}">
                                                                            <a href="${pageContext.request.contextPath}/student?action=courses&page=${currentPage - 1}"
                                                                                class="page-btn flex items-center gap-1 px-3 text-slate-600 border border-slate-200 bg-white">
                                                                                <span
                                                                                    class="material-symbols-outlined text-lg">chevron_left</span>
                                                                                <span
                                                                                    class="hidden sm:inline">Previous</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span
                                                                                class="page-btn disabled flex items-center gap-1 px-3 text-slate-400 border border-slate-100 bg-slate-50">
                                                                                <span
                                                                                    class="material-symbols-outlined text-lg">chevron_left</span>
                                                                                <span
                                                                                    class="hidden sm:inline">Previous</span>
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                    <%-- Page numbers --%>
                                                                        <c:forEach begin="1" end="${totalPages}"
                                                                            var="p">
                                                                            <c:choose>
                                                                                <c:when test="${p == currentPage}">
                                                                                    <span
                                                                                        class="page-btn active">${p}</span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a href="${pageContext.request.contextPath}/student?action=courses&page=${p}"
                                                                                        class="page-btn text-slate-600 border border-slate-200 bg-white">${p}</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:forEach>

                                                                        <%-- Next --%>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${currentPage < totalPages}">
                                                                                    <a href="${pageContext.request.contextPath}/student?action=courses&page=${currentPage + 1}"
                                                                                        class="page-btn flex items-center gap-1 px-3 text-slate-600 border border-slate-200 bg-white">
                                                                                        <span
                                                                                            class="hidden sm:inline">Next</span>
                                                                                        <span
                                                                                            class="material-symbols-outlined text-lg">chevron_right</span>
                                                                                    </a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span
                                                                                        class="page-btn disabled flex items-center gap-1 px-3 text-slate-400 border border-slate-100 bg-slate-50">
                                                                                        <span
                                                                                            class="hidden sm:inline">Next</span>
                                                                                        <span
                                                                                            class="material-symbols-outlined text-lg">chevron_right</span>
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                            </div>
                                                        </c:if>
                                                    </div>

                                            </c:otherwise>
                                        </c:choose>

                            </main>
                </div>

                <jsp:include page="../common/userbuttom.jsp" />

                <%-- Animate progress bars after page load --%>
                    <script>
                        window.addEventListener('load', function () {
                            document.querySelectorAll('.progress-fill').forEach(function (bar) {
                                const pct = bar.getAttribute('data-pct') || '0';
                                bar.style.width = pct + '%';
                            });
                        });
                    </script>
            </body>

            </html>