
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Billing History – DevLearn</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@400,0&display=swap" rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: { extend: { colors: { primary: "#10B981" }, fontFamily: { display: ["Inter", "sans-serif"] }, maxWidth: { canvas: "1200px" } } }
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        /* Smooth row hover */
        .billing-row {
            transition: all 0.2s cubic-bezier(.4,0,.2,1);
        }
        .billing-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px -5px rgba(16, 185, 129, 0.12), 0 4px 10px -5px rgba(0, 0, 0, 0.04);
        }

        /* Status badge animations */
        .status-badge {
            animation: fadeIn 0.3s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Staggered row entrance */
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .billing-row {
            animation: slideUp 0.4s ease-out backwards;
        }
        .billing-row:nth-child(1) { animation-delay: 0.05s; }
        .billing-row:nth-child(2) { animation-delay: 0.10s; }
        .billing-row:nth-child(3) { animation-delay: 0.15s; }
        .billing-row:nth-child(4) { animation-delay: 0.20s; }
        .billing-row:nth-child(5) { animation-delay: 0.25s; }
        .billing-row:nth-child(6) { animation-delay: 0.30s; }
        .billing-row:nth-child(7) { animation-delay: 0.35s; }
        .billing-row:nth-child(8) { animation-delay: 0.40s; }

        /* Arrow hover animation */
        .arrow-icon {
            transition: transform 0.2s ease;
        }
        .billing-row:hover .arrow-icon {
            transform: translateX(4px);
        }

        /* Card entrance */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-card {
            animation: fadeInUp 0.5s ease-out backwards;
        }
    </style>
</head>

<body class="font-display bg-gradient-to-br from-slate-50 to-emerald-50 min-h-screen text-slate-800">

    <jsp:include page="../common/header.jsp" />

    <div class="max-w-6xl mx-auto px-4 pt-28 pb-16 flex gap-8">

        <%-- ── SIDEBAR ── --%>
        <aside class="w-64 flex-shrink-0">
            <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden sticky top-28">
                <div class="p-6 border-b border-slate-100 bg-gradient-to-br from-emerald-50 to-teal-50">
                    <div class="w-16 h-16 rounded-full bg-emerald-100 flex items-center justify-center mx-auto mb-3">
                        <span class="material-symbols-outlined text-3xl text-emerald-600">person</span>
                    </div>
                    <p class="text-center font-bold text-slate-800 truncate">
                        ${sessionScope.USER.fullName != null ? sessionScope.USER.fullName : sessionScope.USER.username}
                    </p>
                    <p class="text-center text-xs text-slate-400 truncate mt-0.5">
                        ${sessionScope.USER.email}
                    </p>
                </div>
                <nav class="p-3 space-y-1">
                    <a href="${pageContext.request.contextPath}/student?action=profile"
                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">manage_accounts</span>
                        My Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=password"
                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">lock</span>
                        Change Password
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=courses"
                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                        <span class="material-symbols-outlined text-lg">menu_book</span>
                        My Courses
                    </a>
                    <a href="${pageContext.request.contextPath}/student?action=billing"
                        class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-semibold bg-emerald-50 text-emerald-700">
                        <span class="material-symbols-outlined text-lg">receipt_long</span>
                        Billing
                    </a>
                </nav>
            </div>
        </aside>

        <%-- ── MAIN CONTENT ── --%>
        <main class="flex-1 min-w-0">

            <div class="bg-white rounded-2xl shadow-sm border border-slate-100 animate-card">
                <%-- Header --%>
                <div class="px-8 py-6 border-b border-slate-100">
                    <div class="flex items-center gap-3 mb-1">
                        <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-emerald-400 to-teal-500 flex items-center justify-center shadow-lg shadow-emerald-500/20">
                            <span class="material-symbols-outlined text-white text-xl">receipt_long</span>
                        </div>
                        <div>
                            <h1 class="text-xl font-bold text-slate-800">Billing History</h1>
                            <p class="text-sm text-slate-400 mt-0.5">Easily track your course purchases and transactions.</p>
                        </div>
                    </div>
                </div>

                <%-- Billing List --%>
                <div class="p-6">
                    <c:choose>
                        <c:when test="${empty orders}">
                            <%-- Empty state --%>
                            <div class="text-center py-16">
                                <div class="w-20 h-20 rounded-full bg-slate-50 flex items-center justify-center mx-auto mb-4">
                                    <span class="material-symbols-outlined text-4xl text-slate-300">receipt</span>
                                </div>
                                <h3 class="text-lg font-semibold text-slate-600 mb-1">No transactions yet</h3>
                                <p class="text-sm text-slate-400">Your billing history will appear here after your first purchase.</p>
                                <a href="${pageContext.request.contextPath}/courses"
                                    class="inline-flex items-center gap-2 mt-6 px-6 py-2.5 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-semibold rounded-xl shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200 text-sm">
                                    <span class="material-symbols-outlined text-lg">explore</span>
                                    Browse Courses
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%-- Summary stats --%>
                            <div class="grid grid-cols-3 gap-4 mb-6">
                                <div class="bg-gradient-to-br from-emerald-50 to-teal-50 rounded-xl p-4 border border-emerald-100/60">
                                    <p class="text-xs font-semibold text-emerald-600 uppercase tracking-wider mb-1">Total Orders</p>
                                    <p class="text-2xl font-bold text-emerald-700">
                                        <c:out value="${orders.size()}" />
                                    </p>
                                </div>
                                <c:set var="completedCount" value="0" />
                                <c:set var="totalSpent" value="0" />
                                <c:forEach var="o" items="${orders}">
                                    <c:if test="${o.status == 'PAID' || o.status == 'COMPLETED'}">
                                        <c:set var="completedCount" value="${completedCount + 1}" />
                                        <c:if test="${o.totalAmount != null}">
                                            <c:set var="totalSpent" value="${totalSpent + o.totalAmount}" />
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-4 border border-blue-100/60">
                                    <p class="text-xs font-semibold text-blue-600 uppercase tracking-wider mb-1">Completed</p>
                                    <p class="text-2xl font-bold text-blue-700">${completedCount}</p>
                                </div>
                                <div class="bg-gradient-to-br from-violet-50 to-purple-50 rounded-xl p-4 border border-violet-100/60">
                                    <p class="text-xs font-semibold text-violet-600 uppercase tracking-wider mb-1">Total Spent</p>
                                    <p class="text-2xl font-bold text-violet-700">
                                        <fmt:formatNumber value="${totalSpent}" type="number" groupingUsed="true" /> <span class="text-sm font-medium">VND</span>
                                    </p>
                                </div>
                            </div>

                            <%-- Order rows --%>
                            <div class="space-y-3">
                                <c:forEach var="order" items="${orders}">
                                    <a href="${pageContext.request.contextPath}/student?action=billingDetail&orderId=${order.orderId}"
                                       class="billing-row block bg-white border border-slate-100 rounded-xl p-5 cursor-pointer group">
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center gap-4">
                                                <%-- Order icon --%>
                                                <div class="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PAID' || order.status == 'COMPLETED'}">bg-emerald-50</c:when>
                                                        <c:when test="${order.status == 'PENDING'}">bg-amber-50</c:when>
                                                        <c:otherwise>bg-red-50</c:otherwise>
                                                    </c:choose>
                                                ">
                                                    <span class="material-symbols-outlined text-xl
                                                        <c:choose>
                                                            <c:when test="${order.status == 'PAID' || order.status == 'COMPLETED'}">text-emerald-500</c:when>
                                                            <c:when test="${order.status == 'PENDING'}">text-amber-500</c:when>
                                                            <c:otherwise>text-red-500</c:otherwise>
                                                        </c:choose>
                                                    ">shopping_bag</span>
                                                </div>

                                                <%-- Order info --%>
                                                <div>
                                                    <div class="flex items-center gap-2.5 mb-1">
                                                        <p class="text-sm font-bold text-slate-800">Order #${order.orderId}</p>
                                                        <c:if test="${not empty order.vnpTxnRef}">
                                                            <span class="text-xs text-slate-400 font-medium bg-slate-50 px-2 py-0.5 rounded-md">${order.vnpTxnRef}</span>
                                                        </c:if>
                                                    </div>
                                                    <p class="text-xs text-slate-400">
                                                        <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy – HH:mm" />
                                                    </p>
                                                </div>
                                            </div>

                                            <div class="flex items-center gap-5">
                                                <%-- Amount --%>
                                                <div class="text-right">
                                                    <p class="text-sm font-bold text-slate-800">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" />
                                                        <span class="text-xs font-medium text-slate-400 ml-0.5">VND</span>
                                                    </p>
                                                </div>

                                                <%-- Status badge --%>
                                                <div class="status-badge">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PAID' || order.status == 'COMPLETED'}">
                                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200/60">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                                                Completed
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'PENDING'}">
                                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200/60">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span>
                                                                Pending
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-semibold bg-red-50 text-red-700 border border-red-200/60">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                                                                Failed
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <%-- Arrow --%>
                                                <span class="material-symbols-outlined text-lg text-slate-300 group-hover:text-emerald-500 arrow-icon">arrow_forward_ios</span>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <jsp:include page="../common/userbuttom.jsp" />

</body>

</html>
