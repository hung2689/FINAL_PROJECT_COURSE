<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Support Management | Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
    
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
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
    <c:set var="activeMenu" value="support" scope="request" />
    
    <div class="flex min-h-screen">
        <!-- Sidebar Include -->
        <jsp:include page="/views/common/aside-admin.jsp" />
        
        <main class="flex-1 ml-64 min-h-screen flex flex-col">
            <!-- Header -->
            <header class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                <div class="flex items-center gap-4">
                    <h1 class="text-2xl font-bold text-slate-900 dark:text-white flex items-center gap-2">
                        <span class="material-symbols-outlined text-emerald-500">support_agent</span>
                        Support Requests
                    </h1>
                    <span class="text-sm font-medium text-slate-500 bg-slate-100 dark:bg-slate-800 px-3 py-1 rounded-full">
                        Server Monitored
                    </span>
                </div>
                <div class="flex items-center gap-4">
                    <button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                        <span class="material-icons">notifications</span>
                        <c:if test="${not empty errorList}">
                            <span class="absolute top-2 right-2 w-2 h-2 bg-emerald-500 rounded-full border-2 border-white dark:border-background-dark"></span>
                        </c:if>
                    </button>
                    <!-- Server active pulse icon -->
                    <div class="flex items-center gap-2 px-4 py-2 bg-emerald-50 border border-emerald-100 dark:bg-emerald-900/20 dark:border-emerald-800 rounded-full">
                        <span class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></span>
                        <span class="text-xs font-bold text-emerald-600 dark:text-emerald-400 uppercase tracking-widest">Active</span>
                    </div>
                </div>
            </header>

            <!-- Main Content Area -->
            <div class="p-8 flex-1">
                <div class="mb-6">
                    <p class="text-slate-500 dark:text-slate-400 font-medium">Monitoring real-time student technical issues. Review tickets and mark them as resolved below.</p>
                </div>

                <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden transition-all duration-200">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800 text-slate-500 text-xs uppercase tracking-wider font-bold">
                                    <th class="px-6 py-4">Student Info</th>
                                    <th class="px-6 py-4">Issue Description</th>
                                    <th class="px-6 py-4 text-center">Screenshot</th>
                                    <th class="px-6 py-4 text-center">Status</th>
                                    <th class="px-6 py-4 text-right">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                <c:forEach items="${errorList}" var="report">
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/40 transition-colors duration-200 group">
                                        <td class="px-6 py-4">
                                            <div class="font-bold text-slate-900 dark:text-slate-100">${report.studentName}</div>
                                            <div class="text-[12px] text-slate-400 font-medium mt-1">
                                                <span class="material-symbols-outlined text-[12px] align-middle">calendar_clock</span>
                                                <fmt:formatDate value="${report.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <p class="text-sm text-slate-600 dark:text-slate-400 max-w-sm truncate font-medium" title="${report.description}">
                                                ${report.description}
                                            </p>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex justify-center">
                                                <a href="${pageContext.request.contextPath}/${report.imagePath}" target="_blank" class="block w-12 h-12 relative group/img">
                                                    <img src="${pageContext.request.contextPath}/${report.imagePath}" 
                                                         onerror="this.src='https://placehold.co/100x100?text=No+Image'"
                                                         class="w-full h-full object-cover rounded-xl border-2 border-white dark:border-slate-700 shadow-sm group-hover/img:scale-110 transition-transform cursor-zoom-in">
                                                </a>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <span class="px-3 py-1.5 rounded-full text-[10px] font-bold tracking-widest uppercase
                                                ${report.status == 'PENDING' ? 'bg-amber-100 text-amber-600 dark:bg-amber-900/30 dark:text-amber-500' : 'bg-emerald-100 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-500'}">
                                                ${report.status}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <button data-id="${report.id}" 
                                                    data-student="${report.studentName}" 
                                                    data-desc="${report.description}" 
                                                    data-img="${report.imagePath}" 
                                                    data-status="${report.status}"
                                                    onclick="openDetails(this)" 
                                                    class="inline-flex items-center gap-1.5 bg-slate-900 dark:bg-slate-700 text-white hover:bg-emerald-500 dark:hover:bg-emerald-500 px-4 py-2 rounded-lg text-xs font-bold transition-all shadow-md hover:shadow-emerald-200 dark:hover:shadow-none cursor-pointer border-none">
                                                <span class="material-symbols-outlined text-[16px]">visibility</span>
                                                Details
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <c:if test="${empty errorList}">
                        <div class="p-16 text-center">
                            <span class="material-symbols-outlined text-6xl text-slate-200 dark:text-slate-700 mb-4 block">auto_awesome</span>
                            <h3 class="text-lg font-bold text-slate-700 dark:text-slate-300">Inbox is clear!</h3>
                            <p class="text-slate-400 mt-2 font-medium">No new reports found in the system.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>

    <!-- DETAILS MODAL -->
    <div id="detailsModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/60 backdrop-blur-md p-4 transition-all">
        <div class="absolute inset-0 z-0" onclick="closeDetails()"></div>
        <div class="bg-white dark:bg-slate-900 w-full max-w-3xl rounded-[32px] shadow-2xl overflow-hidden relative z-10 animate-[fadeIn_0.3s_ease-out]">
            <div class="px-8 py-6 flex justify-between items-center border-b border-slate-100 dark:border-slate-800">
                <div>
                    <h3 class="text-xl font-bold text-slate-900 dark:text-white">Issue Ticket <span id="modalId" class="text-emerald-500 ml-1"></span></h3>
                    <p class="text-sm text-slate-400 font-medium">Reviewing student reported error</p>
                </div>
                <button onclick="closeDetails()" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-red-50 dark:hover:bg-red-900/20 text-slate-400 hover:text-red-500 transition-colors border-none cursor-pointer">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>

            <div class="p-8 grid grid-cols-1 md:grid-cols-2 gap-8">
                <div class="space-y-6">
                    <div>
                        <label class="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-500 mb-2 block">Student Name</label>
                        <p id="modalStudent" class="text-lg font-semibold text-slate-900 dark:text-white"></p>
                    </div>
                    <div>
                        <label class="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-500 mb-2 block">Issue Description</label>
                        <div id="modalDesc" class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed bg-slate-50 dark:bg-slate-800 p-5 rounded-2xl border border-slate-100 dark:border-slate-700 min-h-[140px] font-medium italic"></div>
                    </div>
                </div>
                <div>
                    <label class="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-500 mb-2 block text-center">Screenshot</label>
                    <a id="modalImgLink" href="#" target="_blank" class="block group rounded-2xl overflow-hidden relative shadow-md">
                        <img id="modalImg" src="" class="w-full h-[220px] object-cover border border-slate-200 dark:border-slate-700 transition-transform duration-300 group-hover:scale-105">
                        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors flex items-center justify-center">
                            <span class="material-symbols-outlined text-white opacity-0 group-hover:opacity-100 drop-shadow-md transition-opacity">open_in_new</span>
                        </div>
                    </a>
                </div>
            </div>

            <div class="px-8 py-6 bg-slate-50/50 dark:bg-slate-800/30 border-t border-slate-100 dark:border-slate-800 flex justify-end gap-3">
                <button onclick="closeDetails()" class="px-6 py-2.5 text-slate-500 dark:text-slate-400 text-sm font-semibold hover:bg-slate-200/50 dark:hover:bg-slate-800 rounded-xl transition-all border-none cursor-pointer">Close</button>
                <form action="${pageContext.request.contextPath}/update-report-status" method="POST">
                    <input type="hidden" name="reportId" id="inputReportId">
                    <button id="btnResolve" type="submit" class="px-6 py-2.5 flex items-center gap-2 bg-emerald-500 hover:bg-emerald-600 text-white text-sm font-bold rounded-xl shadow-lg shadow-emerald-100 dark:shadow-none transition-all border-none cursor-pointer hover:-translate-y-0.5">
                        <span class="material-symbols-outlined text-[18px]">check_circle</span>
                        Mark as Resolved
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openDetails(btn) {
            const id = btn.getAttribute('data-id');
            const student = btn.getAttribute('data-student');
            const desc = btn.getAttribute('data-desc');
            const img = btn.getAttribute('data-img');
            const status = btn.getAttribute('data-status');

            document.getElementById('modalId').innerText = '#' + id;
            document.getElementById('inputReportId').value = id;
            document.getElementById('modalStudent').innerText = student;
            document.getElementById('modalDesc').innerText = desc;
            
            const cleanImgPath = img.replace(/\\/g, '/'); 
            const fullImgUrl = '${pageContext.request.contextPath}/' + cleanImgPath;
            
            document.getElementById('modalImg').src = fullImgUrl;
            document.getElementById('modalImgLink').href = fullImgUrl;
            
            const btnResolve = document.getElementById('btnResolve');
            if (status === 'RESOLVED') {
                btnResolve.classList.add('hidden');
            } else {
                btnResolve.classList.remove('hidden');
            }

            document.getElementById('detailsModal').classList.remove('hidden');
        }

        function closeDetails() {
            document.getElementById('detailsModal').classList.add('hidden');
        }

        // Close on ESC block
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeDetails();
            }
        });
    </script>
</body>
</html>