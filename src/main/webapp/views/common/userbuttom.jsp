<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <style>
        @keyframes spin-glowing-border {
            0% {
                transform: translate(-50%, -50%) rotate(0deg);
            }

            100% {
                transform: translate(-50%, -50%) rotate(360deg);
            }
        }

        .animate-border {
            position: relative;
            display: inline-flex;
        }

        .animate-border::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 600px;
            height: 600px;
            background: conic-gradient(from 0deg, transparent 70%, #10B981 100%);
            z-index: 0;
            transform: translate(-50%, -50%);
            animation: spin-glowing-border 3s linear infinite;
        }
    </style>

 
    <!-- Fixed User Pill -->
    <c:set var="pillClasses" value="${param.isSidebar == 'true' ? 'relative w-full z-50' : 'fixed bottom-6 left-6 z-50'}" />
    <div class="${pillClasses}">
         <c:choose>
            <c:when test="${sessionScope.USER == null}">
                <div class="relative z-50 user-pill w-full">
                    <div class="animate-border relative w-full inline-flex p-[4px] overflow-hidden rounded-full">
                        <a href="${pageContext.request.contextPath}/login"
                            class="relative w-full z-10 inline-flex items-center justify-center px-6 py-2.5 rounded-full text-[14px] font-semibold tracking-wide bg-gradient-to-r from-emerald-400 to-emerald-600 text-white shadow-lg shadow-emerald-900/40 transition-all duration-200 hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:-translate-y-0.5 hover:brightness-105">
                            Sign Up / Sign In
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="relative z-50 user-pill w-full">
                    <div class="${param.isSidebar == 'true' ? '' : 'animate-border p-[4px]'} relative inline-flex overflow-hidden rounded-full w-full">
                        <button id="userMenuButton"
                            class="relative w-full z-10 inline-flex items-center gap-3 px-4 py-2 ${param.isSidebar == 'true' ? 'rounded-lg bg-transparent hover:bg-slate-800' : 'rounded-full bg-slate-200 dark:bg-slate-700 shadow-md transition-all duration-200 hover:bg-slate-300 dark:hover:bg-slate-600'}">
                            <div class="h-10 w-10 rounded-full flex items-center justify-center font-bold text-white uppercase text-lg ring-2 ring-primary/20 bg-gradient-to-br from-emerald-400 to-teal-600 flex-shrink-0"
                                data-alt="User Portrait">
                                ${sessionScope.USER.username != null ? sessionScope.USER.username.substring(0, 1) : "U"}
                            </div>
                            <div class="hidden sm:block text-left w-full overflow-hidden">
                                <p class="text-sm font-semibold tracking-wide ${param.isSidebar == 'true' ? 'text-slate-200' : 'text-slate-900 dark:text-slate-100'} truncate leading-none capitalize">
                                    ${sessionScope.USER.username != null ? sessionScope.USER.username : 'User'}</p>
                                <p class="text-[11px] font-medium ${param.isSidebar == 'true' ? 'text-slate-500' : 'text-slate-500 dark:text-slate-400'} uppercase tracking-wider mt-1 truncate">
                                    ${sessionScope.ROLE != null ? sessionScope.ROLE : 'User'}
                                </p>
                            </div>
                            <span class="material-symbols-outlined ${param.isSidebar == 'true' ? 'text-slate-400' : 'text-slate-400 group-hover:text-slate-600'} flex-shrink-0">expand_more</span>
                        </button>
                    </div>
                </div>

                <div id="userDropdown"
                    class="absolute ${param.isSidebar == 'true' ? 'left-4 bottom-full mb-2 w-[calc(100%-2rem)]' : 'left-0 bottom-full mb-3 w-60'} origin-bottom-left rounded-2xl ${param.isSidebar == 'true' ? 'bg-slate-800 border-slate-700 text-slate-200 shadow-2xl' : 'bg-white shadow-lg border-gray-200'} hidden transition-all duration-200 z-50 overflow-hidden">

                    <div class="px-5 py-3.5 border-b ${param.isSidebar == 'true' ? 'border-slate-700 bg-slate-800/80' : 'border-gray-200 bg-gray-50'}">
                        <p class="text-[12px] font-semibold ${param.isSidebar == 'true' ? 'text-slate-400' : 'text-gray-500'} mb-0.5 uppercase tracking-wider">Signed in as</p>
                        <p class="text-[14px] font-bold ${param.isSidebar == 'true' ? 'text-white' : 'text-gray-900'} truncate">${USER.email}</p>
                    </div>

                    <div class="py-2">
 
                        <c:choose>
                            <c:when test="${sessionScope.ROLE == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/adminDashboard"
                                    class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium ${param.isSidebar == 'true' ? 'text-slate-300 hover:bg-slate-700/50 hover:text-primary' : 'text-gray-600 hover:bg-gray-100 hover:text-emerald-600'} transition-colors"
                                    style="text-decoration: none;">
                                    <span class="material-symbols-outlined text-[20px]">admin_panel_settings</span>
                                    View Admin
                                </a>
                                <a href="${pageContext.request.contextPath}/home"
                                    class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium ${param.isSidebar == 'true' ? 'text-slate-300 hover:bg-slate-700/50 hover:text-primary' : 'text-gray-600 hover:bg-gray-100 hover:text-emerald-600'} transition-colors"
                                    style="text-decoration: none;">
                                    <span class="material-symbols-outlined text-[20px]">school</span>
                                    View Study
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/student"
                                    class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium ${param.isSidebar == 'true' ? 'text-slate-300 hover:bg-slate-700/50' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-900'} transition-colors"
                                    style="text-decoration: none;">
                                    <span class="material-symbols-outlined text-[20px]">person</span>
                                    Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/student?action=courses"
                                    class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium ${param.isSidebar == 'true' ? 'text-slate-300 hover:bg-slate-700/50' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-900'} transition-colors"
                                    style="text-decoration: none;">
                                    <span class="material-symbols-outlined text-[20px]">menu_book</span>
                                    My Courses
                                </a>
                                <a href="${pageContext.request.contextPath}/student?action=billing"
                                    class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium ${param.isSidebar == 'true' ? 'text-slate-300 hover:bg-slate-700/50' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-900'} transition-colors"
                                    style="text-decoration: none;">
                                    <span class="material-symbols-outlined text-[20px]">payments</span>
                                    Billing
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
 
                    <div class="py-2 border-t ${param.isSidebar == 'true' ? 'border-slate-700' : 'border-gray-200'}">
                        <div class="flex items-center justify-between px-4 py-2 mb-2 rounded-lg mx-3 ${param.isSidebar == 'true' ? 'bg-emerald-500/10 border border-emerald-500/20' : 'bg-emerald-50 border border-emerald-100'}">
                             <div class="flex items-center gap-2">
                                <span class="material-symbols-outlined text-emerald-500 text-[20px]">monetization_on</span>
                                <span class="text-sm font-bold ${param.isSidebar == 'true' ? 'text-emerald-400' : 'text-emerald-600'}">Study Coins</span>
                             </div>
                             <span class="text-sm font-black text-emerald-500">${sessionScope.USER.studyCoins != null ? sessionScope.USER.studyCoins : 0}</span>
                        </div>

                        <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium text-red-500 ${param.isSidebar == 'true' ? 'hover:bg-red-500/10' : 'hover:bg-red-50 hover:text-red-600'} transition-colors"
                            style="text-decoration: none;">
                            <span class="material-symbols-outlined text-[20px]">logout</span>
                            Logout
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        (function () {
            const button = document.getElementById("userMenuButton");
            const dropdown = document.getElementById("userDropdown");

            if (button && dropdown) {
                button.addEventListener("click", function (e) {
                    e.stopPropagation();
                    dropdown.classList.toggle("hidden");
                });

                document.addEventListener("click", function () {
                    dropdown.classList.add("hidden");
                });
            }
        })();
    </script>