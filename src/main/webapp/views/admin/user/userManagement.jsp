<%-- Document : userManagement --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        borderRadius: {"DEFAULT": "0.5rem", "lg": "1rem", "xl": "1.5rem", "full": "9999px"},
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
                    <div class="flex items-center gap-4">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">User Management</h1>
                        <select id="viewSelector" onchange="switchView(this.value)"
                                class="px-4 py-2 rounded-lg bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-sm font-semibold text-slate-700 dark:text-slate-200 focus:ring-2 focus:ring-primary/50 cursor-pointer shadow-sm">
                            <option value="users">All Users</option>
                            <option value="teachers">Teachers</option>
                            <option value="students">Students</option>
                        </select>
                        <form id="searchForm" onsubmit="event.preventDefault();" class="relative w-[400px]">
                            <span class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input type="text" id="globalSearchInput" name="search_global" value=""
                                   oninput="filterCurrentView()"
                                   class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-full ring-1 ring-slate-200 dark:ring-slate-700 focus:ring-2 focus:ring-primary/50 text-sm transition-all shadow-sm"
                                   placeholder="Search..." autofocus="autofocus" autocomplete="off" />
                        </form>
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

                    </div>
                </header>
                <div class="p-8">
                    <c:if test="${not empty ERROR}">
                        <div class="mb-6 bg-red-50 dark:bg-red-900/30 border border-red-200 dark:border-red-800 text-red-600 dark:text-red-400 px-4 py-3 rounded-xl flex items-center gap-3">
                            <span class="material-icons">error_outline</span>
                            <p class="font-medium text-sm">${ERROR}</p>
                        </div>
                    </c:if>
                    
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Users
                            </p>
                            <p id="totalUsersCount" class="text-3xl font-bold mt-1">${totalUsers}</p>
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

                    <!-- SEARCH FILTER FORM REMOVED PER REQ -->

                    <!-- ==================== USERS TABLE ==================== -->
                    <div id="viewUsers">
                        <div id="tableContainer"
                             class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden transition-opacity duration-200">
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
                                                class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                Coins</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                                Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                        <c:forEach var="u" items="${users}">
                                            <tr
                                                class="user-row hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors"
                                                data-search="${u.userId} ${u.fullName.toLowerCase()} ${u.email.toLowerCase()}">
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
                                                <td class="px-6 py-4">
                                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold bg-amber-50 text-amber-600 border border-amber-200">
                                                        <span class="material-icons text-xs">monetization_on</span>
                                                        ${u.studyCoins != null ? u.studyCoins : 0}
                                                    </span>
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
                                class="px-6 py-4 flex flex-col sm:flex-row items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50 relative">
                                <div class="text-sm text-slate-500 mb-4 sm:mb-0">
                                    Showing <span id="visibleRange" class="font-medium">0 - 0</span> 
                                    of <span id="visibleCount" class="font-medium">${totalUsers}</span> users
                                </div>
                                <div id="paginationControls" class="flex items-center gap-2"></div>
                                <div id="noUserFound" style="display: none;" class="w-full text-center py-4 absolute inset-x-0 bottom-10 left-0 right-0">
                                    <span class="material-icons text-4xl text-slate-300">search_off</span>
                                    <h3 class="text-lg font-bold text-slate-700 mt-2">No results found</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ==================== TEACHERS TABLE ==================== -->
                    <div id="viewTeachers" style="display:none;">
                        <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse">
                                    <thead>
                                        <tr class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Teacher</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Email</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Specialization</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Experience</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Approval</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">CV</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                        <c:forEach var="t" items="${teachers}">
                                            <tr class="teacher-row hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors"
                                                data-search="${t.teacherId} ${t.users.fullName.toLowerCase()} ${t.users.email.toLowerCase()} ${t.specialization != null ? t.specialization.toLowerCase() : ''}">
                                                <td class="px-6 py-4">
                                                    <div class="flex items-center gap-3">
                                                        <div class="w-10 h-10 rounded-full bg-emerald-100 dark:bg-emerald-900/30 flex items-center justify-center text-lg font-bold text-emerald-600">
                                                            <span class="uppercase">${t.users.fullName.substring(0, 1)}</span>
                                                        </div>
                                                        <div>
                                                            <p class="font-semibold text-slate-900 dark:text-white">${t.users.fullName}</p>
                                                            <p class="text-xs text-slate-500">ID: ${t.teacherId}</p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 text-sm">${t.users.email}</td>
                                                <td class="px-6 py-4 text-sm">${t.specialization != null ? t.specialization : '-'}</td>
                                                <td class="px-6 py-4 text-sm font-semibold">${t.experienceYear != null ? t.experienceYear : 0} yrs</td>
                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${t.approvalStatus == 'APPROVED'}">
                                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700">${t.approvalStatus}</span>
                                                        </c:when>
                                                        <c:when test="${t.approvalStatus == 'PENDING'}">
                                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-700">${t.approvalStatus}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600">${t.approvalStatus != null ? t.approvalStatus : 'N/A'}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <c:if test="${t.cvUrl != null && t.cvUrl != ''}">
                                                        <!-- View CV -->
                                                        <button type="button" onclick="openCvModal('${t.cvUrl}')"
                                                                title="View CV"
                                                                class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                            <span class="material-icons text-lg">description</span>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${t.cvUrl == null || t.cvUrl == ''}"><span class="text-slate-400 text-sm">-</span></c:if>
                                                    </td>
                                                    <td class="px-6 py-4 text-right">
                                                        <button type="button" onclick="openUpdateTeacherModal(${t.teacherId})"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                        <span class="material-icons text-lg">edit</span>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50 relative">
                                <div class="text-sm text-slate-500">
                                    Showing <span id="teacherVisibleRange" class="font-medium">0 - 0</span> 
                                    of <span id="teacherVisibleCount" class="font-medium">0</span> teachers
                                </div>
                                <div id="teacherPaginationControls" class="flex items-center gap-2"></div>
                                <div id="noTeacherFound" style="display: none;" class="w-full text-center py-4 absolute inset-x-0 bottom-10">
                                    <span class="material-icons text-4xl text-slate-300">search_off</span>
                                    <h3 class="text-lg font-bold text-slate-700 mt-2">No results found</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ==================== STUDENTS TABLE ==================== -->
                    <div id="viewStudents" style="display:none;">
                        <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse">
                                    <thead>
                                        <tr class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Student</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Email</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Level</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Date of Birth</th>
                                            <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                        <c:forEach var="s" items="${students}">
                                            <tr class="student-row hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors"
                                                data-search="${s.studentId} ${s.users.fullName.toLowerCase()} ${s.users.email.toLowerCase()} ${s.level != null ? s.level.toLowerCase() : ''}">
                                                <td class="px-6 py-4">
                                                    <div class="flex items-center gap-3">
                                                        <div class="w-10 h-10 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center text-lg font-bold text-blue-600">
                                                            <span class="uppercase">${s.users.fullName.substring(0, 1)}</span>
                                                        </div>
                                                        <div>
                                                            <p class="font-semibold text-slate-900 dark:text-white">${s.users.fullName}</p>
                                                            <p class="text-xs text-slate-500">ID: ${s.studentId}</p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 text-sm">${s.users.email}</td>
                                                <td class="px-6 py-4">
                                                    <span class="px-2 py-1 bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400 text-[10px] font-bold rounded uppercase">${s.level != null ? s.level : 'N/A'}</span>
                                                </td>
                                                <td class="px-6 py-4 text-sm">
                                                    <fmt:formatDate value="${s.dateOfBirth}" pattern="dd/MM/yyyy" var="formattedDob"/>
                                                    ${not empty formattedDob ? formattedDob : '-'}
                                                </td>
                                                <td class="px-6 py-4 text-right">
                                                    <button type="button" onclick="openUpdateStudentModal(${s.studentId})"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                        <span class="material-icons text-lg">edit</span>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50 relative">
                                <div class="text-sm text-slate-500">
                                    Showing <span id="studentVisibleRange" class="font-medium">0 - 0</span> 
                                    of <span id="studentVisibleCount" class="font-medium">0</span> students
                                </div>
                                <div id="studentPaginationControls" class="flex items-center gap-2"></div>
                                <div id="noStudentFound" style="display: none;" class="w-full text-center py-4 absolute inset-x-0 bottom-10">
                                    <span class="material-icons text-4xl text-slate-300">search_off</span>
                                    <h3 class="text-lg font-bold text-slate-700 mt-2">No results found</h3>
                                </div>
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

        <!-- UPDATE TEACHER MODAL -->
        <div id="updateTeacherModal" class="fixed inset-0 hidden items-center justify-center z-50">
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeUpdateTeacherModal()"></div>
            <div class="relative z-10 w-full flex justify-center px-4">
                <div class="bg-white dark:bg-slate-900 rounded-2xl w-full max-w-2xl overflow-hidden shadow-2xl relative">
                    <div class="flex items-center justify-between p-6 border-b border-slate-200 dark:border-slate-800">
                        <h3 class="text-xl font-bold text-slate-900 dark:text-white">Update Teacher</h3>
                        <button type="button" onclick="closeUpdateTeacherModal()" class="text-slate-400 hover:text-slate-500">
                            <span class="material-icons">close</span>
                        </button>
                    </div>
                    <form id="updateTeacherForm" action="${pageContext.request.contextPath}/userAdmin" method="post" class="p-6">
                        <input type="hidden" name="action" value="updateTeacher">
                        <input type="hidden" name="teacher_id" id="updateTeacherId">
                        <div class="grid grid-cols-1 gap-6">
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Full Name</label>
                                    <input type="text" id="updateTeacherFullName" disabled
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 text-slate-500 cursor-not-allowed" />
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Email</label>
                                    <input type="text" id="updateTeacherEmail" disabled
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 text-slate-500 cursor-not-allowed" />
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Specialization</label>
                                <input type="text" name="specialization" id="updateTeacherSpecialization"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50"
                                       placeholder="e.g. Web Development, Data Science..." />
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Experience (years)</label>
                                    <input type="number" name="experienceYear" id="updateTeacherExpYear" min="0"
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50" />
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Approval Status</label>
                                    <select name="approvalStatus" id="updateTeacherApproval"
                                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50">
                                        <option value="PENDING">PENDING</option>
                                        <option value="APPROVED">APPROVED</option>
                                        <option value="REJECTED">REJECTED</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">CV URL</label>
                                <input type="url" name="cvUrl" id="updateTeacherCvUrl"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50"
                                       placeholder="https://..." />
                            </div>
                        </div>
                        <div class="mt-8 flex justify-end gap-3 border-t border-slate-200 dark:border-slate-800 pt-6">
                            <button type="button" onclick="closeUpdateTeacherModal()"
                                    class="px-5 py-2.5 rounded-lg text-slate-500 font-medium hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">Cancel</button>
                            <button type="submit"
                                    class="bg-primary text-background-dark font-bold px-5 py-2.5 rounded-lg hover:shadow-lg hover:shadow-primary/30 transition-all">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- UPDATE STUDENT MODAL -->
        <div id="updateStudentModal" class="fixed inset-0 hidden items-center justify-center z-50">
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeUpdateStudentModal()"></div>
            <div class="relative z-10 w-full flex justify-center px-4">
                <div class="bg-white dark:bg-slate-900 rounded-2xl w-full max-w-2xl overflow-hidden shadow-2xl relative">
                    <div class="flex items-center justify-between p-6 border-b border-slate-200 dark:border-slate-800">
                        <h3 class="text-xl font-bold text-slate-900 dark:text-white">Update Student</h3>
                        <button type="button" onclick="closeUpdateStudentModal()" class="text-slate-400 hover:text-slate-500">
                            <span class="material-icons">close</span>
                        </button>
                    </div>
                    <form id="updateStudentForm" action="${pageContext.request.contextPath}/userAdmin" method="post" class="p-6">
                        <input type="hidden" name="action" value="updateStudent">
                        <input type="hidden" name="student_id" id="updateStudentId">
                        <div class="grid grid-cols-1 gap-6">
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Full Name</label>
                                    <input type="text" id="updateStudentFullName" disabled
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 text-slate-500 cursor-not-allowed" />
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Email</label>
                                    <input type="text" id="updateStudentEmail" disabled
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800 text-slate-500 cursor-not-allowed" />
                                </div>
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Level</label>
                                    <select name="level" id="updateStudentLevel"
                                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50">
                                        <option value="BEGINNER">BEGINNER</option>
                                        <option value="INTERMEDIATE">INTERMEDIATE</option>
                                        <option value="ADVANCED">ADVANCED</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Date of Birth</label>
                                    <input type="date" name="dateOfBirth" id="updateStudentDob"
                                           class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50" />
                                </div>
                            </div>
                        </div>
                        <div class="mt-8 flex justify-end gap-3 border-t border-slate-200 dark:border-slate-800 pt-6">
                            <button type="button" onclick="closeUpdateStudentModal()"
                                    class="px-5 py-2.5 rounded-lg text-slate-500 font-medium hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">Cancel</button>
                            <button type="submit"
                                    class="bg-primary text-background-dark font-bold px-5 py-2.5 rounded-lg hover:shadow-lg hover:shadow-primary/30 transition-all">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- CV PREVIEW MODAL -->
        <div id="cvPreviewModal" class="fixed inset-0 hidden items-center justify-center z-50">
            <!-- Background blur -->
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeCvModal()"></div>

            <!-- Modal content -->
            <div class="relative z-10 w-full max-w-5xl bg-white dark:bg-slate-800 rounded-2xl shadow-2xl overflow-hidden mx-4 flex flex-col h-[90vh]">
                <!-- Modal Header -->
                <div class="flex items-center justify-between px-6 py-4 border-b border-slate-200 dark:border-slate-700">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                        <span class="material-icons text-primary">description</span>
                        Teacher CV Preview
                    </h3>
                    <div class="flex items-center gap-2">
                        <a id="cvOpenNewTab" href="#" target="_blank"
                           class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-semibold text-primary bg-primary/10 hover:bg-primary/20 rounded-lg transition-colors"
                           title="Open in new tab">
                            <span class="material-icons text-sm">open_in_new</span> Open
                        </a>
                        <a id="cvDownloadLink" href="#" download
                           class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-semibold text-blue-600 bg-blue-50 hover:bg-blue-100 rounded-lg transition-colors"
                           title="Download CV">
                            <span class="material-icons text-sm">download</span> Download
                        </a>
                        <button type="button" onclick="closeCvModal()"
                                class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors ml-2">
                            <span class="material-icons">close</span>
                        </button>
                    </div>
                </div>

                <!-- Modal Body -->
                <div class="flex-1 p-0 overflow-hidden bg-slate-100 dark:bg-slate-900">
                    <iframe id="cvIframe" src="" width="100%" height="100%" class="border-none"></iframe>
                </div>

                <!-- Modal Footer -->
                <div class="px-6 py-3 border-t border-slate-200 dark:border-slate-700 flex items-center justify-between">
                    <p class="text-xs text-slate-400">If the preview doesn't load, use the "Open" or "Download" buttons above.</p>
                    <button type="button" onclick="closeCvModal()"
                            class="px-5 py-2 text-sm font-medium text-slate-600 bg-slate-100 hover:bg-slate-200 dark:text-slate-300 dark:bg-slate-700 dark:hover:bg-slate-600 rounded-lg transition-colors">
                        Close
                    </button>
                </div>
            </div>
        </div>

        <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/users">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="user_id" id="deleteUserId">
        </form>
        <script>
            window.CONTEXT_PATH = '${pageContext.request.contextPath}';
        </script>
        <script src="${pageContext.request.contextPath}/assets/js/user-management.js"></script>
        <script>
                                let currentView = 'users';
                                let currentPage = 1;
                                const PAGE_SIZE = 10;
                                let filteredRows = [];

                                // ========= VIEW SWITCHING =========
                                function switchView(view) {
                                    document.getElementById('viewUsers').style.display = 'none';
                                    document.getElementById('viewTeachers').style.display = 'none';
                                    document.getElementById('viewStudents').style.display = 'none';
                                    document.getElementById('view' + view.charAt(0).toUpperCase() + view.slice(1)).style.display = '';
                                    currentView = view;
                                    currentPage = 1;
                                    document.getElementById('globalSearchInput').value = '';
                                    filterCurrentView();
                                }

                                function filterCurrentView() {
                                    if (currentView === 'users')
                                        filterGeneric('.user-row', 'visibleRange', 'visibleCount', 'paginationControls', 'noUserFound', 'changePage');
                                    else if (currentView === 'teachers')
                                        filterGeneric('.teacher-row', 'teacherVisibleRange', 'teacherVisibleCount', 'teacherPaginationControls', 'noTeacherFound', 'changePage');
                                    else if (currentView === 'students')
                                        filterGeneric('.student-row', 'studentVisibleRange', 'studentVisibleCount', 'studentPaginationControls', 'noStudentFound', 'changePage');
                                }

                                function filterGeneric(rowSelector, rangeId, countId, pagId, noFoundId, pageFunc) {
                                    const query = document.getElementById('globalSearchInput').value.toLowerCase().trim();
                                    const rows = document.querySelectorAll(rowSelector);
                                    filteredRows = [];
                                    rows.forEach(row => {
                                        const text = row.getAttribute('data-search') || '';
                                        if (text.includes(query))
                                            filteredRows.push(row);
                                    });
                                    currentPage = 1;
                                    renderGeneric(rowSelector, rangeId, countId, pagId, noFoundId, rows.length);
                                }

                                function changePage(page) {
                                    const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);
                                    if (page < 1 || page > totalPages)
                                        return;
                                    currentPage = page;
                                    if (currentView === 'users')
                                        renderGeneric('.user-row', 'visibleRange', 'visibleCount', 'paginationControls', 'noUserFound', document.querySelectorAll('.user-row').length);
                                    else if (currentView === 'teachers')
                                        renderGeneric('.teacher-row', 'teacherVisibleRange', 'teacherVisibleCount', 'teacherPaginationControls', 'noTeacherFound', document.querySelectorAll('.teacher-row').length);
                                    else if (currentView === 'students')
                                        renderGeneric('.student-row', 'studentVisibleRange', 'studentVisibleCount', 'studentPaginationControls', 'noStudentFound', document.querySelectorAll('.student-row').length);
                                }

                                function renderGeneric(rowSelector, rangeId, countId, pagId, noFoundId, totalRowCount) {
                                    document.querySelectorAll(rowSelector).forEach(row => row.style.display = 'none');
                                    const startIdx = (currentPage - 1) * PAGE_SIZE;
                                    const endIdx = startIdx + PAGE_SIZE;
                                    for (let i = startIdx; i < endIdx && i < filteredRows.length; i++) {
                                        filteredRows[i].style.display = '';
                                    }
                                    const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);
                                    const startCount = filteredRows.length === 0 ? 0 : startIdx + 1;
                                    const endCount = Math.min(startIdx + PAGE_SIZE, filteredRows.length);

                                    document.getElementById(rangeId).textContent = startCount + ' - ' + endCount;
                                    document.getElementById(countId).textContent = filteredRows.length;

                                    const pagContainer = document.getElementById(pagId);
                                    if (totalPages <= 1) {
                                        pagContainer.innerHTML = '';
                                    } else {
                                        let html = '<a href="javascript:void(0)" onclick="changePage(' + (currentPage - 1) + ')" class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400 ' + (currentPage === 1 ? 'opacity-50 pointer-events-none' : '') + '"><span class="material-icons text-sm">chevron_left</span></a>';
                                        let sp = 1, ep = totalPages;
                                        if (totalPages > 15) {
                                            sp = Math.max(1, currentPage - 5);
                                            ep = Math.min(totalPages, currentPage + 5);
                                        }
                                        for (let i = sp; i <= ep; i++) {
                                            const ac = i === currentPage ? 'bg-primary text-background-dark font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500';
                                            html += '<a href="javascript:void(0)" onclick="changePage(' + i + ')" class="w-8 h-8 rounded flex items-center justify-center text-sm ' + ac + '">' + i + '</a>';
                                        }
                                        html += '<a href="javascript:void(0)" onclick="changePage(' + (currentPage + 1) + ')" class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400 ' + (currentPage === totalPages ? 'opacity-50 pointer-events-none' : '') + '"><span class="material-icons text-sm">chevron_right</span></a>';
                                        pagContainer.innerHTML = html;
                                    }

                                    const noFound = document.getElementById(noFoundId);
                                    if (noFound)
                                        noFound.style.display = (filteredRows.length === 0 && totalRowCount > 0) ? 'block' : 'none';
                                }

                                // ========= TEACHER MODAL =========
                                function openUpdateTeacherModal(id) {
                                    const contextPath = window.CONTEXT_PATH || '';
                                    fetch(contextPath + '/admin/users?action=getTeacherById&id=' + id)
                                            .then(r => r.json())
                                            .then(data => {
                                                document.getElementById('updateTeacherId').value = data.teacherId;
                                                document.getElementById('updateTeacherFullName').value = data.fullName;
                                                document.getElementById('updateTeacherEmail').value = data.email;
                                                document.getElementById('updateTeacherSpecialization').value = data.specialization;
                                                document.getElementById('updateTeacherExpYear').value = data.experienceYear;
                                                document.getElementById('updateTeacherApproval').value = data.approvalStatus;
                                                document.getElementById('updateTeacherCvUrl').value = data.cvUrl;
                                                const modal = document.getElementById('updateTeacherModal');
                                                modal.classList.remove('hidden');
                                                modal.classList.add('flex');
                                                document.body.style.overflow = 'hidden';
                                            })
                                            .catch(err => {
                                                console.error(err);
                                                alert('Could not load teacher data!');
                                            });
                                }
                                function closeUpdateTeacherModal() {
                                    const modal = document.getElementById('updateTeacherModal');
                                    modal.classList.add('hidden');
                                    modal.classList.remove('flex');
                                    document.body.style.overflow = 'auto';
                                }

                                // ========= STUDENT MODAL =========
                                function openUpdateStudentModal(id) {
                                    const contextPath = window.CONTEXT_PATH || '';
                                    fetch(contextPath + '/admin/users?action=getStudentById&id=' + id)
                                            .then(r => r.json())
                                            .then(data => {
                                                document.getElementById('updateStudentId').value = data.studentId;
                                                document.getElementById('updateStudentFullName').value = data.fullName;
                                                document.getElementById('updateStudentEmail').value = data.email;
                                                document.getElementById('updateStudentLevel').value = data.level;
                                                document.getElementById('updateStudentDob').value = data.dateOfBirth;
                                                const modal = document.getElementById('updateStudentModal');
                                                modal.classList.remove('hidden');
                                                modal.classList.add('flex');
                                                document.body.style.overflow = 'hidden';
                                            })
                                            .catch(err => {
                                                console.error(err);
                                                alert('Could not load student data!');
                                            });
                                }
                                function closeUpdateStudentModal() {
                                    const modal = document.getElementById('updateStudentModal');
                                    modal.classList.add('hidden');
                                    modal.classList.remove('flex');
                                    document.body.style.overflow = 'auto';
                                }

                                // ========= INIT =========
                                document.addEventListener('DOMContentLoaded', () => {
                                    // Check URL param to restore view after update redirect
                                    const params = new URLSearchParams(window.location.search);
                                    const viewParam = params.get('view');
                                    if (viewParam && ['users', 'teachers', 'students'].includes(viewParam)) {
                                        document.getElementById('viewSelector').value = viewParam;
                                        switchView(viewParam);
                                    } else {
                                        filterCurrentView();
                                    }
                                });

                                // ESC close for new modals
                                document.addEventListener('keydown', function (e) {
                                    if (e.key === 'Escape') {
                                        const tm = document.getElementById('updateTeacherModal');
                                        const sm = document.getElementById('updateStudentModal');
                                        if (tm && !tm.classList.contains('hidden'))
                                            closeUpdateTeacherModal();
                                        if (sm && !sm.classList.contains('hidden'))
                                            closeUpdateStudentModal();
                                    }
                                });

                                function openCvModal(cvUrl) {
                                    const modal = document.getElementById('cvPreviewModal');
                                    const iframe = document.getElementById('cvIframe');

                                    if (!cvUrl || cvUrl === 'null' || cvUrl.trim() === '') {
                                        alert('LỐI: Không tìm thấy CV! (Ứng viên chưa tải lên CV hoặc Webhook bị thiếu thông tin cv_url)');
                                        return;
                                    }

                                    // Set Open / Download links (direct Cloudinary URL)
                                    document.getElementById('cvOpenNewTab').href = cvUrl;
                                    document.getElementById('cvDownloadLink').href = cvUrl;

                                    // Sử dụng Google Docs Viewer thay vì Local Proxy.
                                    // Giải quyết vĩnh viễn lỗi bị đụng độ Tomcat tải lại (503/404) và lỗi trình PDF của Edge chặn iframe.
                                    const viewerUrl = 'https://docs.google.com/viewer?url=' + encodeURIComponent(cvUrl) + '&embedded=true';
                                    iframe.src = viewerUrl;

                                    modal.classList.remove('hidden');
                                    modal.classList.add('flex');
                                    document.body.style.overflow = 'hidden';
                                }

                                function closeCvModal() {
                                    const modal = document.getElementById('cvPreviewModal');
                                    const iframe = document.getElementById('cvIframe');

                                    iframe.src = '';

                                    modal.classList.add('hidden');
                                    modal.classList.remove('flex');
                                    document.body.style.overflow = '';
                                }
        </script>
    </body>

</html>