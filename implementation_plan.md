# Inline Editor Refactor — No Page Reload, Clean UI

Fix the resource add UI layout, prevent page reloads on all add operations, and keep edit mode active after creating new items.

## Proposed Changes

### Frontend JavaScript

#### [MODIFY] [edit-course.js](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/assets/js/edit-course.js)

**Complete rewrite of the file** with these changes:

1. **[addSection()](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/assets/js/edit-course.js#125-179)** — After successful POST, dynamically insert a new `<details>` section block into the DOM using the returned `section_id` + `title`. Clear input. No `window.location.reload()`.

2. **[addLesson(sectionId)](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/assets/js/edit-course.js#180-235)** — After successful POST, dynamically append a new `<li>` lesson block inside the section's `<ul>`. Clear input. No reload.

3. **[addResource(lessonId, type)](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/assets/js/edit-course.js#289-355)** — Complete rewrite:
   - Change from current approach to a **two-step toolbar**: small "+ Video" / "+ Document" buttons → clicking one expands a clean inline form (Title + URL + Cancel/Add).
   - After successful POST, dynamically append a new resource `<div>` to the lesson's resource list using the returned `resource_id`, `title`, `url`, `resource_type`.
   - Clear form fields and keep form open for rapid adding.
   - No reload.

4. **[saveResourceEdit()](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/assets/js/edit-course.js#261-288)** — Replace `window.location.reload()` with dynamic DOM update of the edited resource element.

5. **Helper function `createResourceHTML(id, title, url, type)`** — New function that generates the HTML for a resource item, matching the JSP template structure.

6. **Helper function `createLessonHTML(id, title)`** — Generates HTML for a new lesson `<li>` item.

7. **Helper function `createSectionHTML(id, title)`** — Generates HTML for a new section `<details>` block.

---

### JSP Template

#### [MODIFY] [course-detail.jsp](file:///d:/FPTU/semeter_4/PRJ/CourseITProject/src/main/webapp/views/details/course-detail.jsp)

**Lines 298–314** — Replace the current "Add Video" / "Add Doc" button block with a cleaner **resource toolbar**:

```diff
- <div class="edit-only mt-2">
-     <button ... onclick="addResource(id, 'video')" class="... bg-emerald-50 ...">Add Video</button>
-     <button ... onclick="addResource(id, 'document')" class="... bg-emerald-50 ...">Add Doc</button>
- </div>
+ <div class="edit-only mt-3 resource-toolbar" data-lesson-id="${lessonDTO.lesson.lessonId}">
+     <div class="flex items-center gap-2">
+         <span class="text-[11px] text-slate-400 font-semibold uppercase">Add:</span>
+         <button type="button" onclick="showAddResourceForm(this, 'video')" class="small pill button">+ Video</button>
+         <button type="button" onclick="showAddResourceForm(this, 'document')" class="small pill button">+ Document</button>
+     </div>
+     <!-- Form expands here dynamically -->
+ </div>
```

The buttons will be small, pill-shaped, with subtle borders — not large green blocks.

**No backend changes needed** — all 3 servlets already return the data needed for dynamic DOM insertion.

## Verification Plan

### Manual Verification

Since there are no frontend unit tests in the project, manual testing is required. Please test the following after deployment:

1. **Open course detail page** → Click **Edit Mode**
2. **Add Section**: Click "Add New Section" → type title → press Enter → verify new section appears in the list instantly, page does NOT reload, edit mode stays active
3. **Add Lesson**: Inside a section, click "Add Lesson" → type title → Enter → new lesson appears in the section, no reload
4. **Add Resource (Video)**: Inside a lesson, click "+ Video" → form expands → fill Title + URL → click Add or press Enter → new video resource appears in the list, form clears, no reload
5. **Add Resource (Document)**: Same flow for "+ Document"
6. **Cancel**: Click Cancel or press Escape on any inline form → form disappears cleanly
7. **Edit Mode persists**: After all add operations, verify `edit-mode` class is still on `<body>` and edit controls are still visible
8. **Edit existing resource**: Click edit icon → modify → Save → resource updates in-place without reload
