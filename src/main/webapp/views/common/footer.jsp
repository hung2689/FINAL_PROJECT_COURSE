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