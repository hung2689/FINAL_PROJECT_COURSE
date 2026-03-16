You are a senior Java backend developer.

First, scan and understand the ENTIRE project before making any changes.

Project architecture:

* Java Servlet + JSP
* Service layer pattern
* GenericDAO is already implemented and used across repositories
* SQL database is already designed (see DB script): "D:\FPTU\semeter_4\MAIN_COURSEIT\FINAL_PROJECT_COURSE\SQLQuery1.sql"
* Most functions already exist

Important folders:

* dao.base → BaseDAO, GenericDAO
 
* service → business logic
* model → entities
* JSP pages → UI

Your task:

1. Read the whole project structure.
2. Read the database schema from the DB script.
3. Identify existing models, services, and database tables related to:

   * Course
   * Lesson
   * Resource
   * Enrollment
   * Student
4. Do NOT rewrite existing functions if they already work.
5. Reuse the existing GenericDAO methods.

Goal to implement:

When a student opens the course-detail page:

IF the student has enrolled in the course:

* They can click lessons
* They can watch videos
* They can open resources

IF the student has NOT enrolled:

* They can only view the lesson list
* They CANNOT click the lesson
* They CANNOT watch videos
* They CANNOT access resources

Implementation rules:

1. Use the existing EnrollmentService.
2. Add a method to check enrollment status:

boolean isStudentEnrolled(int studentId, int courseId)

3. Implement this method inside EnrollmentServiceImp using the existing GenericDAO.

4. In the Course Detail controller/servlet:

   * Get current logged-in user from session
   * Check enrollment status
   * Pass a boolean "enrolled" to the JSP.

5. In course_detail.jsp:

   * If enrolled == true → allow lesson links
   * If enrolled == false → disable links or show locked icon.

Example UI behavior:

Enrolled:
▶ Lesson 1
▶ Lesson 2
▶ Lesson 3

Not enrolled:
🔒 Lesson 1
🔒 Lesson 2
🔒 Lesson 3

Security requirement (very important):

Even if a user manually opens the lesson URL,
the system must verify enrollment again in the controller.

If not enrolled:
redirect back to course-detail page.

Final requirement:

Do NOT modify unrelated parts of the system.
Reuse existing service classes and GenericDAO methods.
Keep the architecture consistent with the current project.
