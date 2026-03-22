<%-- Document : Teacher Dashboard  Created on : Mar 20, 2026  Author : ASUS --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Teacher Dashboard | DevLearn</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
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
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
        <c:set var="activeMenu" value="dashboard" scope="request" />
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="/views/common/aside-teacher.jsp" />
            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header
                    class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-8">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">My Courses</h1>
                        <div class="relative w-96">
                            <span class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input
                                id="globalSearchInput"
                                oninput="filterCourses()"   
                                class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg ring-1 ring-slate-200 dark:ring-slate-700 focus:ring-2 focus:ring-primary/50 text-sm transition-all shadow-sm"
                                placeholder="Search your courses..." type="text" autocomplete="off" />
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

                <div class="p-8">
                    <!-- Stats Row -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-xl bg-emerald-100 dark:bg-emerald-900/30 flex items-center justify-center">
                                    <span class="material-icons text-emerald-600 text-2xl">library_books</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">My Courses</p>
                                    <p class="text-3xl font-bold mt-1">${fn:length(courses)}</p>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-xl bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
                                    <span class="material-icons text-blue-600 text-2xl">people</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Students</p>
                                    <p class="text-3xl font-bold mt-1" id="totalStudentsCount">...</p>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-xl bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center">
                                    <span class="material-icons text-purple-600 text-2xl">trending_up</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Active Courses</p>
                                    <p class="text-3xl font-bold mt-1">${fn:length(courses)}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Course Cards Grid -->
                    <c:choose>
                        <c:when test="${empty courses}">
                            <!-- Empty State -->
                            <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm p-16 text-center">
                                <div class="w-24 h-24 rounded-full bg-emerald-100 dark:bg-emerald-900/30 flex items-center justify-center mx-auto mb-6">
                                    <span class="material-icons text-emerald-500 text-5xl">menu_book</span>
                                </div>
                                <h3 class="text-2xl font-bold text-slate-900 dark:text-white mb-3">No courses assigned yet</h3>
                                <p class="text-slate-500 max-w-md mx-auto">You haven't been assigned to any courses yet. Contact the admin to get started with your first course.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6" id="courseGrid">
                                <c:forEach var="c" items="${courses}">
                                    <div class="course-card bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden hover:-translate-y-1 hover:shadow-lg transition-all duration-300 cursor-pointer group"
                                         data-search="${c.courseId} ${fn:toLowerCase(c.title)} ${c.categoryId != null ? fn:toLowerCase(c.categoryId.name) : ''} ${fn:toLowerCase(c.level)}"
                                         onclick="goToCourseDetail(${c.courseId})">

                                        <!-- Thumbnail -->
                                        <div class="aspect-video relative overflow-hidden">
                                            <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                 src="${empty c.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : c.thumbnailUrl}"
                                                 alt="${fn:escapeXml(c.title)}" />
                                            <div class="absolute top-3 right-3">
                                                <c:choose>
                                                    <c:when test="${c.status == 'ACTIVE'}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700 shadow-sm">
                                                            ${c.status}
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'DRAFT'}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-700 shadow-sm">
                                                            ${c.status}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600 shadow-sm">
                                                            ${c.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <!-- Card Body -->
                                        <div class="p-5">
                                            <div class="flex items-center gap-2 mb-3">
                                                <c:if test="${c.categoryId != null}">
                                                    <span class="px-2 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 text-[10px] font-bold rounded uppercase">
                                                        ${c.categoryId.name}
                                                    </span>
                                                </c:if>
                                                <span class="text-xs text-slate-400 font-medium">${c.level}</span>
                                            </div>
                                            <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                                ${fn:escapeXml(c.title)}
                                            </h3>
                                            <p class="text-sm text-slate-500 line-clamp-2 mb-4">
                                                ${fn:escapeXml(c.description)}
                                            </p>

                                            <!-- Footer -->
                                            <div class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-slate-800">
                                                <div class="flex items-center gap-1 text-sm text-slate-500">
                                                    <span class="material-icons text-base">attach_money</span>
                                                    <span class="font-semibold">
                                                        <c:choose>
                                                            <c:when test="${c.price == 0}">Free</c:when>
                                                            <c:otherwise>$<fmt:formatNumber value="${c.price}" maxFractionDigits="2" /></c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <button type="button"
                                                        onclick="event.stopPropagation(); goToCourseDetail(${c.courseId})"
                                                        class="text-xs font-bold text-emerald-600 bg-emerald-50 hover:bg-emerald-100 px-3 py-1.5 rounded-lg transition-colors flex items-center gap-1">
                                                    <span class="material-icons text-sm">edit</span>
                                                    Manage
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- No search results -->
                            <div id="noCourseFound" style="display: none;" class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm p-16 text-center mt-6">
                                <span class="material-icons text-4xl text-slate-300">search_off</span>
                                <h3 class="text-lg font-bold text-slate-700 mt-2">No results found</h3>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>

        <script>
            function goToCourseDetail(courseId) {
                window.location.href = "course-detail?id=" + courseId;
            }

            function filterCourses() {
                const searchBox = document.getElementById('globalSearchInput');
                const query = searchBox.value.toLowerCase().trim();
                const cards = document.querySelectorAll('.course-card');
                let visibleCount = 0;

                cards.forEach(card => {
                    const searchableText = card.getAttribute('data-search') || '';
                    if (searchableText.includes(query)) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                const noCourseFound = document.getElementById('noCourseFound');
                if (noCourseFound) {
                    noCourseFound.style.display = (visibleCount === 0 && cards.length > 0) ? 'block' : 'none';
                }
            }
        </script>
    </body>

</html>
