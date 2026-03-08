import sys

jsp_path = r"d:\FPTU\semeter_4\PRJ\CourseITProject\src\main\webapp\views\details\course-detail.jsp"

with open(jsp_path, "rb") as f:
    raw = f.read()

# Detect line ending style
if b"\r\n" in raw:
    sep = b"\r\n"
elif b"\r" in raw:
    sep = b"\r"
else:
    sep = b"\n"

lines = raw.split(sep)
print(f"Total lines: {len(lines)}, line ending: {repr(sep)}")

# Lines 144-163 (0-indexed: 143-162)
print("--- Lines 143-163 (1-indexed 144-164): ---")
for i in range(143, 164):
    print(f"{i+1}: {repr(lines[i])}")
