<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Complete Profile - CourseIT</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#10B981",
                        "primary-hover": "#059669"
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"]
                    }
                },
            },
        }
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f3f4f6; }
        .glass-panel {
            background: #ffffff;
            border-radius: 1.25rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            border: 1px solid #e5e7eb;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-6">
    
    <div class="w-full max-w-md">
        <!-- Logo -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center gap-2 text-primary">
                <span class="material-icons text-4xl">rocket_launch</span>
                <span class="text-3xl font-extrabold tracking-tight text-slate-900">CourseIT</span>
            </div>
        </div>

        <div class="glass-panel p-8 sm:p-10 relative overflow-hidden">
            <!-- Top Accent Line -->
            <div class="absolute top-0 left-0 w-full h-1.5 bg-primary"></div>

            <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-slate-900 mb-1">Complete Profile</h2>
                <p class="text-slate-500 text-sm">Please verify your details to continue.</p>
            </div>

            <form action="${pageContext.request.contextPath}/complete-profile" method="POST" class="space-y-5">
                <!-- Default Role (Hidden) -->
                <input type="hidden" name="role" value="STUDENT"/>

                <div class="flex items-center justify-center gap-2 mb-6 bg-slate-50 rounded-lg p-2 border border-slate-200">
                    <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google" class="w-5 h-5"/>
                    <span class="text-sm font-medium text-slate-700">Linked to Google</span>
                </div>

                <!-- Email Field (Readonly) -->
                <div class="space-y-1">
                    <label class="text-xs font-semibold text-slate-600 uppercase tracking-widest">Email Address</label>
                    <div class="relative flex items-center bg-slate-100 rounded-lg px-3 py-2.5 border border-slate-200 opacity-80 cursor-not-allowed">
                        <span class="material-icons text-slate-400 mr-2 text-lg">mail</span>
                        <input class="w-full bg-transparent border-none p-0 text-slate-500 focus:ring-0 text-sm font-medium" 
                               readonly="" type="email" value="${USER.email}"/>
                    </div>
                </div>

                <!-- Username Field -->
                <div class="space-y-1">
                    <div class="flex justify-between items-end">
                        <label class="text-xs font-semibold text-slate-700 uppercase tracking-widest">Username <span class="text-red-500">*</span></label>
                        <c:if test="${not empty ERROR}">
                            <span class="text-xs text-red-500 font-bold">${ERROR}</span>
                        </c:if>
                    </div>
                    <div class="relative flex items-center bg-white rounded-lg px-3 py-2.5 border ${not empty ERROR ? 'border-red-400 ring-2 ring-red-100' : 'border-slate-300'} focus-within:border-primary focus-within:ring-2 focus-within:ring-primary/20 transition-all">
                        <span class="material-icons text-slate-400 mr-2 text-lg">account_circle</span>
                        <input required name="username" 
                               class="w-full bg-transparent border-none p-0 text-slate-900 focus:ring-0 text-sm font-medium placeholder-slate-400" 
                               placeholder="e.g. johndoe" type="text" autocomplete="off"/>
                    </div>
                </div>

                <!-- Full Name Field -->
                <div class="space-y-1">
                    <label class="text-xs font-semibold text-slate-700 uppercase tracking-widest">Full Name <span class="text-red-500">*</span></label>
                    <div class="relative flex items-center bg-white rounded-lg px-3 py-2.5 border border-slate-300 focus-within:border-primary focus-within:ring-2 focus-within:ring-primary/20 transition-all">
                        <span class="material-icons text-slate-400 mr-2 text-lg">badge</span>
                        <input required name="fullname" 
                               class="w-full bg-transparent border-none p-0 text-slate-900 focus:ring-0 text-sm font-medium placeholder-slate-400" 
                               placeholder="e.g. John Doe" type="text" value="${USER.fullName}" autocomplete="off"/>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="pt-4">
                    <button class="w-full bg-primary hover:bg-primary-hover text-white font-bold py-3.5 px-4 rounded-lg transition-colors flex items-center justify-center gap-2" type="submit">
                        Complete & Continue
                        <span class="material-icons text-lg">arrow_forward</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>