<%-- 
    Document   : courseManagement
    Created on : Feb 11, 2026, 3:12:30 PM
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Admin Course Management Dashboard</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#06d000",
                            "background-light": "#f9fafb",
                            "background-dark": "#243c2f"
                        },
                        fontFamily: {
                            display: "Inter"
                        },
                        borderRadius: {
                            DEFAULT: "0.5rem",
                            lg: "1rem",
                            xl: "1.5rem",
                            full: "9999px"
                        }
                    }
                }
            }
        </script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#37ec13",
                            "background-light": "#f6f8f6",
                            "background-dark": "#132210",
                            "sidebar-dark": "#111827",
                        },
                        fontFamily: {
                            "display": ["Inter"]
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
        </style>
        <link rel="stylesheet" href="assets/css/addCourse.css">
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-200">
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <aside class="w-64 bg-sidebar-dark text-slate-400 flex flex-col fixed h-full z-50">
                <div class="p-6 flex items-center gap-3">
                    <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
                        <span class="material-icons text-background-dark text-xl font-bold">school</span>
                    </div>
                    <span class="text-white font-bold text-xl tracking-tight">DevLearn</span>
                </div>
                <nav class="flex-1 px-4 space-y-1 mt-4">
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">dashboard</span>
                        <span class="font-medium">Dashboard</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg bg-primary/10 text-primary transition-colors border-r-4 border-primary" href="#">
                        <span class="material-icons text-xl">library_books</span>
                        <span class="font-medium">Course Management</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">people</span>
                        <span class="font-medium">Users</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">category</span>
                        <span class="font-medium">Categories</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">payments</span>
                        <span class="font-medium">Transactions</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">assessment</span>
                        <span class="font-medium">Reports</span>
                    </a>
                </nav>
                <div class="p-4 border-t border-slate-800">
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-colors" href="#">
                        <span class="material-icons text-xl">settings</span>
                        <span class="font-medium">Settings</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-red-500/10 text-red-400 transition-colors" href="#">
                        <span class="material-icons text-xl">logout</span>
                        <span class="font-medium">Logout</span>
                    </a>
                </div>
            </aside>
            <!-- Main Content -->
            <main class="flex-1 ml-64 min-h-screen">
                <!-- Header -->
                <header class="h-20 bg-white dark:bg-background-dark/50 border-b border-slate-200 dark:border-slate-800 sticky top-0 z-40 flex items-center justify-between px-8 backdrop-blur-md">
                    <div class="flex items-center gap-8">
                        <h1 class="text-2xl font-bold text-slate-900 dark:text-white">Course Management</h1>
                        <div class="relative w-96">
                            <span class="material-icons absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                            <input class="w-full pl-10 pr-4 py-2 bg-background-light dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary/50 text-sm" placeholder="Search courses, teachers, or IDs..." type="text"/>
                        </div>
                    </div>
                    <div class="flex items-center gap-4">
                        <button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
                            <span class="material-icons">notifications</span>
                            <span class="absolute top-2 right-2 w-2 h-2 bg-primary rounded-full border-2 border-white dark:border-background-dark"></span>
                        </button>
                        <button   type="button"
                                  onclick="openAddCourseModal()" class="bg-primary hover:bg-primary/90 text-background-dark font-bold px-5 py-2.5 rounded-lg flex items-center gap-2 transition-all shadow-lg shadow-primary/20">
                            <span class="material-icons">add</span>
                            Add New Course
                        </button>
                        <div class="h-8 w-[1px] bg-slate-200 dark:bg-slate-800 mx-2"></div>
                        <div class="flex items-center gap-3">
                            <img class="w-10 h-10 rounded-full object-cover border-2 border-primary/20" data-alt="Admin user avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC3fr4TV71PEV9sNYTnWVWnR7SFkKNCP2tOJ3uTs7_134rEVjBQFJH_1TZv4PVE7-oihzRX-tgoP57g8KmcdbXZprDHAErYLIExmsgNUM3McmNYrzKm2iqzA3IF_JI_3dybUgk1kLagPSA4IxAI88M2-hbR_SNvLDVV9brN8WLVtQ5tJyF-ThF1ajLFnn_BDKoOK_XLZI68wABBdqinG1IIYP4gVTXlzN3NGob2goNK-zcTPi9O2dawgzY5HtsEjf7uojzNKEW_8DQ"/>
                            <div class="hidden lg:block">
                                <p class="text-sm font-semibold text-slate-900 dark:text-white">Alex Rivera</p>
                                <p class="text-xs text-slate-500">Super Admin</p>
                            </div>
                        </div>
                    </div>
                </header> 
                <!-- Table Section -->
                <div class="p-8">
                    <!-- Filters/Stats Row -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Total Courses</p>
                            <p class="text-3xl font-bold mt-1">${totalCourses}</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>12% from last month</span>
                            </div>
                        </div>
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Active Students</p>
                            <p class="text-3xl font-bold mt-1">42.5k</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>8% from last month</span>
                            </div>
                        </div>
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Course Revenue</p>
                            <p class="text-3xl font-bold mt-1">$156.2k</p>
                            <div class="mt-2 text-primary text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">trending_up</span>
                                <span>24% from last month</span>
                            </div>
                        </div>
                        <div class="bg-white dark:bg-slate-800/50 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
                            <p class="text-slate-500 text-sm font-medium uppercase tracking-wider">Draft Courses</p>
                            <p class="text-3xl font-bold mt-1">45</p>
                            <div class="mt-2 text-slate-400 text-xs flex items-center gap-1 font-semibold">
                                <span class="material-icons text-xs">remove_red_eye</span>
                                <span>Needs review</span>
                            </div>
                        </div>
                    </div>
                    ${ERROR}
                    <!-- Table Container -->
                    <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>

                                    <tr class="bg-background-light dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Thumbnail</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Course Title</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Category</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Level</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Price</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Students</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Teacher</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Status</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                    <!-- Row 1 --> 
                                    <c:forEach var="c" items="${list}" >
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td class="px-6 py-4">
                                                <img class="w-12 h-12 rounded-lg object-cover" data-alt="Coding course thumbnail preview" src="${c.thumbnailUrl}"/>
                                            </td>
                                            <td class="px-6 py-4">
                                                <p class="font-semibold text-slate-900 dark:text-white">${c.title}</p>
                                                <p class="text-xs text-slate-500">ID: ${c.courseId}</p>
                                            </td>
                                            <td class="px-6 py-4">
                                                <span class="px-2 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 text-[10px] font-bold rounded uppercase">${c.categoryId.name}</span>
                                            </td>
                                            <td class="px-6 py-4 text-sm">${c.level}</td>
                                            <td class="px-6 py-4 text-sm font-semibold">$${c.price}</td>
                                            <td class="px-6 py-4 text-sm"> ${studentCountMap[c.courseId] != null ? studentCountMap[c.courseId] : 0}</td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-2">
                                                    <img class="w-6 h-6 rounded-full" data-alt="Teacher portrait thumbnail" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCF7TCep_MVBlnZOY2hB6OMCaDrb_8HJKLWRKUMsoBfQ_AITRof0HqmUGLzbc35bIkKXtKR75XHP7ZFLpnuW2ZGRI8dum0WEBq_H4PMkyUy1xqCYsmElxjXUr000THJTxs_NUFxhfG-v3t4M0ul6f-hBDmtfKXEh6YWnogHJj1DSo0fzNe-HnvDA0dgScK0JtR8ZlBpyLQDQLzCN9nmGePPTSkuVWpjcLuTamTXxh0bUcG23adSOg_EdIzT6cGLuge5eXnaqzUCXMA"/>
                                                    <span class="text-sm"> ${teacherMap[c.courseId] != null ? teacherMap[c.courseId] : "chưa có"}
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>

                                                    <c:when test="${c.status == 'ACTIVE'}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-600">
                                                            ${c.status}
                                                        </span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-600">
                                                            ${c.status}
                                                        </span>
                                                    </c:otherwise>

                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-right space-x-2">
                                                <button class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors">
                                                    <span class="material-icons text-lg">visibility</span>
                                                </button>
                                                <button type="button"
                                                        onclick="openUpdateCourseModal(${c.courseId})" class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-primary transition-colors">
                                                    <span class="material-icons text-lg">edit</span>
                                                </button>
                                                <button type="button"
                                                        onclick="confirmDelete(${c.courseId})"
                                                        class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-400 hover:text-red-500 transition-colors">
                                                    <span class="material-icons text-lg">delete</span>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            ${error}
                        </div>
                        <!-- Pagination -->
                        <div class="px-6 py-4 flex items-center justify-between border-t border-slate-200 dark:border-slate-800 bg-background-light dark:bg-slate-900/50">
                            <div class="text-sm text-slate-500">
                                Showing 
                                <span class="font-medium">${(currentPage - 1) * 10 + 1}</span> 
                                to 
                                <span class="font-medium">
                                    ${currentPage * 10 > totalCourses ? totalCourses : currentPage * 10}
                                </span> 
                                of 
                                <span class="font-medium">${totalCourses}</span> courses
                            </div>
                            <div class="flex items-center gap-2">
                                <a class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                    <c:if test="${currentPage > 1}">
                                        <a href="?page=${currentPage - 1}" 
                                           class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                            <span class="material-icons text-sm">chevron_left</span>
                                        </a>
                                    </c:if>
                                </a>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="?page=${i}"
                                       class="w-8 h-8 rounded flex items-center justify-center text-sm
                                       ${i == currentPage ? 'bg-primary text-background-dark font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-800'}">
                                        ${i}
                                    </a>
                                </c:forEach>
                                <a class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?page=${currentPage + 1}" 
                                           class="p-2 border border-slate-200 dark:border-slate-700 rounded hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400">
                                            <span class="material-icons text-sm">chevron_right</span>
                                        </a>
                                    </c:if>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>



        <!-- ADD COURSE MODAL -->
        <div id="addCourseModal"
             class="fixed inset-0 hidden items-center justify-center z-50">

            <!-- Background blur -->
            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm"
                 onclick="closeAddCourseModal()"></div>

            <!-- Modal content -->
            <div class="relative z-10 w-full flex justify-center px-4">
                <jsp:include page="addCourse.jsp" />
            </div>
        </div>

        <!-- UPDATE COURSE MODAL -->
        <div id="updateCourseModal"
             class="fixed inset-0 hidden items-center justify-center z-50">

            <div class="absolute inset-0 bg-black/60 backdrop-blur-sm"
                 onclick="closeUpdateCourseModal()"></div>

            <div class="relative z-10 w-full flex justify-center px-4">
                <jsp:include page="updateCourse.jsp" />
            </div>
        </div>
        <form id="deleteForm" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="course_id" id="deleteCourseId">
        </form>
        <!--
                <script>
                    function openAddCourseModal() {
                        const modal = document.getElementById("addCourseModal");
                        modal.classList.remove("hidden");
                        modal.classList.add("flex");
                        document.body.style.overflow = "hidden"; // khóa scroll nền
                    }
        
                    function closeAddCourseModal() {
                        const modal = document.getElementById("addCourseModal");
                        modal.classList.add("hidden");
                        modal.classList.remove("flex");
                        document.body.style.overflow = "auto";
                    }
        
        // ESC để đóng
                    document.addEventListener("keydown", function (e) {
                        if (e.key === "Escape") {
                            closeAddCourseModal();
                        }
                    });
                </script>
        
        
                <script>
                    document.addEventListener("change", function (event) {
        
                        if (event.target.id === "thumbnailInput") {
        
                            const file = event.target.files[0];
                            if (!file)
                                return;
        
                            if (!file.type.startsWith("image/")) {
                                alert("Please select an image file!");
                                return;
                            }
        
                            const reader = new FileReader();
        
                            reader.onload = function (e) {
                                document.getElementById("thumbnailPreview").src = e.target.result;
                                document.getElementById("previewBox").classList.remove("hidden");
                                document.getElementById("uploadBox").classList.add("hidden");
                            };
        
                            reader.readAsDataURL(file);
                        }
                    });
        
                    function removeThumbnail() {
                        document.getElementById("thumbnailInput").value = "";
                        document.getElementById("previewBox").classList.add("hidden");
                        document.getElementById("uploadBox").classList.remove("hidden");
                    }
                </script>
        
        
                <script>
                    document.querySelectorAll(".level-btn").forEach(button => {
        
                        button.addEventListener("click", function () {
        
                            // Remove active from all
                            document.querySelectorAll(".level-btn").forEach(btn => {
                                btn.classList.remove(
                                        "bg-white",
                                        "dark:bg-primary",
                                        "text-slate-700",
                                        "dark:text-background-dark",
                                        "shadow-sm"
                                        );
        
                                btn.classList.add(
                                        "text-slate-500",
                                        "dark:text-primary/60"
                                        );
                            });
        
                            // Add active to clicked
                            this.classList.add(
                                    "bg-white",
                                    "dark:bg-primary",
                                    "text-slate-700",
                                    "dark:text-background-dark",
                                    "shadow-sm"
                                    );
        
                            this.classList.remove(
                                    "text-slate-500",
                                    "dark:text-primary/60"
                                    );
        
                            // Update hidden input
                            document.getElementById("levelInput").value = this.dataset.level;
        
                        });
        
                    });
                </script>
        
                <script>
                    document.querySelector("form").addEventListener("submit", function () {
                        document.getElementById("loadingOverlay").classList.remove("hidden");
                    });
                </script>
        
        
                <script>
                    function openUpdateCourseModal(id) {
        
                        fetch("courseAdmin?action=getById&id=" + id)
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error("Network response was not ok");
                                    }
                                    return response.json();
                                })
                                .then(data => {
        
                                    console.log("DATA:", data); // test
        
                                    document.getElementById("updateCourseId").value = data.courseId;
                                    document.getElementById("updateTitle").value = data.title;
                                    document.getElementById("updateDescription").value = data.description;
                                    document.getElementById("updatePrice").value = data.price;
                                    document.getElementById("updateLevelInput").value = data.level;
                                    document.getElementById("updateCategory").value = data.categoryId;
                                     document.getElementById("updateThumbnailUrl").value = data.thumbnailUrl;
                                    const modal = document.getElementById("updateCourseModal");
                                    modal.classList.remove("hidden");
                                    modal.classList.add("flex");
        
                                    document.body.style.overflow = "hidden";
                                })
                                .catch(error => {
                                    console.error("Fetch error:", error);
                                    alert("Không lấy được dữ liệu course!");
                                });
                    }
                </script>
        
        
                <script>
                    document.getElementById("updateCourseForm")
                            .addEventListener("submit", function () {
                                document.getElementById("updateLoadingOverlay")
                                        .classList.remove("hidden");
                            });
                </script>
        
                <script>
                    function closeUpdateCourseModal() {
                        const modal = document.getElementById("updateCourseModal");
                        modal.classList.add("hidden");
                        modal.classList.remove("flex");
                        document.body.style.overflow = "auto";
                    }
        
                    // ESC để đóng update modal
                    document.addEventListener("keydown", function (e) {
                        if (e.key === "Escape") {
                            closeUpdateCourseModal();
                        }
                    });
                </script>
        
                <script>
                    function removeUpdateThumbnail() {
                        document.getElementById("updateThumbnailInput").value = "";
                        document.getElementById("updatePreviewBox").classList.add("hidden");
                        document.getElementById("updateUploadBox").classList.remove("hidden");
                    }
                </script>  -->


        <script src="${pageContext.request.contextPath}/assets/js/course-management.js"></script>
    </body></html>