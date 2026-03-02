<%-- 
    Document   : addCourse
    Created on : Feb 22, 2026, 4:29:03 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Backdrop -->
<!-- Modal Container -->
<div class="relative z-10 w-full max-w-4xl bg-white dark:bg-slate-50 border border-primary/10 shadow-2xl rounded-xl overflow-hidden flex flex-col max-h-[90vh]">
    <!-- Header -->
    <div class="px-8 py-6 border-b border-primary/10 flex items-center justify-between bg-white dark:bg-[#1a2e16] sticky top-0 z-20">
        <div>
            <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Update Course</h2>
            <p class="text-sm text-slate-500 dark:text-primary/60 mt-1">Fill in the details to update your E-learning content.</p>
        </div>
        <button type="button"
                onclick="closeUpdateCourseModal()" class="p-2 hover:bg-primary/10 rounded-full transition-colors text-slate-400 dark:text-primary/40 hover:text-primary">
            <span class="material-icons">close</span>
        </button>
    </div>
    <!-- Form Body (Scrollable) -->
    <c:if test="${not empty ERROR}">
        <div class="mb-4 p-4 rounded-lg bg-red-100 text-red-700 border border-red-300">
            ${ERROR}
        </div>
    </c:if>
    <form id="updateCourseForm" action="courseAdmin?action=update" method="post" enctype="multipart/form-data" class="modal-body overflow-y-auto p-8 space-y-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <!-- Left Column: Media & Status -->
            <div class="lg:col-span-4 space-y-6">
                <input type="hidden" name="course_id" id="updateCourseId">
                <div>
                    <label class="block text-sm font-semibold text-slate-700 mb-3">
                        Course Thumbnail
                    </label>

                    <!-- INPUT ẨN -->
                    <input   type="file"
                             name="url"
                             id="updateThumbnailInput"
                             accept="image/png, image/jpeg, image/webp"
                             class="hidden" />

                    <!-- Upload box -->
                    <div id="updateUploadBox"
                         onclick="document.getElementById('updateThumbnailInput').click()"
                         class="w-full aspect-video rounded-lg border-2 border-dashed border-primary/30 bg-primary/5 hover:border-primary/60 transition-all flex flex-col items-center justify-center text-center p-4 cursor-pointer">

                        <span class="material-icons text-primary text-4xl mb-2">
                            cloud_upload
                        </span>

                        <p class="text-xs font-medium">
                            Click to upload
                        </p>
                    </div>

                    <!-- Preview -->
                    <div id="updatePreviewBox"
                         class="hidden mt-3 w-40 relative">

                        <img id="updateThumbnailUrl"
                             class="rounded-lg border object-cover w-full" />

                        <button type="button"
                                onclick="removeUpdateThumbnail()"
                                class="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-6 h-6 text-xs">
                            ×
                        </button>
                    </div>
                </div>
                <div class="p-4 rounded-lg bg-primary/5 border border-primary/10">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-semibold text-slate-700 dark:text-slate-200">Course Status</p>
                            <p class="text-xs text-slate-500 dark:text-primary/60">Set visibility for students</p>
                        </div>
                        <label class="inline-flex items-center cursor-pointer">

                            <input name="status"   class="sr-only peer" type="checkbox" value="ACTIVE"/>
                            <div class="relative w-11 h-6 bg-slate-300 peer-focus:outline-none dark:peer-focus:ring-primary/20 rounded-full peer dark:bg-slate-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-primary"></div>
                        </label>
                    </div>
                    <div class="mt-2 flex items-center space-x-2">
                        <span class="w-2 h-2 rounded-full bg-primary animate-pulse"></span>
                        <span class="text-xs font-medium text-primary uppercase tracking-wider">Active</span>
                    </div>
                </div>
            </div>
            <!-- Right Column: Details -->
            <div class="lg:col-span-8 space-y-6">
                <!-- Title -->
                <div class="space-y-2">
                    <label class="block text-sm font-semibold text-slate-700 dark:text-slate-200">Course Title</label>
                    <input id="updateTitle" required="" name="title" class="w-full px-4 py-3 bg-slate-50 dark:bg-[#11200e] border border-slate-200 dark:border-primary/20 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all dark:text-white placeholder:text-slate-400 dark:placeholder:text-primary/30" placeholder="e.g. Advanced UI Design Patterns" type="text"/>
                </div>
                <!-- Category & Teacher -->
                <!-- Category -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                    <!-- Category -->
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-slate-700 dark:text-slate-200">
                            Category
                        </label>

                        <div class="relative">
                            <select name="category_id" id="updateCategory"
                                    class="w-full px-4 py-3 bg-slate-50 dark:bg-[#11200e] border border-slate-200 dark:border-primary/20 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all dark:text-white appearance-none cursor-pointer">

                                <option value="1">Software Engineering</option>
                                <option value="2">Mathematics</option>
                                <option value="4">Free Course</option>
                                <option value="3">Foreign Language</option>

                            </select>

                            <span class="material-icons absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none">
                                expand_more
                            </span>
                        </div>
                    </div>

                    <!-- Teacher ID -->
                    <div class="space-y-2">
                        <label  class="block text-sm font-semibold text-slate-700 dark:text-slate-200">
                            Teacher ID
                        </label>

                        <input type="number"
                               name="teacher_id"
                               id="updateTeacher"
                               class="w-full px-4 py-3 bg-slate-50 dark:bg-[#11200e] border border-slate-200 dark:border-primary/20 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all dark:text-white placeholder:text-slate-400 dark:placeholder:text-primary/30"
                               placeholder="Enter teacher ID" />
                    </div>

                </div>
                <!-- Description -->
                <div class="space-y-2">
                    <label class="block text-sm font-semibold text-slate-700 dark:text-slate-200">Description</label>
                    <textarea id="updateDescription" required="" name="description" class="w-full px-4 py-3 bg-slate-50 dark:bg-[#11200e] border border-slate-200 dark:border-primary/20 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all dark:text-white placeholder:text-slate-400 dark:placeholder:text-primary/30 resize-none" placeholder="Briefly describe what students will learn..." rows="4"></textarea>
                </div>
                <!-- Level & Price -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-slate-700 dark:text-slate-200">
                            Difficulty Level
                        </label>

                        <!-- Hidden input để gửi form -->
                        <input type="hidden" name="level" id="updateLevelInput" value="">

                        <div id="updateLevelGroup"
                             class="flex p-1 bg-slate-100 dark:bg-[#11200e] rounded-lg border border-slate-200 dark:border-primary/10">

                            <button type="button"
                                    data-level="Beginner"
                                    class="update-level-btn flex-1 py-2 text-xs font-semibold rounded-md bg-white dark:bg-primary text-slate-700 dark:text-background-dark shadow-sm transition-all duration-300">
                                Beginner
                            </button>

                            <button type="button"
                                    data-level="Intermediate"
                                    class="update-level-btn flex-1 py-2 text-xs font-semibold text-slate-500 dark:text-primary/60 transition-all duration-300">
                                Intermediate
                            </button>

                            <button type="button"
                                    data-level="Advanced"
                                    class="update-level-btn flex-1 py-2 text-xs font-semibold text-slate-500 dark:text-primary/60 transition-all duration-300">
                                Advanced
                            </button>

                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="block text-sm font-semibold text-slate-700 dark:text-slate-200">Price (USD)</label>
                        <div class="relative">
                            <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 dark:text-primary/40 font-semibold">$</span>
                            <input 
                                id="updatePrice"
                                required
                                name="price"
                                type="number"
                                step="0.01"
                                min="0"
                                class="w-full pl-8 pr-4 py-3 bg-slate-50 dark:bg-[#11200e] border border-slate-200 dark:border-primary/20 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all dark:text-white placeholder:text-slate-400 dark:placeholder:text-primary/30"
                                placeholder="0.00"
                                />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Actions -->
        <div class="px-8 py-6 border-t border-primary/10 bg-slate-50 dark:bg-[#1a2e16] flex flex-col sm:flex-row items-center justify-end space-y-3 sm:space-y-0 sm:space-x-4">
            <button type="button"
                    onclick="closeUpdateCourseModal()" class="w-full sm:w-auto px-6 py-2.5 text-sm font-semibold text-slate-600 dark:text-primary/70 hover:text-slate-900 dark:hover:text-primary border border-slate-300 dark:border-primary/20 rounded-lg hover:bg-slate-100 dark:hover:bg-primary/5 transition-all"  >
                Cancel
            </button>
            <button class="w-full sm:w-auto px-10 py-2.5 text-sm font-bold text-background-dark bg-primary hover:bg-primary/90 rounded-lg shadow-lg shadow-primary/20 transform hover:-translate-y-0.5 transition-all active:scale-95 flex items-center justify-center space-x-2" type="submit">
                <span class="material-icons text-[20px]">check_circle</span>
                <span>Save Course</span>
            </button>
        </div>

        <div id="updateLoadingOverlay"
             class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center">

            <div class="bg-white p-6 rounded-xl shadow-xl text-center space-y-4">
                <div class="animate-spin rounded-full h-10 w-10 border-4 border-primary border-t-transparent mx-auto"></div>
                <p class="text-sm font-semibold">Uploading & Saving course...</p>
            </div>
        </div>
    </form>
</div>

