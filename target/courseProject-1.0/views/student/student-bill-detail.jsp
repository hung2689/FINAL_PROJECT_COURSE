
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Detail – DevLearn</title>
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

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-card {
            animation: fadeInUp 0.5s ease-out backwards;
        }
        .animate-card:nth-child(2) { animation-delay: 0.1s; }
        .animate-card:nth-child(3) { animation-delay: 0.2s; }
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

            <%-- Back button --%>
            <a href="${pageContext.request.contextPath}/student?action=billing"
               class="inline-flex items-center gap-1.5 text-sm font-semibold text-slate-500 hover:text-emerald-600 transition-colors mb-5 group">
                <span class="material-symbols-outlined text-lg group-hover:-translate-x-1 transition-transform">arrow_back</span>
                Back to Billing History
            </a>

            <%-- Error state --%>
            <c:if test="${not empty error}">
                <div class="mb-6 flex items-center gap-3 px-5 py-3.5 rounded-xl bg-red-50 border border-red-200 text-red-700 font-semibold text-sm shadow-sm">
                    <span class="material-symbols-outlined text-red-500">error</span>
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty order}">

                <%-- Order Header --%>
                <div class="bg-white rounded-2xl shadow-sm border border-slate-100 mb-5 animate-card">
                    <div class="px-8 py-6 border-b border-slate-100">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-11 h-11 rounded-xl bg-gradient-to-br from-emerald-400 to-teal-500 flex items-center justify-center shadow-lg shadow-emerald-500/20">
                                    <span class="material-symbols-outlined text-white text-xl">receipt</span>
                                </div>
                                <div>
                                    <h1 class="text-xl font-bold text-slate-800">Order #${order.orderId}</h1>
                                    <p class="text-sm text-slate-400">
                                        <fmt:formatDate value="${order.createdAt}" pattern="dd MMMM yyyy – HH:mm" />
                                    </p>
                                </div>
                            </div>
                            <%-- Status badge --%>
                            <c:choose>
                                <c:when test="${order.status == 'PAID' || order.status == 'COMPLETED'}">
                                    <span class="inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full text-sm font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200/60">
                                        <span class="material-symbols-outlined text-base">check_circle</span>
                                        Completed
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 'PENDING'}">
                                    <span class="inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full text-sm font-semibold bg-amber-50 text-amber-700 border border-amber-200/60">
                                        <span class="material-symbols-outlined text-base">schedule</span>
                                        Pending
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full text-sm font-semibold bg-red-50 text-red-700 border border-red-200/60">
                                        <span class="material-symbols-outlined text-base">cancel</span>
                                        Failed
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <%-- Order Information --%>
                    <div class="p-8">
                        <h2 class="text-sm font-bold text-slate-800 uppercase tracking-wider mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg text-emerald-500">info</span>
                            Order Information
                        </h2>
                        <div class="grid grid-cols-2 gap-4">
                            <div class="bg-slate-50 rounded-xl p-4">
                                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Order ID</p>
                                <p class="text-sm font-bold text-slate-800">#${order.orderId}</p>
                            </div>
                            <div class="bg-slate-50 rounded-xl p-4">
                                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Transaction Ref</p>
                                <p class="text-sm font-bold text-slate-800">${not empty order.vnpTxnRef ? order.vnpTxnRef : 'N/A'}</p>
                            </div>
                            <div class="bg-slate-50 rounded-xl p-4">
                                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Purchase Date</p>
                                <p class="text-sm font-bold text-slate-800">
                                    <fmt:formatDate value="${order.createdAt}" pattern="dd MMMM yyyy, HH:mm" />
                                </p>
                            </div>
                            <div class="bg-slate-50 rounded-xl p-4">
                                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Payment Method</p>
                                <p class="text-sm font-bold text-slate-800">
                                    <c:choose>
                                        <c:when test="${not empty payment && not empty payment.paymentMethod}">
                                            <span class="inline-flex items-center gap-1.5">
                                                <span class="material-symbols-outlined text-base text-blue-500">credit_card</span>
                                                ${payment.paymentMethod}
                                            </span>
                                        </c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Course Information --%>
                <div class="bg-white rounded-2xl shadow-sm border border-slate-100 mb-5 animate-card">
                    <div class="p-8">
                        <h2 class="text-sm font-bold text-slate-800 uppercase tracking-wider mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg text-blue-500">school</span>
                            Course Information
                        </h2>

                        <c:choose>
                            <c:when test="${not empty order.courseOrderItemCollection}">
                                <div class="space-y-3">
                                    <c:forEach var="item" items="${order.courseOrderItemCollection}">
                                        <div class="bg-slate-50 rounded-xl p-5 flex items-center justify-between group hover:bg-emerald-50/40 transition-colors">
                                            <div class="flex items-center gap-4">
                                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-400 to-indigo-500 flex items-center justify-center shadow-md shadow-blue-500/20">
                                                    <span class="material-symbols-outlined text-white">play_lesson</span>
                                                </div>
                                                <div>
                                                    <p class="text-sm font-bold text-slate-800 mb-0.5">
                                                        ${item.courseId != null ? item.courseId.title : 'Unknown Course'}
                                                    </p>
                                                    <p class="text-xs text-slate-400 flex items-center gap-1">
                                                        <span class="material-symbols-outlined text-sm">person</span>
                                                        <c:choose>
                                                            <c:when test="${item.courseId != null && instructorMap[item.courseId.courseId] != null}">
                                                                ${instructorMap[item.courseId.courseId]}
                                                            </c:when>
                                                            <c:otherwise>Instructor</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-sm font-bold text-slate-800">
                                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />
                                                    <span class="text-xs font-medium text-slate-400 ml-0.5">VND</span>
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-sm text-slate-400 italic">No course items found for this order.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <%-- Payment Summary --%>
                <div class="bg-white rounded-2xl shadow-sm border border-slate-100 animate-card">
                    <div class="p-8">
                        <h2 class="text-sm font-bold text-slate-800 uppercase tracking-wider mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-lg text-violet-500">payments</span>
                            Payment Summary
                        </h2>

                        <div class="bg-gradient-to-br from-slate-50 to-emerald-50/30 rounded-xl p-6 border border-slate-100">
                            <%-- Subtotal --%>
                            <c:set var="subtotal" value="0" />
                            <c:if test="${not empty order.courseOrderItemCollection}">
                                <c:forEach var="item" items="${order.courseOrderItemCollection}">
                                    <c:if test="${item.price != null}">
                                        <c:set var="subtotal" value="${subtotal + item.price}" />
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <div class="flex justify-between items-center py-3 border-b border-slate-200/60">
                                <p class="text-sm text-slate-500">Subtotal</p>
                                <p class="text-sm font-semibold text-slate-700">
                                    <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" /> VND
                                </p>
                            </div>

                            <%-- Tax --%>
                            <div class="flex justify-between items-center py-3 border-b border-slate-200/60">
                                <p class="text-sm text-slate-500">Tax</p>
                                <p class="text-sm font-semibold text-slate-700">0 VND</p>
                            </div>

                            <%-- Discount --%>
                            <c:set var="discount" value="${subtotal - order.totalAmount}" />
                            <c:if test="${discount > 0}">
                                <div class="flex justify-between items-center py-3 border-b border-slate-200/60">
                                    <p class="text-sm text-emerald-600 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-sm">sell</span>
                                        Discount
                                    </p>
                                    <p class="text-sm font-semibold text-emerald-600">
                                        -<fmt:formatNumber value="${discount}" type="number" groupingUsed="true" /> VND
                                    </p>
                                </div>
                            </c:if>

                            <%-- Total --%>
                            <div class="flex justify-between items-center pt-4">
                                <p class="text-base font-bold text-slate-800">Total Amount</p>
                                <p class="text-xl font-extrabold bg-gradient-to-r from-emerald-500 to-teal-600 bg-clip-text text-transparent">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> VND
                                </p>
                            </div>
                        </div>

                        <%-- Payment status note --%>
                        <c:if test="${order.status == 'PAID' || order.status == 'COMPLETED'}">
                            <div class="mt-4 flex items-center gap-2 px-4 py-3 rounded-xl bg-emerald-50 border border-emerald-200/60">
                                <span class="material-symbols-outlined text-emerald-500">verified</span>
                                <p class="text-xs font-semibold text-emerald-700">Payment verified and completed successfully.</p>
                            </div>
                        </c:if>
                        <c:if test="${order.status == 'PENDING'}">
                            <div class="mt-4 flex items-center gap-2 px-4 py-3 rounded-xl bg-amber-50 border border-amber-200/60">
                                <span class="material-symbols-outlined text-amber-500 animate-pulse">hourglass_top</span>
                                <p class="text-xs font-semibold text-amber-700">Payment is being processed. Please wait.</p>
                            </div>
                        </c:if>
                        <c:if test="${order.status == 'FAILED'}">
                            <div class="mt-4 flex items-center gap-2 px-4 py-3 rounded-xl bg-red-50 border border-red-200/60">
                                <span class="material-symbols-outlined text-red-500">warning</span>
                                <p class="text-xs font-semibold text-red-700">Payment failed. Please try again or contact support.</p>
                            </div>
                        </c:if>
                    </div>
                </div>

            </c:if>
        </main>
    </div>

    <jsp:include page="../common/userbuttom.jsp" />

</body>

</html>
