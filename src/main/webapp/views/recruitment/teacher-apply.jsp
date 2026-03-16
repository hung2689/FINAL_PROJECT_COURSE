<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply: ${job.title} - DevLearn</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#14b8a6" },
                    fontFamily: { sans: ["Inter", "sans-serif"] },
                    maxWidth: { canvas: "1100px" }
                }
            }
        }
    </script>

    <style>
        html { scroll-behavior: smooth; }
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }

        /* Animation */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in { animation: fadeInUp 0.5s ease-out forwards; }

        /* Banner Background Pattern */
        .banner-pattern {
            background-color: #14b8a6; /* Teal 500 */
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }

        /* Description Content Styling incase it's plain text or weak HTML */
        .job-content-html h1, .job-content-html h2, .job-content-html h3 {
            font-weight: 800;
            color: #0f172a;
            margin-top: 1.5rem;
            margin-bottom: 0.75rem;
            text-transform: uppercase;
            font-size: 1.1rem;
        }
        .job-content-html ul {
            list-style-type: disc;
            padding-left: 1.5rem;
            margin-bottom: 1.25rem;
        }
        .job-content-html li {
            margin-bottom: 0.5rem;
            line-height: 1.6;
        }
        .job-content-html p {
            margin-bottom: 1rem;
            line-height: 1.6;
        }
        
        /* Upload box */
        .upload-zone:hover {
            border-color: #14b8a6;
            background-color: #f0fdfa;
        }
    </style>
</head>

