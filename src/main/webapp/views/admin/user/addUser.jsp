<%-- addUser.jsp --%>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <div class="bg-white dark:bg-slate-900 rounded-2xl w-full max-w-2xl overflow-hidden shadow-2xl relative">
            <div class="flex items-center justify-between p-6 border-b border-slate-200 dark:border-slate-800">
                <h3 class="text-xl font-bold text-slate-900 dark:text-white">Add New User</h3>
                <button type="button" onclick="closeAddUserModal()"
                    class="text-slate-400 hover:text-slate-500 dark:hover:text-slate-300">
                    <span class="material-icons">close</span>
                </button>
            </div>
            <form id="addUserForm" action="${pageContext.request.contextPath}/userAdmin" method="post" class="p-6">
                <input type="hidden" name="action" value="add">
                <div class="grid grid-cols-1 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Full
                            Name</label>
                        <input type="text" name="fullName" required
                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Email</label>
                        <input type="email" name="email" required
                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50" />
                    </div>
                    <div>
                        <label
                            class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Password</label>
                        <input type="password" name="password" required
                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50" />
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label
                                class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Role</label>
                            <select name="role"
                                class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50">
                                <option value="USER">User (Default)</option>
                                <option value="STUDENT">Student</option>
                                <option value="TEACHER">Teacher</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                        <div>
                            <label
                                class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Status</label>
                            <select name="status"
                                class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50">
                                <option value="ACTIVE">ACTIVE</option>
                                <option value="INACTIVE">INACTIVE</option>
                                <option value="PENDING">PENDING</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-2">Study Coins</label>
                        <input type="number" name="studyCoins" min="0" value="0"
                            class="w-full px-4 py-2.5 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-primary/50"
                            placeholder="0" />
                    </div>
                </div>
                <div class="mt-8 flex justify-end gap-3 border-t border-slate-200 dark:border-slate-800 pt-6">
                    <button type="button" onclick="closeAddUserModal()"
                        class="px-5 py-2.5 rounded-lg text-slate-500 font-medium hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">Cancel</button>
                    <button type="submit"
                        class="bg-primary text-background-dark font-bold px-5 py-2.5 rounded-lg hover:shadow-lg hover:shadow-primary/30 transition-all">Save
                        User</button>
                </div>
            </form>
        </div>