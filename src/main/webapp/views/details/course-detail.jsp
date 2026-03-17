<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>Course Details | DevLearn</title>
                    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                        rel="stylesheet" />
                    <link
                        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                        rel="stylesheet" />
                    <style type="text/tailwindcss">
                        .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                font-size: 20px;
            }
            @layer base {
                body {
                    @apply font-sans antialiased;
                }
            }
            details > summary::-webkit-details-marker {
                display: none;
            }
            .edit-mode .edit-only {
                display: flex !important;
            }
            .edit-only {
                display: none !important;
            }
        </style>

                    <!-- Native CSS for Entrance Animations -> Prevents flash before Tailwind CDN loads -->
                    <style>
                        .animate-course-fade-up {
                            animation: courseFadeUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) both !important;
                        }

                        .animate-card-slide-up {
                            animation: cardSlideUp 1s cubic-bezier(0.16, 1, 0.3, 1) both !important;
                        }

                        .course-delay-1 {
                            animation-delay: 0.1s !important;
                        }

                        .course-delay-2 {
                            animation-delay: 0.2s !important;
                        }

                        .course-delay-3 {
                            animation-delay: 0.3s !important;
                        }

                        .course-delay-4 {
                            animation-delay: 0.4s !important;
                        }

                        .course-delay-5 {
                            animation-delay: 0.5s !important;
                        }

                        .card-delay {
                            animation-delay: 0.8s !important;
                        }

                        @keyframes courseFadeUp {
                            0% {
                                opacity: 0;
                                transform: translateY(30px);
                            }

                            100% {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        @keyframes cardSlideUp {
                            0% {
                                opacity: 0;
                                transform: translateY(50px);
                            }

                            100% {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }
                    </style>
                </head>

                <body class="font-display transition-colors duration-300"
                    style="background: linear-gradient(135deg, #f8fffc, #e6f7f1); color: #0f172a;">
                    <div class="relative flex min-h-screen w-full flex-col">
                        <c:if test="${not empty param.msg}">
                            <div id="toast-success"
                                class="fixed top-24 right-5 z-[500] flex items-center p-4 mb-4 w-full max-w-xs border-l-4 border-emerald-500 text-slate-500 bg-white rounded-lg shadow-2xl"
                                role="alert">
                                <div
                                    class="inline-flex flex-shrink-0 justify-center items-center w-8 h-8 text-emerald-500 bg-emerald-50 rounded-lg">
                                    <span class="material-symbols-outlined font-bold text-lg">check_circle</span>
                                </div>
                                <div class="ml-3 text-sm font-bold text-slate-800">${fn:escapeXml(param.msg)}</div>
                                <button type="button"
                                    class="ml-auto -mx-1.5 -my-1.5 bg-white text-slate-400 hover:text-slate-900 rounded-lg p-1.5 hover:bg-slate-100 inline-flex h-8 w-8"
                                    onclick="this.parentElement.remove()">
                                    <span class="material-symbols-outlined text-sm font-bold mt-0.5">close</span>
                                </button>
                            </div>
                            <script>setTimeout(() => { const el = document.getElementById('toast-success'); if (el) el.style.display = 'none'; }, 5000);</script>
                        </c:if>
                        <c:if test="${not empty param.error}">
                            <div id="toast-error"
                                class="fixed top-24 right-5 z-[500] flex items-center p-4 mb-4 w-full max-w-xs border-l-4 border-red-500 text-slate-500 bg-white rounded-lg shadow-2xl"
                                role="alert">
                                <div
                                    class="inline-flex flex-shrink-0 justify-center items-center w-8 h-8 text-red-500 bg-red-50 rounded-lg">
                                    <span class="material-symbols-outlined font-bold text-lg">error</span>
                                </div>
                                <div class="ml-3 text-sm font-bold text-slate-800">${fn:escapeXml(param.error)}</div>
                                <button type="button"
                                    class="ml-auto -mx-1.5 -my-1.5 bg-white text-slate-400 hover:text-slate-900 rounded-lg p-1.5 hover:bg-slate-100 inline-flex h-8 w-8"
                                    onclick="this.parentElement.remove()">
                                    <span class="material-symbols-outlined text-sm font-bold mt-0.5">close</span>
                                </button>
                            </div>
                            <script>setTimeout(() => { const el = document.getElementById('toast-error'); if (el) el.style.display = 'none'; }, 5000);</script>
                        </c:if>
                        <jsp:include page="../common/header.jsp" />
                        <div class="bg-white  border-b border-emerald-100 ">
                            <div class="max-w-canvas mx-auto px-6 lg:px-12 py-4">
                                <nav
                                    class="flex items-center gap-2 text-xs font-semibold uppercase tracking-wider text-slate-500">
                                    <a class="hover:text-[#10B981]" href="#">Home</a>
                                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                                    <a class="hover:text-[#10B981]" href="#">Web Development</a>
                                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                                    <span class="text-slate-900 ">Full-stack React &amp; Node.js</span>
                                </nav>
                            </div>
                        </div>
                        <main class="max-w-canvas mx-auto px-6 lg:px-12 py-10">
                            <div class="flex flex-col lg:flex-row gap-12">
                                <div class="lg:w-[70%]">
                                    <div class="mb-12">
                                        <div
                                            class="inline-block px-3 py-1 rounded-md bg-emerald-500/10 text-emerald-700 text-xs font-bold mb-4 animate-course-fade-up course-delay-1">
                                            MOST POPULAR
                                        </div>
                                        <h1
                                            class="text-4xl lg:text-5xl font-black text-slate-900 leading-[1.15] mb-6 animate-course-fade-up course-delay-2">
                                            ${courseDetail.course.title}
                                        </h1>
                                        <p
                                            class="text-lg text-slate-500 leading-relaxed max-w-4xl mb-8 animate-course-fade-up course-delay-3">
                                            ${courseDetail.course.description}
                                        </p>
                                        <div
                                            class="flex flex-wrap gap-8 items-center border-y border-emerald-100 py-6 animate-course-fade-up course-delay-4">
                                            <c:forEach var="teacher" items="${courseDetail.teachers}">
                                                <div class="flex items-center gap-3">
                                                    <div class="size-10 rounded-full bg-gray-200 border-2 border-primary"
                                                        style="background-image: url('${empty teacher.users.providerId ? 'https://ui-avatars.com/api/?name='.concat(teacher.users.fullName).concat('&background=random') : 'default.jpg'}'); background-size: cover;">
                                                    </div>
                                                    <div>
                                                        <p class="text-xs text-slate-500 font-medium uppercase">
                                                            ${teacher.specialization}</p>
                                                        <p class="text-sm font-bold">${teacher.users.fullName}</p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <div class="flex items-center gap-3">
                                                <span class="material-symbols-outlined text-[#10B981]">update</span>
                                                <div>
                                                    <p class="text-xs text-slate-500 font-medium uppercase">Last Updated
                                                    </p>
                                                    <p class="text-sm font-bold">Nov 2023</p>
                                                </div>
                                            </div>
                                            <div class="flex items-center gap-3">
                                                <span class="material-symbols-outlined text-[#10B981]">language</span>
                                                <div>
                                                    <p class="text-xs text-slate-500 font-medium uppercase">Language</p>
                                                    <p class="text-sm font-bold">English (US)</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-12 animate-course-fade-up course-delay-5">
                                        <h3 class="text-2xl font-bold mb-6 flex items-center gap-2">
                                            <span class="w-8 h-1 bg-emerald-500 text-white rounded-full"></span>
                                            What you'll learn
                                        </h3>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4">
                                            <div class="flex gap-3">
                                                <span
                                                    class="material-symbols-outlined text-[#10B981]">check_circle</span>
                                                <span class="text-sm text-slate-500 ">Build powerful, fast,
                                                    user-friendly and
                                                    reactive web apps</span>
                                            </div>
                                            <div class="flex gap-3">
                                                <span
                                                    class="material-symbols-outlined text-[#10B981]">check_circle</span>
                                                <span class="text-sm text-slate-500 ">Master React Hooks, State, and
                                                    Context
                                                    API</span>
                                            </div>
                                            <div class="flex gap-3">
                                                <span
                                                    class="material-symbols-outlined text-[#10B981]">check_circle</span>
                                                <span class="text-sm text-slate-500 ">Design and implement RESTful APIs
                                                    with
                                                    Express</span>
                                            </div>
                                            <div class="flex gap-3">
                                                <span
                                                    class="material-symbols-outlined text-[#10B981]">check_circle</span>
                                                <span class="text-sm text-slate-500 ">Database management with MongoDB
                                                    and
                                                    Mongoose</span>
                                            </div>
                                        </div>
                                    </div>
                                    <section>
                                        <div class="flex items-center justify-between mb-8">
                                            <h3 class="text-2xl font-bold flex items-center gap-3">
                                                Course Content
                                                <c:if test="${isEditAllowed}">
                                                    <button id="toggleEditModeBtn" onclick="toggleEditMode()"
                                                        class="px-3 py-1 text-xs font-bold rounded-lg bg-emerald-100 text-emerald-700 hover:bg-emerald-200 transition-colors flex items-center gap-1 shadow-sm border border-emerald-200">
                                                        <span class="material-symbols-outlined text-[16px]">edit</span>
                                                        Edit Mode
                                                    </button>
                                                </c:if>
                                            </h3>
                                            <p class="text-sm text-slate-500 font-medium">
                                                ${courseDetail.sections.size()}
                                                Sections •
                                                ${courseDetail.totalLessons} Lectures • ${courseDetail.totalDuration}s
                                                total
                                                length
                                            </p>
                                        </div>
                                        <div class="space-y-4" id="course-content-area">
                                            <c:forEach var="sectionDTO" items="${courseDetail.sections}"
                                                varStatus="status">
                                                <details
                                                    class="group bg-white  border border-emerald-100  rounded-xl overflow-hidden shadow-sm"
                                                    open="">
                                                    <summary
                                                        class="flex flex-col sm:flex-row cursor-pointer sm:items-center justify-between p-5 list-none hover:bg-emerald-50 transition-colors gap-2 sm:gap-0">
                                                        <div class="flex items-center gap-4 flex-1">
                                                            <span
                                                                class="material-symbols-outlined text-[#10B981] group-open:rotate-180 transition-transform">expand_more</span>
                                                            <span
                                                                class="text-base font-bold text-slate-900 tracking-tight"
                                                                onclick="makeEditable(this, 'section', ${sectionDTO.section.sectionId})"
                                                                title="Click to edit section title">Section
                                                                ${sectionDTO.section.orderIndex}:
                                                                ${sectionDTO.section.title}</span>
                                                        </div>
                                                        <div class="flex items-center gap-3">
                                                            <span
                                                                class="text-xs font-bold text-slate-500">${sectionDTO.lessons.size()}
                                                                Lectures</span>
                                                            <button type="button"
                                                                class="edit-only text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded transition-colors"
                                                                onclick="deleteEntity('section', ${sectionDTO.section.sectionId}, this.closest('details'))"
                                                                title="Delete Section">
                                                                <span
                                                                    class="material-symbols-outlined text-[18px]">delete</span>
                                                            </button>
                                                        </div>
                                                    </summary>
                                                    <div class="p-5 pt-0 border-t border-emerald-100 ">
                                                        <ul class="space-y-4 mt-4">
                                                            <c:forEach var="lessonDTO" items="${sectionDTO.lessons}">
                                                                <li class="border border-slate-100 rounded-lg bg-white">
                                                                    <details class="group">
                                                                        <summary
                                                                            class="flex flex-col sm:flex-row sm:items-center justify-between cursor-pointer p-3 rounded-lg hover:bg-slate-50 transition-colors list-none select-none gap-2 sm:gap-0">
                                                                            <div class="flex items-center gap-3 flex-1">
                                                                                <span
                                                                                    class="material-symbols-outlined text-slate-500 group-open:rotate-90 transition-transform duration-200 shrink-0">
                                                                                    chevron_right
                                                                                </span>
                                                                                <span
                                                                                    class="text-sm font-semibold text-slate-700 w-full"
                                                                                    onclick="makeEditable(this, 'lesson', ${lessonDTO.lesson.lessonId})"
                                                                                    title="Click to edit lesson title">
                                                                                    ${lessonDTO.lesson.orderIndex}.
                                                                                    ${lessonDTO.lesson.title}
                                                                                </span>
                                                                            </div>
                                                                            <div class="flex items-center gap-2">
                                                                                <button type="button"
                                                                                    class="edit-only text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded transition-colors"
                                                                                    onclick="deleteEntity('lesson', ${lessonDTO.lesson.lessonId}, this.closest('li'))"
                                                                                    title="Delete Lesson">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-[16px]">delete</span>
                                                                                </button>
                                                                            </div>
                                                                        </summary>
                                                                        <div
                                                                            class="pl-9 pr-3 pb-3 pt-1 flex flex-col gap-2">
                                                                            <c:forEach var="resource"
                                                                                items="${lessonDTO.resources}">
                                                                                <div class="flex items-center justify-between group/res hover:bg-slate-50 rounded-lg p-2"
                                                                                    id="resource-container-${resource.resourceId}">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${resource.resourceType == 'video'}">
                                                                                            <c:choose>
                                                                                                <c:when
                                                                                                    test="${enrolled || isEditAllowed}">
                                                                                                    <a href="${pageContext.request.contextPath}/courseVideo?resourceId=${resource.resourceId}"
                                                                                                        class="flex items-start gap-3 transition-colors cursor-pointer w-full text-left">
                                                                                                        <span
                                                                                                            class="material-symbols-outlined text-[#10B981] text-xl shrink-0 mt-0.5"
                                                                                                            style="font-variation-settings: 'FILL' 1;">play_circle</span>
                                                                                                        <div>
                                                                                                            <p
                                                                                                                class="text-sm font-semibold text-slate-700 leading-tight">
                                                                                                                ${resource.title}
                                                                                                            </p>
                                                                                                            <p
                                                                                                                class="text-xs text-slate-500 mt-1">
                                                                                                                Video
                                                                                                                &bull;
                                                                                                                ${not
                                                                                                                empty
                                                                                                                resource.duration
                                                                                                                ?
                                                                                                                resource.duration
                                                                                                                : 0} min
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <div
                                                                                                        class="flex items-start gap-3 w-full text-left opacity-60 cursor-not-allowed">
                                                                                                        <span
                                                                                                            class="material-symbols-outlined text-slate-400 text-xl shrink-0 mt-0.5"
                                                                                                            style="font-variation-settings: 'FILL' 1;">lock</span>
                                                                                                        <div>
                                                                                                            <p
                                                                                                                class="text-sm font-semibold text-slate-500 leading-tight">
                                                                                                                ${resource.title}
                                                                                                            </p>
                                                                                                            <p
                                                                                                                class="text-xs text-slate-400 mt-1">
                                                                                                                Video
                                                                                                                &bull;
                                                                                                                ${not
                                                                                                                empty
                                                                                                                resource.duration
                                                                                                                ?
                                                                                                                resource.duration
                                                                                                                : 0} min
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </c:when>
                                                                                        <c:when
                                                                                            test="${resource.resourceType == 'assignment'}">
                                                                                            <div class="flex items-start gap-3 w-full text-left opacity-50">
                                                                                                <span class="material-symbols-outlined text-slate-400 text-xl shrink-0 mt-0.5" style="font-variation-settings: 'FILL' 1;">terminal</span>
                                                                                                <div>
                                                                                                    <p class="text-sm font-semibold text-slate-500 leading-tight">
                                                                                                        ${resource.title}
                                                                                                    </p>
                                                                                                    <p class="text-xs text-amber-500 mt-1 font-bold">
                                                                                                        Legacy Link (Please add Assignment directly)
                                                                                                    </p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <c:choose>
                                                                                                <c:when
                                                                                                    test="${enrolled || isEditAllowed}">
                                                                                                    <button
                                                                                                        type="button"
                                                                                                        onclick="openDocModal('${resource.title}', '${resource.url}')"
                                                                                                        class="flex items-start gap-3 transition-colors cursor-pointer w-full text-left">
                                                                                                        <span
                                                                                                            class="material-symbols-outlined text-[#10B981] text-xl shrink-0 mt-0.5"
                                                                                                            style="font-variation-settings: 'FILL' 1;">menu_book</span>
                                                                                                        <div>
                                                                                                            <p
                                                                                                                class="text-sm font-semibold text-slate-700 leading-tight">
                                                                                                                ${resource.title}
                                                                                                            </p>
                                                                                                            <p
                                                                                                                class="text-xs text-slate-500 mt-1">
                                                                                                                Document
                                                                                                                &bull;
                                                                                                                ${not
                                                                                                                empty
                                                                                                                resource.duration
                                                                                                                ?
                                                                                                                resource.duration
                                                                                                                : 0} min
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </button>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <div
                                                                                                        class="flex items-start gap-3 w-full text-left opacity-60 cursor-not-allowed">
                                                                                                        <span
                                                                                                            class="material-symbols-outlined text-slate-400 text-xl shrink-0 mt-0.5"
                                                                                                            style="font-variation-settings: 'FILL' 1;">lock</span>
                                                                                                        <div>
                                                                                                            <p
                                                                                                                class="text-sm font-semibold text-slate-500 leading-tight">
                                                                                                                ${resource.title}
                                                                                                            </p>
                                                                                                            <p
                                                                                                                class="text-xs text-slate-400 mt-1">
                                                                                                                Document
                                                                                                                &bull;
                                                                                                                ${not
                                                                                                                empty
                                                                                                                resource.duration
                                                                                                                ?
                                                                                                                resource.duration
                                                                                                                : 0} min
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <div
                                                                                        class="edit-only flex items-center gap-2 opacity-0 group-hover/res:opacity-100 transition-opacity">
                                                                                        <button type="button"
                                                                                            class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 p-1 rounded"
                                                                                            onclick="showResourceEditor(${resource.resourceId}, '${fn:escapeXml(resource.title)}', '${fn:escapeXml(resource.url)}')"
                                                                                            title="Edit Resource">
                                                                                            <span
                                                                                                class="material-symbols-outlined text-[16px]">edit</span>
                                                                                        </button>
                                                                                        <button type="button"
                                                                                            class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded"
                                                                                            onclick="deleteEntity('resource', ${resource.resourceId}, this.closest('#resource-container-${resource.resourceId}'))"
                                                                                            title="Delete Resource">
                                                                                            <span
                                                                                                class="material-symbols-outlined text-[16px]">delete</span>
                                                                                        </button>
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>

                                                                            <c:forEach var="assignment" items="${lessonDTO.lesson.assignmentCollection}">
                                                                                <div class="flex items-center justify-between group/assign hover:bg-slate-50 rounded-lg p-2"
                                                                                    id="assignment-container-${assignment.assignmentId}">
                                                                                    <c:choose>
                                                                                        <c:when test="${enrolled || isEditAllowed}">
                                                                                                <div class="flex-grow flex items-start gap-3 transition-colors cursor-pointer w-full text-left" onclick="openAssignmentModal(this)"
                                                                                                    data-id="${assignment.assignmentId}"
                                                                                                    data-title="${fn:escapeXml(assignment.title)}"
                                                                                                    data-desc="${fn:escapeXml(assignment.description)}"
                                                                                                    data-reqs="${fn:escapeXml(assignment.criteria)}"
                                                                                                    data-output="${fn:escapeXml(assignment.expectedOutput)}"
                                                                                                    data-files="${fn:escapeXml(assignment.fileExtensions)}">
                                                                                                    <span class="material-symbols-outlined text-[#10B981] text-xl shrink-0 mt-0.5" style="font-variation-settings: 'FILL' 1;">terminal</span>
                                                                                                    <div>
                                                                                                        <p class="text-sm font-semibold text-slate-700 leading-tight">
                                                                                                            ${assignment.title}
                                                                                                        </p>
                                                                                                        <p class="text-xs text-slate-500 mt-1">
                                                                                                            Assignment
                                                                                                        </p>
                                                                                                    </div>
                                                                                                </div>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <div class="flex items-start gap-3 w-full text-left opacity-60 cursor-not-allowed">
                                                                                                <span class="material-symbols-outlined text-slate-400 text-xl shrink-0 mt-0.5" style="font-variation-settings: 'FILL' 1;">lock</span>
                                                                                                <div>
                                                                                                    <p class="text-sm font-semibold text-slate-500 leading-tight">
                                                                                                        ${assignment.title}
                                                                                                    </p>
                                                                                                    <p class="text-xs text-slate-400 mt-1">
                                                                                                        Assignment
                                                                                                    </p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <div class="edit-only flex items-center gap-2 opacity-0 group-hover/assign:opacity-100 transition-opacity ml-2 shrink-0">
                                                                                        <button type="button"
                                                                                            class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 p-1.5 rounded"
                                                                                            onclick="openEditAssignmentModal(${assignment.assignmentId})"
                                                                                            title="Edit Assignment">
                                                                                            <span class="material-symbols-outlined text-[16px]">edit</span>
                                                                                        </button>
                                                                                        <button type="button"
                                                                                            class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1.5 rounded"
                                                                                            onclick="deleteEntity('assignment', ${assignment.assignmentId}, this.closest('#assignment-container-${assignment.assignmentId}'))"
                                                                                            title="Delete Assignment">
                                                                                            <span class="material-symbols-outlined text-[16px]">delete</span>
                                                                                        </button>
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>

                                                                            <!-- Add Resource Button -->
                                                                            <div class="edit-only mt-3 resource-toolbar"
                                                                                data-lesson-id="${lessonDTO.lesson.lessonId}">
                                                                                <div class="flex items-center gap-2">
                                                                                    <span
                                                                                        class="text-[11px] text-slate-400 font-semibold uppercase">Add:</span>
                                                                                    <button type="button"
                                                                                        onclick="showAddResourceForm(this, 'video')"
                                                                                        class="text-[11px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 px-3 py-1 rounded-full transition-colors flex items-center gap-1">
                                                                                        + Video
                                                                                    </button>
                                                                                    <button type="button"
                                                                                        onclick="showAddResourceForm(this, 'document')"
                                                                                        class="text-[11px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 px-3 py-1 rounded-full transition-colors flex items-center gap-1">
                                                                                        + Document
                                                                                    </button>
                                                                                    <button type="button"
                                                                                        onclick="showAddResourceForm(this, 'assignment')"
                                                                                        class="text-[11px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 px-3 py-1 rounded-full transition-colors flex items-center gap-1">
                                                                                        + Code
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </details>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>

                                                        <!-- Add Lesson Button -->
                                                        <div class="edit-only mt-4 flex justify-center">
                                                            <button type="button"
                                                                onclick="addLesson(${sectionDTO.section.sectionId})"
                                                                class="text-sm font-bold text-emerald-600 bg-emerald-50 hover:bg-emerald-100 px-4 py-2 rounded-lg transition-colors flex items-center gap-1 border border-emerald-200">
                                                                <span
                                                                    class="material-symbols-outlined text-[18px]">add</span>
                                                                Add Lesson
                                                            </button>
                                                        </div>
                                                    </div>
                                                </details>
                                            </c:forEach>

                                            <!-- Add Section Button -->
                                            <c:if test="${isEditAllowed}">
                                                <div class="edit-only mt-6 flex justify-center">
                                                    <button type="button" id="addSectionBtn" onclick="addSection()"
                                                        class="text-base font-bold text-white bg-emerald-500 hover:bg-emerald-600 px-6 py-3 rounded-xl transition-all shadow-lg flex items-center gap-2">
                                                        <span class="material-symbols-outlined">add_circle</span> Add New
                                                        Section
                                                    </button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </section>
                                </div>
                                <aside class="lg:w-[30%]">
                                    <div
                                        class="sidebar-sticky sticky rounded-2xl border border-emerald-100 bg-white shadow-xl overflow-hidden animate-card-slide-up card-delay">
                                        <div class="aspect-video relative group cursor-pointer overflow-hidden">
                                            <img alt="Course Preview"
                                                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
                                                src="${empty courseDetail.course.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : courseDetail.course.thumbnailUrl}" />
                                            <div
                                                class="absolute inset-0 bg-slate-900/40 flex items-center justify-center">
                                                <div
                                                    class="size-16 rounded-full bg-white flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                                                    <span class="material-symbols-outlined text-white scale-150"
                                                        style="font-variation-settings: 'FILL' 1;">play_arrow</span>
                                                </div>
                                            </div>
                                            <div class="absolute bottom-4 left-0 right-0 text-center">
                                                <span class="text-white text-sm font-bold drop-shadow-md">Preview this
                                                    course</span>
                                            </div>
                                        </div>
                                        <div class="p-8">
                                            <div class="flex items-center gap-3 mb-2">
                                                <span class="text-4xl font-black text-slate-900 ">$
                                                    ${courseDetail.course.price}</span>
                                                <span class="text-lg text-gray-400 line-through font-medium">$
                                                    <fmt:formatNumber value="${courseDetail.course.price * 1.5}"
                                                        maxFractionDigits="2" />
                                                </span>
                                            </div>
                                            <p
                                                class="text-xs text-red-500 font-bold uppercase mb-6 flex items-center gap-1">
                                                <span class="material-symbols-outlined text-sm">alarm</span>
                                                45% OFF • 2 days left at this price
                                            </p>
                                            <div class="space-y-3 mb-8">
                                                    <c:choose>
                                                        <c:when test="${courseDetail.enrolled}">
                                                            <button
                                                                class="w-full bg-slate-800 text-white hover:bg-slate-900 text-lg font-black py-4 rounded-xl transition-all shadow-lg flex items-center justify-center gap-2">
                                                                <span class="material-symbols-outlined">play_circle</span>
                                                                Continue Learning
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${courseDetail.course.price == 0}">
                                                            <button type="button"
                                                                    onclick="handleEnrollment(this, ${courseDetail.course.courseId}, ${sessionScope.USER != null})"
                                                                    class="free-course-btn w-full bg-emerald-500 text-white hover:bg-emerald-600 font-black py-4 rounded-xl transition-all duration-300 hover:scale-105 shadow-md flex items-center justify-center gap-2"
                                                                    data-course-id="${courseDetail.course.courseId}">
                                                                Join
                                                            </button>
                                                            <button type="button" disabled
                                                                    class="free-course-enrolled-btn hidden w-full bg-slate-800 text-white hover:bg-slate-900 text-lg font-black py-4 rounded-xl transition-all shadow-lg flex items-center justify-center gap-2"
                                                                    data-course-id="${courseDetail.course.courseId}">
                                                                <span class="material-symbols-outlined">play_circle</span> Continue Learning
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${courseDetail.course.courseId}"
                                                                class="w-full bg-emerald-500 text-white hover:bg-emerald-600 font-black py-4 rounded-xl transition-all duration-300 hover:scale-105 shadow-md flex items-center justify-center gap-2">
                                                                <span class="material-symbols-outlined">shopping_cart</span>
                                                                Add to Cart
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                            </div>
                                            <div class="space-y-5">
                                                <h4
                                                    class="text-sm font-black uppercase tracking-widest text-slate-900 ">
                                                    This
                                                    course
                                                    includes:</h4>
                                                <div class="grid grid-cols-1 gap-4">
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">video_library</span>
                                                        <span>24.5 hours on-demand video</span>
                                                    </div>
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">assignment</span>
                                                        <span>12 Coding exercises</span>
                                                    </div>
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">description</span>
                                                        <span>85 Downloadable resources</span>
                                                    </div>
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">all_inclusive</span>
                                                        <span>Full lifetime access</span>
                                                    </div>
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">smartphone</span>
                                                        <span>Access on mobile and TV</span>
                                                    </div>
                                                    <div class="flex items-center gap-3 text-sm text-slate-500">
                                                        <span
                                                            class="material-symbols-outlined text-[#10B981]">verified</span>
                                                        <span>Certificate of completion</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div
                                                class="mt-8 pt-8 border-t border-emerald-100  flex justify-center gap-8">
                                                <button
                                                    class="flex flex-col items-center gap-1 text-slate-500 hover:text-[#10B981] transition-colors">
                                                    <span class="material-symbols-outlined">share</span>
                                                    <span class="text-[10px] font-bold uppercase">Share</span>
                                                </button>
                                                <button
                                                    class="flex flex-col items-center gap-1 text-slate-500 hover:text-[#10B981] transition-colors">
                                                    <span class="material-symbols-outlined">info</span>
                                                    <span class="text-[10px] font-bold uppercase">Gift</span>
                                                </button>
                                                <button
                                                    class="flex flex-col items-center gap-1 text-slate-500 hover:text-[#10B981] transition-colors">
                                                    <span class="material-symbols-outlined">money_off</span>
                                                    <span class="text-[10px] font-bold uppercase">Coupon</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </aside>
                            </div>
                        </main>
                        <!-- More courses for you — same layout as home page -->
                        <section class="py-12 lg:py-10">
                            <div class="max-w-canvas mx-auto px-8 lg:px-12">
                                <div class="flex flex-col lg:flex-row lg:items-end justify-between mb-16 gap-8">
                                    <div class="max-w-xl">
                                        <h2
                                            class="text-4xl font-black tracking-tight bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">
                                            More courses for you</h2>
                                    </div>
                                    <a class="inline-flex items-center gap-2 text-[#10B981] font-bold group"
                                        href="${pageContext.request.contextPath}/shop">
                                        View All Courses
                                        <span
                                            class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="slider relative">
                                    <!-- Prev -->
                                    <button
                                        class="slider-prev absolute left-0 -translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <!-- Next -->
                                    <button
                                        class="slider-next absolute right-0 translate-x-1/2 top-1/2 -translate-y-1/2 z-10 w-12 h-12 rounded-full bg-white border border-emerald-200 text-slate-600 shadow-lg flex items-center justify-center hover:scale-110 hover:bg-emerald-50 transition">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                    <div class="slider-wrapper overflow-x-auto snap-x snap-mandatory w-full relative" style="scrollbar-width: none; -ms-overflow-style: none;">
                                        <div
                                            class="slider-track flex gap-6 transition-transform duration-500 ease-in-out">
                                            <c:forEach var="c" items="${moreCourses}">
                                                <div
                                                    class="group w-[280px] lg:w-[calc(25%-18px)] flex-shrink-0 snap-start flex flex-col bg-white rounded-[2rem] overflow-hidden border border-emerald-100 hover:border-emerald-400/50 hover:shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)] transition-all duration-300 cursor-pointer"
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/course-detail?id=${c.courseId}'">
                                                    <div class="aspect-[16/10] overflow-hidden relative">
                                                        <img alt="${fn:escapeXml(c.title)}"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                                                            src="${empty c.thumbnailUrl ? pageContext.request.contextPath.concat('/assets/images/default-course.jpg') : c.thumbnailUrl}" />
                                                    </div>
                                                    <div class="p-6 flex flex-col flex-grow">
                                                        <div class="flex items-center gap-2 mb-3">
                                                            <span
                                                                class="text-[10px] font-bold text-[#10B981] bg-[#10B981]/10 px-2 py-1 rounded">${c.categoryId
                                                                != null ? c.categoryId.name : 'No Category'}</span>
                                                            <span class="text-xs text-gray-400">• 12 Hours</span>
                                                        </div>
                                                        <h3
                                                            class="text-xl font-bold mb-3 leading-tight group-hover:text-[#10B981] transition-colors line-clamp-2">
                                                            ${fn:escapeXml(c.title)}</h3>
                                                        <div class="flex items-center gap-2 mb-6">
                                                            <div class="flex text-yellow-400">
                                                                <span
                                                                    class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                                                                <span
                                                                    class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star_half</span>
                                                            </div>
                                                            <span class="text-xs font-bold text-gray-500">4.8
                                                                (1.2k)</span>
                                                        </div>
                                                        <div
                                                            class="flex mt-auto items-center justify-between pt-2 border-t border-slate-100">
                                                            <span
                                                                class="text-xl font-black text-emerald-400">
                                                                <c:choose>
                                                                    <c:when test="${c.price == 0}">Free</c:when>
                                                                    <c:otherwise>$<fmt:formatNumber value="${c.price}" maxFractionDigits="2" /></c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${c.price == 0}">
                                                                    <button type="button"
                                                                            onclick="event.stopPropagation(); handleEnrollment(this, ${c.courseId}, ${sessionScope.USER != null})"
                                                                            class="free-course-btn hidden px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95"
                                                                            data-course-id="${c.courseId}">
                                                                        Join
                                                                    </button>
                                                                    <button type="button" disabled
                                                                            onclick="event.stopPropagation()"
                                                                            class="free-course-enrolled-btn hidden px-4 py-2 font-bold text-sm bg-emerald-100 text-emerald-700 rounded-xl cursor-not-allowed transition-all"
                                                                            data-course-id="${c.courseId}">
                                                                        Enrolled
                                                                    </button>
                                                                    <c:if test="${sessionScope.USER == null}">
                                                                        <button type="button"
                                                                                onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/login'"
                                                                                class="px-4 py-2 font-bold text-sm bg-emerald-500 text-white rounded-xl hover:bg-emerald-600 transition-all shadow-md shadow-emerald-500/20 active:scale-95">
                                                                        Join
                                                                        </button>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${sessionScope.USER != null}">
                                                                            <a href="${pageContext.request.contextPath}/addToCart?id=${c.courseId}"
                                                                               onclick="event.stopPropagation()"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 inline-block">
                                                                                <span class="material-symbols-outlined text-[#10B981] text-xl transition-all duration-300 align-middle">shopping_cart</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="${pageContext.request.contextPath}/login"
                                                                               onclick="event.stopPropagation()"
                                                                               class="group/cart p-2 rounded-lg border border-emerald-500/30 bg-emerald-500/10 transition-all duration-300 hover:bg-emerald-500/20 hover:border-emerald-400 active:scale-90 inline-block">
                                                                                <span class="material-symbols-outlined text-[#10B981] text-xl transition-all duration-300 align-middle">shopping_cart</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>

                    <!-- Document Modal -->
                    <div id="docModal"
                        class="fixed inset-0 z-[100] hidden bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 sm:p-6">
                        <div
                            class="bg-white w-full max-w-4xl rounded-2xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">
                            <div class="flex items-center justify-between p-4 border-b border-slate-100">
                                <h2 id="docModalTitle" class="text-lg font-bold text-slate-900 truncate pr-4">Document
                                    Title
                                </h2>
                                <button onclick="closeDocModal()" type="button"
                                    class="text-slate-400 hover:text-slate-700 hover:bg-slate-100 p-2 rounded-full transition-colors">
                                    <span class="material-symbols-outlined shrink-0"
                                        style="font-size: 20px;">close</span>
                                </button>
                            </div>
                            <div class="p-0 flex-1 overflow-hidden bg-slate-50">
                                <iframe id="docModalIframe" src=""
                                    class="w-full h-full min-h-[60vh] sm:min-h-[70vh] border-0"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    allowfullscreen>
                                </iframe>
                            </div>
                        </div>
                    </div>
                    <!-- Assignment Modal -->
                    <div id="assignmentModal"
                        class="fixed inset-0 z-[150] hidden bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 sm:p-6 transition-all duration-300">
                        <div
                            class="bg-white w-full max-w-5xl rounded-2xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh] ring-1 ring-slate-200">

                            <!-- Modal Header -->
                            <div
                                class="flex items-center justify-between px-6 py-5 border-b border-slate-200 bg-slate-50/80">
                                <div class="flex items-center gap-4">
                                    <div
                                        class="w-10 h-10 rounded-xl bg-emerald-600 flex items-center justify-center shadow-sm">
                                        <span class="material-symbols-outlined text-white"
                                            style="font-size: 20px;">terminal</span>
                                    </div>
                                    <div>
                                        <h2 id="assignmentModalTitle" class="text-xl font-bold text-slate-800">Code
                                            Assignment: Introduction to Java</h2>
                                        <p class="text-xs font-medium text-slate-500 mt-0.5">Submit your repository for
                                            automated evaluation</p>
                                    </div>
                                </div>
                                <button onclick="closeAssignmentModal()" type="button"
                                    class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-200 transition-colors">
                                    <span class="material-symbols-outlined" style="font-size: 20px;">close</span>
                                </button>
                            </div>

                            <!-- Modal Body -->
                            <div class="flex-1 overflow-y-auto bg-white custom-scrollbar">
                                <div class="flex flex-col lg:flex-row h-full">

                                    <!-- Left Column: Problem Details -->
                                    <div
                                        class="flex-1 p-6 lg:p-8 border-b lg:border-b-0 lg:border-r border-slate-200 bg-white">

                                        <div class="space-y-8">
                                            <!-- Description section -->
                                            <section>
                                                <h3
                                                    class="text-xs font-bold tracking-widest text-slate-400 uppercase mb-3 flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-emerald-500"
                                                        style="font-size: 16px;">description</span>
                                                    Description
                                                </h3>
                                                <div id="modalAssignmentDesc"
                                                    class="text-sm text-slate-700 leading-relaxed font-medium whitespace-pre-wrap">
                                                </div>
                                            </section>

                                            <!-- Requirements section -->
                                            <section>
                                                <h3
                                                    class="text-xs font-bold tracking-widest text-slate-400 uppercase mb-3 flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-emerald-500"
                                                        style="font-size: 16px;">task_alt</span>
                                                    Requirements
                                                </h3>
                                                <div id="modalAssignmentReqs"
                                                    class="text-sm text-slate-700 font-medium whitespace-pre-wrap">
                                                </div>
                                            </section>

                                            <!-- Expected Output section -->
                                            <section>
                                                <h3
                                                    class="text-xs font-bold tracking-widest text-slate-400 uppercase mb-3 flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-emerald-500"
                                                        style="font-size: 16px;">output</span>
                                                    Expected Output
                                                </h3>
                                                <div id="modalAssignmentOutput"
                                                    class="bg-slate-50 border border-slate-200 rounded-lg p-4 font-mono text-sm text-slate-600 whitespace-pre-wrap">
                                                </div>
                                            </section>

                                            <!-- Allowed files section -->
                                            <section
                                                class="flex gap-4 p-4 mt-6 bg-slate-50 rounded-lg border border-slate-200">
                                                <div>
                                                    <h3 class="text-xs font-bold text-slate-500 mb-1">Required Files
                                                    </h3>
                                                    <div id="modalAssignmentFiles" class="flex gap-2">
                                                    </div>
                                                </div>
                                            </section>

                                        </div>
                                    </div>

                                    <!-- Right Column: Submission Area -->
                                    <div class="w-full lg:w-[450px] shrink-0 bg-slate-50 p-6 lg:p-8 flex flex-col">
                                        <input type="hidden" id="modalAssignmentIdInput" value="" />

                                        <!-- STATE 1: Submission Form -->
                                        <div id="submissionFormArea">
                                            <h3 class="text-lg font-bold text-slate-800 mb-2">Nộp bài</h3>
                                            <p class="text-sm text-slate-500 mb-6 font-medium">Dán link repository GitHub public chứa bài làm của bạn.</p>
                                            <div class="space-y-6 flex-1">
                                                <div class="space-y-2">
                                                    <label for="githubUrl" class="block text-sm font-bold text-slate-700">Repository URL</label>
                                                    <div class="relative">
                                                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none">
                                                            <svg class="h-5 w-5 text-slate-400" viewBox="0 0 24 24" fill="currentColor"><path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/></svg>
                                                        </div>
                                                        <input type="url" id="githubUrl" name="githubUrl" required placeholder="https://github.com/username/repository" class="w-full pl-11 pr-4 py-2.5 rounded-lg border border-slate-300 bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200 outline-none transition-all placeholder:text-slate-400 text-slate-700 font-medium text-sm">
                                                    </div>
                                                </div>
                                                <div class="bg-emerald-50 border border-emerald-100 rounded-lg p-4">
                                                    <div class="flex items-start gap-3">
                                                        <span class="material-symbols-outlined text-emerald-500 text-xl">info</span>
                                                        <div>
                                                            <h4 class="text-sm font-bold text-emerald-900">Chấm điểm tự động</h4>
                                                            <p class="text-xs text-emerald-700 mt-1 font-medium leading-relaxed">Hệ thống sẽ clone repository, phân tích code và chấm điểm bằng AI.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-auto pt-6">
                                                <button type="button" id="btnSubmitAssignment" onclick="submitAssignmentAjax()" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-3 rounded-lg flex items-center justify-center gap-2 transition-colors shadow-md shadow-emerald-500/20">
                                                    <span class="material-symbols-outlined">rocket_launch</span> Nộp bài
                                                </button>
                                            </div>
                                        </div>

                                        <!-- STATE 2: Loading / Grading in Progress -->
                                        <div id="submissionLoadingArea" class="hidden flex-1 flex flex-col items-center justify-center py-8">
                                            <div class="relative w-16 h-16 mb-6">
                                                <div class="absolute inset-0 rounded-full border-4 border-slate-200"></div>
                                                <div class="absolute inset-0 rounded-full border-4 border-emerald-500 border-t-transparent animate-spin"></div>
                                            </div>
                                            <p id="gradingStatusText" class="text-sm font-bold text-slate-700 mb-2">Đang chấm điểm và lưu kết quả...</p>
                                            <p class="text-xs text-slate-400 text-center">Quá trình này có thể mất 1-3 phút.<br/>Vui lòng không đóng cửa sổ này.</p>
                                        </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Grading Result Modal -->
                    <div id="gradingResultModal"
                        class="fixed inset-0 z-[160] hidden bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 sm:p-6 transition-all duration-300">
                        <div
                            class="bg-white w-full max-w-4xl rounded-2xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh] ring-1 ring-slate-200">
                            <!-- Modal Header -->
                            <div class="flex items-center justify-between px-6 py-5 border-b border-slate-200 bg-slate-50/80">
                                <div class="flex items-center gap-4">
                                    <div class="w-10 h-10 rounded-xl bg-indigo-600 flex items-center justify-center shadow-sm">
                                        <span class="material-symbols-outlined text-white" style="font-size: 20px;">workspace_premium</span>
                                    </div>
                                    <div>
                                        <h2 class="text-xl font-bold text-slate-800">Kết quả chấm điểm</h2>
                                        <p class="text-xs font-medium text-slate-500 mt-0.5" id="resultModalSubtitle">Assignment</p>
                                    </div>
                                </div>
                                <button onclick="closeGradingResultModal()" type="button"
                                    class="w-8 h-8 flex items-center justify-center rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-200 transition-colors">
                                    <span class="material-symbols-outlined" style="font-size: 20px;">close</span>
                                </button>
                            </div>

                            <!-- Modal Body -->
                            <div class="flex-1 overflow-y-auto bg-white custom-scrollbar p-6 lg:p-8">
                                <div class="max-w-3xl mx-auto">
                                    <!-- Score Header -->
                                    <div class="text-center mb-6">
                                        <p class="text-xs text-slate-400 font-bold uppercase tracking-wider mb-1">Điểm trung bình</p>
                                        <p id="resultScore" class="text-5xl font-black text-slate-900">0 / 100</p>
                                        <p id="resultFileCount" class="text-xs text-slate-400 mt-2"></p>
                                    </div>
                                    <div class="flex justify-center mb-8">
                                        <div id="resultStatusBadge"></div>
                                    </div>

                                    <!-- AI Feedback -->
                                    <div class="bg-indigo-50/50 border border-indigo-100 rounded-xl p-5 mb-8">
                                        <h4 class="text-xs font-bold text-indigo-800 uppercase tracking-wider mb-3 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-indigo-500" style="font-size:18px;">auto_awesome</span>
                                            Đánh giá tổng quan từ AI
                                        </h4>
                                        <div id="resultFeedback" class="text-sm text-slate-700 whitespace-pre-wrap leading-relaxed font-medium"></div>
                                    </div>

                                    <!-- File Analysis Table -->
                                    <div class="mb-4">
                                        <h4 class="text-xs font-bold text-slate-500 uppercase tracking-wider mb-3 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-emerald-500" style="font-size:16px;">description</span>
                                            Kết quả chi tiết theo file
                                        </h4>
                                        <div class="rounded-xl border border-slate-200 overflow-x-auto shadow-sm">
                                            <table class="w-full text-sm min-w-max">
                                                <thead>
                                                    <tr class="bg-slate-50 border-b border-slate-200">
                                                        <th class="text-left px-4 py-3 text-xs font-bold text-slate-500 uppercase">File Path</th>
                                                        <th class="px-4 py-3 text-xs font-bold text-slate-500 uppercase text-center w-24">Issues</th>
                                                        <th class="px-4 py-3 text-xs font-bold text-slate-500 uppercase text-right w-28">Điểm</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="resultFilesTable" class="divide-y divide-slate-100"></tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Close / Retry Buttons -->
                                    <div class="mt-8 flex items-center justify-end gap-3 pt-6 border-t border-slate-100">
                                        <button type="button" onclick="closeGradingResultModal()" class="px-6 py-2.5 rounded-lg text-slate-600 font-bold text-sm hover:bg-slate-100 transition-colors">
                                            Đóng
                                        </button>
                                        <button type="button" onclick="retryAssignment()" class="px-6 py-2.5 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-sm shadow-md transition-colors flex items-center gap-2">
                                            <span class="material-symbols-outlined" style="font-size:18px;">refresh</span> Nộp lại
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                                </div>
                            </div>
                        </div>
                    </div><!-- Delete Confirmation Modal -->
                    <div id="deleteConfirmModal"
                        class="fixed inset-0 z-[200] hidden bg-slate-900/50 backdrop-blur-sm flex items-center justify-center p-4"
                        style="transition: opacity 0.2s ease;">
                        <div
                            class="bg-white rounded-2xl shadow-2xl p-6 w-full max-w-sm text-center animate-[fadeInUp_0.2s_ease]">
                            <div class="flex justify-center mb-4">
                                <div class="w-12 h-12 rounded-full bg-red-50 flex items-center justify-center">
                                    <span class="material-symbols-outlined text-red-500"
                                        style="font-size: 28px;">help</span>
                                </div>
                            </div>
                            <p id="deleteConfirmMessage" class="text-base font-semibold text-slate-800 mb-6">Are you
                                sure you want to delete this item?</p>
                            <div class="flex items-center justify-center gap-3">
                                <button id="deleteConfirmNo" type="button"
                                    class="px-6 py-2 text-sm font-bold text-slate-600 bg-white border border-slate-300 rounded-lg hover:bg-slate-50 transition-colors">
                                    No
                                </button>
                                <button id="deleteConfirmYes" type="button"
                                    class="px-6 py-2 text-sm font-bold text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition-colors shadow-sm">
                                    Yes
                                </button>
                            </div>
                        </div>
                    </div>

                    <style>
                        @keyframes fadeInUp {
                            from {
                                opacity: 0;
                                transform: translateY(10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        /* === Custom Position Dropdown === */
                        .pos-dropdown {
                            position: relative;
                            user-select: none;
                            min-width: 140px;
                        }
                        .pos-dropdown-toggle {
                            display: flex;
                            align-items: center;
                            gap: 8px;
                            padding: 0 14px;
                            height: 42px;
                            border: 1.5px solid #d1d5db;
                            border-radius: 10px;
                            background: #fff;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            font-size: 13px;
                            font-weight: 600;
                            color: #334155;
                        }
                        .pos-dropdown-toggle:hover {
                            border-color: #10b981;
                            box-shadow: 0 0 0 3px rgba(16,185,129,0.1);
                        }
                        .pos-dropdown-toggle.active {
                            border-color: #10b981;
                            box-shadow: 0 0 0 3px rgba(16,185,129,0.15);
                        }
                        .pos-dropdown-toggle .pos-icon {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            width: 24px;
                            height: 24px;
                            border-radius: 6px;
                            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
                            color: #059669;
                            font-size: 14px;
                            flex-shrink: 0;
                        }
                        .pos-dropdown-toggle .pos-label {
                            flex: 1;
                            white-space: nowrap;
                            overflow: hidden;
                            text-overflow: ellipsis;
                        }
                        .pos-dropdown-toggle .pos-label small {
                            font-weight: 400;
                            color: #94a3b8;
                            font-size: 11px;
                            margin-left: 2px;
                        }
                        .pos-dropdown-toggle .pos-arrow {
                            color: #94a3b8;
                            transition: transform 0.25s ease;
                            font-size: 18px;
                            flex-shrink: 0;
                        }
                        .pos-dropdown-toggle.active .pos-arrow {
                            transform: rotate(180deg);
                            color: #10b981;
                        }
                        .pos-dropdown-menu {
                            position: absolute;
                            top: calc(100% + 6px);
                            left: 0;
                            right: 0;
                            background: #fff;
                            border: 1.5px solid #e5e7eb;
                            border-radius: 12px;
                            box-shadow: 0 10px 40px -10px rgba(0,0,0,0.12), 0 4px 12px -2px rgba(0,0,0,0.06);
                            z-index: 50;
                            padding: 6px;
                            opacity: 0;
                            transform: translateY(-8px) scale(0.97);
                            pointer-events: none;
                            transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
                            max-height: 220px;
                            overflow-y: auto;
                        }
                        .pos-dropdown-menu.open {
                            opacity: 1;
                            transform: translateY(0) scale(1);
                            pointer-events: auto;
                        }
                        .pos-dropdown-item {
                            display: flex;
                            align-items: center;
                            gap: 10px;
                            padding: 8px 12px;
                            border-radius: 8px;
                            cursor: pointer;
                            font-size: 13px;
                            font-weight: 500;
                            color: #475569;
                            transition: all 0.15s ease;
                        }
                        .pos-dropdown-item:hover {
                            background: #f0fdf4;
                            color: #065f46;
                        }
                        .pos-dropdown-item.selected {
                            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
                            color: #065f46;
                            font-weight: 700;
                        }
                        .pos-dropdown-item .pos-item-num {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            width: 26px;
                            height: 26px;
                            border-radius: 7px;
                            background: #f1f5f9;
                            font-size: 12px;
                            font-weight: 700;
                            color: #64748b;
                            flex-shrink: 0;
                            transition: all 0.15s ease;
                        }
                        .pos-dropdown-item:hover .pos-item-num {
                            background: #d1fae5;
                            color: #059669;
                        }
                        .pos-dropdown-item.selected .pos-item-num {
                            background: #10b981;
                            color: #fff;
                        }
                        .pos-dropdown-item .pos-item-check {
                            margin-left: auto;
                            opacity: 0;
                            color: #10b981;
                            font-size: 16px;
                            transition: opacity 0.15s ease;
                        }
                        .pos-dropdown-item.selected .pos-item-check {
                            opacity: 1;
                        }
                        .pos-dropdown-menu::-webkit-scrollbar {
                            width: 4px;
                        }
                        .pos-dropdown-menu::-webkit-scrollbar-track {
                            background: transparent;
                        }
                        .pos-dropdown-menu::-webkit-scrollbar-thumb {
                            background: #cbd5e1;
                            border-radius: 4px;
                        }
                    </style>

                    <!-- Edit Assignment Modal -->
                    <div id="editAssignmentModal" class="fixed inset-0 z-[100] hidden items-center justify-center pointer-events-none">
                        <div class="absolute inset-0 bg-slate-900/40 backdrop-blur-sm opacity-0 transition-opacity duration-300 transition-opacity modal-overlay pointer-events-auto"></div>
                        <div class="bg-white rounded-2xl shadow-2xl w-full max-w-[800px] max-h-[90vh] flex flex-col scale-95 opacity-0 transition-all duration-300 relative z-10 pointer-events-auto">
                            <!-- Header -->
                            <div class="p-5 sm:p-6 border-b border-emerald-100 flex items-center justify-between bg-emerald-50/50 rounded-t-2xl">
                                <div class="flex items-center gap-3">
                                    <div class="size-10 rounded-xl bg-emerald-100 flex items-center justify-center text-emerald-600 shadow-sm border border-emerald-200">
                                        <span class="material-symbols-outlined shrink-0" style="font-variation-settings: 'FILL' 1;">edit_square</span>
                                    </div>
                                    <div>
                                        <h2 class="text-xl font-bold text-slate-800">Edit Assignment</h2>
                                        <p class="text-xs font-medium text-slate-500 mt-0.5">Update assignment details below</p>
                                    </div>
                                </div>
                                <button onclick="closeEditAssignmentModal()" type="button" class="text-slate-400 hover:text-slate-600 bg-white hover:bg-slate-100 size-8 rounded-full flex items-center justify-center transition-colors shadow-sm border border-slate-200">
                                    <span class="material-symbols-outlined text-[20px]">close</span>
                                </button>
                            </div>
                            <!-- Body -->
                            <div class="p-5 sm:p-6 overflow-y-auto space-y-4">
                                <input type="hidden" id="editAssignmentIdInput" value="" />
                                <div>
                                    <label class="block text-sm font-semibold text-slate-700 mb-1">Title</label>
                                    <input type="text" id="editAssignmentTitle" class="w-full border border-slate-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" />
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-slate-700 mb-1">Description</label>
                                    <textarea id="editAssignmentDesc" rows="3" class="w-full border border-slate-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500"></textarea>
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-slate-700 mb-1">Criteria / Requirements</label>
                                    <textarea id="editAssignmentReqs" rows="3" class="w-full border border-slate-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500"></textarea>
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-slate-700 mb-1">Expected Output</label>
                                    <textarea id="editAssignmentOutput" rows="3" class="w-full border border-slate-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500"></textarea>
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-slate-700 mb-1">File Extensions (comma separated)</label>
                                    <input type="text" id="editAssignmentFiles" class="w-full border border-slate-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500" placeholder="e.g. .java, .cpp, .js" />
                                </div>
                            </div>
                            <!-- Footer -->
                            <div class="p-4 sm:p-5 border-t border-slate-100 bg-slate-50 rounded-b-2xl flex justify-end gap-3">
                                <button type="button" onclick="closeEditAssignmentModal()" class="px-5 py-2 rounded-lg text-slate-600 font-medium hover:bg-slate-200 transition-colors">Cancel</button>
                                <button type="button" onclick="submitEditAssignmentAjax()" class="px-5 py-2 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-bold transition-colors">Update Assignment</button>
                            </div>
                        </div>
                    </div>

                    <script src="${pageContext.request.contextPath}/assets/js/edit-course.js?v=12"></script>
                    <script>
                        // Course ID is needed for adding new sections
                        window.COURSE_ID = ${ courseDetail.course.courseId };
                        window.CONTEXT_PATH = '${pageContext.request.contextPath}';

                        // ---- Custom Delete Confirmation (override edit-course.js deleteEntity) ----
                        function showDeleteConfirm(type) {
                            return new Promise((resolve) => {
                                const modal = document.getElementById('deleteConfirmModal');
                                const msg = document.getElementById('deleteConfirmMessage');
                                const btnNo = document.getElementById('deleteConfirmNo');
                                const btnYes = document.getElementById('deleteConfirmYes');

                                const labels = { section: 'section', lesson: 'lesson', resource: 'resource' };
                                msg.textContent = 'Remove this ' + (labels[type] || 'item') + '?';

                                modal.classList.remove('hidden');
                                document.body.style.overflow = 'hidden';

                                function cleanup() {
                                    modal.classList.add('hidden');
                                    document.body.style.overflow = '';
                                    btnNo.removeEventListener('click', onNo);
                                    btnYes.removeEventListener('click', onYes);
                                    modal.removeEventListener('click', onBackdrop);
                                }
                                function onNo() {
                                    cleanup();
                                    resolve(false);
                                }
                                function onYes() {
                                    cleanup();
                                    resolve(true);
                                }
                                function onBackdrop(e) {
                                    if (e.target === modal) {
                                        cleanup();
                                        resolve(false);
                                    }
                                }

                                btnNo.addEventListener('click', onNo);
                                btnYes.addEventListener('click', onYes);
                                modal.addEventListener('click', onBackdrop);
                            });
                        }

                        // Override deleteEntity to use the custom modal instead of confirm()
                        deleteEntity = async function (type, id, elementToRemove) {
                            const confirmed = await showDeleteConfirm(type);
                            if (!confirmed)
                                return;

                            let endpoint = '';
                            let body = new URLSearchParams();
                            body.append('action', 'delete');

                            if (type === 'section') {
                                endpoint = '/sectionAdmin';
                                body.append('section_id', id);
                            } else if (type === 'lesson') {
                                endpoint = '/lessonAdmin';
                                body.append('lesson_id', id);
                            } else if (type === 'resource') {
                                endpoint = '/resourceAdmin';
                                body.append('resource_id', id);
                            } else if (type === 'assignment') {
                                endpoint = '/assignmentAdmin';
                                body.append('assignment_id', id);
                            }

                            try {
                                const response = await fetch((window.CONTEXT_PATH || '') + endpoint, {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                    body: body
                                });
                                const result = await response.json();
                                if (result.status === 'success') {
                                    if (elementToRemove) {
                                        elementToRemove.remove();
                                    } else {
                                        window.location.reload();
                                    }
                                } else {
                                    alert('Error deleting: ' + (result.message || 'Unknown error'));
                                }
                            } catch (error) {
                                console.error('Error:', error);
                                alert('Request failed');
                            }
                        };
                        function convertToIframeUrl(url) {
                            if (!url)
                                return "";

                            try {
                                const parsed = new URL(url);

                                // YouTube
                                if (parsed.hostname.includes("youtube.com")) {
                                    const videoId = parsed.searchParams.get("v");
                                    if (videoId) {
                                        return "https://www.youtube.com/embed/" + videoId + "?rel=0";
                                    }
                                }

                                if (parsed.hostname.includes("youtu.be")) {
                                    const videoId = parsed.pathname.substring(1);
                                    return "https://www.youtube.com/embed/" + videoId + "?rel=0";
                                }

                                // Google Drive
                                if (url.includes("drive.google.com/file/d/")) {
                                    const fileId = url.split("/file/d/")[1].split("/")[0];
                                    return "https://drive.google.com/file/d/" + fileId + "/preview";
                                }

                            } catch (e) {
                                console.log("Invalid URL");
                            }

                            return url;
                        }
                        // ---- Document Modal ----
                        function openDocModal(title, url) {
                            if (document.body.classList.contains('edit-mode'))
                                return;
                            if (!url)
                                return;
                            console.log("Original URL:", url);

                            url = convertToIframeUrl(url);

                            console.log("Converted URL:", url);

                            document.getElementById('docModalTitle').innerText = title || 'Document';
                            document.getElementById('docModalIframe').src = url;
                            const modal = document.getElementById('docModal');
                            modal.classList.remove('hidden');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeDocModal() {
                            const modal = document.getElementById('docModal');
                            modal.classList.add('hidden');
                            document.getElementById('docModalIframe').src = '';
                            document.body.style.overflow = '';
                        }

                        // Close modal when clicking outside
                        document.getElementById('docModal').addEventListener('click', function (e) {
                            if (e.target === this) {
                                closeDocModal();
                            }
                        });

                        // ---- Assignment Modal ----
                        let _pollingTimer = null;
                        let _currentAssignmentBtn = null;

                        function openAssignmentModal(btnElement) {
                            if (document.body.classList.contains('edit-mode'))
                                return;

                            _currentAssignmentBtn = btnElement;

                            const title = btnElement.getAttribute('data-title') || 'Code Assignment';
                            const id = btnElement.getAttribute('data-id') || '';
                            const desc = btnElement.getAttribute('data-desc') || 'No description provided.';
                            const reqs = btnElement.getAttribute('data-reqs') || 'No requirements specified.';
                            const output = btnElement.getAttribute('data-output') || 'No expected output specified.';
                            const files = btnElement.getAttribute('data-files') || '';

                            document.getElementById('assignmentModalTitle').innerText = 'Chấm điểm bài tập: ' + title;
                            document.getElementById('modalAssignmentIdInput').value = id;
                            document.getElementById('modalAssignmentDesc').innerText = desc;
                            document.getElementById('modalAssignmentReqs').innerText = reqs;
                            document.getElementById('modalAssignmentOutput').innerText = output;

                            const filesContainer = document.getElementById('modalAssignmentFiles');
                            filesContainer.innerHTML = '';
                            if (files) {
                                files.split(',').forEach(ext => {
                                    const span = document.createElement('span');
                                    span.className = 'px-2 py-0.5 text-xs font-semibold text-slate-700 bg-white border border-slate-300 rounded shadow-sm';
                                    span.innerText = ext.trim();
                                    filesContainer.appendChild(span);
                                });
                            }

                            resetSubmissionForm();
                            const modal = document.getElementById('assignmentModal');
                            modal.classList.remove('hidden');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeAssignmentModal() {
                            if (_pollingTimer) { clearInterval(_pollingTimer); _pollingTimer = null; }
                            const modal = document.getElementById('assignmentModal');
                            modal.classList.add('hidden');
                            document.getElementById('githubUrl').value = '';
                            document.body.style.overflow = '';
                        }

                        document.getElementById('assignmentModal').addEventListener('click', function (e) {
                            if (e.target === this) closeAssignmentModal();
                        });

                        function showArea(areaId) {
                            ['submissionFormArea', 'submissionLoadingArea'].forEach(id => {
                                document.getElementById(id).classList.add('hidden');
                            });
                            document.getElementById(areaId).classList.remove('hidden');
                        }

                        function resetSubmissionForm() {
                            if (_pollingTimer) { clearInterval(_pollingTimer); _pollingTimer = null; }
                            showArea('submissionFormArea');
                            document.getElementById('githubUrl').value = '';
                        }

                        const STATUS_LABELS = {
                            'PENDING': 'Đang chuẩn bị...',
                            'CLONING': 'Đang clone repository...',
                            'ANALYZING': 'Đang phân tích source code...',
                            'GRADING': 'Đang chấm điểm bằng AI...',
                            'DONE': 'Chấm điểm hoàn tất!',
                            'FAILED': 'Chấm điểm thất bại.'
                        };

                        // ---- Edit Assignment Modal ----
                        function openEditAssignmentModal(id) {
                            if (document.body.classList.contains('edit-mode')) {
                                const container = document.getElementById('assignment-container-' + id);
                                const dataElem = container.querySelector('[data-id]');
                                
                                document.getElementById('editAssignmentIdInput').value = id;
                                document.getElementById('editAssignmentTitle').value = dataElem.getAttribute('data-title') || '';
                                document.getElementById('editAssignmentDesc').value = dataElem.getAttribute('data-desc') || '';
                                document.getElementById('editAssignmentReqs').value = dataElem.getAttribute('data-reqs') || '';
                                document.getElementById('editAssignmentOutput').value = dataElem.getAttribute('data-output') || '';
                                document.getElementById('editAssignmentFiles').value = dataElem.getAttribute('data-files') || '';

                                const modal = document.getElementById('editAssignmentModal');
                                const overlay = modal.querySelector('.modal-overlay');
                                const content = modal.querySelector('.bg-white');

                                modal.classList.remove('hidden');
                                modal.classList.add('flex');

                                // Small delay for animation
                                setTimeout(() => {
                                    overlay.classList.remove('opacity-0');
                                    overlay.classList.add('opacity-100');
                                    content.classList.remove('scale-95', 'opacity-0');
                                    content.classList.add('scale-100', 'opacity-100');
                                }, 10);
                            } else {
                                alert("Please switch to Edit Mode to modify assignments.");
                            }
                        }

                        function closeEditAssignmentModal() {
                            const modal = document.getElementById('editAssignmentModal');
                            const overlay = modal.querySelector('.modal-overlay');
                            const content = modal.querySelector('.bg-white');

                            overlay.classList.remove('opacity-100');
                            overlay.classList.add('opacity-0');
                            content.classList.remove('scale-100', 'opacity-100');
                            content.classList.add('scale-95', 'opacity-0');

                            setTimeout(() => {
                                modal.classList.remove('flex');
                                modal.classList.add('hidden');
                            }, 300);
                        }

                        document.getElementById('editAssignmentModal').addEventListener('click', function (e) {
                            if (e.target.classList.contains('modal-overlay')) closeEditAssignmentModal();
                        });

                        async function submitEditAssignmentAjax() {
                            const btn = document.querySelector('#editAssignmentModal .bg-emerald-600');
                            btn.disabled = true;
                            btn.innerText = 'Updating...';

                            try {
                                const body = new URLSearchParams();
                                body.append('action', 'update');
                                body.append('assignment_id', document.getElementById('editAssignmentIdInput').value);
                                body.append('title', document.getElementById('editAssignmentTitle').value);
                                body.append('description', document.getElementById('editAssignmentDesc').value);
                                body.append('criteria', document.getElementById('editAssignmentReqs').value);
                                body.append('expected_output', document.getElementById('editAssignmentOutput').value);
                                body.append('file_extensions', document.getElementById('editAssignmentFiles').value);

                                const res = await fetch((window.CONTEXT_PATH || '') + '/assignmentAdmin', {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                    body: body
                                });

                                const json = await res.json();
                                if (json.status === 'success') {
                                    closeEditAssignmentModal();
                                    await refreshCourseContent();
                                } else {
                                    alert('Error updating assignment: ' + (json.message || 'Unknown error'));
                                }
                            } catch (e) {
                                console.error(e);
                                alert('Failed to update assignment.');
                            } finally {
                                btn.disabled = false;
                                btn.innerText = 'Update Assignment';
                            }
                        }

                        async function submitAssignmentAjax() {
                            const githubUrl = document.getElementById('githubUrl').value.trim();
                            const assignmentId = document.getElementById('modalAssignmentIdInput').value;

                            if (!githubUrl) { alert('Vui lòng nhập GitHub URL'); return; }
                            if (!githubUrl.startsWith('https://github.com/')) {
                                alert('URL phải bắt đầu bằng https://github.com/'); return;
                            }

                            showArea('submissionLoadingArea');
                            document.getElementById('gradingStatusText').innerText = 'Đang gửi bài nộp...';

                            try {
                                const body = new URLSearchParams();
                                body.append('assignmentId', assignmentId);
                                body.append('githubUrl', githubUrl);

                                console.log('Submitting assignment with data:', { assignmentId, githubUrl });

                                const resp = await fetch('${pageContext.request.contextPath}/submitAssignment', {
                                    method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, body
                                });
                                
                                const data = await resp.json();
                                console.log('Received response from /submitAssignment:', data);

                                if (data.status !== 'success' || !data.submissionId) {
                                    alert(data.message || 'Lỗi khi nộp bài.');
                                    showArea('submissionFormArea');
                                    return;
                                }

                                document.getElementById('gradingStatusText').innerText = STATUS_LABELS['CLONING'];
                                pollSubmissionStatus(data.submissionId);

                            } catch (err) {
                                console.error('Submit error:', err);
                                alert('Lỗi kết nối. Vui lòng thử lại.');
                                showArea('submissionFormArea');
                            }
                        }

                        function pollSubmissionStatus(submissionId) {
                            if (_pollingTimer) clearInterval(_pollingTimer);

                            _pollingTimer = setInterval(async () => {
                                try {
                                    console.log('Polling status for submissionId:', submissionId);
                                    const resp = await fetch(`${pageContext.request.contextPath}/submissionStatus?id=` + submissionId);
                                    const data = await resp.json();
                                    
                                    console.log('Poll response:', data);

                                    if (data.status !== 'success') return;

                                    const st = data.submissionStatus || '';
                                    if(STATUS_LABELS[st]) {
                                        document.getElementById('gradingStatusText').innerText = STATUS_LABELS[st];
                                    } else {
                                        document.getElementById('gradingStatusText').innerText = st;
                                    }

                                    if (data.completed) {
                                        clearInterval(_pollingTimer);
                                        _pollingTimer = null;
                                        renderGradingResults(data);
                                    }
                                } catch (e) {
                                    console.error('Polling error:', e);
                                }
                            }, 3000);
                        }

                        function renderGradingResults(data) {
                            const score = data.score != null ? data.score : 0;
                            const isFailed = data.submissionStatus === 'FAILED';

                            document.getElementById('resultScore').innerText = score + ' / 100';
                            document.getElementById('resultFileCount').innerText =
                                (data.totalFiles || 0) + ' files | 0 issues';

                            const badgeEl = document.getElementById('resultStatusBadge');
                            if (isFailed) {
                                badgeEl.innerHTML = '<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold bg-red-50 text-red-700 border border-red-200"><span class="material-symbols-outlined" style="font-size:14px;">error</span>Chấm điểm thất bại</span>';
                            } else {
                                badgeEl.innerHTML = '<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold bg-emerald-50 text-emerald-700 border border-emerald-200"><span class="material-symbols-outlined" style="font-size:14px;">check_circle</span>Chấm điểm thành công</span>';
                            }

                            // File table
                            const tbody = document.getElementById('resultFilesTable');
                            tbody.innerHTML = '';
                            if (data.fileAnalyses && data.fileAnalyses.length > 0) {
                                data.fileAnalyses.forEach(f => {
                                    const tr = document.createElement('tr');
                                    tr.className = 'border-t border-slate-100 hover:bg-slate-50';
                                    const fileScore = f.aiScore != null ? f.aiScore : 100;
                                    const scoreColor = fileScore >= 90 ? 'text-emerald-600' : fileScore >= 70 ? 'text-amber-600' : 'text-red-600';
                                    tr.innerHTML = '<td class="px-4 py-3 text-slate-600 font-medium whitespace-normal break-all">' + (f.fileName || '') + '</td>'
                                        + '<td class="px-4 py-3 text-center text-slate-500">0</td>'
                                        + '<td class="px-4 py-3 text-right font-bold whitespace-nowrap ' + scoreColor + '">' + fileScore + ' / 100</td>';
                                    tbody.appendChild(tr);
                                });
                            }

                            // AI Feedback
                            document.getElementById('resultFeedback').innerText = data.feedback || 'Không có phản hồi.';

                            document.getElementById('resultModalSubtitle').innerText = document.getElementById('assignmentModalTitle').innerText.replace('Chấm điểm bài tập: ', '');

                            closeAssignmentModal();
                            const modal = document.getElementById('gradingResultModal');
                            modal.classList.remove('hidden');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeGradingResultModal() {
                            const modal = document.getElementById('gradingResultModal');
                            modal.classList.add('hidden');
                            document.body.style.overflow = '';
                        }

                        function retryAssignment() {
                            closeGradingResultModal();
                            setTimeout(() => {
                                if (_currentAssignmentBtn) {
                                    openAssignmentModal(_currentAssignmentBtn);
                                }
                            }, 300); // Wait for modal to close
                        }

                        document.getElementById('gradingResultModal').addEventListener('click', function(e) {
                            if (e.target === this) {
                                closeGradingResultModal();
                            }
                        });

                        // ===== Slider for "More courses for you" =====
                        window.addEventListener("load", function () {
                            const sliders = document.querySelectorAll(".slider");

                            sliders.forEach(function (slider) {
                                const track = slider.querySelector(".slider-track");
                                const prevBtn = slider.querySelector(".slider-prev");
                                const nextBtn = slider.querySelector(".slider-next");
                                const wrapper = slider.querySelector(".slider-wrapper");
                                if (!track || !prevBtn || !nextBtn || !wrapper) return;
                                let currentIndex = 0;

                                function getCards() {
                                    return track.querySelectorAll(":scope > div");
                                }

                                function getCardWidth() {
                                    const cards = getCards();
                                    if (!cards.length) return 0;
                                    const style = window.getComputedStyle(track);
                                    const gap = parseFloat(style.columnGap);
                                    return cards[0].getBoundingClientRect().width + gap;
                                }

                                function getMaxIndex() {
                                    const cardWidth = getCardWidth();
                                    if (cardWidth === 0) return 0;
                                    const maxScroll = track.scrollWidth - wrapper.clientWidth;
                                    return Math.ceil(maxScroll / cardWidth);
                                }

                                function updateSlider() {
                                    wrapper.scrollTo({
                                        left: currentIndex * getCardWidth(),
                                        behavior: "smooth"
                                    });
                                }

                                nextBtn.addEventListener("click", function () {
                                    const maxIndex = getMaxIndex();
                                    if (currentIndex < maxIndex) {
                                        currentIndex++;
                                    } else {
                                        currentIndex = 0;
                                    }
                                    updateSlider();
                                });

                                prevBtn.addEventListener("click", function () {
                                    const maxIndex = getMaxIndex();
                                    if (currentIndex > 0) {
                                        currentIndex--;
                                    } else {
                                        currentIndex = maxIndex;
                                    }
                                    updateSlider();
                                });
                            });
                        });
                        
                        /* ── Enrollment Logic ── */
                        document.addEventListener("DOMContentLoaded", function() {
                            const isLoggedIn = ${sessionScope.USER != null};
                            if (isLoggedIn) {
                                const freeCourseBtns = document.querySelectorAll('.free-course-btn');
                                freeCourseBtns.forEach(btn => {
                                    const courseId = btn.getAttribute('data-course-id');
                                    fetch(`${pageContext.request.contextPath}/api/courses/${courseId}/enrollment-status`)
                                        .then(r => r.json())
                                        .then(data => {
                                            if (data.enrolled) {
                                                const enrolledBtn = btn.parentElement.querySelector('.free-course-enrolled-btn');
                                                btn.classList.add('hidden');
                                                enrolledBtn.classList.remove('hidden');
                                            } else {
                                                btn.classList.remove('hidden');
                                            }
                                        })
                                        .catch(e => {
                                            console.error('Status check error:', e);
                                            btn.classList.remove('hidden');
                                        });
                                });
                            }
                        });

                        window.handleEnrollment = function(btn, courseId, isLogged) {
                            if (!isLogged) {
                                window.location.href = '${pageContext.request.contextPath}/login';
                                return;
                            }

                            const originalText = btn.innerHTML;
                            btn.innerHTML = '<span class="material-symbols-outlined animate-spin text-sm align-middle">progress_activity</span> Processing...';
                            btn.disabled = true;

                            fetch(`${pageContext.request.contextPath}/api/courses/${courseId}/enroll`, {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                }
                            })
                            .then(r => {
                                if (r.ok || r.status === 401) {
                                    return r.json();
                                } else {
                                    throw new Error('API failed');
                                }
                            })
                            .then(data => {
                                if (data.error && data.error === 'User not logged in') {
                                    window.location.href = '${pageContext.request.contextPath}/login';
                                    return;
                                }
                                if (data.enrolled) {
                                    const enrolledBtn = btn.parentElement.querySelector('.free-course-enrolled-btn');
                                    btn.classList.add('hidden');
                                    enrolledBtn.classList.remove('hidden');
                                    // if it's the main enroll button, it might need page reload to unlock content
                                    if (btn.classList.contains('w-full')) {
                                        setTimeout(() => window.location.reload(), 1000);
                                    }
                                } else {
                                    btn.innerHTML = originalText;
                                    btn.disabled = false;
                                    alert('Enrollment failed');
                                }
                            })
                            .catch(e => {
                                console.error('Enroll error:', e);
                                btn.innerHTML = originalText;
                                btn.disabled = false;
                                alert('Something went wrong during enrollment');
                            });
                        };
                    </script>

                    <jsp:include page="../common/userbuttom.jsp" />

                </body>

                </html>