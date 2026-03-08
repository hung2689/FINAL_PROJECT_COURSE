<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>DevLearn - Instructor Application</title>

            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                rel="stylesheet" />

            <script>
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: { "primary": "#10B981" },
                            fontFamily: { "display": ["Inter", "sans-serif"] },
                            maxWidth: { "canvas": "1200px" }
                        }
                    }
                }
            </script>

            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }

                .animate-fade-in {
                    animation: fadeIn 0.7s ease-out forwards;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(12px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                /* Nav active underline */
                .nav-link {
                    position: relative;
                }

                .nav-link::after {
                    content: '';
                    position: absolute;
                    bottom: -2px;
                    left: 0;
                    right: 0;
                    height: 2px;
                    background: #10B981;
                    transform: scaleX(0);
                    transition: transform 0.2s;
                }

                .nav-link:hover::after {
                    transform: scaleX(1);
                }
            </style>
        </head>

        <body class="min-h-screen font-display text-slate-800"
            style="background: linear-gradient(135deg, #f8fffc, #e6f7f1);">

            <div class="relative flex min-h-screen w-full flex-col">

                <!-- ═══════════════ HEADER — matches home.jsp ═══════════════ -->
                <jsp:include page="../common/header.jsp" />

                <!-- ═══════════════ MAIN ═══════════════ -->
                <main class="flex-1 flex flex-col items-center justify-center px-4 md:px-10 pt-32 pb-16">
                    <div class="w-full max-w-3xl space-y-8 animate-fade-in">

                        <!-- Page heading -->
                        <div class="text-center space-y-2">
                            <h1 class="text-3xl md:text-4xl font-black text-slate-800 tracking-tight">Become an
                                Instructor</h1>
                            <p class="text-slate-500">Share your knowledge with a global community of eager learners.
                            </p>
                        </div>

                        <!-- ── Application Card ── -->
                        <div class="bg-white border border-slate-100 rounded-2xl shadow-lg overflow-hidden">

                            <!-- Step Indicator -->
                            <div class="grid grid-cols-3 border-b border-slate-100">
                                <div class="flex items-center justify-center py-5 px-4 gap-3 bg-slate-50">
                                    <span class="material-symbols-outlined text-emerald-500 text-xl">check_circle</span>
                                    <span class="hidden md:inline font-semibold text-sm text-slate-400">Account
                                        Setup</span>
                                </div>
                                <div
                                    class="flex items-center justify-center py-5 px-4 gap-3 border-x border-slate-100 bg-emerald-50">
                                    <span
                                        class="flex items-center justify-center w-6 h-6 rounded-full bg-emerald-500 text-white text-xs font-bold">2</span>
                                    <span class="font-bold text-sm text-slate-800">Professional Info</span>
                                </div>
                                <div class="flex items-center justify-center py-5 px-4 gap-3">
                                    <span
                                        class="flex items-center justify-center w-6 h-6 rounded-full border-2 border-slate-300 text-slate-400 text-xs font-bold">3</span>
                                    <span class="hidden md:inline font-semibold text-sm text-slate-400">Final
                                        Review</span>
                                </div>
                            </div>

                            <!-- Form -->
                            <form action="${pageContext.request.contextPath}/teacherRegister" method="post"
                                enctype="multipart/form-data">

                                <div class="p-6 md:p-10 space-y-8">

                                    <!-- Teaching Specialization -->
                                     

                                    <!-- Years of Experience (full width after removing Portfolio) -->
                                     

                                    <!-- CV Upload Zone -->
                                    <div class="space-y-3">
                                        <label class="block text-sm font-bold text-slate-700">CV / Resume Upload</label>

                                        <div id="upload-box" class="border-2 border-dashed border-emerald-300 rounded-xl p-8 bg-emerald-50/50
                                            flex flex-col items-center justify-center text-center cursor-pointer
                                            hover:bg-emerald-50 transition-colors group">
                                            <div
                                                class="w-14 h-14 rounded-full bg-white flex items-center justify-center text-emerald-500 mb-4 shadow-sm group-hover:scale-110 transition-transform">
                                                <span class="material-symbols-outlined text-3xl">cloud_upload</span>
                                            </div>
                                            <h4 class="text-base font-semibold text-slate-700">Click to upload or drag
                                                and drop</h4>
                                            <p class="text-sm text-slate-400 mt-1">PDF, DOCX (Maximum 5MB)</p>
                                            <input required name="cv" id="cv-input" class="hidden" type="file"
                                                accept=".pdf,.doc,.docx" />
                                        </div>

                                        <!-- File Info -->
                                        <div id="file-info"
                                            class="hidden flex items-center justify-between p-4 border border-slate-200 rounded-xl bg-slate-50">
                                            <div class="flex items-center gap-3">
                                                <span
                                                    class="material-symbols-outlined text-emerald-500">description</span>
                                                <div>
                                                    <p id="file-name" class="text-sm font-semibold text-slate-800"></p>
                                                    <p id="file-size" class="text-xs text-slate-400"></p>
                                                </div>
                                            </div>
                                            <button id="remove-file" type="button"
                                                class="text-slate-400 hover:text-red-500 transition-colors">
                                                <span class="material-symbols-outlined">close</span>
                                            </button>
                                        </div>
                                    </div>

                                </div>

                                <!-- Form Footer -->
                                <div
                                    class="px-6 md:px-10 py-6 bg-slate-50 border-t border-slate-100 flex flex-col md:flex-row justify-between items-center gap-4">
                                    <button type="button"
                                        class="w-full md:w-auto px-6 py-3 text-slate-500 font-semibold hover:text-slate-800 flex items-center justify-center gap-2 transition-colors">
                                        <span class="material-symbols-outlined text-lg">arrow_back</span>
                                        Back to Step 1
                                    </button>
                                    <button type="submit"
                                        class="w-full md:w-auto px-10 py-3 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold rounded-xl shadow-lg hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all duration-300 flex items-center justify-center gap-2">
                                        Submit for Review
                                        <span class="material-symbols-outlined text-lg">arrow_forward</span>
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Footer note -->
                        <div
                            class="flex flex-col md:flex-row items-center justify-between text-xs text-slate-400 gap-4 pb-4">
                            <div class="flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm text-emerald-500">verified_user</span>
                                Your professional data is encrypted and handled securely.
                            </div>
                            <div class="flex gap-6">
                                <a class="hover:text-slate-600 hover:underline transition-colors" href="#">Privacy
                                    Policy</a>
                                <a class="hover:text-slate-600 hover:underline transition-colors" href="#">Instructor
                                    Terms</a>
                                <a class="hover:text-slate-600 hover:underline transition-colors" href="#">Need
                                    Help?</a>
                            </div>
                        </div>

                    </div>
                </main>
            </div>

            <!-- Skill tag JS -->
            <script>
                const skillInput = document.getElementById("skill-input");
                const skillContainer = document.getElementById("skill-container");
                const hiddenInput = document.getElementById("specialization-hidden");
                const skills = new Set();

                skillInput.addEventListener("keydown", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault();
                        const value = skillInput.value.trim();
                        if (!value || skills.has(value.toLowerCase())) { skillInput.value = ""; return; }
                        skills.add(value);
                        addSkillTag(value);
                        updateHiddenInput();
                        skillInput.value = "";
                    }
                });

                function addSkillTag(text) {
                    const tag = document.createElement("div");
                    tag.className = "flex items-center gap-1.5 px-3 py-1 bg-emerald-50 text-emerald-700 border border-emerald-200 rounded-full text-sm font-medium";
                    const spanText = document.createElement("span");
                    spanText.textContent = text;
                    const close = document.createElement("span");
                    close.className = "material-symbols-outlined text-xs cursor-pointer hover:text-red-500 transition-colors";
                    close.textContent = "close";
                    close.addEventListener("click", () => { skills.delete(text); tag.remove(); updateHiddenInput(); });
                    tag.appendChild(spanText);
                    tag.appendChild(close);
                    skillContainer.insertBefore(tag, skillInput);
                }

                function updateHiddenInput() {
                    hiddenInput.value = Array.from(skills).join(", ");
                }
            </script>

            <!-- File upload JS -->
            <script>
                const uploadBox = document.getElementById("upload-box");
                const fileInput = document.getElementById("cv-input");
                const fileInfo = document.getElementById("file-info");
                const fileName = document.getElementById("file-name");
                const fileSize = document.getElementById("file-size");
                const removeBtn = document.getElementById("remove-file");

                uploadBox.addEventListener("click", () => fileInput.click());

                fileInput.addEventListener("change", () => {
                    const file = fileInput.files[0];
                    if (!file) return;
                    fileName.textContent = file.name;
                    fileSize.textContent = formatSize(file.size);
                    uploadBox.classList.add("hidden");
                    fileInfo.classList.remove("hidden");
                });

                removeBtn.addEventListener("click", () => {
                    fileInput.value = "";
                    fileInfo.classList.add("hidden");
                    uploadBox.classList.remove("hidden");
                });

                function formatSize(bytes) {
                    if (bytes < 1024) return bytes + " B";
                    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + " KB";
                    return (bytes / (1024 * 1024)).toFixed(1) + " MB";
                }
            </script>

            <jsp:include page="../common/userbuttom.jsp" />

        </body>

        </html>