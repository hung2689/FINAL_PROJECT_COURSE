<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>body { font-family: 'Inter', sans-serif; }</style>

<div class="p-8 bg-slate-50 min-h-screen">
    <div class="flex justify-between items-start mb-8">
        <div>
            <div class="flex items-center gap-4 mb-2">
                <a href="${pageContext.request.contextPath}/courseAdmin" 
                   class="flex items-center justify-center w-10 h-10 bg-white border border-slate-200 rounded-xl text-slate-400 hover:text-emerald-500 hover:border-emerald-500 transition-all shadow-sm"
                   title="Back to Admin Dashboard">
                    <span class="material-symbols-outlined">arrow_back</span>
                </a>
                <h2 class="text-3xl font-black text-slate-900 tracking-tight">Support Requests</h2>
            </div>
            <p class="text-slate-500 ml-14 font-medium">Monitoring real-time student technical issues.</p>
        </div>
        
        <div class="bg-emerald-50 border border-emerald-100 px-4 py-2 rounded-2xl">
            <span class="text-[11px] font-black text-emerald-600 uppercase tracking-widest block">Server Status</span>
            <span class="text-emerald-500 font-bold text-sm flex items-center gap-1">
                <span class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></span> Systems Active
            </span>
        </div>
    </div>

    <div class="bg-white rounded-[32px] shadow-[0_8px_30px_rgb(0,0,0,0.04)] border border-slate-100 overflow-hidden">
        <table class="w-full text-left border-collapse">
            <thead>
                <tr class="bg-slate-50/50 text-slate-400 text-[11px] uppercase tracking-[0.15em] font-black">
                    <th class="p-6">Student Info</th>
                    <th class="p-6">Issue Description</th>
                    <th class="p-6 text-center">Screenshot</th>
                    <th class="p-6 text-center">Status</th>
                    <th class="p-6 text-right">Action</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
                <c:forEach items="${errorList}" var="report">
                    <tr class="hover:bg-slate-50/50 transition-all duration-200 group">
                        <td class="p-6">
                            <div class="font-bold text-slate-900">${report.studentName}</div>
                            <div class="text-[12px] text-slate-400 font-medium">
                                <fmt:formatDate value="${report.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </td>
                        <td class="p-6">
                            <p class="text-[14px] text-slate-600 max-w-xs truncate font-medium" title="${report.description}">
                                ${report.description}
                            </p>
                        </td>
                        <td class="p-6">
                            <div class="flex justify-center">
                                <a href="${pageContext.request.contextPath}/${report.imagePath}" target="_blank" class="block w-12 h-12 relative group/img">
                                    <img src="${pageContext.request.contextPath}/${report.imagePath}" 
                                         onerror="this.src='https://placehold.co/100x100?text=No+Image'"
                                         class="w-full h-full object-cover rounded-xl border-2 border-white shadow-sm group-hover/img:scale-110 transition-transform cursor-zoom-in">
                                </a>
                            </div>
                        </td>
                        <td class="p-6 text-center">
                            <span class="px-3 py-1 rounded-full text-[10px] font-black tracking-widest uppercase
                                ${report.status == 'PENDING' ? 'bg-amber-100 text-amber-600' : 'bg-emerald-100 text-emerald-600'}">
                                ${report.status}
                            </span>
                        </td>
                        <td class="p-6 text-right">
                            <button data-id="${report.id}" 
                                    data-student="${report.studentName}" 
                                    data-desc="${report.description}" 
                                    data-img="${report.imagePath}" 
                                    data-status="${report.status}"
                                    onclick="openDetails(this)" 
                                    class="bg-slate-900 text-white hover:bg-emerald-500 px-5 py-2 rounded-xl text-xs font-bold transition-all shadow-lg shadow-slate-200 hover:shadow-emerald-200 cursor-pointer border-none">
                                Details
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty errorList}">
            <div class="p-20 text-center">
                <span class="material-symbols-outlined text-6xl text-slate-200">auto_awesome</span>
                <p class="text-slate-400 mt-4 font-bold">Inbox is clear. No new reports!</p>
            </div>
        </c:if>
    </div>
