<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Admin Dashboard - Transaction Management</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet" />
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                    rel="stylesheet" />
                <!-- ApexCharts -->
                <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
                <script id="tailwind-config">
                    tailwind.config = {
                        darkMode: "class",
                        theme: {
                            extend: {
                                colors: {
                                    "primary": "#10B981",
                                    "background-light": "#f8fffc",
                                    "background-dark": "#0F172A",
                                    "sidebar-dark": "#111827",
                                },
                                fontFamily: {
                                    "display": ["Inter", "sans-serif"]
                                },
                                borderRadius: { "DEFAULT": "0.5rem", "lg": "1rem", "xl": "1.5rem", "full": "9999px" },
                            },
                        },
                    }
                </script>
                <style>
                    body {
                        font-family: 'Inter', sans-serif;
                    }

                    ::-webkit-scrollbar {
                        width: 8px;
                    }

                    ::-webkit-scrollbar-track {
                        background: #f1f1f1;
                    }

                    ::-webkit-scrollbar-thumb {
                        background: #cbd5e1;
                        border-radius: 4px;
                    }

                    ::-webkit-scrollbar-thumb:hover {
                        background: #94a3b8;
                    }
                </style>
            </head>

            <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
                <c:set var="activeMenu" value="transaction" scope="request" />
                <div class="flex min-h-screen">
                    <!-- Sidebar -->
                    <jsp:include page="/views/common/aside-admin.jsp" />

                    <!-- Main Content -->
                    <main class="flex-1 ml-64 min-h-screen">
                        <!-- Header -->
                        <header
                            class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                            <div class="flex items-center gap-8">
                                <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Transaction Management
                                </h1>
                                <div class="relative w-96">
                                    <span
                                        class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                    <input
                                        class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm"
                                        placeholder="Search transactions..." type="text" />
                                </div>
                            </div>
                            <div class="flex items-center gap-4">
                                <button
                                    class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                                    <span class="material-icons">notifications</span>
                                    <span
                                        class="absolute top-2 right-2 w-2 h-2 bg-primary rounded-full border-2 border-white dark:border-background-dark"></span>
                                </button>

                            </div>
                        </header>

                        <!-- Content Section -->
                        <div class="p-8">
                            <!-- Section 1: Statistics Cards -->
                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                                <!-- Total Revenue -->
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total
                                                Revenue</p>
                                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">
                                                $${totalRevenue}</p>
                                        </div>
                                        <div
                                            class="w-12 h-12 rounded-full bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-500 flex items-center justify-center">
                                            <span class="material-icons">attach_money</span>
                                        </div>
                                    </div>
                                    <div class="mt-4 flex items-center gap-1 text-sm">
                                        <span class="text-emerald-500 font-medium flex items-center">
                                            <span class="material-icons text-sm">arrow_upward</span> 12.5%
                                        </span>
                                        <span class="text-slate-500">vs last month</span>
                                    </div>
                                </div>

                                <!-- Total Transactions -->
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total
                                                Transactions</p>
                                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">
                                                ${totalTransactions}</p>
                                        </div>
                                        <div
                                            class="w-12 h-12 rounded-full bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-500 flex items-center justify-center">
                                            <span class="material-icons">receipt_long</span>
                                        </div>
                                    </div>
                                    <div class="mt-4 flex items-center gap-1 text-sm">
                                        <span class="text-emerald-500 font-medium flex items-center">
                                            <span class="material-icons text-sm">arrow_upward</span> 8.2%
                                        </span>
                                        <span class="text-slate-500">vs last month</span>
                                    </div>
                                </div>

                                <!-- Successful Payments -->
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">
                                                Successful Payments</p>
                                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">
                                                ${successPayments}</p>
                                        </div>
                                        <div
                                            class="w-12 h-12 rounded-full bg-primary/10 text-primary flex items-center justify-center">
                                            <span class="material-icons">check_circle</span>
                                        </div>
                                    </div>
                                    <div class="mt-4 flex items-center gap-1 text-sm">
                                        <span class="text-emerald-500 font-medium flex items-center">
                                            <span class="material-icons text-sm">arrow_upward</span> 5.1%
                                        </span>
                                        <span class="text-slate-500">vs last month</span>
                                    </div>
                                </div>

                                <!-- Failed Payments -->
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">
                                                Failed
                                                Payments</p>
                                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">
                                                ${failedPayments}</p>
                                        </div>
                                        <div
                                            class="w-12 h-12 rounded-full bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-500 flex items-center justify-center">
                                            <span class="material-icons">error_outline</span>
                                        </div>
                                    </div>
                                    <div class="mt-4 flex items-center gap-1 text-sm">
                                        <span class="text-red-500 font-medium flex items-center">
                                            <span class="material-icons text-sm">arrow_downward</span> 1.2%
                                        </span>
                                        <span class="text-slate-500">vs last month</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Section 2: Revenue Analytics Chart -->
                            <div
                                class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm mb-8">
                                <div class="flex items-center justify-between mb-6">
                                    <h2 class="text-lg font-bold text-slate-900 dark:text-white">Revenue Analytics</h2>
                                    <!-- Toggle Buttons -->
                                    <div class="flex items-center bg-slate-100 dark:bg-slate-900 p-1 rounded-lg">
                                        <button id="btnWeekly" onclick="updateChart('weekly')"
                                            class="px-4 py-1.5 text-sm font-medium rounded-md bg-white dark:bg-slate-700 text-slate-900 dark:text-white shadow-sm transition-all duration-200">Weekly</button>
                                        <button id="btnMonthly" onclick="updateChart('monthly')"
                                            class="px-4 py-1.5 text-sm font-medium rounded-md text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-slate-300 transition-all duration-200">Monthly</button>
                                    </div>
                                </div>
                                <!-- Chart Area -->
                                <div id="revenueChart" class="w-full h-[350px]"></div>
                            </div>

                            <!-- Section 3: Recent Transactions -->
                            <div>
                                <h2 class="text-lg font-bold text-slate-900 dark:text-white mb-4">Recent Transactions
                                </h2>

                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${empty recentTransactions}">
                                            <p class="text-slate-500 italic">No recent transactions found.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="tx" items="${recentTransactions}">
                                                <a href="javascript:void(0)"
                                                    onclick="openDetailModal('${pageContext.request.contextPath}/admin/transaction-detail?id=${tx.paymentId}')"
                                                    class="block">
                                                    <div
                                                        class="bg-white dark:bg-slate-800/50 p-4 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm hover:shadow-md hover:border-primary/30 transition-all cursor-pointer flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
                                                        <div class="flex items-center gap-4">
                                                            <div
                                                                class="w-10 h-10 rounded-full bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-500 flex items-center justify-center font-bold text-sm uppercase">
                                                                <c:out
                                                                    value="${fn:substring(tx.studentId.users.fullName != null ? tx.studentId.users.fullName : 'UN', 0, 2)}" />
                                                            </div>
                                                            <div>
                                                                <p class="font-semibold text-slate-900 dark:text-white">
                                                                    <c:out
                                                                        value="${tx.studentId.users.fullName != null ? tx.studentId.users.fullName : 'Unknown User'}" />
                                                                </p>
                                                                <p class="text-xs text-slate-500">
                                                                    <c:out value="${tx.vnpTxnRef}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="flex flex-col md:flex-row items-start md:items-center gap-4 md:gap-8 w-full md:w-auto">
                                                            <c:choose>
                                                                <c:when test="${tx.status == 'SUCCESS'}">
                                                                    <span
                                                                        class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-500 whitespace-nowrap">
                                                                        <span
                                                                            class="w-1.5 h-1.5 bg-emerald-500 rounded-full mr-1.5"></span>
                                                                        Completed
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${tx.status == 'FAILED'}">
                                                                    <span
                                                                        class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-500 whitespace-nowrap">
                                                                        <span
                                                                            class="w-1.5 h-1.5 bg-red-500 rounded-full mr-1.5"></span>
                                                                        Failed
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-500 whitespace-nowrap">
                                                                        <span
                                                                            class="w-1.5 h-1.5 bg-amber-500 rounded-full mr-1.5"></span>
                                                                        Pending
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div class="text-right flex-1 md:flex-none">
                                                                <p class="font-bold text-slate-900 dark:text-white">USD
                                                                    <c:out value="${tx.amount}" />
                                                                </p>
                                                                <p class="text-xs text-slate-500">
                                                                    <c:out value="${tx.createdAt}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                        </div>
                    </main>
                </div>

                <!-- Transaction Detail Modal Overlay -->
                <div id="detailModal" class="fixed inset-0 z-[9999] hidden">
                    <!-- Glass blur overlay -->
                    <div class="absolute inset-0 bg-black/30 backdrop-blur-md transition-opacity duration-300"
                        onclick="closeDetailModal()"></div>
                    <!-- Modal container -->
                    <div class="absolute inset-0 flex items-center justify-center p-4 pointer-events-none">
                        <div class="relative w-full max-w-[900px] max-h-[90vh] pointer-events-auto">
                            <!-- Close button -->
                            <button onclick="closeDetailModal()"
                                class="absolute -top-3 -right-3 z-10 w-9 h-9 flex items-center justify-center rounded-full bg-white shadow-lg text-gray-500 hover:text-gray-800 hover:bg-gray-100 transition-all">
                                <span class="material-icons text-xl">close</span>
                            </button>
                            <!-- Iframe content -->
                            <iframe id="detailIframe" src="" class="w-full rounded-2xl shadow-2xl bg-white"
                                style="height: 85vh; border: none;"></iframe>
                        </div>
                    </div>
                </div>

                <!-- Chart Configuration Script -->
                <script>
                    // Data from Backend
                    const weeklyCatsStr = '${weeklyCategories}';
                    const weeklySerStr = '${weeklySeries}';
                    const monthlyCatsStr = '${monthlyCategories}';
                    const monthlySerStr = '${monthlySeries}';

                    let wCats = [];
                    let wSer = [];
                    let mCats = [];
                    let mSer = [];

                    try {
                        if (weeklyCatsStr) wCats = JSON.parse(weeklyCatsStr);
                        if (weeklySerStr) wSer = JSON.parse(weeklySerStr);
                        if (monthlyCatsStr) mCats = JSON.parse(monthlyCatsStr);
                        if (monthlySerStr) mSer = JSON.parse(monthlySerStr);
                    } catch (e) {
                        console.error("Error parsing chart data", e);
                    }

                    const dataWeekly = {
                        categories: wCats,
                        series: [{ name: 'Revenue', data: wSer }]
                    };

                    const dataMonthly = {
                        categories: mCats,
                        series: [{ name: 'Revenue', data: mSer }]
                    };

                    // Chart options
                    const apexOptions = {
                        chart: {
                            type: 'bar',
                            height: 350,
                            fontFamily: 'Inter, sans-serif',
                            toolbar: { show: false }
                        },
                        colors: ['#10B981'],
                        plotOptions: {
                            bar: {
                                borderRadius: 4,
                                columnWidth: '50%',
                            }
                        },
                        dataLabels: { enabled: false },
                        series: dataWeekly.series,
                        xaxis: {
                            categories: dataWeekly.categories,
                            axisBorder: { show: false },
                            axisTicks: { show: false },
                            labels: {
                                style: { colors: '#64748b' }
                            }
                        },
                        yaxis: {
                            labels: {
                                style: { colors: '#64748b' },
                                formatter: (value) => { return "$" + value }
                            }
                        },
                        grid: {
                            borderColor: '#e2e8f0',
                            strokeDashArray: 4,
                            yaxis: { lines: { show: true } }
                        },
                        tooltip: {
                            theme: 'light',
                            y: { formatter: function (val) { return "$" + val } }
                        }
                    };

                    // Render Chart
                    let chart = new ApexCharts(document.querySelector("#revenueChart"), apexOptions);
                    chart.render();

                    // Handle Chart Toggle
                    function updateChart(mode) {
                        const btnWeekly = document.getElementById('btnWeekly');
                        const btnMonthly = document.getElementById('btnMonthly');

                        const activeClass = ['bg-white', 'dark:bg-slate-700', 'text-slate-900', 'dark:text-white', 'shadow-sm'];
                        const inactiveClass = ['text-slate-500', 'dark:text-slate-400', 'hover:text-slate-700', 'dark:hover:text-slate-300', 'bg-transparent'];

                        if (mode === 'monthly') {
                            btnMonthly.classList.add(...activeClass);
                            btnMonthly.classList.remove(...inactiveClass);

                            btnWeekly.classList.add(...inactiveClass);
                            btnWeekly.classList.remove(...activeClass);

                            chart.updateSeries(dataMonthly.series);
                            chart.updateOptions({ xaxis: { categories: dataMonthly.categories } });
                        } else {
                            btnWeekly.classList.add(...activeClass);
                            btnWeekly.classList.remove(...inactiveClass);

                            btnMonthly.classList.add(...inactiveClass);
                            btnMonthly.classList.remove(...activeClass);

                            chart.updateSeries(dataWeekly.series);
                            chart.updateOptions({ xaxis: { categories: dataWeekly.categories } });
                        }
                    }

                    // === Transaction Detail Modal ===
                    function openDetailModal(url) {
                        const modal = document.getElementById('detailModal');
                        const iframe = document.getElementById('detailIframe');
                        iframe.src = url;
                        modal.classList.remove('hidden');
                        document.body.style.overflow = 'hidden';
                    }

                    function closeDetailModal() {
                        const modal = document.getElementById('detailModal');
                        const iframe = document.getElementById('detailIframe');
                        modal.classList.add('hidden');
                        iframe.src = '';
                        document.body.style.overflow = '';
                    }

                    // Close modal on Escape key
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') closeDetailModal();
                    });
                </script>
            </body>

            </html>