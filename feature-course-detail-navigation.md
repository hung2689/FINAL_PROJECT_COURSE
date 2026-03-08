# URGENT BUG FIX – Course Detail Sections Not Displaying

## Problem
When clicking a course card in `course-list.jsp`, the application correctly navigates to the course detail page. However, the **sections of the course are not displayed**.

Current UI shows:

0 Sections • 0 Lectures • 0s total length

But the database already contains sections and lessons.

This means **data is not being loaded or passed correctly from backend to JSP**.

Your task is to **analyze the entire project and fix this issue completely.**

---

# IMPORTANT INSTRUCTIONS

You must:

1. Read the entire project source code.
2. Identify why **sections are not displayed in course-detail.jsp**.
3. Check all layers of the architecture.
4. Fix the code directly in the project.
5. Ensure sections and lessons are displayed correctly.

DO NOT stop until the issue is fully fixed.

---

# FILES YOU MUST CHECK

You MUST review and debug the following files:

### Frontend (JSP)
- `course-list.jsp`
- `course-detail.jsp`

Verify:
- courseId is sent correctly
- JSTL loops are correct
- `${courseDetail.sections}` is used properly

---

### Controller Layer
Check:

`CourseDetailServlet.java`

Verify:

- courseId is received from request
- courseId is parsed correctly
- service method is called
- request attribute is set correctly

Example that MUST exist:

```java
CourseDetailDTO courseDetail = courseDetailService.getCourseDetail(courseId);
request.setAttribute("courseDetail", courseDetail);
request.getRequestDispatcher("/WEB-INF/views/course/course-detail.jsp").forward(request, response);