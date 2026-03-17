You are a senior full-stack developer. I need you to refactor both frontend and backend logic for a course platform.

==================== REQUIREMENTS ====================

1. FREE COURSES UI CHANGE
- If a course is FREE (price = 0):
  - DO NOT show "Add to Cart" button or cart icon
  - Instead, show a button with text:
    → "Join" (if user has NOT enrolled)
    → "Enrolled" (if user ALREADY enrolled)

2. BUTTON BEHAVIOR
- When user clicks "Join":
  - Call API to enroll the user into the course
  - Immediately update UI to "Enrolled"
  - Disable the button after enrolled

3. ENROLLMENT LOGIC (BACKEND)
- Create an enrollment when user clicks Join
- Prevent duplicate enrollment
- Return status:
    {
      enrolled: true
    }

4. DATABASE
- Ensure there is a table:
  Enrollment(user_id, course_id, created_at)

- Add unique constraint:
  (user_id, course_id) must be unique

5. API DESIGN
- POST /api/courses/{courseId}/enroll
    → Enroll current user

- GET /api/courses/{courseId}/enrollment-status
    → Return:
      {
        enrolled: true/false
      }

6. FRONTEND LOGIC (IMPORTANT)
- On course load:
  → Call enrollment-status API
  → If enrolled = true → show "Enrolled"
  → Else → show "Join"

- Button states:
  - Join → clickable
  - Enrolled → disabled

7. NON-FREE COURSES
- Keep existing logic:
  - Show price
  - Show Add to Cart button

8. TECH STACK
- Backend: Java (Spring Boot)
- Frontend: JSP / Servlet / or React (detect and adapt)
- Use clean, production-ready code

9. EXTRA
- Handle loading state when clicking Join
- Handle API errors gracefully

==================== OUTPUT ====================

Provide:
1. Backend Controller + Service + Repository
2. SQL table + constraint
3. Frontend code (JSP or React depending on context)
4. Clear explanation of logic

Make sure code is clean, complete, and ready to use.