<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <style>
        /* Global Glass Header CSS to ensure it works beautifully on any page */
        .glass-header-nav {
            background: rgba(15, 23, 42, 0.65);
            background-image: linear-gradient(135deg, rgba(15, 23, 42, 0.85) 0%, rgba(6, 78, 59, 0.5) 50%, rgba(15, 23, 42, 0.85) 100%);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }
    </style>

    <header class="fixed top-0 left-0 w-full z-50 glass-header-nav">
        <div class="max-w-[1200px] w-full mx-auto px-6 lg:px-12 py-5 flex items-center justify-between">
            <div class="flex items-center gap-12 w-full">

                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 group cursor-pointer"
                    style="text-decoration: none;">
                    <div class="w-10 h-10 rounded-xl flex items-center justify-center text-[#101b0d] transition-transform group-hover:scale-105 duration-300"
                        style="background: #10B981; box-shadow: 0 4px 20px rgba(16, 185, 129, 0.25);">
                        <span class="material-symbols-outlined text-2xl font-bold">terminal</span>
                    </div>
                    <h2 class="text-2xl font-black tracking-tight text-white m-0">DevLearn</h2>
                </a>

                <!-- Navigation Links -->
                <nav class="hidden lg:flex items-center gap-8">
                    <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                        href="${pageContext.request.contextPath}/home">Home</a>
                    <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                        href="${pageContext.request.contextPath}/shop">Courses</a>
                    <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                        href="#">Learning Paths</a>
                    <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                        href="#">Community</a>
                    <a class="text-[15px] font-medium text-white/80 hover:text-[#10B981] transition-colors duration-300"
                        href="#">About Us</a>
                </nav>
            </div>
        </div>
    </header>