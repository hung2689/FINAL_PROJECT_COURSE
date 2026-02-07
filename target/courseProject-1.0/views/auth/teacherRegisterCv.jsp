<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html class="light" lang="en"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Instructor Application - Mint Theme</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#38e335",
                            "background-light": "#f6f8f6",
                            "background-dark": "#122111",
                            "mint-soft": "#F4FAF4",
                            "mint-sage": "#ECF7EC",
                        },
                        fontFamily: {
                            "display": ["Inter", "sans-serif"]
                        },
                        borderRadius: {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                    },
                },
            }
        </script>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            .bg-mint-gradient {
                background: linear-gradient(135deg, #F4FAF4 0%, #ECF7EC 100%);
            }
            .dark .bg-mint-gradient {
                background: linear-gradient(135deg, #122111 0%, #1a2e19 100%);
            }
        </style>
    </head>
    <body class="bg-mint-gradient dark:bg-background-dark min-h-screen font-display text-slate-900 dark:text-slate-100">
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="layout-container flex h-full grow flex-col">
                <!-- Navigation Header -->
                <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-slate-200 dark:border-emerald-900/30 px-6 md:px-20 py-4 bg-white/70 dark:bg-background-dark/70 backdrop-blur-md sticky top-0 z-50">
                    <div class="flex items-center gap-3">
                        <div class="text-primary">
                            <svg class="size-8" fill="none" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                            <path clip-rule="evenodd" d="M24 18.4228L42 11.475V34.3663C42 34.7796 41.7457 35.1504 41.3601 35.2992L24 42V18.4228Z" fill="currentColor" fill-rule="evenodd"></path>
                            <path clip-rule="evenodd" d="M24 8.18819L33.4123 11.574L24 15.2071L14.5877 11.574L24 8.18819ZM9 15.8487L21 20.4805V37.6263L9 32.9945V15.8487ZM27 37.6263V20.4805L39 15.8487V32.9945L27 37.6263ZM25.354 2.29885C24.4788 1.98402 23.5212 1.98402 22.646 2.29885L4.98454 8.65208C3.7939 9.08038 3 10.2097 3 11.475V34.3663C3 36.0196 4.01719 37.5026 5.55962 38.098L22.9197 44.7987C23.6149 45.0671 24.3851 45.0671 25.0803 44.7987L42.4404 38.098C43.9828 37.5026 45 36.0196 45 34.3663V11.475C45 10.2097 44.2061 9.08038 43.0155 8.65208L25.354 2.29885Z" fill="currentColor" fill-rule="evenodd"></path>
                            </svg>
                        </div>
                        <h2 class="text-slate-900 dark:text-white text-xl font-bold leading-tight tracking-tight">DevLearn</h2>
                    </div>
                    <div class="flex flex-1 justify-end gap-8 items-center">
                        <nav class="hidden md:flex items-center gap-8">
                            <a class="text-slate-600 dark:text-slate-300 text-sm font-medium hover:text-primary transition-colors" href="#">Home</a>
                            <a class="text-slate-600 dark:text-slate-300 text-sm font-medium hover:text-primary transition-colors" href="#">Courses</a>
                            <a class="text-slate-600 dark:text-slate-300 text-sm font-medium hover:text-primary transition-colors" href="#">About</a>
                        </nav>
                        <div class="flex items-center gap-3">
                            <!-- Avatar -->
                            <div
                                class="bg-center bg-no-repeat aspect-square bg-cover rounded-full size-10 border-2 border-primary/20"
                                style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDrtmg2UU2TsFnqJbAmSrLYehCSGuFQuWPjo69FTH5zq4AvZqjDaeq6CcXa7S0fyAbwfpNUm4MMhDrMiNs0-EIofs13bH6Y_iyxErQLEFXl8KnzJljIVhXl_LStHd1n05MMEbWMvl0g06_LVJxF1CTG4WTGbr1G7hA6vk4u3UiPkX5OK0GYQQ5V5bTrkvGStw2UyVqdBE6WgAOHn1OQFdoEvfbxMF7dF25I-5SqQyR-nbo75itrNk44vYiD9c91EyFAJ9rTMXGFRxI");'>
                            </div>

                            <!-- Username -->
                            <c:if test="${not empty sessionScope.PENDING_TEACHER_USER}">
                                <span class="text-sm font-semibold text-slate-700 dark:text-slate-200">
                                    ${sessionScope.PENDING_TEACHER_USER.username}
                                </span>
                            </c:if>
                        </div>

                    </div>
                </header>
                <main class="flex-1 flex flex-col items-center justify-center p-4 md:p-10">
                    <div class="w-full max-w-4xl space-y-8">
                        <!-- Form Header -->
                        <div class="text-center md:text-left space-y-2">
                            <h1 class="text-3xl md:text-4xl font-black text-slate-900 dark:text-white tracking-tight">Become an Instructor</h1>
                            <p class="text-slate-500 dark:text-slate-400">Share your knowledge with a global community of eager learners.</p>
                        </div>


                        <!-- Main Application Card -->
                        <div class="bg-white dark:bg-background-dark/40 border border-slate-200 dark:border-emerald-900/30 rounded-xl shadow-xl shadow-emerald-900/5 overflow-hidden">
                            <!-- Step Indicator -->
                            <div class="grid grid-cols-3 border-b border-slate-100 dark:border-emerald-900/20">
                                <div class="flex items-center justify-center py-6 px-4 gap-3 bg-slate-50/50 dark:bg-emerald-900/10">
                                    <span class="material-symbols-outlined text-primary text-xl">check_circle</span>
                                    <span class="hidden md:inline font-semibold text-sm text-slate-500">Account Setup</span>
                                </div>
                                <div class="flex items-center justify-center py-6 px-4 gap-3 border-x border-slate-100 dark:border-emerald-900/20 bg-primary/5">
                                    <span class="flex items-center justify-center size-6 rounded-full bg-primary text-white text-xs font-bold">2</span>
                                    <span class="font-bold text-sm text-slate-900 dark:text-white">Professional Info</span>
                                </div>
                                <div class="flex items-center justify-center py-6 px-4 gap-3">
                                    <span class="flex items-center justify-center size-6 rounded-full border-2 border-slate-300 dark:border-emerald-800 text-slate-400 text-xs font-bold">3</span>
                                    <span class="hidden md:inline font-semibold text-sm text-slate-400">Final Review</span>
                                </div>
                            </div>


                            <form action="${pageContext.request.contextPath}/teacherRegister"
                                  method="post"
                                  enctype="multipart/form-data">


                                <!-- Form Content -->
                                <div class="p-6 md:p-10 space-y-8">
                                    <!-- Teaching Specialization -->
                                    <div class="space-y-4">
                                        <label class="block text-sm font-bold text-slate-900 dark:text-slate-200">Teaching Specialization</label>
                                        <div class="flex flex-wrap gap-2 p-3 min-h-[50px] bg-slate-50 dark:bg-background-dark/60 border border-slate-200 dark:border-emerald-900/40 rounded-lg"
                                             id="skill-container">

                                            <input

                                                id="skill-input"
                                                class="bg-transparent border-none focus:ring-0 text-sm flex-1 min-w-[150px] text-slate-600 dark:text-slate-300"
                                                placeholder="Type a skill and press Enter..."
                                                type="text"
                                                />
                                            <input type="hidden" name="specialization" id="specialization-hidden">

                                        </div>
                                        <p class="text-xs text-slate-500">Press enter to add multiple skills that you are qualified to teach.</p>
                                    </div>
                                    <div class="grid md:grid-cols-2 gap-8">
                                        <!-- Years of Experience -->
                                        <div class="space-y-3">
                                            <label class="block text-sm font-bold text-slate-900 dark:text-slate-200" for="experience">Years of Professional Experience</label>
                                            <div class="relative">
                                                <input name="year" class="w-full pl-4 pr-10 py-3 bg-slate-50 dark:bg-background-dark/60 border border-slate-200 dark:border-emerald-900/40 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all dark:text-white" id="experience" min="0" placeholder="e.g. 5" type="number"/>
                                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none text-slate-400">
                                                    <span class="material-symbols-outlined">timeline</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Website/Portfolio Link -->
                                        <div class="space-y-3">
                                            <label class="block text-sm font-bold text-slate-900 dark:text-slate-200" for="portfolio">Portfolio / LinkedIn URL</label>
                                            <div class="relative">
                                                <input class="w-full pl-4 pr-10 py-3 bg-slate-50 dark:bg-background-dark/60 border border-slate-200 dark:border-emerald-900/40 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all dark:text-white" id="portfolio" placeholder="https://..." type="url"/>
                                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none text-slate-400">
                                                    <span class="material-symbols-outlined text-xl">link</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Professional Summary -->
                                    <div class="space-y-3">
                                        <div class="flex justify-between items-center">
                                            <label class="block text-sm font-bold text-slate-900 dark:text-slate-200" for="summary">Professional Summary</label>
                                            <span class="text-xs text-slate-500 font-medium">0 / 500 characters</span>
                                        </div>
                                        <textarea class="w-full p-4 bg-slate-50 dark:bg-background-dark/60 border border-slate-200 dark:border-emerald-900/40 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all dark:text-white resize-none" id="summary" placeholder="Tell us about your professional background and teaching philosophy..." rows="4"></textarea>
                                    </div>
                                    <!-- CV Upload Zone -->
                                    <div class="space-y-3">
                                        <label class="block text-sm font-bold text-slate-900 dark:text-slate-200">
                                            CV / Resume Upload
                                        </label>

                                        <!-- Upload Box -->
                                        <div
                                            id="upload-box"
                                            class="border-2 border-dashed border-primary/40 rounded-xl p-8 bg-primary/5
                                            flex flex-col items-center justify-center text-center cursor-pointer
                                            hover:bg-primary/10 transition-colors group"
                                            >
                                            <div class="size-14 rounded-full bg-white dark:bg-background-dark/80
                                                 flex items-center justify-center text-primary mb-4 shadow-sm
                                                 group-hover:scale-110 transition-transform">
                                                <span class="material-symbols-outlined text-3xl">cloud_upload</span>
                                            </div>
                                            <h4 class="text-base font-semibold text-slate-900 dark:text-white">
                                                Click to upload or drag and drop
                                            </h4>
                                            <p class="text-sm text-slate-500 mt-1">
                                                PDF, DOCX (Maximum 5MB)
                                            </p>

                                            <input
                                                name="cv"
                                                id="cv-input"
                                                class="hidden"
                                                type="file"
                                                accept=".pdf,.doc,.docx"
                                                />
                                        </div>

                                        <!-- File Info -->
                                        <div
                                            id="file-info"
                                            class="hidden flex items-center justify-between p-4
                                            border border-slate-200 dark:border-emerald-900/40
                                            rounded-lg bg-slate-50 dark:bg-background-dark/60"
                                            >
                                            <div class="flex items-center gap-3">
                                                <span class="material-symbols-outlined text-primary">description</span>
                                                <div>
                                                    <p id="file-name" class="text-sm font-semibold text-slate-900 dark:text-white"></p>
                                                    <p id="file-size" class="text-xs text-slate-500"></p>
                                                </div>
                                            </div>
                                            <button
                                                id="remove-file"
                                                type="button"
                                                class="text-slate-400 hover:text-red-500 transition-colors"
                                                >
                                                <span class="material-symbols-outlined">close</span>
                                            </button>
                                        </div>
                                    </div>

                                </div>
                                <!-- Form Footer Actions -->
                                <div class="px-6 md:px-10 py-6 bg-slate-50 dark:bg-emerald-900/10 border-t border-slate-100 dark:border-emerald-900/20 flex flex-col md:flex-row justify-between items-center gap-4">
                                    <button class="w-full md:w-auto px-6 py-3 text-slate-600 dark:text-slate-400 font-bold hover:text-slate-900 dark:hover:text-white flex items-center justify-center gap-2 transition-colors">
                                        <span class="material-symbols-outlined text-lg">arrow_back</span>
                                        Back to Step 1
                                    </button>
                                    <button type="submit" class="w-full md:w-auto px-10 py-3 bg-primary text-white font-bold rounded-lg shadow-lg shadow-primary/20 hover:brightness-110 hover:shadow-primary/30 transition-all flex items-center justify-center gap-2">
                                        Submit for Review
                                        <span class="material-symbols-outlined text-lg">arrow_forward</span>
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Trust/Support Footer -->
                        <div class="flex flex-col md:flex-row items-center justify-between text-xs text-slate-500 gap-4 pt-4 pb-12">
                            <div class="flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm text-primary">verified_user</span>
                                Your professional data is encrypted and handled securely.
                            </div>
                            <div class="flex gap-6">
                                <a class="hover:underline" href="#">Privacy Policy</a>
                                <a class="hover:underline" href="#">Instructor Terms</a>
                                <a class="hover:underline" href="#">Need Help?</a>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            const skillInput = document.getElementById("skill-input");
            const skillContainer = document.getElementById("skill-container");
            const hiddenInput = document.getElementById("specialization-hidden");

            const skills = new Set();

            skillInput.addEventListener("keydown", function (e) {
                if (e.key === "Enter") {
                    e.preventDefault();

                    const value = skillInput.value.trim();
                    if (!value)
                        return;

                    if (skills.has(value.toLowerCase())) {
                        skillInput.value = "";
                        return;
                    }

                    skills.add(value);
                    addSkillTag(value);
                    updateHiddenInput();

                    skillInput.value = "";
                }
            });

            function addSkillTag(text) {
                const tag = document.createElement("div");
                tag.className =
                        "flex items-center gap-1.5 px-3 py-1 bg-primary/10 text-primary border border-primary/20 rounded-full text-sm font-medium";

                const spanText = document.createElement("span");
                spanText.textContent = text;

                const close = document.createElement("span");
                close.className = "material-symbols-outlined text-xs cursor-pointer";
                close.textContent = "close";

                close.addEventListener("click", () => {
                    skills.delete(text);
                    tag.remove();
                    updateHiddenInput();
                });

                tag.appendChild(spanText);
                tag.appendChild(close);

                skillContainer.insertBefore(tag, skillInput);
            }

            function updateHiddenInput() {
                hiddenInput.value = Array.from(skills).join(", ");
                console.log("SPECIALIZATION SUBMIT =", hiddenInput.value);
            }
        </script>


        <script>
            const uploadBox = document.getElementById("upload-box");
            const fileInput = document.getElementById("cv-input");

            const fileInfo = document.getElementById("file-info");
            const fileName = document.getElementById("file-name");
            const fileSize = document.getElementById("file-size");
            const removeBtn = document.getElementById("remove-file");

            // Click box -> open file chooser
            uploadBox.addEventListener("click", () => fileInput.click());

            fileInput.addEventListener("change", () => {
                const file = fileInput.files[0];
                if (!file)
                    return;

                // Hiển thị tên + dung lượng
                fileName.textContent = file.name;
                fileSize.textContent = formatSize(file.size);

                // Ẩn box upload, hiện info
                uploadBox.classList.add("hidden");
                fileInfo.classList.remove("hidden");
            });

            removeBtn.addEventListener("click", () => {
                fileInput.value = "";
                fileInfo.classList.add("hidden");
                uploadBox.classList.remove("hidden");
            });

            function formatSize(bytes) {
                if (bytes < 1024)
                    return bytes + " B";
                if (bytes < 1024 * 1024)
                    return (bytes / 1024).toFixed(1) + " KB";
                return (bytes / (1024 * 1024)).toFixed(1) + " MB";
            }
        </script>


    </body></html>