# Fix Course Content Sidebar Structure (Section → Lesson → Resource)

## Goal
Update the sidebar structure in `course-video.jsp` so that it supports **3-level collapsible navigation**:

Section → Lesson → Resource

Currently the structure is:

Section
   Lesson Title
   Resource
   Resource

But we want:

Section (click to expand)
   Lesson (click to expand)
        Resource
        Resource

---

# Required UI Behavior

### Level 1
Section should be collapsible.

Example:

Section 1: Introduction  
(click to open)

---

### Level 2
Inside each Section, every Lesson should also be collapsible.

Example:

Section 1  
   Lesson 1: Java Basics (click)

---

### Level 3
Inside Lesson, show resources (video / document).

Example:

Lesson 1: Java Basics  
   ▶ Introduction Video  
   📄 Slide PDF

---

# Current Code

Current structure:

```jsp
<c:forEach var="lessonDTO" items="${sectionDTO.lessons}">

    <!-- Lesson Title -->
    <div class="px-5 pt-3 pb-1">
        <p class="text-sm font-bold text-slate-700">
            Lesson ${lessonDTO.lesson.orderIndex}:
            ${lessonDTO.lesson.title}
        </p>
    </div>

    <c:forEach var="resource" items="${lessonDTO.resources}">

This structure does not allow collapsing the lesson.

Required Fix

Convert each Lesson into a <details> element.

Replace the lesson block with this structure:

<c:forEach var="lessonDTO" items="${sectionDTO.lessons}">

    <details class="group bg-gray-50">

        <summary
            class="flex items-center justify-between px-5 py-3 cursor-pointer hover:bg-gray-100 transition-colors">

            <p class="text-sm font-bold text-slate-700">
                Lesson ${lessonDTO.lesson.orderIndex}:
                ${lessonDTO.lesson.title}
            </p>

            <span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform">
                expand_more
            </span>

        </summary>

        <div>

            <c:forEach var="resource" items="${lessonDTO.resources}">
Resource Items

Inside the lesson, keep the same resource structure:

Video icon:

play_circle

Document icon:

menu_book

Example:

▶ Introduction Video
📄 Java Slide PDF
Important Rules

Do NOT modify:

Tailwind layout

CSS classes

Database structure

Servlet logic

EL variables

Only change the HTML structure of the sidebar to support collapsible lessons.

Expected Result

The sidebar should behave like Udemy:

Section 1: Introduction
   ▼
   Lesson 1: Java Basics
       ▶ Introduction Video
       📄 Java Slide

   Lesson 2: Variables
       ▶ Variable Video
       📄 Exercise PDF

Section and Lesson must both be expandable/collapsible.