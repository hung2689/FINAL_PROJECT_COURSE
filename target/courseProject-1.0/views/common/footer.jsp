<%@page contentType="text/html" pageEncoding="UTF-8" %>

<footer class="bg-white border-t border-slate-100 pt-16 pb-8 font-['Inter'] relative z-20">
    <div class="max-w-[1200px] mx-auto px-6 lg:px-12">
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-12 lg:gap-8 mb-16">
            
            <div class="lg:col-span-5 pr-0 lg:pr-12">
                <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 text-2xl font-black text-slate-900 hover:opacity-80 transition-opacity" style="text-decoration: none;">
                    <div class="w-8 h-8 bg-[#10B981] rounded-lg flex items-center justify-center text-white">
                        <span class="material-symbols-outlined text-[20px]">terminal</span>
                    </div>
                    DevLearn
                </a>
                
                <p class="text-slate-500 mt-6 leading-relaxed text-[15px] max-w-sm">
                    Accompanying thousands of students on their journey to becoming professional software engineers with practical curriculum.
                </p>

                <div class="flex items-center gap-3 mt-8">
                    <a href="#" class="w-10 h-10 rounded-full border border-slate-200 flex items-center justify-center text-slate-400 hover:text-[#10B981] hover:border-[#10B981] transition-all">
                        <span class="material-symbols-outlined text-[18px]">military_tech</span>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-full border border-slate-200 flex items-center justify-center text-slate-400 hover:text-[#10B981] hover:border-[#10B981] transition-all">
                        <span class="material-symbols-outlined text-[18px]">integration_instructions</span>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-full border border-slate-200 flex items-center justify-center text-slate-400 hover:text-[#10B981] hover:border-[#10B981] transition-all">
                        <span class="material-symbols-outlined text-[18px]">smart_display</span>
                    </a>
                </div>
            </div>

            <div class="lg:col-span-2">
                <h3 class="text-[13px] font-bold text-slate-900 tracking-widest uppercase mb-6">Courses</h3>
                <ul class="space-y-4">
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Frontend Development</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Backend Development</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Mobile Development</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Data Science & AI</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">DevOps & Cloud</a></li>
                </ul>
            </div>

            <div class="lg:col-span-2">
                <h3 class="text-[13px] font-bold text-slate-900 tracking-widest uppercase mb-6">Resources</h3>
                <ul class="space-y-4">
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Tech Blog</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Learning Community</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Free Materials</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">YouTube Channel</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">IT Podcast</a></li>
                </ul>
            </div>

            <div class="lg:col-span-3">
                <h3 class="text-[13px] font-bold text-slate-900 tracking-widest uppercase mb-6">Quick Links</h3>
                <ul class="space-y-4">
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">About Us</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Careers</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Terms of Service</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Privacy Policy</a></li>
                    <li><a href="#" class="text-[15px] text-slate-500 hover:text-[#10B981] transition-colors" style="text-decoration: none;">Contact</a></li>
                </ul>
            </div>

        </div>

        <div class="pt-8 border-t border-slate-100 flex flex-col md:flex-row justify-between items-center gap-6">
            <p class="text-[14px] text-slate-500">
                © 2024 DevLearn Academy. Built for the tech community.
            </p>
            
            <div class="flex items-center gap-8">
                <button class="flex items-center gap-2 text-[14px] text-slate-500 hover:text-slate-800 transition-colors">
                    <span class="material-symbols-outlined text-[18px]">language</span>
                    English
                </button>
                
                <a href="tel:19001234" class="flex items-center gap-2 text-[14px] text-slate-500 hover:text-slate-800 transition-colors" style="text-decoration: none;">
                    <span class="material-symbols-outlined text-[18px]">support_agent</span>
                    1900 1234
                </a>
            </div>
        </div>

    </div>
                    
                    
</footer>
                    
                                      
<button id="supportBtn" class="fixed bottom-8 right-8 w-14 h-14 bg-[#10B981] hover:bg-emerald-600 text-white rounded-full shadow-[0_8px_30px_rgb(0,0,0,0.12)] flex items-center justify-center transition-transform hover:scale-110 z-40 cursor-pointer border-none">
    <span class="material-symbols-outlined text-3xl">support_agent</span>
</button>

<div id="supportModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm transition-opacity">
    
    <div class="relative w-full max-w-lg mx-4 p-8 bg-white rounded-2xl shadow-2xl font-['Inter'] animate-[fadeIn_0.3s_ease-out]">
        
        <button id="closeModalBtn" class="absolute top-4 right-4 text-slate-400 hover:text-red-500 transition-colors bg-transparent border-none cursor-pointer">
            <span class="material-symbols-outlined text-2xl">close</span>
        </button>

        <h3 class="text-xl font-bold text-slate-900 mb-6 flex items-center gap-2">
            <span class="material-symbols-outlined text-[#10B981]">bug_report</span>
            Report an Issue
        </h3>
        
        <form action="${pageContext.request.contextPath}/submit-error" method="POST" enctype="multipart/form-data" class="space-y-5">
            
            <div>
                <label class="block text-[14px] font-medium text-slate-700 mb-2">
                    Describe the issue you are experiencing:
                </label>
                <textarea name="description" rows="4" required 
                    placeholder="Example: I'm getting a NullPointerException when trying to connect to the database..." 
                    class="w-full px-4 py-3 text-[14px] border border-slate-200 rounded-lg focus:outline-none focus:border-[#10B981] focus:ring-1 focus:ring-[#10B981] transition-colors resize-none"></textarea>
            </div>

            <div>
                <label class="block text-[14px] font-medium text-slate-700 mb-2">
                    Upload a screenshot:
                </label>
                <input type="file" name="errorImage" accept="image/*" required 
                    class="block w-full text-[14px] text-slate-500 
                    file:mr-4 file:py-2.5 file:px-4 file:rounded-lg file:border-0 
                    file:text-[14px] file:font-medium file:bg-emerald-50 file:text-[#10B981] 
                    hover:file:bg-emerald-100 transition-colors cursor-pointer outline-none">
            </div>

            <button type="submit" class="w-full bg-[#10B981] hover:bg-emerald-600 text-white font-medium text-[15px] px-4 py-3.5 rounded-lg transition-all shadow-md hover:shadow-lg mt-2 cursor-pointer border-none">
                Submit Support Request
            </button>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const supportBtn = document.getElementById('supportBtn');
        const supportModal = document.getElementById('supportModal');
const closeModalBtn = document.getElementById('closeModalBtn');

        // Mở Modal khi bấm nút tai nghe
        supportBtn.addEventListener('click', () => {
            supportModal.classList.remove('hidden');
        });

        // Đóng Modal khi bấm nút X
        closeModalBtn.addEventListener('click', () => {
            supportModal.classList.add('hidden');
        });

        // Nâng cao: Đóng Modal khi click chuột ra vùng đen bên ngoài Form
        window.addEventListener('click', (e) => {
            if (e.target === supportModal) {
                supportModal.classList.add('hidden');
            }
        });
    });
</script>