# Task: Design course-video.jsp page

You need to design a JSP page called:

course-video.jsp

The page layout must be similar to the screenshot provided. The page should look like a modern online learning platform video player.

## Layout Requirements

The page should contain two main sections:

### 1. Left Section (Video Player Area)

This section occupies about 70% of the width.

Include:

- A large embedded YouTube video player
- Video title above the player
- Course name above the title
- Action buttons on the top right of the video section:
  - Leave a rating
  - Progress indicator
  - Share button

Example layout:

Course Title  
Video Title  
Video Player (YouTube iframe)

Below the video:
- Comment input area labeled **Bình luận**

---

### 2. Right Section (Lesson Content Sidebar)

This section occupies about 30% of the width.

It should display:

Header:
Nội dung bài học


Then a collapsible lesson structure like:


Phần 1
Phần 2
Buổi 1 - Quản Lý Rủi Ro và Các Bên Liên Quan
Preview - Review Task 2 và Hướng dẫn cách nhận diện
Phần 3
Phần 4
Phần 5


Each lesson item should have:

- Icon (video or document)
- Title
- Duration

Active lesson should be highlighted.

---

### UI Requirements

Use modern UI style:

- TailwindCSS
- Flexbox layout
- Rounded corners
- Hover effects
- Clean spacing
- Light gray sidebar background
- White main video area

Icons can use:

Material Symbols

Example:


material-symbols-outlined


---

### JSP Requirements

The page must support dynamic data using JSP EL:

Examples:


${course.title}
${lesson.title}
${resource.url}
${resource.duration}


Loop example:


<c:forEach var="lesson" items="${lessons}">


---

### Video Player

Embed video like:

<iframe src="${videoUrl}" allowfullscreen> </iframe> ```
File Structure

Generate full JSP page:

course-video.jsp

Include:

HTML structure

TailwindCSS CDN

Material Symbols CDN

Responsive layout

JSP tags

Important

This page is only used for watching course videos.

Do NOT modify:

course-detail.jsp

course-list.jsp

cart pages

This page should only display video and lesson navigation.