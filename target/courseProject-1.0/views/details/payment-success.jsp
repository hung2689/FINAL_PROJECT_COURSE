<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Payment Successful | DevLearn</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <style>
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-card {
            animation: fadeInUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) both;
        }
    </style>
</head>
<body class="bg-[#0F172A] font-['Inter'] text-white flex flex-col min-h-screen relative overflow-hidden">

    <jsp:include page="../common/header.jsp" />

    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-[#10B981]/20 rounded-full blur-[120px] -z-10 pointer-events-none"></div>

    <main class="flex-1 flex justify-center items-center px-6 pt-[120px] pb-20 z-10">
        <div class="bg-[#0B1120]/80 backdrop-blur-xl border border-white/10 rounded-3xl p-10 shadow-[0_20px_60px_-15px_rgba(0,0,0,0.5)] max-w-[480px] w-full text-center transform transition-all hover:scale-[1.02] duration-500 animate-card">
            
            <div class="w-24 h-24 bg-gradient-to-tr from-[#059669] to-[#34d399] rounded-full flex items-center justify-center mx-auto mb-6 shadow-[0_0_30px_rgba(16,185,129,0.4)]">
                <span class="material-symbols-outlined text-[48px] text-white" style="font-variation-settings: 'wght' 700;">check</span>
            </div>

            <h1 class="text-3xl font-black text-white mb-3">Thanh toán thành công!</h1>
            <p class="text-slate-400 mb-10 text-[15px] leading-relaxed">
                Cảm ơn bạn đã đăng ký khóa học tại DevLearn. Hóa đơn và chi tiết khóa học đã được gửi vào email của bạn. Bạn có thể bắt đầu học ngay bây giờ!
            </p>

            <a href="${pageContext.request.contextPath}/shop" class="block w-full py-4 bg-white text-[#0F172A] font-black text-[15px] rounded-xl hover:bg-slate-200 transition-colors shadow-lg" style="text-decoration: none;">
                Back to Courses
            </a>
            
            <a href="${pageContext.request.contextPath}/home" class="inline-block mt-5 text-sm text-slate-500 hover:text-white transition-colors" style="text-decoration: none;">
                Go to Homepage
            </a>

        </div>
    </main>

</body>
</html>