<body class="min-h-screen flex flex-col">
    <!-- Header -->
    <jsp:include page="/views/common/header.jsp"/>

    <main class="flex-1 pt-24 pb-20">
        <div class="max-w-canvas mx-auto px-4 sm:px-6 lg:px-8">
            
            <!-- Back button -->
            <a href="${pageContext.request.contextPath}/teacher-jobs" class="inline-flex items-center gap-2 text-sm font-semibold text-slate-500 hover:text-teal-600 transition-colors mb-6">
                <span class="material-symbols-outlined text-lg">arrow_back</span>
                Back to Teacher Jobs
            </a>

            <!-- Main White Card -->
            <div class="bg-white rounded-3xl shadow-xl shadow-slate-200/50 overflow-hidden animate-fade-in border border-slate-100 relative">
                
                <!-- Mascot decoration (Optional, matching the user's screenshot vibe) -->
                <img src="https://res.cloudinary.com/dssmrnzag/image/upload/v1738596644/DevLearn_Mascot_-_Transparent_q4qngb.png" 
                     alt="DevLearn Mascot" 
                     class="absolute bottom-8 right-8 w-24 h-24 object-contain opacity-20 pointer-events-none" />

                <!-- Card Header -->
                <div class="p-8 md:p-10 pb-6 flex flex-col md:flex-row md:items-start justify-between gap-6">
                    <div>
                        <h1 class="text-2xl md:text-3xl lg:text-4xl font-black text-slate-900 leading-tight mb-6">
                            ${job.title}
                        </h1>
                        <a href="#apply-section" class="inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-600 text-white px-7 py-3 rounded-xl font-bold transition-all shadow-lg shadow-teal-500/30 hover:-translate-y-0.5">
                            <span class="material-symbols-outlined text-xl">description</span>
                            Apply Now
                        </a>
                    </div>
                </div>

                <!-- Teal Banner Info -->
                <div class="banner-pattern w-full text-white px-8 md:px-10 py-6">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 divide-y md:divide-y-0 md:divide-x divide-white/20">
                        
                        <!-- Col 1: Location -->
                        <div class="flex items-start gap-4 pt-4 md:pt-0">
                            <div class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-red-100">location_on</span>
                            </div>
                            <div>
                                <p class="text-teal-100 text-sm font-medium mb-1 line-clamp-1">Location</p>
                                <p class="font-bold text-white text-base">
                                    <c:choose>
                                        <c:when test="${not empty job.location}">${job.location}</c:when>
                                        <c:otherwise>Hanoi, Vietnam</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>

                        <!-- Col 2: Role/Department (Replaces Salary to hide it) -->
                        <div class="flex items-start gap-4 pt-4 md:pt-0 md:pl-6">
                            <div class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-yellow-100">school</span>
                            </div>
                            <div>
                                <p class="text-teal-100 text-sm font-medium mb-1 line-clamp-1">Department</p>
                                <p class="font-bold text-white text-base">Instructor & Educator</p>
                            </div>
                        </div>

                        <!-- Col 3: Job Type -->
                        <div class="flex items-start gap-4 pt-4 md:pt-0 md:pl-6">
                            <div class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-blue-100">calendar_month</span>
                            </div>
                            <div>
                                <p class="text-teal-100 text-sm font-medium mb-1 line-clamp-1">Employment Type</p>
                                <p class="font-bold text-white text-base">
                                    <c:choose>
                                        <c:when test="${not empty job.jobType}">${job.jobType}</c:when>
                                        <c:otherwise>Part-time / Full-time</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Job Description Body -->
                <div class="p-8 md:p-10 job-content-html text-slate-700">
                    <c:choose>
                        <c:when test="${not empty job.description or not empty job.requirements or not empty job.benefits}">
                            <!-- Rendering the HTML/Text from DB directly -->
                            <div class="prose prose-slate max-w-none prose-headings:font-black prose-headings:text-slate-900 prose-a:text-teal-600 prose-li:marker:text-teal-500">
                                <c:if test="${not empty job.description}">
                                    <h3 class="font-black text-slate-900 text-lg uppercase mb-4">Job Description</h3>
                                    ${job.description}
                                </c:if>

                                <c:if test="${not empty job.requirements}">
                                    <h3 class="font-black text-slate-900 text-lg uppercase mb-4 mt-8">Job Requirements</h3>
                                    ${job.requirements}
                                </c:if>

                                <c:if test="${not empty job.benefits}">
                                    <h3 class="font-black text-slate-900 text-lg uppercase mb-4 mt-8">Benefits</h3>
                                    ${job.benefits}
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3 class="font-black text-slate-900 text-lg uppercase mb-4">Job Description</h3>
                            <ul class="list-disc pl-5 space-y-2 mb-8 text-slate-600">
                                <li>Design and evaluate training curricula and teaching quality.</li>
                                <li>Monitor and accredit learning materials, video lectures, exam papers.</li>
                                <li>Train and improve professional skills for lecturers.</li>
                            </ul>

                            <h3 class="font-black text-slate-900 text-lg uppercase mb-4 mt-8">Job Requirements</h3>
                            <ul class="list-disc pl-5 space-y-2 mb-8 text-slate-600">
                                <li>Proficiency in the required subject matter.</li>
                                <li>Experience in teaching or producing video lectures/assessments.</li>
                                <li>Strong research and content development skills.</li>
                            </ul>

                            <h3 class="font-black text-slate-900 text-lg uppercase mb-4 mt-8">Benefits</h3>
                            <ul class="list-disc pl-5 space-y-2 text-slate-600">
                                <li>Competitive remuneration.</li>
                                <li>Internal training and skill development courses.</li>
                                <li>Flexible, dynamic environment with career growth opportunities.</li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>

                <hr class="border-slate-100" />

                <!-- Application Form Section -->
                <div id="apply-section" class="p-8 md:p-10 bg-slate-50 relative">
                    <div class="max-w-2xl">
                        <h2 class="text-2xl font-black text-slate-900 mb-2">Submit Your Application</h2>
                        <p class="text-slate-500 text-sm mb-8">
                            Upload your CV/Resume below. Our recruitment system will evaluate your profile and our team will get back to you shortly.
                        </p>

                        <c:if test="${not empty sessionScope.toastMsg}">
                            <div class="mb-6 p-4 rounded-xl flex items-start gap-3 text-sm font-medium
                                ${sessionScope.toastType == 'success' ? 'bg-emerald-50 text-emerald-700 border border-emerald-200' : 'bg-red-50 text-red-700 border border-red-200'}">
                                <span class="material-symbols-outlined">${sessionScope.toastType == 'success' ? 'check_circle' : 'error'}</span>
                                ${sessionScope.toastMsg}
                            </div>
                            <!-- Clear the session message -->
                            <c:remove var="toastMsg" scope="session"/>
                            <c:remove var="toastType" scope="session"/>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/teacher-apply" method="post" enctype="multipart/form-data" class="space-y-6">
                            <input type="hidden" name="jobId" value="${job.jobId}"/>

                            <div class="space-y-2">
                                <label for="cv" class="block text-sm font-bold text-slate-800">Your CV / Resume <span class="text-red-500">*</span></label>
                                
                                <!-- File Upload Zone -->
                                <div class="upload-zone relative border-2 border-dashed border-slate-300 rounded-2xl bg-white transition-all overflow-hidden flex flex-col items-center justify-center py-10 px-6 group cursor-pointer">
                                    <input id="cv" name="cv" type="file" required accept=".pdf,.doc,.docx"
                                           class="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10" 
                                           onchange="updateFileName(this)"/>
                                    
                                    <div class="w-14 h-14 rounded-full bg-slate-50 flex items-center justify-center text-slate-400 mb-3 group-hover:text-teal-500 group-hover:bg-teal-50 transition-colors">
                                        <span class="material-symbols-outlined text-3xl">upload_file</span>
                                    </div>
                                    <p class="text-slate-700 font-semibold mb-1" id="fileNameDisplay">Click to upload or drag and drop</p>
                                    <p class="text-slate-400 text-xs text-center">PDF, DOC, DOCX up to 5MB.</p>
                                </div>
                            </div>

                            <button type="submit" class="w-full sm:w-auto inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-600 text-white px-8 py-3.5 rounded-xl font-bold transition-all shadow-lg shadow-teal-500/30 hover:-translate-y-0.5">
                                <span class="material-symbols-outlined text-xl">send</span>
                                Send Application
                            </button>
                            <p class="text-xs text-slate-400 mt-4 flex items-center gap-1.5">
                                <span class="material-symbols-outlined text-sm">lock</span>
                                Your information is securely encrypted and kept confidential.
                            </p>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <!-- Footer Area -->
    <jsp:include page="/views/common/userbuttom.jsp"/>

    <script>
        // File upload UI update
        function updateFileName(input) {
            const display = document.getElementById('fileNameDisplay');
            if (input.files && input.files.length > 0) {
                const fileName = input.files[0].name;
                display.innerHTML = `<span class="text-teal-600 font-bold">Selected: ${fileName}</span>`;
            } else {
                display.textContent = 'Click to upload or drag and drop';
            }
        }
    </script>
</body>
</html>
