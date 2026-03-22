<%-- Document : candidatesManagement Created on : Mar 10, 2026 Author : ASUS --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Admin HR - Candidates Management</title>
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

            /* Custom Scrollbar for iframe */
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
        <c:set var="activeMenu" value="candidates" scope="request" />
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="/views/common/aside-admin.jsp" />

            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header
                    class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-8">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Candidates Management</h1>
                        <div class="relative w-96">
                            <span
                                class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input
                                class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm"
                                placeholder="Search by name or email..." type="text" />
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
                    <!-- Statistics Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Waiting
                                Candidates</p>
                            <p class="text-3xl font-bold mt-1">${waitingCount}</p>
                            <div class="mt-2 text-amber-500 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">pending_actions</span>
                                <span>Needs review</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Interviewing
                                Candidates</p>
                            <p class="text-3xl font-bold mt-1">${interviewingCount}</p>
                            <div class="mt-2 text-blue-500 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">event</span>
                                <span>Scheduled</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Accepted
                                Candidates</p>
                            <p class="text-3xl font-bold mt-1">${acceptedCount}</p>
                            <div class="mt-2 text-emerald-500 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">check_circle</span>
                                <span>Join soon</span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-6 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm hover:-translate-y-1 hover:shadow-md transition-all duration-300">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Rejected
                                Candidates</p>
                            <p class="text-3xl font-bold mt-1">${rejectedCount}</p>
                            <div class="mt-2 text-red-500 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">cancel</span>
                                <span>Not selected</span>
                            </div>
                        </div>
                    </div>

                    <!-- Filters/Stats Row -->
                    <div class="flex flex-col md:flex-row items-center justify-between mb-8 gap-4">
                        <div class="flex gap-4 w-full md:w-auto">
                            <!-- Filter dropdown for status -->
                            <select onchange="window.location.href = '?filter=' + this.value"
                                    class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-300 rounded-lg focus:ring-2 focus:ring-primary/50 text-sm px-4 py-2 hover:border-slate-300 dark:hover:border-slate-600 transition-colors cursor-pointer appearance-none shadow-sm">
                                <option value="All" ${currentFilter=='All' ? 'selected' : '' }>All
                                </option>
                                <option value="Waiting" ${currentFilter=='Waiting' ? 'selected' : '' }>Waiting
                                </option>
                                <option value="Interview" ${currentFilter=='Interview' ? 'selected' : '' }>
                                    Interview</option>
                                <option value="Accept" ${currentFilter=='Accept' ? 'selected' : '' }>Accept
                                </option>
                                <option value="Reject" ${currentFilter=='Reject' ? 'selected' : '' }>Reject
                                </option>
                            </select>
                        </div>
                    </div>

                    ${ERROR}

                    <!-- Table Container -->
                    <div
                        class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse min-w-[1200px]">
                                <thead>
                                    <tr
                                        class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            ID</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Candidate Name</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Email</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-center">
                                            Skill Count</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-center">
                                            Project Count</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Applied Date</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                            Status</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                    <c:forEach var="c" items="${candidatesList}">
                                        <tr
                                            class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td
                                                class="px-6 py-4 text-sm font-medium text-slate-900 dark:text-white">
                                                #${c.id}
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="w-8 h-8 rounded-full bg-primary/10 text-primary flex items-center justify-center font-bold text-xs uppercase">
                                                        ${c.candidateName != null && c.candidateName.length() >
                                                          0 ? c.candidateName.substring(0, 1) : 'C'}
                                                    </div>
                                                    <p class="font-semibold text-slate-900 dark:text-white">
                                                        ${c.candidateName}
                                                    </p>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400">
                                                ${c.email}
                                            </td>
                                            <td
                                                class="px-6 py-4 text-sm font-semibold text-slate-900 dark:text-white text-center">
                                                ${c.skillCount}
                                            </td>
                                            <td
                                                class="px-6 py-4 text-sm font-semibold text-slate-900 dark:text-white text-center">
                                                ${c.projectCount}
                                            </td>
                                            <td class="px-6 py-4 text-sm text-slate-500">
                                                ${c.appliedDate}
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${empty c.status || c.status == 'PENDING'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-500">
                                                            Waiting
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'INTERVIEWING'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-500">
                                                            Interviewing
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'APPROVED'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-500">
                                                            Approved
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'REJECTED'}">
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-500">
                                                            Rejected
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-400">
                                                            ${c.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-right">
                                                <div class="flex items-center justify-end gap-2">
                                                    <!-- View CV -->
                                                    <button type="button" onclick="openCvModal('${c.cvUrl}')"
                                                            title="View CV"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors duration-200">
                                                        <span class="material-icons text-lg">description</span>
                                                    </button>
                                                    <!-- Schedule Interview -->
                                                    <button type="button"
                                                            onclick="openScheduleModal('${c.id}', '${c.candidateName}')"
                                                            title="Schedule Interview"
                                                            class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-blue-500 transition-colors duration-200">
                                                        <span
                                                            class="material-icons text-lg">calendar_today</span>
                                                    </button>
                                                    <!-- Accept -->
                                                    <form
                                                        action="${pageContext.request.contextPath}/candidatesAdmin"
                                                        method="POST" class="inline">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="hidden" name="candidateId" value="${c.id}">
                                                        <button type="submit" title="Accept"
                                                                class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors duration-200"
                                                                onclick="return confirm('Are you sure you want to accept this candidate?')">
                                                            <span
                                                                class="material-icons text-lg">check_circle</span>
                                                        </button>
                                                    </form>
                                                    <!-- Reject -->
                                                    <form
                                                        action="${pageContext.request.contextPath}/candidatesAdmin"
                                                        method="POST" class="inline">
                                                        <input type="hidden" name="action" value="reject">
                                                        <input type="hidden" name="candidateId" value="${c.id}">
                                                        <button type="submit" title="Reject"
                                                                class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-red-500 transition-colors duration-200"
                                                                onclick="return confirm('Are you sure you want to reject this candidate?')">
                                                            <span class="material-icons text-lg">cancel</span>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div
                            class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50">
                            <div class="text-sm text-slate-500">
                                Showing <span class="font-medium">${totalCandidates == 0 ? 0 : startIndex +
                                                                    1}</span> to <span class="font-medium">${endIndex}</span> of <span
                                    class="font-medium">${totalCandidates}</span>
                                candidates
                            </div>
                            <c:if test="${totalPages > 1}">
                                <div class="flex items-center gap-2">
                                    <c:choose>
                                        <c:when test="${currentPage > 1}">
                                            <a href="?filter=${currentFilter}&page=${currentPage - 1}"
                                               class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-600 dark:text-slate-300 cursor-pointer transition-colors">
                                                <span class="material-icons text-sm">chevron_left</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a
                                                class="p-2 border border-slate-200 dark:border-slate-700 rounded bg-slate-50 dark:bg-slate-800/50 text-slate-400 cursor-not-allowed">
                                                <span class="material-icons text-sm">chevron_left</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <c:choose>
                                            <c:when test="${i == currentPage}">
                                                <a href="?filter=${currentFilter}&page=${i}"
                                                   class="w-8 h-8 rounded flex items-center justify-center text-sm bg-primary text-background-dark font-bold">${i}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="?filter=${currentFilter}&page=${i}"
                                                   class="w-8 h-8 rounded flex items-center justify-center text-sm text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">${i}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <c:choose>
                                        <c:when test="${currentPage < totalPages}">
                                            <a href="?filter=${currentFilter}&page=${currentPage + 1}"
                                               class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-600 dark:text-slate-300 cursor-pointer transition-colors">
                                                <span class="material-icons text-sm">chevron_right</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a
                                                class="p-2 border border-slate-200 dark:border-slate-700 rounded bg-slate-50 dark:bg-slate-800/50 text-slate-400 cursor-not-allowed">
                                                <span class="material-icons text-sm">chevron_right</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- CV PREVIEW MODAL -->
        <div id="cvPreviewModal" class="fixed inset-0 hidden items-center justify-center z-50">
            <!-- Background blur -->
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeCvModal()"></div>

            <!-- Modal content -->
            <div
                class="relative z-10 w-full max-w-5xl bg-white dark:bg-slate-800 rounded-2xl shadow-2xl overflow-hidden mx-4 flex flex-col h-[90vh]">
                <!-- Modal Header -->
                <div
                    class="flex items-center justify-between px-6 py-4 border-b border-slate-200 dark:border-slate-700">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                        <span class="material-icons text-primary">description</span>
                        Candidate CV Preview
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

        <!-- Schedule Interview Modal -->
        <div id="scheduleModal"
             class="fixed inset-0 z-50 hidden bg-slate-900/50 backdrop-blur-sm transition-opacity flex items-center justify-center">
            <div
                class="bg-white dark:bg-slate-800 rounded-xl shadow-2xl w-full max-w-md mx-4 overflow-hidden border border-slate-200 dark:border-slate-700">
                <div
                    class="flex items-center justify-between px-6 py-4 border-b border-slate-200 dark:border-slate-700">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                        <span class="material-icons text-primary">event</span>
                        Schedule Interview
                    </h3>
                    <button type="button" onclick="closeScheduleModal()"
                            class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
                        <span class="material-icons">close</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/candidatesAdmin" method="POST">
                    <input type="hidden" name="action" value="scheduleInterview">
                    <input type="hidden" name="candidateId" id="scheduleCandidateId" value="">

                    <div class="p-6 space-y-4">
                        <p class="text-sm text-slate-600 dark:text-slate-400">
                            Schedule an interview for <strong id="scheduleCandidateName"
                                                              class="text-slate-900 dark:text-white"></strong>.
                            An email notification will be sent automatically.
                        </p>

                        <div>
                            <label for="interviewDate"
                                   class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">Date</label>
                            <input type="date" id="interviewDate" name="interviewDate" required
                                   min="<%= java.time.LocalDate.now()%>"
                                   class="w-full px-4 py-2 border border-slate-300 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary focus:border-primary bg-white dark:bg-slate-700 text-slate-900 dark:text-white" />
                        </div>

                        <div>
                            <label for="interviewTime"
                                   class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">Time</label>
                            <input type="time" id="interviewTime" name="interviewTime" required
                                   class="w-full px-4 py-2 border border-slate-300 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary focus:border-primary bg-white dark:bg-slate-700 text-slate-900 dark:text-white" />
                        </div>
                    </div>

                    <div
                        class="px-6 py-4 bg-slate-50 dark:bg-slate-900 border-t border-slate-200 dark:border-slate-700 flex justify-end gap-3">
                        <button type="button" onclick="closeScheduleModal()"
                                class="px-4 py-2 text-sm font-medium text-slate-700 bg-white border border-slate-300 rounded-lg shadow-sm hover:bg-slate-50 dark:bg-slate-800 dark:border-slate-600 dark:text-slate-300 dark:hover:bg-slate-700 transition">
                            Cancel
                        </button>
                        <button type="submit"
                                class="px-4 py-2 text-sm font-medium text-white bg-primary rounded-lg shadow-sm hover:bg-primary-dark transition border border-transparent">
                            Schedule & Notify
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
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

            function openScheduleModal(id, name) {
                document.getElementById('scheduleCandidateId').value = id;
                document.getElementById('scheduleCandidateName').textContent = name || 'this candidate';

                const modal = document.getElementById('scheduleModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
                document.body.style.overflow = 'hidden';
            }

            function closeScheduleModal() {
                const modal = document.getElementById('scheduleModal');
                modal.classList.add('hidden');
                modal.classList.remove('flex');
                document.body.style.overflow = '';
            }

            // Close modals on Escape key
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    closeCvModal();
                    closeScheduleModal();
                }
            });
        </script>
    </body>

</html>