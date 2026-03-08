<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <aside class="w-64 bg-sidebar-dark text-slate-400 flex flex-col fixed h-full z-50">
        <div class="p-6 flex items-center gap-3">
            <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
                <span class="material-icons text-background-dark text-xl font-bold">school</span>
            </div>
            <span class="text-white font-bold text-xl tracking-tight">DevLearn</span>
        </div>
        <nav class="flex-1 px-4 space-y-1 mt-4">
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'dashboard' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="${pageContext.request.contextPath}/home">
                <span class="material-icons text-xl">dashboard</span>
                <span class="font-medium">Dashboard</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'courses' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="${pageContext.request.contextPath}/courseAdmin">
                <span class="material-icons text-xl">library_books</span>
                <span class="font-medium">Course Management</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'users' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="${pageContext.request.contextPath}/userAdmin">
                <span class="material-icons text-xl">people</span>
                <span class="font-medium">Users</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'categories' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="#">
                <span class="material-icons text-xl">category</span>
                <span class="font-medium">Categories</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'transactions' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="#">
                <span class="material-icons text-xl">payments</span>
                <span class="font-medium">Transactions</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'reports' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="#">
                <span class="material-icons text-xl">assessment</span>
                <span class="font-medium">Reports</span>
            </a>
        </nav>
        <div class="p-4 border-t border-slate-800">
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg ${activeMenu == 'settings' ? 'bg-primary/10 text-primary border-r-4 border-primary' : 'hover:bg-slate-800'} transition-colors"
                href="#">
                <span class="material-icons text-xl">settings</span>
                <span class="font-medium">Settings</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-red-500/10 text-red-400 transition-colors"
                href="#">
                <span class="material-icons text-xl">logout</span>
                <span class="font-medium">Logout</span>
            </a>
        </div>
    </aside>

     <style>
         .admin-main {
            opacity: 0;
            transform: translateX(12px);
            animation: adminPageIn 0.3s ease-out forwards;
        }

        @keyframes adminPageIn {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .admin-main.page-leaving {
            animation: adminPageOut 0.25s ease-in forwards;
        }

        @keyframes adminPageOut {
            to {
                opacity: 0;
                transform: translateX(-12px);
            }
        }
    </style>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // Tag the main content area for animation
        var main = document.querySelector('main.flex-1');
        if (main) main.classList.add('admin-main');

        // Intercept sidebar navigation clicks for smooth transition
        var aside = document.querySelector('aside');
        if (!aside) return;

        aside.addEventListener('click', function (e) {
            var link = e.target.closest('a');
            if (!link) return;

            var href = link.getAttribute('href');
            // Skip non-navigation links
            if (!href || href === '#' || href.startsWith('javascript:')) return;
            if (link.target === '_blank') return;
            if (link.hostname && link.hostname !== location.hostname) return;

            e.preventDefault();

            // Fade-out the main content, then navigate
            if (main) {
                main.classList.add('page-leaving');
                setTimeout(function () { window.location.href = href; }, 250);
            } else {
                window.location.href = href;
            }
        });
    });
    </script>