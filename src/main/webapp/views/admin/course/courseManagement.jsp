<%-- Document : courseManagement Created on : Feb 11, 2026, 3:12:30 PM Author : ASUS --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Admin Course Management Dashboard</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap"
              rel="stylesheet" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap"
              rel="stylesheet" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
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
        <link rel="stylesheet" href="assets/css/addCourse.css">
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
        <c:set var="activeMenu" value="courses" scope="request" />
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="/views/common/aside-admin.jsp" />
            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header
                    class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-8">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Course Management</h1>
                        <div class="relative w-96">
                            <span class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input
                                id="globalSearchInput"
                                oninput="filterCourses()"   
                                class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg ring-1 ring-slate-200 dark:ring-slate-700 focus:ring-2 focus:ring-primary/50 text-sm transition-all shadow-sm"
                                placeholder="Search courses, teachers, or IDs..." type="text" autocomplete="off" />
                        </div>
                    </div>
                    <div class="flex items-center gap-4">
                        <button
                            class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                            <span class="material-icons">notifications</span>
                            <span
                                class="absolute top-2 right-2 w-2 h-2 bg-primary rounded-full border-2 border-white dark:border-background-dark"></span>
                        </button>
                        <button type="button" onclick="openAddCourseModal()"
                                class="bg-gradient-to-r from-emerald-500 to-emerald-600 text-white font-bold px-5 py-2.5 rounded-lg flex items-center gap-2 transition-all duration-200 shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/30 hover:scale-[1.02] active:scale-[0.98]">
                            <span class="material-icons">add</span>
                            Add New Course
                        </button>

                    </div>
                </header>
                <!-- Table Section -->
                <div class="p-8">
                    <!-- Filters/Stats Row -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Courses
                            </p>
                            <p class="text-3xl font-bold mt-1">${totalCourses}</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>12% from last month</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Active
                                Students</p>
                            <p class="text-3xl font-bold mt-1">42.5k</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>8% from last month</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Course
                                Revenue</p>
                            <p class="text-3xl font-bold mt-1">$156.2k</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>24% from last month</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Draft Courses
                            </p>
                            <p class="text-3xl font-bold mt-1">45</p>
                            <div class="mt-2 text-slate-400 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">remove_red_eye</span>
                                <span>Needs review</span>
                            </div>
                        </div>
                    </div>
                    ${ERROR}
                    <!-- Table Container -->
                    <div
                        class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>

                                    <tr
                                        class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Thumbnail</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Course Title</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Category</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Level</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Price</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Students</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Teacher</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Status</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                    <!-- Row 1 -->
                                    <c:forEach var="c" items="${list}">
                                        <tr  onclick="goToCourseDetail(${c.courseId})"
                                             class="course-row hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors cursor-pointer"
                                             data-search="${c.courseId} ${c.title.toLowerCase()} ${c.categoryId.name.toLowerCase()} ${c.level.toLowerCase()} ${teacherMap[c.courseId] != null ? teacherMap[c.courseId].toLowerCase() : ''}">
                                            <td class="px-6 py-4">
                                                <img class="w-12 h-12 rounded-lg object-cover"
                                                     data-alt="Coding course thumbnail preview"
                                                     src="${c.thumbnailUrl}" />
                                            </td>
                                            <td class="px-6 py-4">
                                                <p class="font-semibold text-slate-900 dark:text-white">
                                                    ${c.title}</p>
                                                <p class="text-xs text-slate-500">ID: ${c.courseId}</p>
                                            </td>
                                            <td class="px-6 py-4">
                                                <span
                                                    class="px-2 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 text-[10px] font-bold rounded uppercase">${c.categoryId.name}</span>
                                            </td>
                                            <td class="px-6 py-4 text-sm">${c.level}</td>
                                            <td class="px-6 py-4 text-sm font-semibold">$${c.price}</td>
                                            <td class="px-6 py-4 text-sm"> ${studentCountMap[c.courseId] != null
                                                                             ? studentCountMap[c.courseId] : 0}</td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-2">
                                                    <img class="w-6 h-6 rounded-full"
                                                         data-alt="Teacher portrait thumbnail"
                                                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuCF7TCep_MVBlnZOY2hB6OMCaDrb_8HJKLWRKUMsoBfQ_AITRof0HqmUGLzbc35bIkKXtKR75XHP7ZFLpnuW2ZGRI8dum0WEBq_H4PMkyUy1xqCYsmElxjXUr000THJTxs_NUFxhfG-v3t4M0ul6f-hBDmtfKXEh6YWnogHJj1DSo0fzNe-HnvDA0dgScK0JtR8ZlBpyLQDQLzCN9nmGePPTSkuVWpjcLuTamTXxh0bUcG23adSOg_EdIzT6cGLuge5eXnaqzUCXMA" />
                                                    <span class="text-sm"> ${teacherMap[c.courseId] != null ?
                                                                             teacherMap[c.courseId] : "chưa có"}
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>

                                                    <c:when test="${c.status == 'ACTIVE'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700">
                                                            ${c.status}
                                                        </span>
                                                    </c:when>

                                                    <c:when test="${c.status == 'DRAFT'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-700">
                                                            ${c.status}
                                                        </span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600">
                                                            ${c.status}
                                                        </span>
                                                    </c:otherwise>

                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-right space-x-2">
                                                <button
                                                    class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                    <span class="material-icons text-lg">visibility</span>
                                                </button>
                                                <button type="button"
                                                         onclick="event.stopPropagation(); openUpdateCourseModal(${c.courseId})"
                                                        class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                    <span class="material-icons text-lg">edit</span>
                                                </button>
                                                <button type="button"  onclick="event.stopPropagation(); confirmDelete(${c.courseId})"
                                                        class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-red-500 transition-colors duration-200">
                                                    <span class="material-icons text-lg">delete</span>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            ${error}
                        </div>
                        <!-- Pagination -->
                        <div
                            class="px-6 py-4 flex flex-col sm:flex-row items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50 relative">
                            <div class="text-sm text-slate-500 mb-4 sm:mb-0">
                                Showing <span id="visibleRange" class="font-medium">0 - 0</span> 
                                of <span id="visibleCount" class="font-medium">${totalCourses}</span> courses
                            </div>
                            <div id="paginationControls" class="flex items-center gap-2">
                                <!-- JS will dynamically populate pagination here -->
                            </div>
                            <div id="noCourseFound" style="display: none;" class="w-full text-center py-4 absolute inset-x-0 bottom-16 left-0 right-0">
                                <span class="material-icons text-4xl text-slate-300">search_off</span>
                                <h3 class="text-lg font-bold text-slate-700 mt-2">No results found</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>



        <!-- ADD COURSE MODAL -->
        <div id="addCourseModal" class="fixed inset-0 hidden items-center justify-center z-50">

            <!-- Background blur -->
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeAddCourseModal()"></div>

            <!-- Modal content -->
            <div class="relative z-10 w-full flex justify-center px-4">
                <jsp:include page="addCourse.jsp" />
            </div>
        </div>

        <!-- UPDATE COURSE MODAL -->
        <div id="updateCourseModal" class="fixed inset-0 hidden items-center justify-center z-50">

            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeUpdateCourseModal()"></div>

            <div class="relative z-10 w-full flex justify-center px-4">
                <jsp:include page="updateCourse.jsp" />
            </div>
        </div>
        <form id="deleteForm" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="course_id" id="deleteCourseId">
        </form>


        <script src="${pageContext.request.contextPath}/assets/js/course-management.js"></script>
        <script>
            let currentPage = 1;
            const PAGE_SIZE = 10;
            let filteredRows = [];

            function changePage(page) {
                const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);
                if (page < 1 || page > totalPages) return;
                currentPage = page;
                renderTable();
            }

            function renderTable() {
                document.querySelectorAll('.course-row').forEach(row => row.style.display = 'none');
                
                const startIdx = (currentPage - 1) * PAGE_SIZE;
                const endIdx = startIdx + PAGE_SIZE;
                
                for (let i = startIdx; i < endIdx && i < filteredRows.length; i++) {
                    filteredRows[i].style.display = '';
                }
                
                const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);
                const startCount = filteredRows.length === 0 ? 0 : startIdx + 1;
                const endCount = Math.min(startIdx + PAGE_SIZE, filteredRows.length);
                
                document.getElementById('visibleRange').textContent = startCount + ' - ' + endCount;
                document.getElementById('visibleCount').textContent = filteredRows.length;
                
                const pagContainer = document.getElementById('paginationControls');
                if (totalPages <= 1) {
                    pagContainer.innerHTML = '';
                    return;
                }
                
                let html = '<a href="javascript:void(0)" onclick="changePage(' + (currentPage - 1) + ')" class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400 ' + (currentPage === 1 ? 'opacity-50 pointer-events-none' : '') + '"><span class="material-icons text-sm">chevron_left</span></a>';
                
                let startPage = 1;
                let endPage = totalPages;
                
                if (totalPages > 15) {
                    startPage = Math.max(1, currentPage - 5);
                    endPage = Math.min(totalPages, currentPage + 5);
                }
                
                for (let i = startPage; i <= endPage; i++) {
                    const activeClass = i === currentPage ? 'bg-primary text-background-dark font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500';
                    html += '<a href="javascript:void(0)" onclick="changePage(' + i + ')" class="w-8 h-8 rounded flex items-center justify-center text-sm ' + activeClass + '">' + i + '</a>';
                }
                
                html += '<a href="javascript:void(0)" onclick="changePage(' + (currentPage + 1) + ')" class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400 ' + (currentPage === totalPages ? 'opacity-50 pointer-events-none' : '') + '"><span class="material-icons text-sm">chevron_right</span></a>';
                
                pagContainer.innerHTML = html;
            }

            function filterCourses() {
                const searchBox = document.getElementById('globalSearchInput');
                const query = searchBox.value.toLowerCase().trim();
                const rows = document.querySelectorAll('.course-row');
                
                filteredRows = [];
                rows.forEach(row => {
                    const searchableText = row.getAttribute('data-search') || '';
                    if (searchableText.includes(query)) {
                        filteredRows.push(row);
                    }
                });
                
                currentPage = 1;
                renderTable();
                
                const noCourseFound = document.getElementById('noCourseFound');
                if (noCourseFound) {
                    noCourseFound.style.display = (filteredRows.length === 0 && rows.length > 0) ? 'block' : 'none';
                }
            }

            document.addEventListener('DOMContentLoaded', () => {
                filterCourses(); 
            });
        </script>
    </body>
    <script>
                document.addEventListener("DOMContentLoaded", function () {

                    const params = new URLSearchParams(window.location.search);

                    const modal = params.get("modal");
                    const courseId = params.get("courseId");
                    const error = params.get("error");

                    if (modal === "update" && courseId) {

                        // mở modal và load lại dữ liệu course
                        openUpdateCourseModal(courseId);

                        if (error === "teacher") {
                            const errorBox = document.getElementById("teacherError");
                            if (errorBox) {
                                errorBox.innerText = "Teacher not found";
                            }
                        }
                    }

                });

                function goToCourseDetail(courseId) {
                    window.location.href = "course-detail?id=" + courseId;
                }
    </script>

</html>