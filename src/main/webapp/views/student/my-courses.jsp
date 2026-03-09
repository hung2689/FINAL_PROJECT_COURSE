<%-- 
    Document   : my-courses
    Created on : Mar 6, 2026
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${empty myEnrollments}">
        <div class="text-center">
            <div class="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="material-symbols-outlined text-slate-300">menu_book</span>
            </div>

            <h3 class="font-bold mb-2">Chưa có khóa học nào</h3>
            <p class="text-slate-500 text-sm mb-4">
                Hãy khám phá danh mục và đăng ký khóa học đầu tiên của bạn!
            </p>

            <a href="${pageContext.request.contextPath}/shop"
               class="bg-[#10B981] text-white px-6 py-2 rounded-lg font-bold">
                Xem các khóa học
            </a>
        </div>
    </c:when>
 <c:otherwise>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${myEnrollments}" var="en">

                <div class="bg-white rounded-xl shadow-lg p-4 border border-slate-100 flex flex-col h-full hover:shadow-xl transition-shadow">

                    <img src="${en.courseId.thumbnailUrl}"
                         alt="${en.courseId.title}"
                         class="w-full h-40 object-cover rounded-lg mb-4">

                    <h3 class="font-bold text-slate-800 text-lg mb-2 line-clamp-2 flex-1">
                        ${en.courseId.title}
                    </h3>

                    <p class="text-xs text-slate-400 mb-4">
                        Đăng ký: ${en.formattedEnrollmentDate}
                    </p>

                    <a href="${pageContext.request.contextPath}/learn?id=${en.courseId.courseId}"
                       class="mt-auto flex justify-center items-center py-2.5 bg-[#10B981] text-white text-[15px] font-bold rounded-lg hover:bg-[#059669] transition-colors w-full">
                        Vào học ngay
                    </a>

                </div>

            </c:forEach>
        </div>
    </c:otherwise>
    
</c:choose>