</div>

<div id="detailsModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/60 backdrop-blur-md p-4 transition-all">
    <div class="bg-white w-full max-w-3xl rounded-[40px] shadow-2xl overflow-hidden animate-[fadeIn_0.3s_ease-out]">
        <div class="px-10 py-8 flex justify-between items-center border-b border-slate-50">
            <div>
                <h3 class="text-2xl font-black text-slate-900">Issue Ticket <span id="modalId" class="text-emerald-500 ml-2"></span></h3>
                <p class="text-sm text-slate-400 font-medium">Reviewing student reported error</p>
            </div>
            <button onclick="closeDetails()" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-red-50 text-slate-400 hover:text-red-500 transition-colors border-none cursor-pointer">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div class="p-10 grid grid-cols-1 md:grid-cols-2 gap-10">
            <div class="space-y-6">
                <div>
                    <label class="text-[11px] font-black uppercase tracking-[0.2em] text-emerald-500 mb-2 block">Student Name</label>
                    <p id="modalStudent" class="text-xl font-extrabold text-slate-900"></p>
                </div>
                <div>
                    <label class="text-[11px] font-black uppercase tracking-[0.2em] text-emerald-500 mb-2 block">Issue Description</label>
                    <div id="modalDesc" class="text-slate-600 text-[15px] leading-relaxed bg-slate-50 p-6 rounded-3xl border border-slate-100 min-h-[120px] font-medium italic"></div>
                </div>
            </div>
            <div>
                <label class="text-[11px] font-black uppercase tracking-[0.2em] text-emerald-500 mb-2 block text-center">Screenshot</label>
                <a id="modalImgLink" href="#" target="_blank" class="block group">
                    <img id="modalImg" src="" class="w-full h-[280px] object-cover rounded-[32px] shadow-lg group-hover:opacity-90 transition-all border border-slate-200">
                </a>
            </div>
        </div>

        <div class="px-10 py-8 bg-slate-50/50 border-t border-slate-100 flex justify-end gap-4">
            <button onclick="closeDetails()" class="px-8 py-3 text-slate-500 font-bold hover:bg-white rounded-2xl transition-all border-none cursor-pointer">Close</button>
            <form action="${pageContext.request.contextPath}/update-report-status" method="POST">
                <input type="hidden" name="reportId" id="inputReportId">
                <button id="btnResolve" type="submit" class="px-10 py-3 bg-emerald-500 hover:bg-emerald-600 text-white font-black rounded-2xl shadow-xl shadow-emerald-100 transition-all border-none cursor-pointer">
                    Mark as Resolved
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    function openDetails(btn) {
        // Lấy dữ liệu an toàn 100%
        const id = btn.getAttribute('data-id');
        const student = btn.getAttribute('data-student');
        const desc = btn.getAttribute('data-desc');
        const img = btn.getAttribute('data-img');
        const status = btn.getAttribute('data-status');

        document.getElementById('modalId').innerText = '#' + id;
        document.getElementById('inputReportId').value = id;
        document.getElementById('modalStudent').innerText = student;
        document.getElementById('modalDesc').innerText = desc;
        
        // Xử lý lại đường dẫn ảnh đề phòng lỗi HĐH Windows
        const cleanImgPath = img.replace(/\\/g, '/'); 
        const fullImgUrl = '${pageContext.request.contextPath}/' + cleanImgPath;
        
        document.getElementById('modalImg').src = fullImgUrl;
        document.getElementById('modalImgLink').href = fullImgUrl;
        
        const btnResolve = document.getElementById('btnResolve');
        if (status === 'RESOLVED') {
            btnResolve.classList.add('hidden');
        } else {
            btnResolve.classList.remove('hidden');
        }

        document.getElementById('detailsModal').classList.remove('hidden');
    }

    function closeDetails() {
        document.getElementById('detailsModal').classList.add('hidden');
    }
</script>