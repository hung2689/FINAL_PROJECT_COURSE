I am working on a Java web application built with:



\* Java Servlet

\* JSP

\* JPA (Hibernate)

\* MVC architecture

\* SQL Server database



Before making any changes, I need you to \*\*carefully analyze the entire project structure and database schema first\*\*, then refactor the system according to the requirements below.



⚠️ IMPORTANT:

The database schema has \*\*already been created manually\*\*.

You must \*\*analyze the existing database structure and adapt the code to it\*\*, NOT redesign the database from scratch.



\---



1\. ANALYZE PROJECT FIRST



\---



Before writing any code, you must:



1\. Analyze the entire project structure.

2\. Understand the current MVC layers:



&#x20;  \* Controller (Servlet)

&#x20;  \* Service

&#x20;  \* DAO

&#x20;  \* Entity/Model

3\. Identify the current authentication and registration flow.

4\. Check how Users, Student, Teacher, UserRole, and other related entities are implemented.

5\. Analyze the current TeacherRegister servlet and teacher CV upload flow.



Only after understanding the system should you start refactoring.



\---



2\. ANALYZE DATABASE SCHEMA



\---



You must analyze the existing database tables and relationships.



Important tables already exist, including:



Users

Roles

UserRoles

Student

Teacher

Candidates

TeacherJob



TeacherJob table already exists:



CREATE TABLE TeacherJob (

job\_id        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

title         NVARCHAR(255) NOT NULL,

description   NVARCHAR(MAX) NULL,

location      NVARCHAR(255) NULL,

job\_type      VARCHAR(50) NULL,

salary\_min    DECIMAL(18,2) NULL,

salary\_max    DECIMAL(18,2) NULL,

salary\_unit   NVARCHAR(50) NULL,

status        VARCHAR(50) NULL,

created\_at    DATETIME2(7) DEFAULT SYSDATETIME(),

updated\_at    DATETIME2(7) DEFAULT SYSDATETIME()

);



Candidates table already exists and has been linked:



ALTER TABLE candidates

ADD job\_id INT NULL;



ALTER TABLE candidates

ADD CONSTRAINT FK\_Candidates\_TeacherJob

FOREIGN KEY (job\_id) REFERENCES TeacherJob(job\_id);



Do NOT recreate these tables.

Instead, use them in the new recruitment system.



\---



3\. NEW REGISTER FLOW



\---



The registration system must be simplified.



Users should NO LONGER select a role during registration.



New rule:



Every new account will automatically be assigned the role:



STUDENT



Changes required:



1\. Remove role selection from register.jsp.

2\. Remove role parameter from AuthServlet register logic.

3\. After OTP verification, call:



userService.register(user, "STUDENT");



4\. Automatically create a Student profile with:



level = "BEGINNER"



\---



4\. REMOVE OLD TEACHER REGISTER FLOW



\---



Currently the system has this flow:



Register → OTP → /teacherRegister → Upload CV



This flow must be removed.



Remove:



TeacherRegister servlet

teacherRegister.jsp

Teacher signup logic



Teacher accounts should NOT be created during registration anymore.



\---



5\. NEW FEATURE: TEACHER RECRUITMENT SYSTEM



\---



Teacher recruitment should be a separate feature.



Users must:



1\. Register normally as STUDENT.

2\. Login to the system.

3\. Navigate to "Teacher Recruitment".



Header dropdown example:



About DevLearn

├── About Company

├── Teacher Recruitment

└── DevLearn News



\---



6\. TEACHER JOB LIST PAGE



\---



Create a page that displays TeacherJob records.



Each job card should show:



Title

Location

Job Type

Salary Range

Apply Button



\---



7\. APPLY FOR TEACHER JOB



\---



When a logged-in user clicks "Apply":



Flow:



User logged in

↓

Click Apply

↓

Upload CV

↓

System uploads file

↓

Insert record into Candidates table



Fields to save:



user\_id

job\_id

cv\_url

status = "PENDING"

created\_at



\---



8\. n8n AUTOMATION INTEGRATION



\---



The system must integrate with n8n for automated CV processing.



After a candidate submits an application, the system must send a webhook request.



Webhook endpoint:



http://localhost:5678/webhook/teacher-apply



Example JSON payload:



{

"name": "Nguyen Van A",

"user\_id": 12,

"email": "\[user@email.com](mailto:user@email.com)",

"cv\_url": "https://site.com/uploads/cv/cv123.pdf",

"job\_id": 5

}



This webhook triggers an n8n workflow which may:



\* Send CV to HR email

\* Store candidate info in Google Sheets

\* Run AI CV analysis

\* Notify HR on Slack/Discord

\* Track candidate status



\---



9\. PERMISSIONS



\---



Only logged-in users can apply for teacher jobs.



If the user is not logged in:



redirect to /login



\---



10\. ADMIN APPROVAL FLOW



\---



Applying for a job does NOT make the user a teacher automatically.



Approval flow:



Candidate status = PENDING

↓

Admin reviews CV

↓

Admin approves

↓

System assigns TEACHER role

↓

Teacher profile is created



\---



11\. WHAT I NEED FROM YOU



\---



After analyzing the project and database:



1\. Refactor the register system

2\. Remove teacher signup logic

3\. Implement teacher recruitment feature

4\. Implement job application system

5\. Integrate webhook with n8n

6\. Follow existing MVC architecture

7\. Reuse existing services like FileUploadService

8\. Do not break existing database structure



Please explain the refactor plan first before writing code.



