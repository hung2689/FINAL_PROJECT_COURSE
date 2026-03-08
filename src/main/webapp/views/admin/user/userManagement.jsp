<%-- Document : userManagement --%>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Admin User Management Dashboard</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet" />
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                    rel="stylesheet" />
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
                </style>
            </head>

            <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
                <c:set var="activeMenu" value="users" scope="request" />
                <div class="flex min-h-screen">
                    <jsp:include page="/views/common/aside-admin.jsp" />
                    <main class="flex-1 ml-64 min-h-screen">
                        <header
                            class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                            <div class="flex items-center gap-8">
                                <h1 class="text-2xl font-bold text-slate-900 dark:text-white">User Management</h1>
                                <div class="relative w-96">
                                    <span
                                        class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                    <input
                                        class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm"
                                        placeholder="Search users, emails, or IDs..." type="text" />
                                </div>
                            </div>
                            <div class="flex items-center gap-4">
                                <button
                                    class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                                    <span class="material-icons">notifications</span>
                                    <span
                                        class="absolute top-2 right-2 w-2 h-2 bg-primary rounded-full border-2 border-white dark:border-background-dark"></span>
                                </button>
                                <button type="button" onclick="openAddUserModal()"
                                    class="bg-gradient-to-r from-emerald-500 to-emerald-600 text-white font-bold px-5 py-2.5 rounded-lg flex items-center gap-2 transition-all duration-200 shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/30 hover:scale-[1.02] active:scale-[0.98]">
                                    <span class="material-icons">add</span> Add New User
                                </button>
                                <div class="h-8 w-[1px] bg-slate-200 dark:bg-slate-800 mx-2"></div>
                                <div class="flex items-center gap-3">
                                    <img class="w-10 h-10 rounded-full object-cover border-2 border-primary/20"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuC3fr4TV71PEV9sNYTnWVWnR7SFkKNCP2tOJ3uTs7_134rEVjBQFJH_1TZv4PVE7-oihzRX-tgoP57g8KmcdbXZprDHAErYLIExmsgNUM3McmNYrzKm2iqzA3IF_JI_3dybUgk1kLagPSA4IxAI88M2-hbR_SNvLDVV9brN8WLVtQ5tJyF-ThF1ajLFnn_BDKoOK_XLZI68wABBdqinG1IIYP4gVTXlzN3NGob2goNK-zcTPi9O2dawgzY5HtsEjf7uojzNKEW_8DQ" />
                                    <div class="hidden lg:block">
                                        <p class="text-sm font-semibold text-slate-900 dark:text-white">Admin User</p>
                                        <p class="text-xs text-slate-500">Super Admin</p>
                                    </div>
                                </div>
                            </div>
                        </header>
                        <div class="p-8">
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Users
                                    </p>
                                    <p class="text-3xl font-bold mt-1">${totalUsers}</p>
                                    <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                        <span class="material-icons text-xs">trending_up</span><span>12% from last
                                            month</span>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Active
                                        Students</p>
                                    <p class="text-3xl font-bold mt-1">42.5k</p>
                                    <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                        <span class="material-icons text-xs">trending_up</span><span>8% from last
                                            month</span>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Active
                                        Teachers</p>
                                    <p class="text-3xl font-bold mt-1">1.2k</p>
                                    <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                        <span class="material-icons text-xs">trending_up</span><span>5% from last
                                            month</span>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Pending
                                        Teachers</p>
                                    <p class="text-3xl font-bold mt-1">45</p>
                                    <div class="mt-2 text-slate-400 text-xs flex items-center gap-1 font-semibold">
                                        <span class="material-icons text-xs">remove_red_eye</span><span>Needs
                                            review</span>
                                    </div>
                                </div>
                            </div>

                             <div
                                class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="w-full text-left border-collapse">
                                        <thead>
                                            <tr
                                                class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    User</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Contact</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Role</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Status</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                                    Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                            <c:forEach var="u" items="${users}">
                                                <tr
                                                    class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                                    <td class="px-6 py-4">
                                                        <div class="flex items-center gap-3">
                                                            <div
                                                                class="w-10 h-10 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center text-lg font-bold text-slate-500 dark:text-slate-400">
                                                                <span class="uppercase">${u.fullName.substring(0,
                                                                    1)}</span>
                                                            </div>
                                                            <div>
                                                                <p class="font-semibold text-slate-900 dark:text-white">
                                                                    ${u.fullName}</p>
                                                                <p class="text-xs text-slate-500">ID: ${u.userId}</p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <p class="text-sm">${u.email}</p>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <span
                                                            class="px-2 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 text-[10px] font-bold rounded uppercase">${roleMap[u.userId]
                                                            != null ? roleMap[u.userId] : 'USER'}</span>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <c:choose>
                                                            <c:when test="${u.status == 'ACTIVE'}">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700">${u.status}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600">${u.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="px-6 py-4 text-right space-x-2">
                                                        <button type="button" onclick="openUpdateUserModal(${u.userId})"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                            <span class="material-icons text-lg">edit</span>
                                                        </button>
                                                        <button type="button" onclick="confirmDelete(${u.userId})"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-red-500 transition-colors duration-200">
                                                            <span class="material-icons text-lg">delete</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div
                                    class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50">
                                    <div class="text-sm text-slate-500">
                                        Showing <span class="font-medium">${(currentPage - 1) * 10 + 1}</span> to
                                        <span class="font-medium">${currentPage * 10 > totalUsers ? totalUsers :
                                            currentPage * 10}</span>
                                        of <span class="font-medium">${totalUsers}</span> users
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <c:if test="${currentPage > 1}">
                                            <a href="?page=${currentPage - 1}"
                                                class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                                <span class="material-icons text-sm">chevron_left</span>
                                            </a>
                                        </c:if>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <a href="?page=${i}"
                                                class="w-8 h-8 rounded flex items-center justify-center text-sm ${i == currentPage ? 'bg-primary text-background-dark font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-800'}">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <a href="?page=${currentPage + 1}"
                                                class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                                <span class="material-icons text-sm">chevron_right</span>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>

                <!-- MODALS -->
                <div id="addUserModal" class="fixed inset-0 hidden items-center justify-center z-50">
                    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeAddUserModal()"></div>
                    <div class="relative z-10 w-full flex justify-center px-4">
                        <jsp:include page="addUser.jsp" />
                    </div>
                </div>

                <div id="updateUserModal" class="fixed inset-0 hidden items-center justify-center z-50">
                    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeUpdateUserModal()"></div>
                    <div class="relative z-10 w-full flex justify-center px-4">
                        <jsp:include page="updateUser.jsp" />
                    </div>
                </div>

                <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/users">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="user_id" id="deleteUserId">
                </form>

                <script src="${pageContext.request.contextPath}/assets/js/user-management.js"></script>
            </body>

            </html>