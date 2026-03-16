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
    <div class="fixed bottom-6 left-6 z-50">
        <c:choose>
            <c:when test="${sessionScope.USER == null}">
                <div class="relative z-50 user-pill">
                    <div class="animate-border relative inline-flex p-[4px] overflow-hidden rounded-full">
                        <a href="login?action=login"
                            class="relative z-10 inline-flex items-center justify-center px-6 py-2.5 rounded-full text-[14px] font-semibold tracking-wide bg-gradient-to-r from-emerald-400 to-emerald-600 text-white shadow-lg shadow-emerald-900/40 transition-all duration-200 hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] hover:-translate-y-0.5 hover:brightness-105">
                            Sign Up / Sign In
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="relative z-50 user-pill">
                    <div class="animate-border relative inline-flex p-[4px] overflow-hidden rounded-full">
                        <button id="userMenuButton"
                            class="relative w-full z-10 inline-flex items-center gap-3 px-4 py-2 rounded-full bg-slate-200 dark:bg-slate-700 transition-all duration-200 hover:bg-slate-300 dark:hover:bg-slate-600">
                            <div class="h-10 w-10 rounded-full bg-cover bg-center ring-2 ring-primary/20"
                                data-alt="Close up portrait of a smiling young man"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuA8a1rLcaZoYgR6wiziFK7eqdHhw_Z-iG8_53E2NuJo_2kSo1jDAdm9iRMyxWoMz2rVzDCMmwxOOwTtnoQxiMNniTWw2dJyBOc4lKO1r87tXpP7qnfSpXPqXuaNqV1wlGrq9aR6TSwvsFGc_uUy1QhTLOIcuiKOhJLjm5gi2xW9e8CBL6eIrQhhmioU_Pz_znoR7DZ6qH2KREgGzVKbk3DiFf7dWgkewrYDLIBcEvU9FODSZi5rY00RoB1f5FfmZQNSstTTpC0KCyo')">
                            </div>
                            <div class="hidden sm:block text-left">
                                <p class="text-sm font-semibold text-slate-900 dark:text-slate-100 leading-none">
                                    ${USER.username}</p>
                                <p
                                    class="text-[11px] font-medium text-slate-500 dark:text-slate-400 uppercase tracking-wider mt-1">
                                    Premium</p>
                            </div>
                            <span
                                class="material-symbols-outlined text-slate-400 group-hover:text-slate-600">expand_more</span>
                        </button>
                    </div>
                </div>

                <div id="userDropdown"
                    class="absolute left-0 bottom-full mb-3 w-60 origin-bottom-left rounded-2xl bg-white shadow-lg border border-gray-200 hidden transition-all duration-200 z-50 overflow-hidden">

                    <div class="px-5 py-3.5 border-b border-gray-200 bg-gray-50">
                        <p class="text-[13px] text-gray-500 mb-0.5">Signed in as</p>
                        <p class="text-[14px] font-bold text-gray-900 truncate">${USER.email}</p>
                    </div>

                    <div class="py-2">
                        <a href="${pageContext.request.contextPath}/student"
                            class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                            style="text-decoration: none;">
                            <span class="material-symbols-outlined text-[20px]">person</span>
                            Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/student?action=courses"
                            class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                            style="text-decoration: none;">
                            <span class="material-symbols-outlined text-[20px]">menu_book</span>
                            My Courses
                        </a>
                        <a href="${pageContext.request.contextPath}/student?action=billing"
                            class="flex items-center gap-3 px-5 py-2.5 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900 transition-colors"
                            style="text-decoration: none;">
                            <span class="material-symbols-outlined text-[20px]">payments</span>
                            Billing
                        </a>
                       
                    </div>

                    <div class="py-2 border-t border-gray-200">
                        <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center gap-3 px-5 py-2 text-sm font-medium text-red-500 hover:bg-red-50 hover:text-red-600 transition-colors"
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