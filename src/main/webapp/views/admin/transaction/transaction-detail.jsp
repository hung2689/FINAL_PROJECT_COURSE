<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>Order Details</title>
                    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet" />
                    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
                    <style>
                        body {
                            font-family: 'Inter', sans-serif;
                            margin: 0;
                            padding: 0;
                            background: white;
                        }
                    </style>
                </head>

                <body>
                    <c:choose>
                        <c:when test="${payment == null}">
                            <div class="p-12 text-center">
                                <span class="material-icons text-6xl text-gray-300 mb-4">receipt_long</span>
                                <p class="text-gray-500 text-lg">Transaction not found.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Modal Header -->
                            <div class="pt-8 pb-4 px-8 border-b border-gray-100">
                                <h2 class="text-2xl font-bold text-gray-900 text-center">Order Details</h2>
                                <p class="text-center text-sm text-gray-400 mt-1">
                                    Invoice #${payment.paymentId} &mdash;
                                    <fmt:formatDate value="${payment.createdAt}" pattern="MMMM dd, yyyy 'at' HH:mm" />
                                </p>
                            </div>

                            <!-- SECTION 1: Customer Information -->
                            <div class="px-8 py-6">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                                    <!-- Buyer Information Card -->
                                    <div class="bg-gray-50 rounded-xl p-5">
                                        <h3 class="text-sm font-semibold text-gray-700 mb-4 flex items-center gap-2">
                                            <span class="material-icons text-base text-blue-500">person</span>
                                            Buyer Information
                                        </h3>
                                        <div class="space-y-3">
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Name</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.fullName != null ? payment.studentId.users.fullName : 'N/A'}" />
                                                </span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Phone Number</span>
                                                <span class="font-medium text-gray-900">N/A</span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Email</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.email != null ? payment.studentId.users.email : 'N/A'}" />
                                                </span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Username</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.username != null ? payment.studentId.users.username : 'N/A'}" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Student Information Card -->
                                    <div class="bg-gray-50 rounded-xl p-5">
                                        <h3 class="text-sm font-semibold text-gray-700 mb-4 flex items-center gap-2">
                                            <span class="material-icons text-base text-emerald-500">school</span>
                                            Student Information
                                        </h3>
                                        <div class="space-y-3">
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Name</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.fullName != null ? payment.studentId.users.fullName : 'N/A'}" />
                                                </span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Phone Number</span>
                                                <span class="font-medium text-gray-900">N/A</span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Email</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.email != null ? payment.studentId.users.email : 'N/A'}" />
                                                </span>
                                            </div>
                                            <div class="flex justify-between text-sm">
                                                <span class="text-gray-500">Username</span>
                                                <span class="font-medium text-gray-900">
                                                    <c:out
                                                        value="${payment.studentId.users.username != null ? payment.studentId.users.username : 'N/A'}" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!-- SECTION 2: Product Information -->
                            <div class="px-8 py-4">
                                <h3 class="text-sm font-semibold text-gray-700 mb-4 flex items-center gap-2">
                                    <span class="material-icons text-base text-orange-500">shopping_cart</span>
                                    Products
                                </h3>

                                <c:choose>
                                    <c:when test="${not empty order && not empty order.courseOrderItemCollection}">
                                        <c:forEach var="item" items="${order.courseOrderItemCollection}"
                                            varStatus="loop">
                                            <div class="bg-gray-50 rounded-xl p-4 mb-3">
                                                <div class="flex items-start justify-between">
                                                    <div class="flex-1">
                                                        <p
                                                            class="text-sm font-semibold text-gray-900 flex items-center gap-2">
                                                            <span
                                                                class="w-2 h-2 bg-blue-500 rounded-full inline-block"></span>
                                                            <c:out value="${item.courseId.title}" />
                                                        </p>
                                                        <c:if test="${item.courseId.level != null}">
                                                            <p class="text-xs text-gray-400 ml-4 mt-1">
                                                                ├
                                                                <c:out value="${item.courseId.level}" /> Level
                                                            </p>
                                                        </c:if>
                                                        <p class="text-xs text-gray-400 ml-4 mt-0.5">
                                                            ├ Full Course Package
                                                        </p>
                                                    </div>
                                                    <div class="text-right">
                                                        <p class="text-sm font-bold text-gray-900">
                                                            $
                                                            <fmt:formatNumber value="${item.price}" type="number"
                                                                minFractionDigits="2" maxFractionDigits="2" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="bg-gray-50 rounded-xl p-4">
                                            <div class="flex items-start justify-between">
                                                <div class="flex-1">
                                                    <p
                                                        class="text-sm font-semibold text-gray-900 flex items-center gap-2">
                                                        <span
                                                            class="w-2 h-2 bg-blue-500 rounded-full inline-block"></span>
                                                        <c:out
                                                            value="${courseName != null ? courseName : 'Course Purchase'}" />
                                                    </p>
                                                </div>
                                                <div class="text-right">
                                                    <p class="text-sm font-bold text-gray-900">
                                                        $
                                                        <fmt:formatNumber value="${payment.amount}" type="number"
                                                            minFractionDigits="2" maxFractionDigits="2" />
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- SECTION 3: Payment Summary -->
                            <div class="px-8 pt-2 pb-8">
                                <div class="border-t border-gray-200 pt-5 space-y-3">

                                    <!-- Total Price Row -->
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-500">Total Price</span>
                                        <span class="font-medium text-gray-900">
                                            <c:choose>
                                                <c:when test="${not empty coursePrice}">
                                                    $
                                                    <fmt:formatNumber value="${coursePrice}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </c:when>
                                                <c:otherwise>
                                                    $
                                                    <fmt:formatNumber value="${payment.amount}" type="number"
                                                        minFractionDigits="2" maxFractionDigits="2" />
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <!-- Discount Row (green highlight) -->
                                    <c:if
                                        test="${not empty coursePrice && coursePrice.doubleValue() != payment.amount.doubleValue()}">
                                        <div
                                            class="flex justify-between text-sm bg-emerald-50 rounded-lg px-4 py-2.5 -mx-4">
                                            <span class="text-emerald-700 font-medium">Discount</span>
                                            <span class="text-emerald-600 font-semibold">
                                                -$
                                                <fmt:formatNumber value="${coursePrice - payment.amount}" type="number"
                                                    minFractionDigits="2" maxFractionDigits="2" />
                                            </span>
                                        </div>
                                    </c:if>

                                    <!-- Final Price Row -->
                                    <div class="flex justify-between items-center pt-3 border-t border-gray-200">
                                        <span class="text-base font-bold text-gray-900">Final Price</span>
                                        <span class="text-xl font-bold text-blue-600">
                                            $
                                            <fmt:formatNumber value="${payment.amount}" type="number"
                                                minFractionDigits="2" maxFractionDigits="2" />
                                        </span>
                                    </div>

                                    <!-- Payment Info -->
                                    <div class="flex justify-between text-sm pt-2">
                                        <span class="text-gray-500">Payment Method</span>
                                        <span class="font-medium text-gray-900">
                                            <c:out
                                                value="${payment.paymentMethod != null ? payment.paymentMethod : 'N/A'}" />
                                        </span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-500">Transaction Code</span>
                                        <span class="font-mono text-xs bg-gray-100 px-2 py-0.5 rounded">
                                            <c:out value="${payment.vnpTxnRef != null ? payment.vnpTxnRef : 'N/A'}" />
                                        </span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-500">Status</span>
                                        <c:choose>
                                            <c:when test="${payment.status == 'SUCCESS'}">
                                                <span
                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700">
                                                    <span class="w-1.5 h-1.5 bg-emerald-500 rounded-full mr-1.5"></span>
                                                    Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'FAILED'}">
                                                <span
                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-700">
                                                    <span class="w-1.5 h-1.5 bg-red-500 rounded-full mr-1.5"></span>
                                                    Failed
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-700">
                                                    <span class="w-1.5 h-1.5 bg-amber-500 rounded-full mr-1.5"></span>
                                                    Pending
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                        </c:otherwise>
                    </c:choose>
                </body>

                </html>