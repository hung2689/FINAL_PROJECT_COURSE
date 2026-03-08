import sys

jsp_path = r"d:\FPTU\semeter_4\PRJ\CourseITProject\src\main\webapp\views\details\course-detail.jsp"

with open(jsp_path, "rb") as f:
    raw = f.read()

sep = b"\r\n"
lines = raw.split(sep)
print(f"Total lines: {len(lines)}")

# 0-indexed lines 143 to 162 = 1-indexed lines 144 to 163
# Verify we're touching the right section
print("Line 144:", lines[143][:80])
print("Line 163:", lines[162][:80])

# New accordion block (1 <li> with <details>/<summary>)
new_lines = [
    b'                                                    <li class="border border-slate-100 rounded-lg bg-white">',
    b'                                                        <details class="group">',
    b'                                                            <summary class="flex items-center gap-3 cursor-pointer p-3 rounded-lg hover:bg-slate-50 transition-colors list-none select-none">',
    b'                                                                <span class="material-symbols-outlined text-slate-500 group-open:rotate-90 transition-transform duration-200 shrink-0">',
    b'                                                                    chevron_right',
    b'                                                                </span>',
    b'                                                                <span class="text-sm font-semibold text-slate-700">',
    b'                                                                    ${lessonDTO.lesson.orderIndex}. ${lessonDTO.lesson.title}',
    b'                                                                </span>',
    b'                                                            </summary>',
    b'                                                            <div class="pl-9 pr-3 pb-3 pt-1 flex flex-wrap gap-2">',
    b'                                                                <c:forEach var="resource" items="${lessonDTO.resources}">',
    b'                                                                    <span class="text-[10px] bg-emerald-100 text-emerald-700 px-2 py-1 rounded uppercase font-bold tracking-wider">',
    b'                                                                        ${resource.resourceType}<c:if test="${not empty resource.duration}"> (${resource.duration}s)</c:if>',
    b'                                                                    </span>',
    b'                                                                </c:forEach>',
    b'                                                            </div>',
    b'                                                        </details>',
    b'                                                    </li>',
]

# Replace lines 143-162 (0-indexed) with new_lines
result = lines[:143] + new_lines + lines[163:]

with open(jsp_path, "wb") as f:
    f.write(sep.join(result))

print(f"SUCCESS: replaced lines 144-163 with {len(new_lines)} new lines.")
print(f"New total lines: {len(result)}")
