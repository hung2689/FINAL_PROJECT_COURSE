<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Mock Exam Hub | DevLearn</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-slate-50">

<jsp:include page="../common/header.jsp" />

<!-- Main Container -->
<div class="min-h-screen bg-slate-50 dark:bg-slate-900 pt-24 pb-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Header Section -->
        <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8">
            <div>
                <h1 class="text-3xl font-bold bg-gradient-to-r from-emerald-600 to-teal-500 bg-clip-text text-transparent">
                    Mock Exam Hub
                </h1>
                <p class="mt-2 text-slate-500 dark:text-slate-400">
                    Use your Study Coins to practice with professional-level mock exams and get instant results.
                </p>
            </div>
            
            <div class="flex items-center gap-4 bg-white dark:bg-slate-800 px-6 py-4 rounded-2xl shadow-sm border border-slate-200 dark:border-slate-700">
                <div class="p-3 bg-emerald-100 dark:bg-emerald-500/10 rounded-xl">
                    <span class="material-symbols-outlined text-emerald-600 dark:text-emerald-400 text-[28px]">
                        monetization_on
                    </span>
                </div>
                <div>
                    <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Current Balance</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">
                        <c:out value="${sessionScope.USER.studyCoins != null ? sessionScope.USER.studyCoins : 0}"/> Coins
                    </p>
                </div>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="bg-white dark:bg-slate-800 rounded-2xl p-4 md:p-5 shadow-sm border border-slate-200 dark:border-slate-700 mb-8">
            <div class="flex flex-col md:flex-row gap-4">
                <!-- Search -->
                <div class="flex-1 relative">
                    <span class="material-symbols-outlined absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-[20px]">search</span>
                    <input type="text" id="searchInput" placeholder="Search exams by name..."
                           class="w-full pl-11 pr-4 py-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl text-sm text-slate-800 dark:text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition"
                           onkeyup="filterExams()">
                </div>
                
                <!-- Category Dropdown with optgroup -->
                <div class="relative">
                    <select id="categoryFilter" onchange="filterExams()"
                            class="appearance-none w-full md:w-56 px-4 py-3 pr-10 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl text-sm text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition cursor-pointer">
                        <option value="">All Categories</option>
                        <optgroup label="Technical">
                            <option value="Java">Java</option>
                            <option value="SQL & Database">SQL & Database</option>
                            <option value="Web Development">Web Development</option>
                            <option value="OOP & Design Patterns">OOP & Design Patterns</option>
                            <option value="Data Structures">Data Structures</option>
                            <option value="Git & DevOps">Git & DevOps</option>
                        </optgroup>
                        <optgroup label="Career">
                            <option value="Interview Prep">Interview Prep</option>
                            <option value="Certification Practice">Certification Practice</option>
                            <option value="Aptitude Test">Aptitude Test</option>
                        </optgroup>
                    </select>
                    <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 text-[18px] pointer-events-none">expand_more</span>
                </div>
                
                <!-- Difficulty Dropdown -->
                <div class="relative">
                    <select id="difficultyFilter" onchange="filterExams()"
                            class="appearance-none w-full md:w-48 px-4 py-3 pr-10 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl text-sm text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition cursor-pointer">
                        <option value="">All Levels</option>
                        <option value="Beginner">Beginner</option>
                        <option value="Intermediate">Intermediate</option>
                        <option value="Advanced">Advanced</option>
                    </select>
                    <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 text-[18px] pointer-events-none">expand_more</span>
                </div>
            </div>
            
            <!-- Active Filters & Result Count -->
            <div class="flex items-center justify-between mt-3 pt-3 border-t border-slate-100 dark:border-slate-700">
                <p class="text-sm text-slate-500 dark:text-slate-400">
                    Showing <b id="visibleCount" class="text-slate-800 dark:text-white">0</b> exams
                </p>
                <button onclick="clearFilters()" class="text-sm text-emerald-600 hover:text-emerald-700 font-medium transition hidden" id="clearBtn">
                    Clear filters
                </button>
            </div>
        </div>

        <c:if test="${not empty requestScope.errorMessage}">
            <div class="mb-8 p-4 bg-red-50 border-l-4 border-red-500 text-red-700 rounded-lg">
                <p class="font-medium">Error!</p>
                <p>${requestScope.errorMessage}</p>
            </div>
        </c:if>

        <!-- Exam List Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8" id="examGrid">
            <c:choose>
                <c:when test="${empty examList}">
                    <div class="col-span-full py-20 text-center" id="emptyState">
                        <span class="material-symbols-outlined text-[64px] text-slate-300 dark:text-slate-600 mb-4">
                            inbox
                        </span>
                        <h3 class="text-xl font-medium text-slate-900 dark:text-white mb-2">No exams available yet</h3>
                        <p class="text-slate-500 dark:text-slate-400">We are updating the latest mock exams. Please check back later.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="exam" items="${examList}">
                        <div class="exam-card group bg-white dark:bg-slate-800 rounded-3xl p-6 shadow-sm hover:shadow-xl border border-slate-200 dark:border-slate-700 transition-all duration-300 hover:-translate-y-1"
                             data-title="${exam.title}"
                             data-category="${exam.category != null ? exam.category : 'General'}"
                             data-difficulty="${exam.difficulty != null ? exam.difficulty : 'Beginner'}">
                            
                            <div class="flex justify-between items-start mb-4">
                                <div class="w-14 h-14 bg-gradient-to-br from-emerald-400 to-teal-500 rounded-2xl flex items-center justify-center text-white shadow-lg shadow-emerald-500/30">
                                    <span class="material-symbols-outlined text-[28px]">quiz</span>
                                </div>
                                <div class="px-3 py-1 bg-amber-100 dark:bg-amber-500/10 text-amber-600 flex items-center gap-1.5 rounded-full text-sm font-semibold">
                                    <span class="material-symbols-outlined text-[16px]">stars</span>
                                    <c:out value="${exam.costCoins}"/> Coins
                                </div>
                            </div>
                            
                            <!-- Category & Difficulty Badges -->
                            <div class="flex items-center gap-2 mb-4 flex-wrap">
                                <span class="px-2.5 py-1 bg-blue-50 dark:bg-blue-500/10 text-blue-600 dark:text-blue-400 rounded-lg text-xs font-semibold border border-blue-100 dark:border-blue-500/20">
                                    <c:out value="${exam.category != null ? exam.category : 'General'}"/>
                                </span>
                                
                                <c:choose>
                                    <c:when test="${exam.difficulty == 'Beginner'}">
                                        <span class="px-2.5 py-1 bg-emerald-50 dark:bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 rounded-lg text-xs font-semibold border border-emerald-100 dark:border-emerald-500/20">
                                            Beginner
                                        </span>
                                    </c:when>
                                    <c:when test="${exam.difficulty == 'Intermediate'}">
                                        <span class="px-2.5 py-1 bg-amber-50 dark:bg-amber-500/10 text-amber-600 dark:text-amber-400 rounded-lg text-xs font-semibold border border-amber-100 dark:border-amber-500/20">
                                            Intermediate
                                        </span>
                                    </c:when>
                                    <c:when test="${exam.difficulty == 'Advanced'}">
                                        <span class="px-2.5 py-1 bg-red-50 dark:bg-red-500/10 text-red-600 dark:text-red-400 rounded-lg text-xs font-semibold border border-red-100 dark:border-red-500/20">
                                            Advanced
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-2.5 py-1 bg-slate-50 dark:bg-slate-500/10 text-slate-600 dark:text-slate-400 rounded-lg text-xs font-semibold border border-slate-200 dark:border-slate-500/20">
                                            <c:out value="${exam.difficulty != null ? exam.difficulty : 'Beginner'}"/>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <h3 class="text-xl font-bold text-slate-900 dark:text-white mb-3 line-clamp-2 min-h-[56px]">
                                <c:out value="${exam.title}"/>
                            </h3>
                            
                            <p class="text-sm text-slate-500 dark:text-slate-400 mb-6 line-clamp-2 min-h-[40px]">
                                <c:out value="${exam.description}"/>
                            </p>
                            
                            <div class="flex items-center gap-4 py-4 border-t border-b border-slate-100 dark:border-slate-700/50 mb-6">
                                <div class="flex items-center gap-2 text-slate-600 dark:text-slate-300">
                                    <span class="material-symbols-outlined text-[18px]">timer</span>
                                    <span class="text-sm font-medium"><c:out value="${exam.durationMinutes}"/> Min</span>
                                </div>
                                <div class="w-1 h-1 rounded-full bg-slate-300 dark:bg-slate-600"></div>
                                <div class="flex items-center gap-2 text-slate-600 dark:text-slate-300">
                                    <span class="material-symbols-outlined text-[18px]">format_list_numbered</span>
                                    <span class="text-sm font-medium"><c:out value="${exam.questionCollection.size()}"/> Questions</span>
                                </div>
                            </div>
                            
                            <!-- Start Exam Button -->
                            <form id="examForm_${exam.examId}" action="${pageContext.request.contextPath}/start-exam" method="POST">
                                <input type="hidden" name="examId" value="${exam.examId}">
                                <button type="button" 
                                        onclick="confirmStartExam(this, '${exam.title}', ${exam.costCoins}, ${sessionScope.USER.studyCoins != null ? sessionScope.USER.studyCoins : 0}, ${exam.durationMinutes})"
                                        class="w-full flex items-center justify-center gap-2 bg-slate-900 dark:bg-white text-white dark:text-slate-900 py-3.5 rounded-xl font-semibold transition-colors hover:bg-emerald-600 dark:hover:bg-emerald-500 hover:text-white">
                                    <span class="material-symbols-outlined text-[20px]">play_circle</span>
                                    Start Exam
                                </button>
                            </form>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- No results message -->
        <div id="noResults" class="hidden py-20 text-center">
            <span class="material-symbols-outlined text-[64px] text-slate-300 dark:text-slate-600 mb-4">
                search_off
            </span>
            <h3 class="text-xl font-medium text-slate-900 dark:text-white mb-2">No exams match your filters</h3>
            <p class="text-slate-500 dark:text-slate-400">Try adjusting your search or filter criteria.</p>
        </div>
        
    </div>
