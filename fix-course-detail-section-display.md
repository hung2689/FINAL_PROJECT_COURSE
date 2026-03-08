# Task: Load Course Video Data From Database Into course-video.jsp

## Context
The UI layout of `course-video.jsp` is already completed and must NOT be modified visually.

The page already contains:
- TailwindCSS layout
- Video player
- Lesson sidebar
- Comment section
- JSTL tags

The layout must remain EXACTLY the same.

The servlet `CourseVideoServlet` already exists and handles the backend logic.

Your job is ONLY to connect database data to the JSP page.

---

# Strict Rules

1. DO NOT redesign or change the layout.
2. DO NOT modify TailwindCSS classes.
3. DO NOT change the HTML structure.
4. ONLY modify code related to loading dynamic data.
5. ONLY update files related to this feature.

Allowed files to edit:

- `CourseVideoServlet.java`
- DAO classes if necessary
- DTO / Model classes if necessary
- `course-video.jsp`

DO NOT modify other pages like:

- `course-detail.jsp`
- `course-list.jsp`
- `header.jsp`
- `footer.jsp`

---

# Required Feature

When a user clicks a lesson in the sidebar:


/course-video?resourceId=123


The system must:

1. Receive `resourceId` in `CourseVideoServlet`
2. Query database tables:

Possible tables:
- Course
- Section
- Lesson
- LessonResource

3. Load data structure:


Course
└── Sections
└── Lessons
└── Resources


4. Send data to `course-video.jsp`

Example attributes:


request.setAttribute("courseDetail", courseDetailDTO);
request.setAttribute("currentResource", resource);
request.setAttribute("videoUrl", resource.getUrl());


---

# Data That Must Appear On Page

## 1 Course Name


${courseDetail.course.title}


Display at top of page.

---

## 2 Video Title


${currentResource.title}


---

## 3 Video Player

The iframe must load the video URL from database:


${currentResource.url}


Example result:


https://www.youtube.com/embed/xxxx


---

## 4 Lesson Sidebar

Loop structure already exists:


courseDetail.sections
sectionDTO.lessons
lessonDTO.resources


You must populate these objects from the database.

---

# Active Lesson Highlight

Current playing lesson must highlight using:


${resource.resourceId == param.resourceId}


This logic already exists in JSP.

Your job is to ensure:


param.resourceId


is correctly passed from the servlet.

---

# Navigation Links

Each lesson must link like this:


/course-video?resourceId=${resource.resourceId}


NOT:


/course-video.jsp


The request must go through the servlet.

---

# Example Flow

User clicks lesson:


course-video?resourceId=12


↓

`CourseVideoServlet`

↓

Query database

↓

Send data to JSP

↓

JSP renders:

- Course name
- Video title
- Video player
- Sidebar lessons

---

# Important

The UI in `course-video.jsp` must stay visually identical.

Only dynamic data binding is allowed.

DO NOT break the layout.
DO NOT remove existing HTML.