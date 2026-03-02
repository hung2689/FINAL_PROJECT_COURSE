<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Change Password – DevLearn</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@400,0&display=swap"
                rel="stylesheet" />
            <script>
                tailwind.config = {
                    theme: { extend: { colors: { primary: "#10B981" }, fontFamily: { display: ["Inter", "sans-serif"] }, maxWidth: { canvas: "1200px" } } }
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }
            </style>
        </head>

        <body class="font-display bg-gradient-to-br from-slate-50 to-emerald-50 min-h-screen text-slate-800">

            <jsp:include page="../common/header.jsp" />

            <div class="max-w-6xl mx-auto px-4 pt-28 pb-16 flex gap-8">

                <%-- ── SIDEBAR ── --%>
                    <aside class="w-64 flex-shrink-0">
                        <div
                            class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden sticky top-28">
                            <div class="p-6 border-b border-slate-100 bg-gradient-to-br from-emerald-50 to-teal-50">
                                <div
                                    class="w-16 h-16 rounded-full bg-emerald-100 flex items-center justify-center mx-auto mb-3">
                                    <span class="material-symbols-outlined text-3xl text-emerald-600">person</span>
                                </div>
                                <p class="text-center font-bold text-slate-800 truncate">${sessionScope.USER.fullName !=
                                    null ? sessionScope.USER.fullName : sessionScope.USER.username}</p>
                                <p class="text-center text-xs text-slate-400 truncate mt-0.5">${sessionScope.USER.email}
                                </p>
                            </div>
                            <nav class="p-3 space-y-1">
                                <a href="${pageContext.request.contextPath}/student?action=profile"
                                    class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                                    <span class="material-symbols-outlined text-lg">manage_accounts</span>
                                    My Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/student?action=password"
                                    class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-semibold bg-emerald-50 text-emerald-700">
                                    <span class="material-symbols-outlined text-lg">lock</span>
                                    Change Password
                                </a>
                                <a href="${pageContext.request.contextPath}/student?action=courses"
                                    class="flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-slate-600 hover:bg-slate-50 transition-colors">
                                    <span class="material-symbols-outlined text-lg">menu_book</span>
                                    My Courses
                                </a>
                            </nav>
                        </div>
                    </aside>

                    <%-- ── MAIN CONTENT ── --%>
                        <main class="flex-1 min-w-0">

                            <%-- Success toast --%>
                                <c:if test="${param.success == '1'}">
                                    <div id="toast"
                                        class="mb-6 flex items-center gap-3 px-5 py-3.5 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-700 font-semibold text-sm shadow-sm">
                                        <span class="material-symbols-outlined text-emerald-500">check_circle</span>
                                        Password changed successfully!
                                    </div>
                                </c:if>

                                <%-- Error --%>
                                    <c:if test="${not empty error}">
                                        <div
                                            class="mb-6 flex items-center gap-3 px-5 py-3.5 rounded-xl bg-red-50 border border-red-200 text-red-700 font-semibold text-sm shadow-sm">
                                            <span class="material-symbols-outlined text-red-500">error</span>
                                            ${error}
                                        </div>
                                    </c:if>

                                    <div class="bg-white rounded-2xl shadow-sm border border-slate-100">
                                        <div class="px-8 py-6 border-b border-slate-100">
                                            <h1 class="text-xl font-bold text-slate-800">Change Password</h1>
                                            <p class="text-sm text-slate-400 mt-0.5">Keep your account secure with a
                                                strong password</p>
                                        </div>

                                        <form action="${pageContext.request.contextPath}/student" method="post"
                                            class="p-8 space-y-6" id="pwForm">
                                            <input type="hidden" name="action" value="changePassword" />

                                            <%-- Current password --%>
                                                <div class="space-y-1.5">
                                                    <label class="block text-sm font-semibold text-slate-700"
                                                        for="oldPassword">Current Password</label>
                                                    <div class="relative">
                                                        <input id="oldPassword" name="oldPassword" type="password"
                                                            required autocomplete="current-password"
                                                            class="w-full px-4 py-2.5 pr-12 rounded-xl border border-slate-200 bg-slate-50 focus:ring-2 focus:ring-emerald-400 focus:border-emerald-400 outline-none transition text-slate-800 text-sm" />
                                                        <button type="button" onclick="toggle('oldPassword','eyeOld')"
                                                            class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                                                            <span id="eyeOld"
                                                                class="material-symbols-outlined text-xl">visibility_off</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <%-- New password --%>
                                                    <div class="space-y-1.5">
                                                        <label class="block text-sm font-semibold text-slate-700"
                                                            for="newPassword">New Password</label>
                                                        <div class="relative">
                                                            <input id="newPassword" name="newPassword" type="password"
                                                                required autocomplete="new-password" minlength="6"
                                                                class="w-full px-4 py-2.5 pr-12 rounded-xl border border-slate-200 bg-slate-50 focus:ring-2 focus:ring-emerald-400 focus:border-emerald-400 outline-none transition text-slate-800 text-sm" />
                                                            <button type="button"
                                                                onclick="toggle('newPassword','eyeNew')"
                                                                class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                                                                <span id="eyeNew"
                                                                    class="material-symbols-outlined text-xl">visibility_off</span>
                                                            </button>
                                                        </div>
                                                        <p class="text-xs text-slate-400">Minimum 6 characters.</p>
                                                    </div>

                                                    <%-- Confirm password --%>
                                                        <div class="space-y-1.5">
                                                            <label class="block text-sm font-semibold text-slate-700"
                                                                for="confirmPassword">Confirm New Password</label>
                                                            <div class="relative">
                                                                <input id="confirmPassword" name="confirmPassword"
                                                                    type="password" required autocomplete="new-password"
                                                                    class="w-full px-4 py-2.5 pr-12 rounded-xl border border-slate-200 bg-slate-50 focus:ring-2 focus:ring-emerald-400 focus:border-emerald-400 outline-none transition text-slate-800 text-sm" />
                                                                <button type="button"
                                                                    onclick="toggle('confirmPassword','eyeConfirm')"
                                                                    class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                                                                    <span id="eyeConfirm"
                                                                        class="material-symbols-outlined text-xl">visibility_off</span>
                                                                </button>
                                                            </div>
                                                            <p id="matchMsg" class="text-xs hidden"></p>
                                                        </div>

                                                        <%-- Submit --%>
                                                            <div class="pt-2">
                                                                <button type="submit"
                                                                    class="px-8 py-2.5 bg-gradient-to-r from-emerald-400 to-emerald-600 text-white font-bold rounded-xl shadow-lg shadow-emerald-500/20 hover:shadow-emerald-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200 text-sm">
                                                                    Update Password
                                                                </button>
                                                            </div>
                                        </form>
                                    </div>
                        </main>
            </div>

            <jsp:include page="../common/userbuttom.jsp" />

            <script>
                function toggle(inputId, eyeId) {
                    const input = document.getElementById(inputId);
                    const eye = document.getElementById(eyeId);
                    if (input.type === 'password') {
                        input.type = 'text';
                        eye.textContent = 'visibility';
                    } else {
                        input.type = 'password';
                        eye.textContent = 'visibility_off';
                    }
                }

                // Live match check
                document.getElementById('confirmPassword').addEventListener('input', function () {
                    const msg = document.getElementById('matchMsg');
                    if (this.value === document.getElementById('newPassword').value) {
                        msg.textContent = '✓ Passwords match';
                        msg.className = 'text-xs text-emerald-600';
                        msg.classList.remove('hidden');
                    } else {
                        msg.textContent = '✗ Passwords do not match';
                        msg.className = 'text-xs text-red-500';
                        msg.classList.remove('hidden');
                    }
                });

                // Client-side guard before submit
                document.getElementById('pwForm').addEventListener('submit', function (e) {
                    const np = document.getElementById('newPassword').value;
                    const cp = document.getElementById('confirmPassword').value;
                    if (np !== cp) {
                        e.preventDefault();
                        document.getElementById('matchMsg').textContent = '✗ Passwords do not match';
                        document.getElementById('matchMsg').className = 'text-xs text-red-500';
                        document.getElementById('matchMsg').classList.remove('hidden');
                    }
                });

                const toast = document.getElementById('toast');
                if (toast) setTimeout(() => toast.style.display = 'none', 4000);
            </script>
        </body>

        </html>