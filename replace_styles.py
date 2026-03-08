import sys
import re

with open("src/main/webapp/views/details/course-detail.jsp", "r", encoding="utf-8") as f:
    content = f.read()

# 1. Replace Head & Config
head_pattern = re.compile(r'<head>.*?</head>', re.DOTALL)
new_head = """<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Course Details | DevLearn</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries,line-clamp"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <style type="text/tailwindcss">
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            font-size: 20px;
        }
        @layer base {
            body {
                @apply font-sans antialiased;
            }
        }
        details > summary::-webkit-details-marker {
            display: none;
        }
    </style>
</head>"""
content = head_pattern.sub(new_head, content)

# 2. Replace Body Tag
body_pattern = re.compile(r'<body class="bg-background-light.*?>', re.DOTALL)
new_body = '<body class="font-display transition-colors duration-300" style="background: linear-gradient(135deg, #f8fffc, #e6f7f1); color: #0f172a;">\n    <div class="relative flex min-h-screen w-full flex-col">'
content = body_pattern.sub(new_body, content)

# 3. Replace inline Header with global Header include
header_pattern = re.compile(r'<header class="sticky.*?</header>', re.DOTALL)
new_header = '<jsp:include page="../common/header.jsp" />'
content = header_pattern.sub(new_header, content)

# 4. Replace inline Footer with close wrapper & global userbuttom include
footer_pattern = re.compile(r'<footer class="mt-24.*</footer>', re.DOTALL)
new_footer = '</div>\n    <jsp:include page="../common/userbuttom.jsp" />'
content = footer_pattern.sub(new_footer, content)

# 5. Global styling replacements
replacements = {
    'max-w-[1440px]': 'max-w-canvas',
    'bg-[#f0f4f0]': 'bg-slate-100',
    'dark:bg-[#1d3519]': '',
    'text-accent-green': 'text-slate-500',
    'bg-primary-dark': 'bg-emerald-600',
    'bg-primary/10': 'bg-emerald-500/10',
    'bg-primary': 'bg-emerald-500 text-white',
    'text-primary-dark': 'text-emerald-700',
    'text-primary': 'text-[#10B981]',
    'dark:text-white': '',
    'dark:bg-background-dark': '',
    'dark:bg-surface-dark': '',
    'dark:border-[#1d3519]': '',
    'dark:text-gray-400': '',
    'dark:text-gray-300': '',
    'dark:text-gray-100': '',
    'dark:hover:bg-[#1d2d1b]': '',
    'border-[#e9f3e7]': 'border-emerald-100',
    'text-[#101b0d]': 'text-slate-900',
    'shadow-2xl shadow-primary/5': 'shadow-[0_20px_40px_-15px_rgba(16,185,129,0.2)]',
    'bg-black/40': 'bg-slate-900/40',
    'text-black': 'text-white',
    'hover:bg-[#fbfdfb]': 'hover:bg-emerald-50',
    'hover:bg-[#1d2d1b]': 'hover:bg-slate-800',
    'border-[#f0f4f0]': 'border-emerald-100',
    'class="light"': ''
}

for old, new in replacements.items():
    content = content.replace(old, new)

content = content.replace('</body></html>', '</body>\n</html>')

with open("src/main/webapp/views/details/course-detail.jsp", "w", encoding="utf-8") as f:
    f.write(content)

print("Replacement Complete")
