<%-- Document : jobManagement Created on : Mar 17, 2026 Author : ASUS --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Admin - Teacher Job Management</title>
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
            body { font-family: 'Inter', sans-serif; }
            .modal-overlay {
                opacity: 0;
                transition: opacity 0.25s ease;
            }
            .modal-overlay.show { opacity: 1; }
            .modal-content {
                transform: translateY(20px) scale(0.97);
                opacity: 0;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .modal-overlay.show .modal-content {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
            .toast-slide-in {
                animation: toastIn 0.4s cubic-bezier(0.16,1,0.3,1) forwards;
            }
            @keyframes toastIn {
                from { transform: translateX(100%); opacity: 0; }
                to   { transform: translateX(0); opacity: 1; }
            }
            .toast-slide-out {
                animation: toastOut 0.3s ease-in forwards;
            }
            @keyframes toastOut {
                from { transform: translateX(0); opacity: 1; }
                to   { transform: translateX(100%); opacity: 0; }
            }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
        <c:set var="activeMenu" value="jobs" scope="request" />
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="/views/common/aside-admin.jsp" />

            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-4">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Teacher Job Management</h1>
                        <div class="relative w-64">
                            <span class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input id="searchInput"
                                class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm"
                                placeholder="Search jobs..." type="text" oninput="filterTable()" />
                        </div>
                        <select id="categoryFilter" onchange="filterTable()"
                                class="w-52 px-3.5 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm text-slate-600 dark:text-slate-300 cursor-pointer">
                            <option value="">All Categories</option>
                            <c:set var="addedCats" value="," />
                            <c:forEach var="j" items="${jobs}">
                                <c:if test="${not empty j.jobCategory and not fn:contains(addedCats, fn:trim(j.jobCategory))}">
                                    <option value="${fn:trim(j.jobCategory)}">${fn:trim(j.jobCategory)}</option>
                                    <c:set var="addedCats" value="${addedCats}${fn:trim(j.jobCategory)}," />
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="flex items-center gap-4">
                        <button type="button" onclick="openAddModal()"
                                class="bg-gradient-to-r from-emerald-500 to-emerald-600 text-white font-bold px-5 py-2.5 rounded-lg flex items-center gap-2 transition-all duration-200 shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/30 hover:scale-[1.02] active:scale-[0.98]">
                            <span class="material-icons">add</span>
                            Add New Job
                        </button>
                    </div>
                </header>

                <!-- Content -->
                <div class="p-8">
                    <!-- Stats Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-2xl bg-emerald-50 border border-emerald-100 flex items-center justify-center">
                                    <span class="material-icons text-emerald-600 text-2xl">work</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Jobs</p>
                                    <p class="text-3xl font-bold mt-0.5">${totalJobs}</p>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-2xl bg-blue-50 border border-blue-100 flex items-center justify-center">
                                    <span class="material-icons text-blue-600 text-2xl">check_circle</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Open Jobs</p>
                                    <p class="text-3xl font-bold mt-0.5 text-emerald-600">${openCount}</p>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-2xl bg-red-50 border border-red-100 flex items-center justify-center">
                                    <span class="material-icons text-red-500 text-2xl">cancel</span>
                                </div>
                                <div>
                                    <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Closed Jobs</p>
                                    <p class="text-3xl font-bold mt-0.5 text-red-500">${closedCount}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Table Container -->
                    <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse" id="jobTable">
                                <thead>
                                    <tr class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">ID</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Title</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Category</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Type</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Location</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Salary</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Status</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Created</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                    <c:forEach var="job" items="${jobs}">
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors job-row"
                                            data-title="${job.title}" data-category="${job.jobCategory}">
                                            <td class="px-6 py-4">
                                                <span class="text-xs font-semibold text-slate-400">#${job.jobId}</span>
                                            </td>
                                            <td class="px-6 py-4">
                                                <p class="font-semibold text-slate-900 dark:text-white text-sm">${job.title}</p>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:if test="${not empty job.jobCategory}">
                                                    <span class="px-2.5 py-1 bg-violet-100 dark:bg-violet-900/30 text-violet-600 dark:text-violet-400 text-[10px] font-bold rounded-full uppercase">${job.jobCategory}</span>
                                                </c:if>
                                                <c:if test="${empty job.jobCategory}">
                                                    <span class="text-slate-400 text-xs">—</span>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${job.jobType == 'Full time'}">
                                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                                            <span class="material-icons" style="font-size:12px;">schedule</span>
                                                            Full time
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-[10px] font-bold bg-orange-50 text-orange-500 border border-orange-200">
                                                            <span class="material-icons" style="font-size:12px;">schedule</span>
                                                            ${not empty job.jobType ? job.jobType : 'Part time'}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-slate-600">
                                                <div class="flex items-center gap-1">
                                                    <span class="material-icons text-slate-400" style="font-size:14px;">location_on</span>
                                                    ${not empty job.location ? job.location : '—'}
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-sm font-semibold">
                                                <c:choose>
                                                    <c:when test="${job.salaryMin != null && job.salaryMax != null}">
                                                        <fmt:formatNumber value="${job.salaryMin}" pattern="#,##0"/>
                                                        –
                                                        <fmt:formatNumber value="${job.salaryMax}" pattern="#,##0"/>
                                                        <c:if test="${not empty job.salaryUnit}">
                                                            <span class="text-xs text-slate-400 ml-0.5">${job.salaryUnit}</span>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-slate-400">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${job.status == 'OPEN' || empty job.status}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700">
                                                            OPEN
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${job.status == 'CLOSED'}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600">
                                                            CLOSED
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-700">
                                                            ${job.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-xs text-slate-400">
                                                <c:if test="${not empty job.createdAt}">
                                                    <fmt:formatDate value="${job.createdAt}" pattern="dd/MM/yyyy"/>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 text-right">
                                                <div class="flex items-center justify-end gap-1">
                                                    <button type="button" onclick="openUpdateModal(${job.jobId})"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200"
                                                            title="Edit">
                                                        <span class="material-icons text-lg">edit</span>
                                                    </button>
                                                    <button type="button" onclick="confirmDelete(${job.jobId}, '${job.title}')"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-red-500 transition-colors duration-200"
                                                            title="Delete">
                                                        <span class="material-icons text-lg">delete</span>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty jobs}">
                                        <tr>
                                            <td colspan="9" class="px-6 py-16 text-center">
                                                <div class="flex flex-col items-center">
                                                    <div class="w-16 h-16 rounded-full bg-slate-100 flex items-center justify-center mb-4">
                                                        <span class="material-icons text-3xl text-slate-300">work_off</span>
                                                    </div>
                                                    <p class="text-slate-500 font-semibold">No jobs found</p>
                                                    <p class="text-slate-400 text-sm mt-1">Click "Add New Job" to create one.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50">
                                <div class="text-sm text-slate-500">
                                    Showing page
                                    <span class="font-medium">${currentPage}</span>
                                    of
                                    <span class="font-medium">${totalPages}</span>
                                    (<span class="font-medium">${totalJobs}</span> jobs)
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
                                           class="w-8 h-8 rounded flex items-center justify-center text-sm
                                           ${i == currentPage ? 'bg-primary text-white font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-800'}">
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
                        </c:if>
                    </div>
                </div>
            </main>
        </div>

        <!-- ================== ADD JOB MODAL ================== -->
        <div id="addJobModal" class="fixed inset-0 z-50 hidden modal-overlay">
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeAddModal()"></div>
            <div class="absolute inset-0 flex items-center justify-center p-4 pointer-events-none">
                <div class="modal-content bg-white dark:bg-slate-900 rounded-2xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto pointer-events-auto">
                    <div class="sticky top-0 bg-white dark:bg-slate-900 px-8 py-5 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between z-10">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-xl bg-emerald-50 border border-emerald-100 flex items-center justify-center">
                                <span class="material-icons text-emerald-600">add_circle</span>
                            </div>
                            <h2 class="text-xl font-bold text-slate-900 dark:text-white">Add New Job</h2>
                        </div>
                        <button type="button" onclick="closeAddModal()" class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                            <span class="material-icons text-slate-400">close</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/jobAdmin" method="post" class="px-8 py-6 space-y-5">
                        <input type="hidden" name="action" value="add"/>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Title *</label>
                                <input type="text" name="title" required
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Category</label>
                                <input type="text" name="jobCategory" placeholder="e.g. Web Development"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Type</label>
                                <select name="jobType"
                                        class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition">
                                    <option value="Full time">Full time</option>
                                    <option value="Part time">Part time</option>
                                    <option value="Contract">Contract</option>
                                    <option value="Freelance">Freelance</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Location</label>
                                <input type="text" name="location" placeholder="e.g. Hanoi, Vietnam"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Status</label>
                                <select name="status"
                                        class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition">
                                    <option value="OPEN">OPEN</option>
                                    <option value="CLOSED">CLOSED</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Min</label>
                                <input type="number" name="salaryMin" step="0.01" placeholder="0"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Max</label>
                                <input type="number" name="salaryMax" step="0.01" placeholder="0"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Unit</label>
                                <input type="text" name="salaryUnit" placeholder="e.g. VND/month, USD/hour"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Description</label>
                                <textarea name="description" rows="3" placeholder="Job description..."
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Requirements</label>
                                <textarea name="requirements" rows="3" placeholder="Requirements (one per line)..."
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Benefits</label>
                                <textarea name="benefits" rows="3" placeholder="Benefits (one per line)..."
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                        </div>

                        <div class="flex justify-end gap-3 pt-4 border-t border-slate-100 dark:border-slate-800">
                            <button type="button" onclick="closeAddModal()"
                                    class="px-5 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition-colors">
                                Cancel
                            </button>
                            <button type="submit"
                                    class="px-6 py-2.5 rounded-lg bg-gradient-to-r from-emerald-500 to-emerald-600 text-white text-sm font-bold shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/30 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200">
                                <span class="flex items-center gap-2">
                                    <span class="material-icons text-base">add</span>
                                    Create Job
                                </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ================== UPDATE JOB MODAL ================== -->
        <div id="updateJobModal" class="fixed inset-0 z-50 hidden modal-overlay">
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeUpdateModal()"></div>
            <div class="absolute inset-0 flex items-center justify-center p-4 pointer-events-none">
                <div class="modal-content bg-white dark:bg-slate-900 rounded-2xl shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto pointer-events-auto">
                    <div class="sticky top-0 bg-white dark:bg-slate-900 px-8 py-5 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between z-10">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-xl bg-blue-50 border border-blue-100 flex items-center justify-center">
                                <span class="material-icons text-blue-600">edit_note</span>
                            </div>
                            <h2 class="text-xl font-bold text-slate-900 dark:text-white">Update Job</h2>
                        </div>
                        <button type="button" onclick="closeUpdateModal()" class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                            <span class="material-icons text-slate-400">close</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/jobAdmin" method="post" class="px-8 py-6 space-y-5">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="jobId" id="updateJobId"/>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Title *</label>
                                <input type="text" name="title" id="updateTitle" required
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Category</label>
                                <input type="text" name="jobCategory" id="updateCategory"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Job Type</label>
                                <select name="jobType" id="updateJobType"
                                        class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition">
                                    <option value="Full time">Full time</option>
                                    <option value="Part time">Part time</option>
                                    <option value="Contract">Contract</option>
                                    <option value="Freelance">Freelance</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Location</label>
                                <input type="text" name="location" id="updateLocation"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Status</label>
                                <select name="status" id="updateStatus"
                                        class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition">
                                    <option value="OPEN">OPEN</option>
                                    <option value="CLOSED">CLOSED</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Min</label>
                                <input type="number" name="salaryMin" id="updateSalaryMin" step="0.01"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Max</label>
                                <input type="number" name="salaryMax" id="updateSalaryMax" step="0.01"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Salary Unit</label>
                                <input type="text" name="salaryUnit" id="updateSalaryUnit"
                                       class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition"/>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Description</label>
                                <textarea name="description" id="updateDescription" rows="3"
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Requirements</label>
                                <textarea name="requirements" id="updateRequirements" rows="3"
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1.5">Benefits</label>
                                <textarea name="benefits" id="updateBenefits" rows="3"
                                          class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 text-sm focus:ring-2 focus:ring-primary/50 focus:border-primary transition resize-none"></textarea>
                            </div>
                        </div>

                        <div class="flex justify-end gap-3 pt-4 border-t border-slate-100 dark:border-slate-800">
                            <button type="button" onclick="closeUpdateModal()"
                                    class="px-5 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition-colors">
                                Cancel
                            </button>
                            <button type="submit"
                                    class="px-6 py-2.5 rounded-lg bg-gradient-to-r from-blue-500 to-blue-600 text-white text-sm font-bold shadow-lg shadow-blue-500/20 hover:shadow-blue-500/30 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200">
                                <span class="flex items-center gap-2">
                                    <span class="material-icons text-base">save</span>
                                    Update Job
                                </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ================== DELETE CONFIRM MODAL ================== -->
        <div id="deleteModal" class="fixed inset-0 z-50 hidden modal-overlay">
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeDeleteModal()"></div>
            <div class="absolute inset-0 flex items-center justify-center p-4 pointer-events-none">
                <div class="modal-content bg-white dark:bg-slate-900 rounded-2xl shadow-2xl w-full max-w-md pointer-events-auto">
                    <div class="p-8 text-center">
                        <div class="w-16 h-16 rounded-full bg-red-50 border-2 border-red-100 flex items-center justify-center mx-auto mb-5">
                            <span class="material-icons text-red-500 text-3xl">delete_forever</span>
                        </div>
                        <h3 class="text-xl font-bold text-slate-900 dark:text-white mb-2">Delete Job?</h3>
                        <p class="text-slate-500 text-sm mb-1">Are you sure you want to delete:</p>
                        <p class="text-slate-700 font-semibold text-sm mb-6" id="deleteJobTitle"></p>
                        <p class="text-red-400 text-xs mb-6">This action cannot be undone. All associated candidates will also be removed.</p>
                        <div class="flex justify-center gap-3">
                            <button type="button" onclick="closeDeleteModal()"
                                    class="px-5 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition-colors">
                                Cancel
                            </button>
                            <form action="${pageContext.request.contextPath}/jobAdmin" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="jobId" id="deleteJobId"/>
                                <button type="submit"
                                        class="px-6 py-2.5 rounded-lg bg-gradient-to-r from-red-500 to-red-600 text-white text-sm font-bold shadow-lg shadow-red-500/20 hover:shadow-red-500/30 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200">
                                    <span class="flex items-center gap-2">
                                        <span class="material-icons text-base">delete</span>
                                        Delete
                                    </span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toast notification -->
        <div id="toastContainer" class="fixed top-6 right-6 z-[100] space-y-3"></div>

        <script>
            // ========== MODAL CONTROLS ==========
            function openModal(id) {
                var m = document.getElementById(id);
                m.classList.remove('hidden');
                m.style.display = 'flex';
                requestAnimationFrame(function() {
                    requestAnimationFrame(function() {
                        m.classList.add('show');
                    });
                });
                document.body.style.overflow = 'hidden';
            }

            function closeModal(id) {
                var m = document.getElementById(id);
                m.classList.remove('show');
                setTimeout(function() {
                    m.classList.add('hidden');
                    m.style.display = '';
                    document.body.style.overflow = '';
                }, 300);
            }

            function openAddModal() { openModal('addJobModal'); }
            function closeAddModal() { closeModal('addJobModal'); }

            function openUpdateModal(jobId) {
                openModal('updateJobModal');
                // Fetch job data
                fetch('${pageContext.request.contextPath}/jobAdmin?action=getById&id=' + jobId)
                    .then(function(r) { return r.json(); })
                    .then(function(job) {
                        document.getElementById('updateJobId').value = job.jobId;
                        document.getElementById('updateTitle').value = job.title || '';
                        document.getElementById('updateCategory').value = job.jobCategory || '';
                        document.getElementById('updateJobType').value = job.jobType || 'Full time';
                        document.getElementById('updateLocation').value = job.location || '';
                        document.getElementById('updateStatus').value = job.status || 'OPEN';
                        document.getElementById('updateSalaryMin').value = job.salaryMin || '';
                        document.getElementById('updateSalaryMax').value = job.salaryMax || '';
                        document.getElementById('updateSalaryUnit').value = job.salaryUnit || '';
                        document.getElementById('updateDescription').value = job.description || '';
                        document.getElementById('updateRequirements').value = job.requirements || '';
                        document.getElementById('updateBenefits').value = job.benefits || '';
                    })
                    .catch(function(err) {
                        console.error('Error loading job:', err);
                        showToast('Failed to load job data', 'error');
                    });
            }
            function closeUpdateModal() { closeModal('updateJobModal'); }

            function confirmDelete(jobId, title) {
                document.getElementById('deleteJobId').value = jobId;
                document.getElementById('deleteJobTitle').textContent = '"' + title + '"';
                openModal('deleteModal');
            }
            function closeDeleteModal() { closeModal('deleteModal'); }

            // ========== TABLE SEARCH + CATEGORY FILTER ==========
            function filterTable() {
                var s = (document.getElementById('searchInput').value || '').toLowerCase().trim();
                var selectedCat = (document.getElementById('categoryFilter').value || '').trim();
                var rows = document.querySelectorAll('#jobTable .job-row');
                var visibleCount = 0;
                rows.forEach(function(row) {
                    var title = (row.getAttribute('data-title') || '').toLowerCase();
                    var cat = (row.getAttribute('data-category') || '').trim();
                    var matchSearch = !s || title.includes(s) || cat.toLowerCase().includes(s);
                    var matchCategory = !selectedCat || cat === selectedCat;
                    var show = matchSearch && matchCategory;
                    row.style.display = show ? '' : 'none';
                    if (show) visibleCount++;
                });
            }

            // ========== TOAST NOTIFICATIONS ==========
            function showToast(message, type) {
                var container = document.getElementById('toastContainer');
                var toast = document.createElement('div');
                var bgColor = type === 'error' ? 'bg-red-500' : 'bg-emerald-500';
                var icon = type === 'error' ? 'error' : 'check_circle';
                toast.className = 'toast-slide-in flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-xl text-white text-sm font-semibold ' + bgColor;
                toast.innerHTML = '<span class="material-icons text-lg">' + icon + '</span>' + message;
                container.appendChild(toast);
                setTimeout(function() {
                    toast.classList.remove('toast-slide-in');
                    toast.classList.add('toast-slide-out');
                    setTimeout(function() { toast.remove(); }, 300);
                }, 4000);
            }

            // Show session messages as toasts
            document.addEventListener('DOMContentLoaded', function() {
                <c:if test="${not empty sessionScope.SUCCESS}">
                    showToast('${sessionScope.SUCCESS}', 'success');
                    <% session.removeAttribute("SUCCESS"); %>
                </c:if>
                <c:if test="${not empty sessionScope.ERROR}">
                    showToast('${sessionScope.ERROR}', 'error');
                    <% session.removeAttribute("ERROR"); %>
                </c:if>
            });
        </script>
    </body>
</html>
