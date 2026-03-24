<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Assignment Results | DevLearn</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
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
                    fontFamily: {"display": ["Inter", "sans-serif"]},
                },
            },
        }
    </script>
    <style> body { font-family: 'Inter', sans-serif; } </style>
</head>

<body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
    <c:set var="activeMenu" value="assignments" scope="request" />
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <jsp:include page="/views/common/aside-teacher.jsp" />

        <!-- Main Content -->
        <main class="flex-1 ml-64 min-h-screen">
            <header class="h-20 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                <div class="flex items-center gap-4">
                    <h1 class="text-2xl font-bold text-slate-900 dark:text-white">AI Assignment Results</h1>
                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">
                        <span class="w-1.5 h-1.5 rounded-full bg-blue-500 mr-2"></span>
                        n8n Supervised
                    </span>
                </div>
            </header>

            <div class="p-8">
                <!-- Info Alert -->
                <div class="mb-6 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-xl p-4 flex items-start gap-3">
                    <span class="material-icons text-blue-500 mt-0.5">info</span>
                    <div>
                        <h4 class="text-sm font-semibold text-blue-800 dark:text-blue-300">Auto-Grading Active</h4>
                        <p class="text-xs text-blue-600 dark:text-blue-400 mt-1">
                            The AI engine automatically analyzes student GitHub repositories and calculates scores. You can monitor the results below and intervene if scores seem inaccurate.
                        </p>
                    </div>
                </div>

                <!-- Data Table -->
                <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-700">
                                <tr>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300">Course & Assignment</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300">Student</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300 text-center">Repository</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300 text-center">Status</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300 text-center">AI Score</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300">Submitted At</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-slate-600 dark:text-slate-300 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                <c:choose>
                                    <c:when test="${empty submissions}">
                                        <tr>
                                            <td colspan="7" class="px-6 py-12 text-center text-slate-500">
                                                <span class="material-icons text-4xl mb-3 text-slate-300">receipt_long</span>
                                                <p>No assignments have been submitted by your students yet.</p>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="sub" items="${submissions}">
                                            <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                                <td class="px-6 py-4">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate max-w-[200px]" title="${sub.assignmentId.title}">${sub.assignmentId.title}</p>
                                                    <p class="text-xs text-slate-500 truncate mt-1">Course: ${sub.assignmentId.lessonId.courseId.title}</p>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <div class="flex items-center gap-3">
                                                        <div class="w-8 h-8 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center font-bold text-slate-600 dark:text-slate-300 uppercase text-xs">
                                                            ${fn:substring(sub.studentId.users.fullName, 0, 1)}
                                                        </div>
                                                        <div>
                                                            <p class="font-medium text-slate-900 dark:text-slate-200">${sub.studentId.users.fullName}</p>
                                                            <p class="text-xs text-slate-500">${sub.studentId.users.email}</p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 text-center">
                                                    <a href="${sub.githubUrl}" target="_blank" class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 hover:text-black dark:hover:text-white hover:bg-slate-200 transition-colors" title="View Repository">
                                                        <span class="material-icons text-sm">code</span>
                                                    </a>
                                                </td>
                                                <td class="px-6 py-4 text-center">
                                                    <c:choose>
                                                        <c:when test="${sub.status == 'PENDING'}">
                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-bold bg-amber-100 text-amber-700 uppercase tracking-wider">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span>
                                                                Pending AI
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-bold bg-emerald-100 text-emerald-700 uppercase tracking-wider">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                                                Graded
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4 text-center">
                                                    <c:choose>
                                                        <c:when test="${sub.score == null}">
                                                            <span class="text-slate-400 text-xs font-medium">Auto-grading...</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="font-bold text-lg ${sub.score >= 80 ? 'text-emerald-500' : (sub.score >= 50 ? 'text-amber-500' : 'text-red-500')}">
                                                                ${sub.score} <span class="text-xs text-slate-400 font-normal">/ 100</span>
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <span class="text-xs text-slate-500 font-medium">
                                                        <fmt:formatDate value="${sub.submittedAt}" pattern="MMM dd, yyyy HH:mm" />
                                                    </span>
                                                </td>
                                                <td class="px-6 py-4 text-right">
                                                    <button onclick="viewFeedback('${sub.submissionId}')" class="text-sky-600 hover:text-sky-800 font-semibold text-xs uppercase tracking-wider transition-colors inline-block px-3 py-1.5 hover:bg-sky-50 dark:hover:bg-slate-800 rounded-lg">
                                                        View Details
                                                    </button>
                                                    
                                                    <!-- Hidden Feedback Data -->
                                                    <div id="feedback-${sub.submissionId}" class="hidden">
                                                        ${sub.feedback != null ? sub.feedback : 'AI processing is currently pending. Please wait for the webhook response.'}
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Feedback Modal -->
    <div id="feedbackModal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 flex justify-center items-center w-full md:inset-0 h-full bg-slate-900/50 backdrop-blur-sm">
        <div class="relative p-4 w-full max-w-2xl max-h-full">
            <div class="relative bg-white dark:bg-slate-900 rounded-2xl shadow-xl border border-slate-200 dark:border-slate-800">
                <div class="flex items-center justify-between p-5 border-b border-slate-200 dark:border-slate-800 rounded-t-xl bg-slate-50 dark:bg-slate-800/50">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                        <span class="material-icons text-primary">analytics</span>
                        AI Evaluation Report
                    </h3>
                    <button type="button" onclick="closeFeedback()" class="text-slate-400 bg-transparent hover:bg-slate-200 hover:text-slate-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-slate-700 dark:hover:text-white">
                        <span class="material-icons">close</span>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <div class="p-6 space-y-4">
                    <div class="bg-blue-50 dark:bg-slate-800 rounded-xl p-4 border border-blue-100 dark:border-slate-700 leading-relaxed text-sm text-slate-700 dark:text-slate-300">
                        <div id="modalFeedbackContent" class="whitespace-pre-wrap font-mono text-xs">...</div>
                    </div>
                </div>
                <!-- Future Override Functionality Button -->
                <div class="flex items-center justify-end p-5 border-t border-slate-200 dark:border-slate-800 rounded-b-xl">
                    <button type="button" class="text-xs font-bold uppercase tracking-wider text-slate-600 dark:text-slate-300 bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 px-5 py-2.5 rounded-lg transition-colors mr-3" onclick="closeFeedback()">Close</button>
                    <button type="button" class="text-xs font-bold uppercase tracking-wider text-white bg-primary hover:bg-emerald-600 px-5 py-2.5 rounded-lg shadow-sm shadow-emerald-500/50 transition-all flex items-center gap-2 cursor-pointer">
                        <span class="material-icons text-sm">edit</span>
                        Manual Override (Beta)
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function viewFeedback(id) {
            const feedbackText = document.getElementById('feedback-' + id).innerText;
            document.getElementById('modalFeedbackContent').innerText = feedbackText;
            document.getElementById('feedbackModal').classList.remove('hidden');
        }

        function closeFeedback() {
            document.getElementById('feedbackModal').classList.add('hidden');
        }
    </script>
</body>
</html>
