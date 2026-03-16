I am building a Learning Management System (LMS) website.
the first analazy database in : "D:\FPTU\semeter_4\MAIN_COURSEIT\FINAL_PROJECT_COURSE\SQLQuery.sql"
Current situation:
I already have a Student Profile page that contains:

* My Profile
* Change Password
* My Courses

I want to ADD a new menu item called **Billing**.

Requirements:

1. Sidebar Menu
   Add a new item in the sidebar navigation:

My Profile
Change Password
My Courses
Billing

When the user clicks **Billing**, it must redirect to a new page:

student-billing.jsp

2. Student Billing Page UI

The student-billing page should show the **Billing History** of the student.

Design it similar to a modern dashboard card layout.

Page title:
Billing History

Subtitle:
Easily track your course purchases and transactions.

Each billing item should display:

* Order ID
* Price
* Currency (VND)
* Payment Status (Completed / Pending / Failed)
* Purchase Date & Time
* Arrow icon to view details

Example layout:

Order ID: US9KH8AH
Price: 3,750,000 VND
Status: Completed
Date: 20 May 2025 – 23:30

Clicking the row should open:

student-bill-detail.jsp

3. Bill Detail Page

The detail page must show:

Order Information

* Order ID
* Transaction ID
* Purchase Date
* Payment Method

Course Information

* Course Name
* Instructor
* Price

Payment Summary

* Subtotal
* Tax (if any)
* Total Amount

4. UI Design Requirements

Use modern UI like:

* Coursera
* Udemy
* Stripe dashboard

Style requirements:

* Rounded cards
* Soft shadows
* Hover effect for billing rows
* Status badge colors:

  * Green → Completed
  * Orange → Pending
  * Red → Failed

5. Output Required

Provide FULL implementation:

1. Sidebar menu HTML update
2. student-billing.jsp
3. student-bill-detail.jsp
4. CSS styles
5. Example data for billing history

Important:
The UI must be clean, modern, and responsive.
