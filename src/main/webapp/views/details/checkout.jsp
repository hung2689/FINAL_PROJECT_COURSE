<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Payment | DevLearn</title>
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
            .animate-delay-1 { animation-delay: 0.1s; }
            .animate-delay-2 { animation-delay: 0.2s; }
        </style>
    </head>
    <body class="bg-[#0F172A] font-['Inter'] text-white flex flex-col min-h-screen relative">
        <jsp:include page="../common/header.jsp" />
        <main class="flex-1 pt-[120px] pb-20 flex justify-center items-center">
            <div class="max-w-[500px] w-full px-6 animate-card">

                <div class="bg-white/5 border border-white/10 rounded-xl p-4 mb-6 text-center">
                    <p class="text-lg font-bold">Total Amount: <fmt:formatNumber value="${finalTotal}" pattern="#,###"/> VNĐ</p>
                </div>

                <div class="bg-[#0B1120] border border-white/10 rounded-3xl p-8 shadow-2xl text-center">
                    <div class="w-20 h-20 bg-[#10B981]/10 rounded-full flex items-center justify-center mx-auto mb-5 border border-[#10B981]/20">
                        <span class="material-symbols-outlined text-[#10B981] text-[40px]">qr_code_scanner</span>
                    </div>

                    <h2 class="text-2xl font-black text-white mb-3">Secure Payment</h2>
                    <p class="text-slate-400 mb-8 text-[15px] leading-relaxed">
                        The system will automatically generate a QR code via <b>payOS</b>. Simply use your Banking App to scan the code, and your order will be confirmed instantly!
                    </p>

                    <form action="${pageContext.request.contextPath}/payos-payment" method="GET" class="w-full">

                       

                        <input type="hidden" name="amount" value="${finalTotal}" />
                        <input type="hidden" name="orderId" value="${orderId}" />

                        <button type="submit"
                                class="w-full flex justify-center items-center gap-2 py-4 bg-[#10B981] text-white text-[16px] font-bold rounded-xl hover:bg-[#059669] shadow-lg shadow-[#10B981]/30 transition-all duration-300">
                            Proceed to Scan QR
                        </button>

                    </form>

                </div>

                <a href="${pageContext.request.contextPath}/cart" class="flex items-center justify-center gap-2 mt-8 text-slate-400 hover:text-white transition-colors text-sm">
                    <span class="material-symbols-outlined text-sm">arrow_back</span>
                    Back to Cart
                </a>
            </div>
        </main>
    </body>
</html>