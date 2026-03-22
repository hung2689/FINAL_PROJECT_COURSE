<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Room - ${exam.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        brand: {
                            50: '#ecfdf5',
                            100: '#d1fae5',
                            500: '#10b981',
                            600: '#059669',
                            900: '#064e3b',
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-slate-50 text-slate-900 h-screen flex flex-col overflow-hidden select-none">
    
    <!-- Topbar -->
    <header class="bg-white border-b border-slate-200 h-16 flex items-center justify-between px-6 shrink-0 shadow-sm z-50">
        <div class="flex items-center gap-4">
            <div class="w-10 h-10 bg-brand-100 text-brand-600 rounded-xl flex items-center justify-center">
                <span class="material-symbols-outlined text-xl">quiz</span>
            </div>
            <div>
                <h1 class="font-bold text-slate-800 line-clamp-1 max-w-[300px] md:max-w-md">${exam.title}</h1>
                <p class="text-xs text-slate-500">Attempt ID: #${attempt.attemptId}</p>
            </div>
        </div>
        
        <div class="flex items-center gap-6">
            <div class="flex items-center gap-2 bg-red-50 text-red-600 px-4 py-2 rounded-lg border border-red-100 font-mono text-xl md:text-2xl font-bold tracking-wider shadow-inner" id="timerDisplay">
                00:00:00
            </div>
            
            <button onclick="document.getElementById('examForm').submit();" class="bg-brand-600 hover:bg-brand-700 text-white px-6 py-2.5 rounded-xl font-semibold transition flex items-center gap-2 shadow-lg shadow-brand-500/30">
                <span class="material-symbols-outlined text-[20px]">send</span>
                Submit
            </button>
        </div>
    </header>

    <!-- Main Content -->
    <form id="examForm" action="${pageContext.request.contextPath}/exam-room" method="POST" class="flex flex-1 overflow-hidden">
        <input type="hidden" name="attemptId" value="${attempt.attemptId}">
        
        <!-- Sidebar Navigation -->
        <aside class="w-72 bg-white border-r border-slate-200 flex flex-col shrink-0 custom-scrollbar overflow-y-auto">
            <div class="p-4 border-b border-slate-100 bg-slate-50/50">
                <h2 class="font-bold text-slate-700 flex items-center gap-2">
                    <span class="material-symbols-outlined">grid_view</span>
                    Question List
                </h2>
                <div class="mt-2 text-sm text-slate-500 flex justify-between">
                    <span>Answered: <b id="answeredCount" class="text-brand-600">0</b>/${questions.size()}</span>
                </div>
            </div>
            
            <div class="p-4 grid grid-cols-5 gap-2">
                <c:forEach var="q" items="${questions}" varStatus="loop">
                    <button type="button" onclick="scrollToQuestion(${q.questionId})" id="navBtn_${q.questionId}"
                            class="aspect-square rounded-lg border border-slate-200 text-sm font-medium flex items-center justify-center transition-colors hover:border-brand-500 hover:text-brand-600">
                        ${loop.index + 1}
                    </button>
                </c:forEach>
            </div>
            
            <!-- ─── AI Anti-Cheat Screen Monitor ───────────────── -->
            <div class="mt-auto m-4 space-y-3">
                <div class="bg-slate-900 rounded-xl overflow-hidden shadow-lg border border-slate-700 relative">
                    <video id="screenVideo" autoplay playsinline muted class="w-full aspect-video object-cover"></video>
                    <canvas id="screenCanvas" class="hidden"></canvas>
                    <!-- Status indicator -->
                    <div id="acStatusDot" class="absolute top-2 right-2 flex items-center gap-1.5 bg-black/60 backdrop-blur-sm px-2 py-1 rounded-full">
                        <span class="w-2 h-2 rounded-full bg-green-400 animate-pulse"></span>
                        <span class="text-[10px] text-green-300 font-medium">MONITORING</span>
                    </div>
                </div>
                <div id="acWarningBar" class="p-3 bg-amber-50 border border-amber-200 rounded-xl">
                    <p class="text-xs text-amber-800 font-medium flex gap-2 items-center">
                        <span class="material-symbols-outlined text-sm">screen_search_desktop</span>
                        <span id="acWarningText">AI anti-cheat is active. Screen is being monitored.</span>
                    </p>
                    <div class="mt-2 flex gap-1" id="acWarningDots">
                        <span class="w-2 h-2 rounded-full bg-slate-300" id="acDot1"></span>
                        <span class="w-2 h-2 rounded-full bg-slate-300" id="acDot2"></span>
                        <span class="w-2 h-2 rounded-full bg-slate-300" id="acDot3"></span>
                    </div>
                </div>
            </div>
        </aside>

        <!-- Question View -->
        <main class="flex-1 bg-slate-50 p-6 md:p-10 overflow-y-auto custom-scrollbar" id="questionContainer" oncontextmenu="return false;">
            <div class="max-w-3xl mx-auto space-y-8 pb-32">
                <c:forEach var="q" items="${questions}" varStatus="loop">
                    <div id="qBlock_${q.questionId}" class="bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
                        <div class="flex gap-4 mb-6">
                            <div class="w-10 h-10 shrink-0 bg-slate-100 rounded-lg flex items-center justify-center font-bold text-slate-500 text-lg">
                                ${loop.index + 1}
                            </div>
                            <div class="text-lg text-slate-800 leading-relaxed pt-1 font-medium">
                                ${q.content}
                            </div>
                        </div>
                        
                        <div class="space-y-3 pl-14">
                            <c:forEach var="opt" items="A,B,C,D" varStatus="optLoop">
                                <c:set var="optContent" value="${optLoop.index == 0 ? q.optionA : (optLoop.index == 1 ? q.optionB : (optLoop.index == 2 ? q.optionC : q.optionD))}"/>
                                
                                <label class="flex items-start gap-3 p-4 rounded-xl border border-slate-200 hover:bg-slate-50 hover:border-brand-300 cursor-pointer transition-all has-[:checked]:border-brand-500 has-[:checked]:bg-brand-50 has-[:checked]:shadow-sm">
                                    <div class="pt-0.5">
                                        <input type="radio" name="q_${q.questionId}" value="${opt}" onchange="markAnswered(${q.questionId})" class="w-4 h-4 text-brand-600 focus:ring-brand-500 border-slate-300">
                                    </div>
                                    <span class="font-semibold text-slate-700 w-6">${opt}.</span>
                                    <span class="text-slate-600 flex-1 leading-snug">${optContent}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </form>

    <script>
        // ═══════════════════════════════════════════════════════════════
        //  1. ANTI-CHEAT: Tab Switching Detection
        // ═══════════════════════════════════════════════════════════════
        let cheatCount = 0;
        document.addEventListener("visibilitychange", () => {
            if (document.hidden) {
                cheatCount++;
                if (cheatCount >= 3) {
                    Swal.fire('Violation!', 'You have switched tabs too many times. Your exam will be auto-submitted.', 'error')
                    .then(() => document.getElementById('examForm').submit());
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Cheating Warning!',
                        text: 'You just left the exam screen. If you do this ' + (3 - cheatCount) + ' more time(s), your exam will be auto-submitted!'
                    });
                }
            }
        });

        // ═══════════════════════════════════════════════════════════════
        //  2. ANTI-CHEAT: AI Screen Monitoring (YOLO Integration)
        // ═══════════════════════════════════════════════════════════════
        const AC_INTERVAL_MS = 3000;            // Screenshot every 3 seconds
        const DETECT_ENDPOINT = '${pageContext.request.contextPath}/detect-cheat';

        let acIntervalId = null;
        let acSending = false;  // prevent overlapping requests

        // ── Start screen capture ──
        async function initScreenCapture() {
            const video = document.getElementById('screenVideo');
            try {
                // Hint for entire screen
                const stream = await navigator.mediaDevices.getDisplayMedia({
                    video: {
                        cursor: 'always',
                        displaySurface: 'monitor'
                    },
                    audio: false
                });

                // Enforce Entire Screen check
                const videoTrack = stream.getVideoTracks()[0];
                const settings = videoTrack.getSettings();
                
                if (settings.displaySurface !== 'monitor') {
                    videoTrack.stop();
                    Swal.fire({
                        icon: 'error',
                        title: 'Full Screen Required!',
                        text: 'You MUST select "Entire Screen" to share. Tabs or Windows are not allowed for anti-cheat.',
                        confirmButtonText: 'Try Again',
                        allowOutsideClick: false,
                        allowEscapeKey: false
                    }).then(() => {
                        initScreenCapture(); // Prompt again
                    });
                    return;
                }

                video.srcObject = stream;
                await video.play();
                console.log('✅ [AntiCheat] Screen capture started');

                // If user stops sharing screen → auto-submit exam
                stream.getVideoTracks()[0].addEventListener('ended', () => {
                    console.warn('⚠️ [AntiCheat] Screen sharing stopped by user');
                    stopAntiCheatLoop();
                    updateACStatus('error', 'SHARE STOPPED');
                    Swal.fire({
                        icon: 'error',
                        title: 'Screen Sharing Required!',
                        text: 'You stopped sharing your screen. The exam will be auto-submitted.',
                        allowOutsideClick: false,
                        allowEscapeKey: false
                    }).then(() => document.getElementById('examForm').submit());
                });

                startAntiCheatLoop();
            } catch (err) {
                console.warn('⚠️ [AntiCheat] Screen capture denied:', err.message);
                updateACStatus('error', 'DENIED');
                Swal.fire({
                    icon: 'error',
                    title: 'Screen Sharing Required!',
                    text: 'You must share your screen to take this exam. The exam will be auto-submitted.',
                    allowOutsideClick: false,
                    allowEscapeKey: false
                }).then(() => document.getElementById('examForm').submit());
            }
        }

        // ── Capture a screenshot from the video stream as a Blob ──
        function captureScreenshot() {
            const video = document.getElementById('screenVideo');
            const canvas = document.getElementById('screenCanvas');
            if (!video || video.readyState < 2) return null;

            canvas.width = video.videoWidth || 1280;
            canvas.height = video.videoHeight || 720;
            const ctx = canvas.getContext('2d');
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

            return new Promise(resolve => {
                canvas.toBlob(blob => resolve(blob), 'image/jpeg', 0.75);
            });
        }

        // ── Send screenshot to /detect-cheat ──
        async function sendToAntiCheat() {
            if (acSending) return;
            acSending = true;

            try {
                const blob = await captureScreenshot();
                if (!blob) { acSending = false; return; }

                const formData = new FormData();
                formData.append('file', blob, 'screenshot.jpg');
                formData.append('attemptId', '${attempt.attemptId}');

                const resp = await fetch(DETECT_ENDPOINT, {
                    method: 'POST',
                    body: formData
                });

                if (!resp.ok) {
                    console.error('[AntiCheat] Server error:', resp.status);
                    acSending = false;
                    return;
                }

                const data = await resp.json();
                handleAntiCheatResult(data);

            } catch (err) {
                console.error('[AntiCheat] Fetch error:', err);
            } finally {
                acSending = false;
            }
        }

        // ── Handle detection result from backend ──
        function handleAntiCheatResult(data) {
            // Update warning dots
            const warnings = data.warnings || 0;
            for (let i = 1; i <= 3; i++) {
                const dot = document.getElementById('acDot' + i);
                if (dot) {
                    dot.className = i <= warnings
                        ? 'w-2 h-2 rounded-full bg-red-500'
                        : 'w-2 h-2 rounded-full bg-slate-300';
                }
            }

            // Handle degraded mode (AI server down)
            if (data.degraded) {
                updateACStatus('warn', 'AI OFFLINE');
                return;
            }

            // Handle blocked – auto submit exam
            if (data.blocked) {
                stopAntiCheatLoop();
                updateACStatus('error', 'BLOCKED');
                document.getElementById('acWarningText').textContent = data.message;
                Swal.fire({
                    icon: 'error',
                    title: 'Exam Blocked!',
                    text: data.message,
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    confirmButtonText: 'OK'
                }).then(() => {
                    document.getElementById('examForm').submit();
                });
                return;
            }

            // Handle warning
            if (data.cheatingDetected) {
                updateACStatus('warn', 'WARNING ' + data.warnings + '/3');
                document.getElementById('acWarningText').textContent = data.message;
                document.getElementById('acWarningBar').className =
                    'p-3 bg-red-50 border border-red-300 rounded-xl transition-colors';
                Swal.fire({
                    icon: 'warning',
                    title: 'Suspicious Activity Detected!',
                    html: '<b>' + data.message + '</b><br><br>Suspicious activity detected on your screen.',
                    timer: 4000,
                    timerProgressBar: true,
                    showConfirmButton: false
                });
                // Reset bar color after a few seconds
                setTimeout(() => {
                    document.getElementById('acWarningBar').className =
                        'p-3 bg-amber-50 border border-amber-200 rounded-xl transition-colors';
                }, 5000);
            } else {
                updateACStatus('ok', 'MONITORING');
            }
        }

        function updateACStatus(level, text) {
            const dot = document.querySelector('#acStatusDot span:first-child');
            const label = document.querySelector('#acStatusDot span:last-child');
            label.textContent = text;
            dot.className = 'w-2 h-2 rounded-full animate-pulse ';
            switch (level) {
                case 'ok':    dot.className += 'bg-green-400'; label.className = 'text-[10px] text-green-300 font-medium'; break;
                case 'warn':  dot.className += 'bg-yellow-400'; label.className = 'text-[10px] text-yellow-300 font-medium'; break;
                case 'error': dot.className += 'bg-red-500'; label.className = 'text-[10px] text-red-300 font-medium'; break;
            }
        }

        function startAntiCheatLoop() {
            sendToAntiCheat(); // fire immediately on first load
            acIntervalId = setInterval(sendToAntiCheat, AC_INTERVAL_MS);
        }

        function stopAntiCheatLoop() {
            if (acIntervalId) { clearInterval(acIntervalId); acIntervalId = null; }
        }

        // Initialize screen capture when page loads
        document.addEventListener('DOMContentLoaded', initScreenCapture);

        // ═══════════════════════════════════════════════════════════════
        //  3. TIMER Logic
        // ═══════════════════════════════════════════════════════════════
        const durationMinutes = ${exam.durationMinutes};
        const startedAt = new Date("${attempt.startedAt}").getTime();
        const endTime = startedAt + (durationMinutes * 60 * 1000);
        
        const timerDisplay = document.getElementById('timerDisplay');
        
        const timerInterval = setInterval(() => {
            const now = new Date().getTime();
            const distance = endTime - now;
            
            if (distance < 0) {
                clearInterval(timerInterval);
                stopAntiCheatLoop();
                timerDisplay.innerHTML = "00:00:00";
                Swal.fire('Time is up!', 'Your exam is being auto-submitted...', 'info')
                .then(() => document.getElementById('examForm').submit());
                return;
            }
            
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            timerDisplay.innerHTML = 
                String(hours).padStart(2, '0') + ":" + 
                String(minutes).padStart(2, '0') + ":" + 
                String(seconds).padStart(2, '0');
                
            if (distance < 300000) {
                timerDisplay.classList.add('animate-pulse');
            }
        }, 1000);

        // ═══════════════════════════════════════════════════════════════
        //  4. UI Interactions
        // ═══════════════════════════════════════════════════════════════
        function scrollToQuestion(qId) {
            document.getElementById('qBlock_' + qId).scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        
        function markAnswered(qId) {
            const btn = document.getElementById('navBtn_' + qId);
            if (!btn.classList.contains('bg-brand-500')) {
                btn.classList.add('bg-brand-500', 'text-white', 'border-brand-500');
                btn.classList.remove('border-slate-200', 'text-slate-700');
            }
            const answered = document.querySelectorAll('main input[type="radio"]:checked').length;
            document.getElementById('answeredCount').innerText = answered;
        }
        
        // Disable copy paste
        document.addEventListener('copy', function(e) {
            e.preventDefault();
            return false;
        });

        // Cleanup screen capture on page unload
        window.addEventListener('beforeunload', () => {
            stopAntiCheatLoop();
            const video = document.getElementById('screenVideo');
            if (video && video.srcObject) {
                video.srcObject.getTracks().forEach(t => t.stop());
            }
        });
    </script>
    
    <style>
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</body>
</html>
