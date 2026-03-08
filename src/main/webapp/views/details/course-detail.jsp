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
                                        <div class="space-y-4">
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
                                                                                                        Video &bull;
                                                                                                        ${not empty
                                                                                                        resource.duration
                                                                                                        ?
                                                                                                        resource.duration
                                                                                                        : 0}
                                                                                                        min
                                                                                                    </p>
                                                                                                </div>
                                                                                            </a>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <button type="button"
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
                                                                                                        Document &bull;
                                                                                                        ${not
                                                                                                        empty
                                                                                                        resource.duration
                                                                                                        ?
                                                                                                        resource.duration
                                                                                                        : 0}
                                                                                                        min
                                                                                                    </p>
                                                                                                </div>
                                                                                            </button>
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
                                            <div class="edit-only mt-6 flex justify-center">
                                                <button type="button" id="addSectionBtn" onclick="addSection()"
                                                    class="text-base font-bold text-white bg-emerald-500 hover:bg-emerald-600 px-6 py-3 rounded-xl transition-all shadow-lg flex items-center gap-2">
                                                    <span class="material-symbols-outlined">add_circle</span> Add New
                                                    Section
                                                </button>
                                            </div>
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
                            <section class="mt-24">
                                <div class="flex items-center justify-between mb-10">
                                    <h3 class="text-3xl font-black text-slate-900 ">More courses for you</h3>
                                    <a class="text-sm font-bold text-[#10B981] flex items-center gap-1 hover:underline underline-offset-4"
                                        href="#">
                                        View all courses
                                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                    </a>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                                    <div class="group cursor-pointer">
                                        <div class="aspect-video rounded-2xl overflow-hidden mb-4 relative">
                                            <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBuOuOWmEviGXb4z7eDRuATW7I8km4bZ7g3wT3jIsGTnYD-NaLOd1jrwldvri5DvEtv-_d2Bl8YKyAQPVyhTjrlC3ss9883eou8UHtfcaByuMetA5xZiitt6VwpFJ8Wi3PnDvsYWSTT_-Na04Ba7Ldil8O3SyukIfOugW13Q_5n-y7OHoBmeD5tRZqfRq371MhT7dUM8rt3EJlAbeVWfLRKkCFQ2-LUfNx1SQL0e4iBXWmyU1_q_A3hGVGEDzdxxeT3nLkNP19rpzs" />
                                            <div
                                                class="absolute top-3 left-3 bg-white/90 backdrop-blur rounded px-2 py-1 text-[10px] font-black text-white">
                                                BESTSELLER</div>
                                        </div>
                                        <h4
                                            class="text-base font-bold text-slate-900  leading-tight mb-2 group-hover:text-[#10B981] transition-colors line-clamp-2">
                                            Python for Data Science and Machine Learning Masterclass
                                        </h4>
                                        <div class="flex items-center gap-2 mb-2">
                                            <div class="flex text-[#ffd700]">
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star_half</span>
                                            </div>
                                            <span class="text-xs text-slate-500 font-bold">4.8 (12k)</span>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-black ">1.299.000đ</span>
                                            <span
                                                class="text-[10px] font-bold text-slate-500 bg-emerald-500/10 px-2 py-1 rounded uppercase">Python</span>
                                        </div>
                                    </div>
                                    <div class="group cursor-pointer">
                                        <div class="aspect-video rounded-2xl overflow-hidden mb-4">
                                            <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDW17Qpsg15-NOgH4MQbJZT4z01txMWevo5s6khIhS_3sON3DhLilUYgnCXRn8XRgVqgiV-DItnUhjCN7e-7rWC1pe3yH2TwT1Aregw2xMXRymYav9dA_o_Tgf6sJIxJkyWcCQrMof7Q_yTUOON3PCSQmBUbnPXhT1TH7eq_7nRS7dCCmXPi2O4S6Bl3iaVPjvL8UJcsxrBpw4GaqVx_xpwEm_NubpAMsLk-7x_ZjgTpY0hNQ-MCa4SNI4Y71bGwOPD1HrhuDwa5vo" />
                                        </div>
                                        <h4
                                            class="text-base font-bold text-slate-900  leading-tight mb-2 group-hover:text-[#10B981] transition-colors line-clamp-2">
                                            Modern UI/UX Design Fundamentals with Figma &amp; Adobe XD
                                        </h4>
                                        <div class="flex items-center gap-2 mb-2">
                                            <div class="flex text-[#ffd700]">
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 0;">star</span>
                                            </div>
                                            <span class="text-xs text-slate-500 font-bold">4.2 (3k)</span>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-black ">899.000đ</span>
                                            <span
                                                class="text-[10px] font-bold text-slate-500 bg-emerald-500/10 px-2 py-1 rounded uppercase">Design</span>
                                        </div>
                                    </div>
                                    <div class="group cursor-pointer">
                                        <div class="aspect-video rounded-2xl overflow-hidden mb-4">
                                            <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDpW8GPZ21XxbzZWQHA9mFn2KucLEXGeRNtb_sVYyIi8H5_aI_zHOvsa1LWehH40gu7ijM8yhQcEJOJD6j80Xwykbjqr2v6g2Lq0y36fCGdhvzRf7MY0iXh4ZHOtAhtkBQbJdmVEOn9kBFgTrTyO6merKD3SCaFfQ63x4w9kSGOj6QgdjKFRKYPhq99e1zJt9yo3oclND26RyMMGtEMyWZbdszqWag7E2g3MWZqkJ0OM6u6Q33S2WAwvBNWultjLQLj2SpM4V9K-Uw" />
                                        </div>
                                        <h4
                                            class="text-base font-bold text-slate-900  leading-tight mb-2 group-hover:text-[#10B981] transition-colors line-clamp-2">
                                            Cybersecurity Essentials: Zero to Hero for Modern Developers
                                        </h4>
                                        <div class="flex items-center gap-2 mb-2">
                                            <div class="flex text-[#ffd700]">
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                            </div>
                                            <span class="text-xs text-slate-500 font-bold">4.9 (1k)</span>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-black ">1.499.000đ</span>
                                            <span
                                                class="text-[10px] font-bold text-slate-500 bg-emerald-500/10 px-2 py-1 rounded uppercase">Security</span>
                                        </div>
                                    </div>
                                    <div class="group cursor-pointer">
                                        <div class="aspect-video rounded-2xl overflow-hidden mb-4">
                                            <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuC-hR69iWs16U8mJKzNWE4mH5g39dOLqVgMjZZqnUljAY-qnMy_3YWr_XB320ViwBtYixQdOsCwkk8CiSNVIw-QlVwNyB9kMd7O8oq6jgxIG2NNozYaPNQf-dmCs-jNzNgaAYKl2VTvHS_7jU2JKOju8fW3gdt89ytr77H6h9vcXePsAMr4RnCNuk_oGuv8F20ozkPweQ5Jr9JOaCXPviuwtRqt87GGwz-DNCP5Kgmg6bVwvopEHuUFDeSkgfLrLUoeWApZ95tLHk8" />
                                        </div>
                                        <h4
                                            class="text-base font-bold text-slate-900  leading-tight mb-2 group-hover:text-[#10B981] transition-colors line-clamp-2">
                                            Advanced SQL and Database Architecture for High-Scale Apps
                                        </h4>
                                        <div class="flex items-center gap-2 mb-2">
                                            <div class="flex text-[#ffd700]">
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 1;">star</span>
                                                <span class="material-symbols-outlined text-sm"
                                                    style="font-variation-settings: 'FILL' 0;">star</span>
                                            </div>
                                            <span class="text-xs text-slate-500 font-bold">4.6 (5k)</span>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-black ">1.199.000đ</span>
                                            <span
                                                class="text-[10px] font-bold text-slate-500 bg-emerald-500/10 px-2 py-1 rounded uppercase">Database</span>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </main>
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

                    <!-- Delete Confirmation Modal -->
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
                    </style>

                    <script src="${pageContext.request.contextPath}/assets/js/edit-course.js"></script>
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
                        }
                        );
                    </script>

                    <jsp:include page="../common/userbuttom.jsp" />

                </body>

                </html>