# TASK: Implement Course Edit Mode (Section / Lesson / LessonResource)

You must read and understand the **ENTIRE PROJECT** before making any changes.

This is a **Java JSP + Servlet LMS project**.

The feature to implement is **Edit Mode for Course Content** similar to Udemy.

IMPORTANT:  
You must NOT break the current project structure.

---

# STEP 1 — READ PROJECT FIRST

Before writing any code:

1. Read the **entire project source code**
2. Understand how:
   - Course
   - Section
   - Lesson
   - LessonResource

are rendered in the UI.

3. Read database schema here:


D:\FPTU\semeter_4\PRJ\CourseITProject\sql.sql


You MUST understand:


Course
└ Section
└ Lesson
└ LessonResource


Database cascade rules:


Section DELETE → Lesson DELETE → LessonResource DELETE
Lesson DELETE → LessonResource DELETE


These cascades already exist in the database.

DO NOT implement manual cascading.

---

# STEP 2 — IMPORTANT RULES

You must follow these rules strictly.

### DO NOT break UI layout

The current layout in:


course-detail.jsp


must remain exactly the same.

Do NOT redesign UI.

Do NOT change HTML structure unnecessarily.

---

### Only modify these files

Frontend:


course-detail.jsp


Backend:


CourseDetailServlet
LessonEditServlet
ResourceEditServlet
SectionEditServlet
LessonEditService
ResourceEditService
SectionEditService


Only modify these files **if necessary**.

---

### DO NOT create new DAO classes

DO NOT create:


LessonEditDAO
ResourceEditDAO
SectionEditDAO


Database logic must be written **inside Service classes directly**.

---

### DO NOT modify unrelated classes

If a class is unrelated to this feature:

DO NOT TOUCH IT.

---

# STEP 3 — ROLE CHECK

Only these roles can use Edit Mode:


ADMIN
TEACHER


Students must NOT see Edit Mode.

So:


if role == ADMIN or TEACHER
show Edit Mode button
else
hide it


Students can only:


view course
watch lessons


No editing.

---

# STEP 4 — EDIT MODE BUTTON

Add a button:


Edit Mode


When clicked:


toggle edit mode


Example:


body.edit-mode


In Edit Mode:

Show controls:


Delete buttons
Add buttons
Editable titles


---

# STEP 5 — DELETE FEATURES

When Edit Mode is ON:

Show **❌ icon** at the beginning of:


Section
Lesson
LessonResource


Like the screenshot.

---

### Delete Section

Click ❌ near section:


delete section


Database will automatically delete:


Lessons
LessonResources


Because of cascade.

---

### Delete Lesson

Click ❌ near lesson:


delete lesson


Database automatically deletes:


LessonResources


---

### Delete LessonResource

Click ❌ near resource:


delete resource


---

# STEP 6 — ADD FEATURES

Add buttons must appear like this:

### Add Section

If there are **no sections**

Show a large row with:


Add Section


---

### Add Lesson

If section exists but **no lesson**

Show:


Add Lesson


under section.

---

### Add LessonResource

If lesson exists but **no resource**

Show:


Add Resource


under lesson.

---

# STEP 7 — EDIT FEATURES

### Edit Section Title

Click section title.

It becomes editable:


contenteditable


When saved:


UPDATE Section
SET title = ?
WHERE section_id = ?


---

### Edit Lesson Title

Same logic.


UPDATE Lesson
SET title = ?
WHERE lesson_id = ?


---

### Edit Resource

When clicking resource:

Allow editing:


title
url
duration


Example:

Video


https://youtube.com/
...


Document


https://example.com/file.pdf


---

# STEP 8 — SAVE MODE

When editing finished:

User clicks:


Save


Then:


send AJAX request
update database
reload UI


---

# STEP 9 — FRONTEND RULES

Frontend changes **only in**:


course-detail.jsp


You may add:


JS
CSS


But do NOT break layout.

Use current HTML structure.

---

# STEP 10 — BACKEND RULES

Backend logic must be implemented in:


SectionEditServlet
LessonEditServlet
ResourceEditServlet


And database operations must be written in:


SectionEditService
LessonEditService
ResourceEditService


Again:

DO NOT create new DAO classes.

---

# STEP 11 — IMPORTANT

You must ensure:


Existing features continue to work


Do NOT break:


course viewing
lesson viewing
quiz
navigation


---

# STEP 12 — OUTPUT FORMAT

After reading the entire project:

Provide code changes for:

1️⃣ course-detail.jsp  
2️⃣ SectionEditServlet  
3️⃣ LessonEditServlet  
4️⃣ ResourceEditServlet  
5️⃣ SectionEditService  
6️⃣ LessonEditService  
7️⃣ ResourceEditService  

Explain **what was changed**.

Do not rewrite entire project.

Only modify necessary parts.

---

# FINAL NOTE

You MUST:

- read entire project
- read SQL schema
- understand relationships
- not break layout
- not create new DAO classes
- only modify allowed files