<%-- Document : dashboard Created on : Mar 17, 2026 Author : ASUS --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Admin Dashboard - DevLearn</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap"
              rel="stylesheet" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.7/dist/chart.umd.min.js"></script>
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
                        borderRadius: {"DEFAULT": "0.5rem", "lg": "1rem", "xl": "1.5rem", "full": "9999px"},
                    },
                },
            }
        </script>
        <style>
            body { font-family: 'Inter', sans-serif; }
            .stat-card {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 20px 40px -12px rgba(0,0,0,0.1);
            }
            @keyframes fadeInUp {
                from { opacity: 0; transform: translateY(20px); }
                to   { opacity: 1; transform: translateY(0); }
            }
            .fade-up { animation: fadeInUp 0.5s ease-out both; }
            .fade-up-1 { animation-delay: 0.05s; }
            .fade-up-2 { animation-delay: 0.1s; }
            .fade-up-3 { animation-delay: 0.15s; }
            .fade-up-4 { animation-delay: 0.2s; }
            .fade-up-5 { animation-delay: 0.25s; }
            .fade-up-6 { animation-delay: 0.3s; }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
        <c:set var="activeMenu" value="dashboard" scope="request" />
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="/views/common/aside-admin.jsp" />

            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-4">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Dashboard</h1>
                        <span class="px-3 py-1 bg-emerald-50 text-emerald-600 text-xs font-bold rounded-full border border-emerald-200">Live</span>
                    </div>
                    <div class="flex items-center gap-4">
                        <button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                            <span class="material-icons">notifications</span>
                            <span class="absolute top-2 right-2 w-2 h-2 bg-primary rounded-full border-2 border-white dark:border-background-dark"></span>
                        </button>
                        <div class="h-8 w-[1px] bg-slate-200 dark:bg-slate-800 mx-2"></div>
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-400 to-teal-600 flex items-center justify-center text-white font-bold text-sm">
                                A
                            </div>
                            <div class="hidden lg:block">
                                <p class="text-sm font-semibold text-slate-900 dark:text-white">Admin</p>
                                <p class="text-xs text-slate-500">Super Admin</p>
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Content -->
                <div class="p-8">

                    <!-- Welcome Banner -->
                    <div class="fade-up fade-up-1 bg-gradient-to-r from-emerald-500 via-emerald-600 to-teal-600 rounded-2xl p-8 mb-8 relative overflow-hidden">
                        <div class="absolute top-0 right-0 w-80 h-80 bg-white/5 rounded-full -translate-y-1/2 translate-x-1/4"></div>
                        <div class="absolute bottom-0 left-1/3 w-48 h-48 bg-white/5 rounded-full translate-y-1/2"></div>
                        <div class="relative z-10">
                            <p class="text-emerald-100 text-sm font-medium mb-1">Welcome back,</p>
                            <h2 class="text-2xl font-bold text-white mb-2">Admin Dashboard</h2>
                            <p class="text-emerald-100 text-sm max-w-lg">Here's what's happening with your platform today. Monitor key metrics, track activity, and manage everything from one place.</p>
                        </div>
                    </div>

                    <!-- Stats Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                        <!-- Total Students -->
                        <div class="stat-card fade-up fade-up-1 bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 rounded-2xl bg-blue-50 border border-blue-100 flex items-center justify-center">
                                    <span class="material-icons text-blue-600 text-2xl">people</span>
                                </div>
                                <span class="inline-flex items-center gap-1 text-xs font-semibold text-emerald-600">
                                    <span class="material-icons" style="font-size:14px;">trending_up</span>
                                    +12%
                                </span>
                            </div>
                            <p class="text-slate-500 text-xs font-medium uppercase tracking-wider">Total Students</p>
                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">1,248</p>
                        </div>

                        <!-- Total Courses -->
                        <div class="stat-card fade-up fade-up-2 bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 flex items-center justify-center">
                                    <span class="material-icons text-emerald-600 text-2xl">library_books</span>
                                </div>
                                <span class="inline-flex items-center gap-1 text-xs font-semibold text-emerald-600">
                                    <span class="material-icons" style="font-size:14px;">trending_up</span>
                                    +8%
                                </span>
                            </div>
                            <p class="text-slate-500 text-xs font-medium uppercase tracking-wider">Total Courses</p>
                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">86</p>
                        </div>

                        <!-- Teachers -->
                        <div class="stat-card fade-up fade-up-3 bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 rounded-2xl bg-violet-50 border border-violet-100 flex items-center justify-center">
                                    <span class="material-icons text-violet-600 text-2xl">school</span>
                                </div>
                                <span class="inline-flex items-center gap-1 text-xs font-semibold text-emerald-600">
                                    <span class="material-icons" style="font-size:14px;">trending_up</span>
                                    +3
                                </span>
                            </div>
                            <p class="text-slate-500 text-xs font-medium uppercase tracking-wider">Teachers</p>
                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">24</p>
                        </div>

                        <!-- Candidates -->
                        <div class="stat-card fade-up fade-up-4 bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 rounded-2xl bg-amber-50 border border-amber-100 flex items-center justify-center">
                                    <span class="material-icons text-amber-600 text-2xl">how_to_reg</span>
                                </div>
                                <span class="inline-flex items-center gap-1 text-xs font-semibold text-amber-500">
                                    <span class="material-icons" style="font-size:14px;">schedule</span>
                                    Pending
                                </span>
                            </div>
                            <p class="text-slate-500 text-xs font-medium uppercase tracking-wider">Candidates</p>
                            <p class="text-3xl font-bold mt-1 text-slate-900 dark:text-white">18</p>
                        </div>
                    </div>

                    <!-- Charts Row -->
                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">

                        <!-- Login Activity Chart (2 cols) -->
                        <div class="fade-up fade-up-5 lg:col-span-2 bg-white dark:bg-slate-800/50 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="px-6 py-5 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                                <div>
                                    <h3 class="text-base font-bold text-slate-900 dark:text-white">Student Login Activity</h3>
                                    <p class="text-xs text-slate-400 mt-0.5">Number of student logins over time</p>
                                </div>
                                <select id="chartFilter" onchange="updateChart()"
                                        class="px-3 py-1.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-xs font-semibold text-slate-600 dark:text-slate-300 focus:ring-2 focus:ring-primary/50 focus:border-primary cursor-pointer">
                                    <option value="7days" selected>Last 7 Days</option>
                                    <option value="today">Today</option>
                                    <option value="30days">Last 30 Days</option>
                                </select>
                            </div>
                            <div class="p-6">
                                <canvas id="loginChart" height="280"></canvas>
                            </div>
                        </div>

                        <!-- Course Distribution (1 col) -->
                        <div class="fade-up fade-up-6 bg-white dark:bg-slate-800/50 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <div class="px-6 py-5 border-b border-slate-100 dark:border-slate-800">
                                <h3 class="text-base font-bold text-slate-900 dark:text-white">Course by Category</h3>
                                <p class="text-xs text-slate-400 mt-0.5">Distribution of courses</p>
                            </div>
                            <div class="p-6 flex items-center justify-center">
                                <canvas id="categoryChart" height="240"></canvas>
                            </div>
                            <div class="px-6 pb-5 space-y-2.5" id="categoryLegend"></div>
                        </div>
                    </div>

                    <!-- Quick Access Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">
                        <a href="${pageContext.request.contextPath}/courseAdmin"
                           class="fade-up fade-up-3 group bg-white dark:bg-slate-800/50 p-5 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md hover:border-emerald-200 transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-11 h-11 rounded-xl bg-emerald-50 border border-emerald-100 flex items-center justify-center group-hover:bg-emerald-100 transition">
                                    <span class="material-icons text-emerald-600">library_books</span>
                                </div>
                                <div>
                                    <p class="text-sm font-bold text-slate-900 dark:text-white">Courses</p>
                                    <p class="text-xs text-slate-400">Manage all courses</p>
                                </div>
                                <span class="material-icons text-slate-300 ml-auto group-hover:text-emerald-500 transition">arrow_forward</span>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/userAdmin"
                           class="fade-up fade-up-4 group bg-white dark:bg-slate-800/50 p-5 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md hover:border-blue-200 transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-11 h-11 rounded-xl bg-blue-50 border border-blue-100 flex items-center justify-center group-hover:bg-blue-100 transition">
                                    <span class="material-icons text-blue-600">people</span>
                                </div>
                                <div>
                                    <p class="text-sm font-bold text-slate-900 dark:text-white">Users</p>
                                    <p class="text-xs text-slate-400">Manage all users</p>
                                </div>
                                <span class="material-icons text-slate-300 ml-auto group-hover:text-blue-500 transition">arrow_forward</span>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/candidatesAdmin"
                           class="fade-up fade-up-5 group bg-white dark:bg-slate-800/50 p-5 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md hover:border-amber-200 transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-11 h-11 rounded-xl bg-amber-50 border border-amber-100 flex items-center justify-center group-hover:bg-amber-100 transition">
                                    <span class="material-icons text-amber-600">how_to_reg</span>
                                </div>
                                <div>
                                    <p class="text-sm font-bold text-slate-900 dark:text-white">Candidates</p>
                                    <p class="text-xs text-slate-400">Review applications</p>
                                </div>
                                <span class="material-icons text-slate-300 ml-auto group-hover:text-amber-500 transition">arrow_forward</span>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/jobAdmin"
                           class="fade-up fade-up-6 group bg-white dark:bg-slate-800/50 p-5 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md hover:border-violet-200 transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-11 h-11 rounded-xl bg-violet-50 border border-violet-100 flex items-center justify-center group-hover:bg-violet-100 transition">
                                    <span class="material-icons text-violet-600">work</span>
                                </div>
                                <div>
                                    <p class="text-sm font-bold text-slate-900 dark:text-white">Teacher Jobs</p>
                                    <p class="text-xs text-slate-400">Manage job listings</p>
                                </div>
                                <span class="material-icons text-slate-300 ml-auto group-hover:text-violet-500 transition">arrow_forward</span>
                            </div>
                        </a>
                    </div>

                </div>
            </main>
        </div>

        <script>
            // =============================================
            //  MOCK DATA
            // =============================================
            var dataSets = {
                'today': {
                    labels: ['6AM','8AM','10AM','12PM','2PM','4PM','6PM','8PM','10PM'],
                    data:   [8, 25, 62, 45, 78, 54, 39, 28, 12]
                },
                '7days': {
                    labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
                    data:   [120, 98, 150, 200, 170, 90, 60]
                },
                '30days': {
                    labels: ['Week 1','Week 2','Week 3','Week 4'],
                    data:   [680, 820, 750, 910]
                }
            };

            // =============================================
            //  LOGIN ACTIVITY LINE CHART
            // =============================================
            var ctx = document.getElementById('loginChart').getContext('2d');

            // Gradient fill
            var gradient = ctx.createLinearGradient(0, 0, 0, 280);
            gradient.addColorStop(0, 'rgba(16, 185, 129, 0.15)');
            gradient.addColorStop(1, 'rgba(16, 185, 129, 0.0)');

            var loginChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: dataSets['7days'].labels,
                    datasets: [{
                        label: 'Student Logins',
                        data: dataSets['7days'].data,
                        borderColor: '#10B981',
                        backgroundColor: gradient,
                        borderWidth: 3,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#10B981',
                        pointBorderWidth: 3,
                        pointRadius: 5,
                        pointHoverRadius: 8,
                        pointHoverBorderWidth: 3,
                        pointHoverBackgroundColor: '#10B981',
                        pointHoverBorderColor: '#ffffff',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#0f172a',
                            titleColor: '#94a3b8',
                            bodyColor: '#ffffff',
                            bodyFont: { size: 14, weight: 'bold' },
                            titleFont: { size: 11 },
                            padding: 14,
                            cornerRadius: 12,
                            displayColors: false,
                            callbacks: {
                                title: function(items) { return items[0].label; },
                                label: function(item) { return item.formattedValue + ' logins'; }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            border: { display: false },
                            ticks: {
                                color: '#94a3b8',
                                font: { size: 12, weight: '500' }
                            }
                        },
                        y: {
                            beginAtZero: true,
                            border: { display: false },
                            grid: {
                                color: 'rgba(148,163,184,0.1)',
                                drawBorder: false
                            },
                            ticks: {
                                color: '#94a3b8',
                                font: { size: 12 },
                                padding: 8
                            }
                        }
                    }
                }
            });

            function updateChart() {
                var filter = document.getElementById('chartFilter').value;
                var ds = dataSets[filter];
                loginChart.data.labels = ds.labels;
                loginChart.data.datasets[0].data = ds.data;
                loginChart.update('active');
            }

            // =============================================
            //  COURSE CATEGORY DOUGHNUT CHART
            // =============================================
            var catColors = ['#10B981','#6366F1','#F59E0B','#EF4444','#3B82F6'];
            var catLabels = ['Software','Math','Foreign Language','Free Courses','Others'];
            var catData   = [35, 18, 22, 8, 3];

            var catCtx = document.getElementById('categoryChart').getContext('2d');
            new Chart(catCtx, {
                type: 'doughnut',
                data: {
                    labels: catLabels,
                    datasets: [{
                        data: catData,
                        backgroundColor: catColors,
                        borderWidth: 0,
                        hoverOffset: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '68%',
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#0f172a',
                            bodyColor: '#ffffff',
                            bodyFont: { size: 13, weight: 'bold' },
                            padding: 12,
                            cornerRadius: 10,
                            displayColors: true,
                            boxWidth: 10,
                            boxHeight: 10,
                            boxPadding: 4,
                            callbacks: {
                                label: function(item) {
                                    return ' ' + item.label + ': ' + item.raw + ' courses';
                                }
                            }
                        }
                    }
                }
            });

            // Build custom legend
            var legendHtml = '';
            for (var i = 0; i < catLabels.length; i++) {
                legendHtml += '<div class="flex items-center justify-between">' +
                    '<div class="flex items-center gap-2.5">' +
                    '<div class="w-2.5 h-2.5 rounded-full" style="background:' + catColors[i] + ';"></div>' +
                    '<span class="text-xs font-medium text-slate-600 dark:text-slate-400">' + catLabels[i] + '</span>' +
                    '</div>' +
                    '<span class="text-xs font-bold text-slate-800 dark:text-white">' + catData[i] + '</span>' +
                    '</div>';
            }
            document.getElementById('categoryLegend').innerHTML = legendHtml;
        </script>
    </body>
</html>
