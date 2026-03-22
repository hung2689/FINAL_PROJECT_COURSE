<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Exam Results | DevLearn</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-slate-50">

<jsp:include page="../common/header.jsp" />

<div class="min-h-screen bg-slate-50 dark:bg-slate-900 pt-32 pb-20 flex items-center justify-center">
    <div class="max-w-3xl w-full px-4 sm:px-6">
        
        <!-- Result Card -->
        <div class="bg-white dark:bg-slate-800 rounded-[2.5rem] p-8 md:p-12 shadow-xl shadow-slate-200/50 dark:shadow-none border border-slate-100 dark:border-slate-700 relative overflow-hidden">
            
            <!-- Confetti Decor -->
            <div class="absolute -top-24 -right-24 w-64 h-64 bg-amber-400 rounded-full mix-blend-multiply filter blur-3xl opacity-20 dark:opacity-10 animate-blob"></div>
            <div class="absolute -bottom-24 -left-24 w-64 h-64 bg-emerald-400 rounded-full mix-blend-multiply filter blur-3xl opacity-20 dark:opacity-10 animate-blob animation-delay-2000"></div>

            <div class="relative z-10 text-center">
                <!-- Trophy Icon -->
                <div class="w-24 h-24 bg-gradient-to-tr from-amber-400 to-orange-400 rounded-full mx-auto flex items-center justify-center mb-8 shadow-lg shadow-amber-500/30">
                    <span class="material-symbols-outlined text-white text-[48px]">workspace_premium</span>
                </div>
                
                <h1 class="text-3xl font-bold text-slate-900 dark:text-white mb-2">Exam Completed!</h1>
                <p class="text-slate-500 dark:text-slate-400 max-w-sm mx-auto mb-10">You have completed the exam <b class="text-slate-700 dark:text-slate-300">${exam.title}</b>. Here are your results:</p>
                
                <!-- Score Board -->
                <div class="bg-slate-50 dark:bg-slate-900/50 rounded-3xl p-8 mb-10 flex flex-col md:flex-row items-center justify-center gap-12 border border-slate-100 dark:border-slate-700">
                    
                    <div class="text-center">
                        <p class="text-sm font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider mb-2">SCORE</p>
                        <div class="text-6xl font-black bg-gradient-to-r from-emerald-600 to-teal-500 bg-clip-text text-transparent drop-shadow-sm">
                            <fmt:formatNumber value="${attempt.score}" maxFractionDigits="1" minFractionDigits="0"/> <!-- Out of 10 -->
                        </div>
                        <p class="text-emerald-600 dark:text-emerald-400 font-medium mt-2">Out of 10</p>
                    </div>

                    <div class="hidden md:block w-px h-24 bg-slate-200 dark:bg-slate-700"></div>

                    <div class="grid grid-cols-2 gap-x-12 gap-y-6 text-left">
                        <div>
                            <p class="text-xs text-slate-500 dark:text-slate-400 mb-1 uppercase tracking-wider font-semibold">ATTEMPT ID</p>
                            <p class="text-slate-900 dark:text-white font-mono font-medium">#${attempt.attemptId}</p>
                        </div>
                        <div>
                            <p class="text-xs text-slate-500 dark:text-slate-400 mb-1 uppercase tracking-wider font-semibold">COST</p>
                            <p class="text-amber-600 dark:text-amber-500 font-bold flex items-center gap-1">
                                <span class="material-symbols-outlined text-[16px]">stars</span>
                                -${attempt.coinsDeducted} Coins
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-slate-500 dark:text-slate-400 mb-1 uppercase tracking-wider font-semibold">STARTED AT</p>
                            <p class="text-slate-900 dark:text-white font-medium text-sm">
                                <fmt:formatDate value="${attempt.startedAt}" pattern="HH:mm, dd/MM/yyyy" />
                            </p>
                        </div>
                        <div>
                            <p class="text-xs text-slate-500 dark:text-slate-400 mb-1 uppercase tracking-wider font-semibold">SUBMITTED AT</p>
                            <p class="text-emerald-600 dark:text-emerald-400 font-medium text-sm font-semibold">
                                <fmt:formatDate value="${attempt.submittedAt}" pattern="HH:mm, dd/MM/yyyy" />
                            </p>
                        </div>
                    </div>

                </div>

                <!-- Actions -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/mock-exams" class="px-8 py-3.5 bg-slate-100 hover:bg-slate-200 text-slate-700 dark:bg-slate-800 dark:hover:bg-slate-700 dark:text-slate-300 rounded-xl font-semibold transition flex items-center justify-center gap-2">
                        <span class="material-symbols-outlined text-[20px]">arrow_back</span>
                        Back to Exams
                    </a>
                    <button class="px-8 py-3.5 bg-emerald-600 hover:bg-emerald-700 text-white rounded-xl font-semibold transition flex items-center justify-center gap-2 shadow-lg shadow-emerald-500/25">
                        <span class="material-symbols-outlined text-[20px]">share</span>
                        Share Score
                    </button>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/userbuttom.jsp" />
<jsp:include page="../common/footer.jsp" />
</body>
</html>