</div>

<script>
    // Initial count
    (function() {
        var cards = document.querySelectorAll('.exam-card');
        document.getElementById('visibleCount').textContent = cards.length;
    })();

    // Filter logic
    function filterExams() {
        var searchVal = document.getElementById('searchInput').value.toLowerCase().trim();
        var categoryVal = document.getElementById('categoryFilter').value;
        var difficultyVal = document.getElementById('difficultyFilter').value;
        var cards = document.querySelectorAll('.exam-card');
        var visibleCount = 0;

        cards.forEach(function(card) {
            var title = (card.getAttribute('data-title') || '').toLowerCase();
            var category = card.getAttribute('data-category') || '';
            var difficulty = card.getAttribute('data-difficulty') || '';

            var matchSearch = !searchVal || title.indexOf(searchVal) !== -1;
            var matchCategory = !categoryVal || category === categoryVal;
            var matchDifficulty = !difficultyVal || difficulty === difficultyVal;

            if (matchSearch && matchCategory && matchDifficulty) {
                card.style.display = '';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        document.getElementById('visibleCount').textContent = visibleCount;
        
        // Toggle no-results
        var noResults = document.getElementById('noResults');
        if (visibleCount === 0 && cards.length > 0) {
            noResults.classList.remove('hidden');
        } else {
            noResults.classList.add('hidden');
        }
        
        // Toggle clear button
        var clearBtn = document.getElementById('clearBtn');
        if (searchVal || categoryVal || difficultyVal) {
            clearBtn.classList.remove('hidden');
        } else {
            clearBtn.classList.add('hidden');
        }
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('categoryFilter').value = '';
        document.getElementById('difficultyFilter').value = '';
        filterExams();
    }

    // SweetAlert2 Confirmation
    function confirmStartExam(btn, examTitle, cost, currentCoins, duration) {
        if (currentCoins < cost) {
            Swal.fire({
                icon: 'error',
                title: 'Insufficient Coins!',
                html: '<div style="text-align:left; line-height:1.8">' +
                      '<p>You need <b style="color:#f59e0b">' + cost + ' Coins</b> to enter this exam.</p>' +
                      '<p>Current balance: <b style="color:#ef4444">' + currentCoins + ' Coins</b></p>' +
                      '<hr style="margin:12px 0; border-color:#e2e8f0">' +
                      '<p style="font-size:13px; color:#64748b">Purchase courses or log in daily to earn more coins!</p>' +
                      '</div>',
                confirmButtonColor: '#10B981',
                confirmButtonText: 'Got it',
                background: '#fff',
                customClass: { popup: 'rounded-2xl', confirmButton: 'rounded-xl px-6' }
            });
            return;
        }
        
        Swal.fire({
            icon: 'question',
            title: 'Confirm Exam Entry',
            html: '<div style="text-align:left; line-height:1.9; padding: 8px 0">' +
                  '<div style="background:#f0fdf4; border-radius:12px; padding:14px 16px; margin-bottom:12px; border:1px solid #bbf7d0">' +
                  '  <p style="font-weight:600; color:#166534; margin-bottom:4px">' + examTitle + '</p>' +
                  '  <p style="font-size:13px; color:#15803d">Duration: ' + duration + ' minutes</p>' +
                  '</div>' +
                  '<div style="background:#fffbeb; border-radius:12px; padding:14px 16px; border:1px solid #fde68a">' +
                  '  <p style="font-size:14px; color:#92400e">Cost: <b>' + cost + ' Coins</b></p>' +
                  '  <p style="font-size:13px; color:#a16207; margin-top:4px">Remaining balance: <b>' + (currentCoins - cost) + ' Coins</b></p>' +
                  '</div>' +
                  '<p style="font-size:12px; color:#94a3b8; margin-top:14px; text-align:center">The countdown starts as soon as you enter!</p>' +
                  '</div>',
            showCancelButton: true,
            confirmButtonColor: '#10B981',
            cancelButtonColor: '#64748b',
            confirmButtonText: 'Start Now',
            cancelButtonText: 'Cancel',
            reverseButtons: true,
            background: '#fff',
            customClass: { popup: 'rounded-2xl', confirmButton: 'rounded-xl px-6', cancelButton: 'rounded-xl px-6' }
        }).then(function(result) {
            if (result.isConfirmed) {
                btn.disabled = true;
                btn.innerHTML = '<span class="material-symbols-outlined text-[20px] animate-spin">progress_activity</span> Entering exam...';
                btn.closest('form').submit();
            }
        });
    }
</script>

<jsp:include page="../common/userbuttom.jsp" />
<jsp:include page="../common/footer.jsp" />
</body>
</html>
