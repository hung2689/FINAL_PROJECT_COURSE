I have a Java Servlet application that sends a webhook request to n8n when a user applies for a job.

Problem: The webhook is being triggered twice, causing duplicate data in my system.

Here is my current flow:

1. User submits a form (POST /teacher-apply)
2. Server uploads CV
3. Saves application to database
4. Calls sendWebhook() using HttpURLConnection

Code snippet (important part):

* Servlet: TeacherJobApplyServlet (doPost method)
* Webhook method: sendWebhook()

I need you to:

1. Analyze possible reasons why the webhook is triggered twice
2. Identify whether the issue is from:

   * Frontend (double submit, reload, button click)
   * Backend (Servlet logic, multiple calls)
   * n8n (retry mechanism, webhook configuration)
3. Suggest concrete debugging steps (logs, breakpoints, request tracing)
4. Provide fixes for each possible cause
5. Suggest best practices to prevent duplicate webhook calls in production

Additional context:

* Using HttpURLConnection (synchronous call)
* Webhook URL: http://localhost:5678/webhook/teacher-apply
* No async processing yet
* No duplicate check in database

Important:
Do NOT give generic answers. I want step-by-step debugging strategy and exact fixes.
