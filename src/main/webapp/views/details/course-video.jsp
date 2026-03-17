<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Course Video Player | DevLearn</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

        <style type="text/tailwindcss">
            @layer base { body { font-family: 'Inter', sans-serif; } }
            .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; font-size: 20px; }
            .material-symbols-outlined.filled { font-variation-settings: 'FILL' 1; }
            .custom-scrollbar::-webkit-scrollbar { width: 6px; }
            .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #cbd5e1; border-radius: 10px; }
            details > summary::-webkit-details-marker { display: none; }
        </style>
    </head>

    <body class="bg-gray-50 flex flex-col h-screen overflow-hidden text-slate-900">

        <main class="flex-1 flex overflow-hidden">

            <section class="w-full lg:w-[70%] h-full flex flex-col bg-white overflow-y-auto custom-scrollbar">

                <div class="px-6 md:px-8 py-5 flex flex-col md:flex-row md:items-start justify-between gap-4 border-b border-gray-100">
                    <div class="flex-1">
                        <div class="text-sm font-bold text-emerald-600 mb-1.5 uppercase tracking-wider">
                            ${not empty courseDetail.course.title ? courseDetail.course.title : 'Course Name'}
                        </div>
                        <h1 class="text-2xl md:text-3xl font-black text-slate-900 leading-tight">
                            ${not empty currentResource.title ? currentResource.title : 'Lesson Title'}
                        </h1>
                    </div>

                    <div class="flex items-center gap-3 shrink-0">
                        <div class="flex items-center gap-1.5 px-3 py-2 rounded-lg bg-emerald-50 border border-emerald-100 text-emerald-700 text-sm font-bold shadow-sm">
                            <span class="material-symbols-outlined self-center text-[18px]">adjust</span>
                            AI Monitoring Active
                        </div>
                    </div>
                </div>

                <div class="w-full aspect-video bg-black shrink-0 relative flex items-center justify-center">
                    <c:set var="rawVideoUrl" value="${not empty videoUrl ? videoUrl : currentResource.url}" />
                    <c:set var="videoId" value="${fn:substringAfter(rawVideoUrl,'v=')}" />
                    <c:set var="videoId" value="${fn:contains(videoId, '&') ? fn:substringBefore(videoId,'&') : videoId}" />

                    <iframe class="absolute inset-0 w-full h-full"
                            src="https://www.youtube.com/embed/${videoId}"
                            frameborder="0" allowfullscreen>
                    </iframe>
                </div>

                <div class="px-6 md:px-8 py-4 border-b border-gray-100 bg-emerald-50/30 flex justify-end">
                    <c:choose>
                        <c:when test="${isCompleted}">
                            <button disabled class="flex items-center gap-2 bg-gray-200 text-emerald-800 font-bold py-2.5 px-6 rounded-xl cursor-not-allowed border border-emerald-100 shadow-inner">
                                <span class="material-symbols-outlined filled">task_alt</span>
                                Lesson Completed
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button id="markCompleteBtn" onclick="markLessonCompleted()"
                                    class="flex items-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-sm hover:shadow-md">
                                <span class="material-symbols-outlined">check_circle</span>
                                Mark as Completed
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="p-6 md:p-8 flex-1 w-full max-w-5xl">
                    <h3 class="text-xl font-bold mb-6 flex items-center gap-2 text-slate-800">
                        <span class="material-symbols-outlined filled text-emerald-500">forum</span>
                        Lesson Discussion
                    </h3>
                    
                    <div class="flex gap-4 items-start mb-10">
                        <div class="w-10 h-10 rounded-full bg-emerald-100 border border-emerald-200 flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-emerald-600">person</span>
                        </div>
                        <div class="flex-1">
                            <textarea rows="3" class="w-full border border-gray-200 rounded-xl p-3 focus:outline-none focus:ring-2 border-slate-200 focus:ring-emerald-500/20 focus:border-emerald-500 resize-none transition-all" placeholder="Write a comment..."></textarea>
                            <div class="flex justify-end mt-3">
                                <button class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2 px-6 rounded-lg transition-colors shadow-sm">Post Comment</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <aside class="w-full lg:w-[30%] h-full bg-slate-50 border-l border-gray-200 flex flex-col hidden lg:flex">
                <div class="p-5 border-b border-gray-200 bg-white shrink-0">
                    <h2 class="text-[17px] font-black text-slate-800 tracking-tight">Course Content</h2>
                </div>
                <div class="flex-1 overflow-y-auto custom-scrollbar">
                    <c:forEach var="sectionDTO" items="${courseDetail.sections}">
                        <details class="group bg-white" open>
                            <summary class="flex items-center justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none select-none border-l-2 border-transparent group-open:border-emerald-400">
                                <h3 class="font-bold text-sm text-emerald-800 uppercase tracking-wide">Section ${sectionDTO.section.orderIndex}: ${sectionDTO.section.title}</h3>
                                <span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform shrink-0">expand_more</span>
                            </summary>
                            <div class="bg-gray-50/50">
                                <c:forEach var="lessonDTO" items="${sectionDTO.lessons}">
                                    <div class="p-2">
                                        <c:forEach var="resource" items="${lessonDTO.resources}">
                                            <c:set var="isActive" value="${resource.resourceId == param.resourceId}" />
                                            <a href="${pageContext.request.contextPath}/courseVideo?resourceId=${resource.resourceId}"
                                               class="flex gap-3 p-2.5 rounded-lg ${isActive ? 'bg-emerald-50 border-l-4 border-emerald-500' : 'hover:bg-gray-100'} transition-all group/item">
                                                <span class="material-symbols-outlined text-[18px] ${isActive ? 'filled text-emerald-600' : 'text-slate-400'}">${resource.resourceType == 'video' ? 'play_circle' : 'menu_book'}</span>
                                                <p class="text-[13px] ${isActive ? 'text-emerald-800 font-bold' : 'text-slate-700 font-semibold'} line-clamp-2">${resource.title}</p>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </details>
                    </c:forEach>
                </div>
            </aside>
        </main>

        <jsp:include page="../common/userbuttom.jsp" />

        <script>
            const currentStudentId = "${sessionScope.USER.userId}";
            const currentResourceId = "${param.resourceId}";

            // 1. AI Heartbeat (StudyLog)
            if (currentStudentId) {
                setInterval(() => {
                    fetch('${pageContext.request.contextPath}/api/track-study-time', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: 'studentId=' + currentStudentId
                    });
                }, 60000);
            }

            // 2. Completion Logic
            function markLessonCompleted() {
                if (!currentStudentId) { alert("Please login to save progress!"); return; }

                const btn = document.getElementById("markCompleteBtn");
                btn.innerHTML = 'Saving...';
                btn.disabled = true;

                fetch('${pageContext.request.contextPath}/api/complete-lesson', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'studentId=' + currentStudentId + '&resourceId=' + currentResourceId
                })
                .then(response => {
                    if (response.ok) {
                        btn.classList.add('bg-gray-200', 'text-emerald-800', 'cursor-not-allowed');
                        btn.classList.remove('bg-emerald-600', 'hover:bg-emerald-700');
                        btn.innerHTML = '<span class="material-symbols-outlined filled">task_alt</span> Completed';
                    } else { throw new Error(); }
                })
                .catch(() => {
                    btn.disabled = false;
                    btn.innerHTML = 'Mark as Completed';
                    alert("Error saving progress!");
                });
            }
        </script>
    </body>
</html>