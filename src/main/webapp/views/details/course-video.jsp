<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Course Video Player | DevLearn</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
        <!-- Google Fonts: Inter -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet" />
        <!-- Material Symbols -->
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet" />

        <style type="text/tailwindcss">
            @layer base {
                body {
                    font-family: 'Inter', sans-serif;
                }
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                font-size: 20px;
            }
            .material-symbols-outlined.filled {
                font-variation-settings: 'FILL' 1;
            }
            /* Custom scrollbar for a cleaner look */
            .custom-scrollbar::-webkit-scrollbar {
                width: 6px;
            }
            .custom-scrollbar::-webkit-scrollbar-track {
                background: transparent;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb {
                background-color: #cbd5e1;
                border-radius: 10px;
            }
            details > summary::-webkit-details-marker {
                display: none;
            }
        </style>
    </head>

    <body class="bg-gray-50 flex flex-col h-screen overflow-hidden text-slate-900">

        <!-- Standard Header Context 
        <div class="flex-none shadow-sm z-10">
        <jsp:include page="../common/header.jsp" />
    </div> -->

        <!-- Main Content Area -->
        <main class="flex-1 flex overflow-hidden">

            <!-- 1. Left Section (Video Player Area) -->
            <section class="w-full lg:w-[70%] h-full flex flex-col bg-white overflow-y-auto custom-scrollbar">

                <!-- Video Header Info -->
                <div
                    class="px-6 md:px-8 py-5 flex flex-col md:flex-row md:items-start justify-between gap-4 border-b border-gray-100">
                    <div class="flex-1">
                        <div class="text-sm font-bold text-emerald-600 mb-1.5 uppercase tracking-wider">
                            <!-- Graceful fallback between standard app course structure and provided mock EL -->
                            ${not empty courseDetail.course.title ? courseDetail.course.title : (not empty
                              course.title ? course.title : 'Course Name')}
                        </div>
                        <h1 class="text-2xl md:text-3xl font-black text-slate-900 leading-tight">
                            <c:choose>
                                <c:when test="${not empty currentResource.title}">${currentResource.title}
                                </c:when>
                                <c:when test="${not empty lesson.title}">${lesson.title}</c:when>
                                <c:otherwise>Video Title</c:otherwise>
                            </c:choose>
                        </h1>
                    </div>

                    <!-- Action buttons -->
                    <div class="flex flex-wrap items-center gap-2 md:gap-3 shrink-0">
                        <button
                            class="flex items-center gap-1.5 px-3 py-2 rounded-lg border border-gray-200 text-sm font-semibold text-slate-600 hover:bg-gray-50 hover:text-emerald-600 transition-colors shadow-sm">
                            <span class="material-symbols-outlined self-center text-[18px]">star_rate</span>
                            <span class="hidden sm:inline">Leave a rating</span>
                        </button>
                        <div
                            class="flex items-center gap-1.5 px-3 py-2 rounded-lg bg-emerald-50 border border-emerald-100 text-emerald-700 text-sm font-bold shadow-sm">
                            <span class="material-symbols-outlined self-center text-[18px]">adjust</span>
                            Progress: 75%
                        </div>
                        <button
                            class="flex items-center gap-1.5 px-3 py-2 rounded-lg border border-gray-200 text-slate-600 hover:bg-gray-50 hover:text-emerald-600 transition-colors text-sm font-semibold shadow-sm">
                            <span class="material-symbols-outlined self-center text-[18px]">share</span>
                            <span class="hidden sm:inline">Share</span>
                        </button>
                    </div>
                </div>

                <!-- YouTube Video Player Area -->
                <div class="w-full aspect-video bg-black shrink-0 relative flex items-center justify-center">
                    <!-- Fallback Logic for video URL embed -->
                    <c:set var="rawVideoUrl"
                           value="${not empty videoUrl ? videoUrl : (not empty currentResource.url ? currentResource.url : 'https://www.youtube.com/watch?v=dQw4w9WgXcQ')}" />

                    <c:set var="videoId" value="${fn:substringAfter(rawVideoUrl,'v=')}" />
                    <c:set var="videoId" value="${fn:substringBefore(videoId,'&')}" />

                    <c:set var="videoEmbedParams"
                           value="https://www.youtube.com/embed/${videoId}" />

                    <iframe class="absolute inset-0 w-full h-full"
                            src="${videoEmbedParams}"
                            title="Course Video Player"
                            frameborder="0"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                            allowfullscreen>
                    </iframe>
                </div>
                <div class="px-6 md:px-8 py-4 border-b border-gray-100 bg-emerald-50/30 flex justify-end">
                    <button id="markCompleteBtn" onclick="markLessonCompleted()"
                            class="flex items-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-sm hover:shadow-md">
                        <span class="material-symbols-outlined">check_circle</span>
                        Đánh dấu đã hoàn thành bài học
                    </button>
                </div>
                <!-- Comment Section -->
                <div class="p-6 md:p-8 flex-1 w-full max-w-5xl">
                    <h3 class="text-xl font-bold mb-6 flex items-center gap-2 text-slate-800">
                        <span class="material-symbols-outlined filled text-emerald-500">forum</span>
                        Comments
                    </h3>

                    <!-- Input Area -->
                    <div class="flex gap-4 items-start mb-10">
                        <div
                            class="w-10 h-10 rounded-full bg-emerald-100 border border-emerald-200 flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-emerald-600">person</span>
                        </div>
                        <div class="flex-1">
                            <textarea rows="3"
                                      class="w-full border border-gray-200 rounded-xl p-3 focus:outline-none focus:ring-2 border-slate-200 focus:ring-emerald-500/20 focus:border-emerald-500 resize-none transition-all"
                                      placeholder="Ask questions, discuss this lesson..."></textarea>
                            <div class="flex justify-end mt-3">
                                <button
                                    class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2 px-6 rounded-lg transition-colors shadow-sm">
                                    Submit Comment
                                </button>
                            </div>
                        </div>
                    </div>

                    <hr class="border-gray-100 mb-8" />

                    <!-- Comments list dummy area -->
                    <div class="space-y-8">
                        <!-- Comment 1 -->
                        <div class="flex gap-4">
                            <div
                                class="w-10 h-10 rounded-full bg-indigo-100 shrink-0 flex items-center justify-center text-indigo-700 font-bold border border-indigo-200">
                                A
                            </div>
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-bold text-slate-800 text-sm">Student A</span>
                                    <span
                                        class="text-[11px] font-medium text-slate-400 bg-slate-100 px-1.5 py-0.5 rounded">1
                                        day ago</span>
                                </div>
                                <p class="text-sm text-slate-600 leading-relaxed mt-1">
                                    The lecture is very detailed and easy to understand, thanks instructor! The
                                    clear expression
                                    helps me easily grasp complex concepts.
                                </p>
                                <div class="flex items-center gap-4 mt-3">
                                    <button
                                        class="text-xs text-slate-500 hover:text-emerald-600 flex items-center gap-1.5 font-semibold transition-colors">
                                        <span class="material-symbols-outlined text-[16px]">thumb_up</span> 12
                                        Helpful
                                    </button>
                                    <button
                                        class="text-xs text-slate-500 hover:text-slate-800 font-semibold transition-colors">Reply</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </section>


            <!-- 2. Right Section (Lesson Content Sidebar) -->
            <aside
                class="w-full lg:w-[30%] h-full bg-slate-50 border-l border-gray-200 flex flex-col hidden lg:flex">

                <div class="p-5 border-b border-gray-200 bg-white shrink-0 flex items-center justify-between">
                    <h2 class="text-[17px] font-black text-slate-800 tracking-tight">Course Content</h2>
                    <button class="text-slate-400 hover:text-emerald-600 transition-colors">
                        <span class="material-symbols-outlined">close_fullscreen</span>
                    </button>
                </div>

                <div class="flex-1 overflow-y-auto custom-scrollbar">

                    <!-- Fallback loop from markdown examples -->
                    <c:choose>
                        <c:when test="${not empty courseDetail and not empty courseDetail.sections}">
                            <!-- Project specific section dynamic loading -->
                            <div class="divide-y divide-gray-100">
                                <c:forEach var="sectionDTO" items="${courseDetail.sections}">
                                    <details class="group bg-white" open>
                                        <summary
                                            class="flex items-center justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none select-none border-l-2 border-transparent group-open:border-emerald-400">
                                            <div class="pr-2">
                                                <h3 class="font-bold text-base text-emerald-800 leading-tight">
                                                    Section ${sectionDTO.section.orderIndex}:
                                                    ${sectionDTO.section.title}
                                                </h3>
                                                <p class="text-[11px] font-medium text-slate-500 mt-1">
                                                    0 / ${sectionDTO.lessons.size()} lessons
                                                </p>
                                            </div>
                                            <span
                                                class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform shrink-0">expand_more</span>
                                        </summary>

                                        <div class="bg-gray-50/50">
                                            <c:forEach var="lessonDTO" items="${sectionDTO.lessons}">

                                                <details class="group bg-gray-50">
                                                    <summary
                                                        class="flex items-center justify-between px-5 py-3 cursor-pointer hover:bg-gray-100 transition-colors">
                                                        <p class="text-sm font-bold text-slate-700">
                                                            Lesson ${lessonDTO.lesson.orderIndex}:
                                                            ${lessonDTO.lesson.title}
                                                        </p>
                                                        <span
                                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform">
                                                            expand_more
                                                        </span>
                                                    </summary>

                                                    <div>
                                                        <c:forEach var="resource"
                                                                   items="${lessonDTO.resources}">

                                                            <c:set var="isActive"
                                                                   value="${resource.resourceId == param.resourceId}" />

                                                            <a href="${pageContext.request.contextPath}/courseVideo?resourceId=${resource.resourceId}"
                                                               class="flex gap-3 p-3 pl-5 border-l-4 ${isActive ? 'border-emerald-500 bg-emerald-50' : 'border-transparent hover:bg-gray-100/80'} transition-all cursor-pointer">

                                                                <div
                                                                    class="mt-0.5 shrink-0 flex flex-col items-center">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${resource.resourceType == 'video'}">
                                                                            <span
                                                                                class="material-symbols-outlined text-[18px] ${isActive ? 'filled text-emerald-600' : 'text-slate-400'}">play_circle</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span
                                                                                class="material-symbols-outlined text-[18px] ${isActive ? 'filled text-emerald-600' : 'text-slate-400'}">menu_book</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>

                                                                <div class="flex-1 min-w-0">
                                                                    <p
                                                                        class="text-[13px] ${isActive ? 'text-emerald-800 font-bold' : 'text-slate-700 font-semibold'} leading-snug line-clamp-2">
                                                                        ${resource.title}
                                                                    </p>
                                                                    <div class="flex items-center gap-2 mt-1.5">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${resource.resourceType == 'video'}">
                                                                                <span
                                                                                    class="text-[10px] font-bold text-slate-500 px-1.5 py-0.5 rounded bg-slate-200/50 flex items-center gap-1 w-max">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-[11px]">schedule</span>
                                                                                    ${not empty
                                                                                      resource.duration ?
                                                                                      resource.duration : '0'}
                                                                                    mins
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span
                                                                                    class="text-[10px] font-bold text-slate-500 px-1.5 py-0.5 rounded bg-slate-200/50 flex items-center gap-1 w-max">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-[11px]">menu_book</span>
                                                                                    Document
                                                                                </span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </c:forEach>
                                                    </div>
                                                </details>
                                            </c:forEach>
                                        </div>
                                    </details>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>

                            <!-- Simple Static Demo & Markdown requirement implementation loop -->
                            <div class="divide-y divide-gray-100">

                                <!-- Static Demo Part 1 -->
                                <details class="group bg-white" open>
                                    <summary
                                        class="flex items-center justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none select-none border-l-2 border-transparent group-open:border-emerald-400">
                                        <div>
                                            <h3 class="font-bold text-sm text-slate-800 leading-tight">Section 1
                                            </h3>
                                        </div>
                                        <span
                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform">expand_more</span>
                                    </summary>
                                    <div class="bg-gray-50/50">
                                        <!-- Fallback to plain lesson loops -->
                                        <c:forEach var="lesson" items="${lessons}">
                                            <a href="#"
                                               class="flex gap-3 p-3 pl-5 border-l-4 border-transparent hover:bg-gray-100/80 transition-all cursor-pointer">
                                                <div class="mt-0.5 shrink-0"><span
                                                        class="material-symbols-outlined text-[18px] text-slate-400">play_circle</span>
                                                </div>
                                                <div class="flex-1 min-w-0">
                                                    <p
                                                        class="text-[13px] text-slate-700 font-semibold leading-snug line-clamp-2">
                                                        ${lesson.title}</p>
                                                    <span
                                                        class="text-[10px] font-bold text-slate-500 px-1.5 py-0.5 rounded bg-slate-200/50 flex items-center gap-1 mt-1.5 w-max">
                                                        <span
                                                            class="material-symbols-outlined text-[11px]">schedule</span>
                                                        ${lesson.duration}
                                                    </span>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </details>

                                <!-- Static Demo Part 2 (To match exact document layout visually if data empty) -->
                                <details class="group bg-white" open>
                                    <summary
                                        class="flex items-center justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none select-none border-l-2 border-transparent group-open:border-emerald-400">
                                        <div>
                                            <h3 class="font-bold text-sm text-slate-800 leading-tight">Section 2
                                            </h3>
                                        </div>
                                        <span
                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform">expand_more</span>
                                    </summary>
                                    <div class="bg-gray-50/50">
                                        <a href="#"
                                           class="flex gap-3 p-3 pl-5 border-l-4 border-emerald-500 bg-emerald-50 transition-all cursor-pointer">
                                            <div class="mt-0.5 shrink-0"><span
                                                    class="material-symbols-outlined text-[18px] filled text-emerald-600">play_circle</span>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <p
                                                    class="text-[13px] text-emerald-800 font-bold leading-snug line-clamp-2">
                                                    Lesson 1 - Risk Management and Stakeholders
                                                </p>
                                                <span
                                                    class="text-[10px] font-bold text-slate-500 px-1.5 py-0.5 rounded bg-slate-200/50 flex items-center gap-1 mt-1.5 w-max">
                                                    <span
                                                        class="material-symbols-outlined text-[11px]">schedule</span>
                                                    15:20
                                                </span>
                                            </div>
                                        </a>
                                        <a href="#"
                                           class="flex gap-3 p-3 pl-5 border-l-4 border-transparent hover:bg-gray-100/80 transition-all cursor-pointer">
                                            <div class="mt-0.5 shrink-0"><span
                                                    class="material-symbols-outlined text-[18px] text-slate-400">menu_book</span>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <p
                                                    class="text-[13px] text-slate-700 font-semibold leading-snug line-clamp-2">
                                                    Preview - Review Task 2 and Identification Guide
                                                </p>
                                                <span
                                                    class="text-[10px] font-bold text-slate-500 px-1.5 py-0.5 rounded bg-slate-200/50 flex items-center gap-1 mt-1.5 w-max">
                                                    <span
                                                        class="material-symbols-outlined text-[11px]">menu_book</span>
                                                    Document
                                                </span>
                                            </div>
                                        </a>
                                    </div>
                                </details>

                                <!-- Static Demo Part 3-5 -->
                                <details class="group bg-white" open>
                                    <summary
                                        class="flex justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none border-l-2 border-transparent group-open:border-emerald-400">
                                        <div>
                                            <h3 class="font-bold text-sm text-slate-800">Section 3</h3>
                                        </div><span
                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180">expand_more</span>
                                    </summary>
                                </details>
                                <details class="group bg-white" open>
                                    <summary
                                        class="flex justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none border-l-2 border-transparent group-open:border-emerald-400">
                                        <div>
                                            <h3 class="font-bold text-sm text-slate-800">Section 4</h3>
                                        </div><span
                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180">expand_more</span>
                                    </summary>
                                </details>
                                <details class="group bg-white" open>
                                    <summary
                                        class="flex justify-between p-4 cursor-pointer hover:bg-emerald-50/50 transition-colors list-none border-l-2 border-transparent group-open:border-emerald-400">
                                        <div>
                                            <h3 class="font-bold text-sm text-slate-800">Section 5</h3>
                                        </div><span
                                            class="material-symbols-outlined text-slate-400 group-open:rotate-180">expand_more</span>
                                    </summary>
                                </details>

                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
            </aside>

        </main>

        <jsp:include page="../common/userbuttom.jsp" />

        <div id="ai-debug-box" style="position: fixed; bottom: 20px; left: 20px; background: #fff; border: 4px solid red; padding: 15px; z-index: 99999; box-shadow: 0 0 15px rgba(0,0,0,0.3); border-radius: 8px;">
            <h3 style="color: red; font-weight: 900; margin-bottom: 10px; font-size: 16px;">🔍 RADAR TÌM ID HỌC VIÊN</h3>

            <p>1. Thử tìm biến <b>user</b>: <span style="color:blue; font-weight:bold; font-size:18px;">${sessionScope.user.userId} ${sessionScope.user.id}</span></p>
            <p>2. Thử tìm biến <b>account</b>: <span style="color:blue; font-weight:bold; font-size:18px;">${sessionScope.account.userId} ${sessionScope.account.id}</span></p>
            <p>3. Thử tìm biến <b>student</b>: <span style="color:blue; font-weight:bold; font-size:18px;">${sessionScope.student.userId} ${sessionScope.student.studentId}</span></p>

            <hr style="margin: 10px 0;">
            <p style="font-size: 12px; color: #666;">Danh sách các biến đang có trong Session của bạn:</p>
            <ul style="font-size: 13px; color: purple; margin-top: 5px; font-weight: bold;">
                <c:forEach items="${sessionScope}" var="attr">
                    <li>👉 ${attr.key}</li>
                    </c:forEach>
            </ul>
        </div>

        <script>
            // 🛑 BƯỚC QUAN TRỌNG NHẤT:
            // Bạn nhìn ra ngoài giao diện Web, xem cái số ID màu xanh lam nó hiện ở dòng 1, 2 hay 3.
            // Nếu nó hiện ở dòng 2 (biến account), bạn hãy sửa chữ "user.userId" ở dưới thành "account.id" (hoặc thuộc tính tương ứng).

            const currentStudentId = "${sessionScope.USER.userId}"; // <--- BẠN CHỈ CẦN SỬA ĐÚNG DÒNG NÀY

            // Logic xử lý ngầm (Không cần sửa)
            if (currentStudentId && currentStudentId !== "") {
                console.log("🟢 Hệ thống theo dõi AI đã kích hoạt cho User ID: " + currentStudentId);

                // Đổi màu bảng Radar sang Xanh lá báo hiệu thành công
                const debugBox = document.getElementById("ai-debug-box");
                debugBox.style.borderColor = "#10b981";
                debugBox.innerHTML += "<div style='margin-top: 15px; padding: 8px; background: #d1fae5; color: #047857; font-weight: bold; border-radius: 4px;'>✅ THÀNH CÔNG! ĐÃ LẤY ĐƯỢC ID: " + currentStudentId + "<br>Hệ thống AI đang chạy ngầm...</div>";

                function sendStudyHeartbeat() {
                    const url = '${pageContext.request.contextPath}/api/track-study-time';

                    fetch(url, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'studentId=' + currentStudentId
                    })
                            .then(response => {
                                if (response.ok) {
                                    console.log("💓 [Ping AI] Đã cộng thêm 1 phút học vào CSDL!");
                                }
                            })
                            .catch(error => console.error('Lỗi tracking AI:', error));
                }

                // Đang để 5000 (5 giây) để test cho lẹ. Chạy thật nhớ đổi lại 60000.
                setInterval(sendStudyHeartbeat, 60000);

            } else {
                console.log("🟡 Chưa đăng nhập, hệ thống tracking AI đang ngủ.");
                document.getElementById("ai-debug-box").innerHTML += "<div style='margin-top: 15px; padding: 8px; background: #fee2e2; color: #b91c1c; font-weight: bold; border-radius: 4px;'>❌ THẤT BẠI: Javascript vẫn nhận được chuỗi rỗng.<br>Hãy sửa dòng `const currentStudentId = ...` cho khớp với Radar phía trên!</div>";
            }



            function markLessonCompleted() {
                // Lấy ID Học Viên
                const currentStudentId = "${sessionScope.USER.userId}";

                // Lấy ID Tài Nguyên từ thanh URL
                const currentResourceId = "${param.resourceId}";

                // --- MÁY SIÊU ÂM (In ra console để bắt bệnh) ---
                console.log("🚀 CHUẨN BỊ GỬI DATA: Student ID = " + currentStudentId + " | Resource ID = " + currentResourceId);

                if (!currentStudentId || currentStudentId === "") {
                    alert("Vui lòng đăng nhập để lưu tiến độ!");
                    return;
                }

                if (!currentResourceId || currentResourceId === "") {
                    alert("Không lấy được ID tài nguyên từ URL!");
                    return;
                }

                const btn = document.getElementById("markCompleteBtn");
                btn.innerHTML = '<span class="material-symbols-outlined animate-spin text-[20px]">sync</span> Đang lưu...';
                btn.disabled = true;
                btn.classList.add('opacity-75', 'cursor-not-allowed');

                const url = '${pageContext.request.contextPath}/api/complete-lesson';

                // ⚠️ ĐÂY LÀ CHỖ QUAN TRỌNG NHẤT: Bắt buộc phải là &resourceId=
                const payload = 'studentId=' + currentStudentId + '&resourceId=' + currentResourceId;

                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: payload
                })
                        .then(response => {
                            if (response.ok) {
                                btn.classList.remove('bg-emerald-600', 'hover:bg-emerald-700', 'text-white');
                                btn.classList.add('bg-gray-200', 'text-emerald-800');
                                btn.innerHTML = '<span class="material-symbols-outlined filled text-[20px]">task_alt</span> Đã hoàn thành';
                            } else {
                                throw new Error('Server trả về lỗi ' + response.status);
                            }
                        })
                        .catch(error => {
                            console.error('❌ Lỗi khi lưu tiến độ:', error);
                            alert("Có lỗi xảy ra, vui lòng thử lại sau!");
                            btn.disabled = false;
                            btn.classList.remove('opacity-75', 'cursor-not-allowed');
                            btn.innerHTML = '<span class="material-symbols-outlined text-[20px]">check_circle</span> Đánh dấu đã hoàn thành bài học';
                        });
            }
        </script>

    </body>

</html>