// Toggles edit mode on the body
function toggleEditMode() {
    const isEditMode = document.body.classList.toggle('edit-mode');
    localStorage.setItem('courseEditMode', isEditMode ? 'true' : 'false');
    updateEditModeBtn();
}

function updateEditModeBtn() {
    const btn = document.getElementById('toggleEditModeBtn');
    if (!btn) return;
    if (document.body.classList.contains('edit-mode')) {
        btn.classList.replace('bg-emerald-100', 'bg-red-100');
        btn.classList.replace('text-emerald-700', 'text-red-700');
        btn.innerHTML = '<span class="material-symbols-outlined text-[16px]">close</span> Exit Edit Mode';
    } else {
        btn.classList.replace('bg-red-100', 'bg-emerald-100');
        btn.classList.replace('text-red-700', 'text-emerald-700');
        btn.innerHTML = '<span class="material-symbols-outlined text-[16px]">edit</span> Edit Mode';
    }
}

// Restore Edit Mode on Page Load
document.addEventListener('DOMContentLoaded', () => {
    const btn = document.getElementById('toggleEditModeBtn');
    if (localStorage.getItem('courseEditMode') === 'true' && btn) {
        document.body.classList.add('edit-mode');
        updateEditModeBtn();
    } else if (!btn) {
        localStorage.setItem('courseEditMode', 'false');
    }

    if (!window.IS_EDIT_ALLOWED) {
        document.querySelectorAll('.edit-only').forEach(el => el.remove());
    }
});

// Convert a title span to an input field
function makeEditable(element, type, id) {
    if (!document.body.classList.contains('edit-mode'))
        return;

    // Prevent making it editable if it already is
    if (element.querySelector('input'))
        return;

    const originalText = element.innerText.trim();
    const input = document.createElement('input');
    input.type = 'text';
    input.value = originalText;
    input.className = 'border border-emerald-400 rounded px-2 py-1 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500';

    // Replace text with input
    element.innerHTML = '';
    element.appendChild(input);
    input.focus();

    // Handle save on Enter or blur
    const saveChanges = async () => {
        const newText = input.value.trim();
        if (newText && newText !== originalText) {
            let endpoint = '';
            let body = new URLSearchParams();
            body.append('action', 'update');
            body.append('title', newText);

            if (type === 'section') {
                endpoint = '/sectionAdmin';
                body.append('section_id', id);
            } else if (type === 'lesson') {
                endpoint = '/lessonAdmin';
                body.append('lesson_id', id);
            }

            try {
                const response = await fetch((window.CONTEXT_PATH || '') + endpoint, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: body
                });
                const result = await response.json();
                if (result.status === 'success') {
                    element.innerHTML = newText; // update text
                } else {
                    alert('Error updating: ' + (result.message || 'Unknown error'));
                    element.innerHTML = originalText; // revert
                }
            } catch (error) {
                console.error('Error:', error);
                alert('Request failed');
                element.innerHTML = originalText; // revert
            }
        } else {
            element.innerHTML = originalText; // revert if empty or no change
        }
    };

    input.addEventListener('blur', saveChanges);
    input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            input.blur(); // Triggers blur which calls saveChanges
        } else if (e.key === 'Escape') {
            element.innerHTML = originalText; // revert immediate
        }
    });
}

// HTML Generators for Dynamic Insertion
function createSectionHTML(id, title, orderIndex) {
    return `
        <details class="group bg-white border border-emerald-100 rounded-xl overflow-hidden shadow-sm" open="">
            <summary class="flex flex-col sm:flex-row cursor-pointer sm:items-center justify-between p-5 list-none hover:bg-emerald-50 transition-colors gap-2 sm:gap-0">
                <div class="flex items-center gap-4 flex-1">
                    <span class="material-symbols-outlined text-[#10B981] group-open:rotate-180 transition-transform">expand_more</span>
                    <span class="text-base font-bold text-slate-900 tracking-tight"
                        onclick="makeEditable(this, 'section', ${id})"
                        title="Click to edit section title">Section ${orderIndex}: ${title}</span>
                </div>
                <div class="flex items-center gap-3">
                    <span class="text-xs font-bold text-slate-500">0 Lectures</span>
                    <button type="button" class="edit-only text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded transition-colors"
                        onclick="deleteEntity('section', ${id}, this.closest('details'))" title="Delete Section">
                        <span class="material-symbols-outlined text-[18px]">delete</span>
                    </button>
                </div>
            </summary>
            <div class="p-5 pt-0 border-t border-emerald-100">
                <ul class="space-y-4 mt-4 lesson-list"></ul>
                <div class="edit-only mt-4 flex justify-center add-lesson-container">
                    <button type="button" onclick="addLesson(${id})" class="text-sm font-bold text-emerald-600 bg-emerald-50 hover:bg-emerald-100 px-4 py-2 rounded-lg transition-colors flex items-center gap-1 border border-emerald-200">
                        <span class="material-symbols-outlined text-[18px]">add</span> Add Lesson
                    </button>
                </div>
            </div>
        </details>
    `;
}

function createLessonHTML(id, title) {
    return `
        <li class="border border-slate-100 rounded-lg bg-white">
            <details class="group" open>
                <summary class="flex flex-col sm:flex-row sm:items-center justify-between cursor-pointer p-3 rounded-lg hover:bg-slate-50 transition-colors list-none select-none gap-2 sm:gap-0">
                    <div class="flex items-center gap-3 flex-1">
                        <span class="material-symbols-outlined text-slate-500 group-open:rotate-90 transition-transform duration-200 shrink-0">chevron_right</span>
                        <span class="text-sm font-semibold text-slate-700 w-full"
                            onclick="makeEditable(this, 'lesson', ${id})"
                            title="Click to edit lesson title">• ${title}</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <button type="button" class="edit-only text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded transition-colors"
                            onclick="deleteEntity('lesson', ${id}, this.closest('li'))" title="Delete Lesson">
                            <span class="material-symbols-outlined text-[16px]">delete</span>
                        </button>
                    </div>
                </summary>
                <div class="pl-9 pr-3 pb-3 pt-1 flex flex-col gap-2 resource-list">
                    <!-- Resources will appear here -->
                    
                    <!-- Add Resource Toolbar -->
                    <div class="edit-only mt-3 resource-toolbar" data-lesson-id="${id}">
                        <div class="flex items-center gap-2">
                            <span class="text-[11px] text-slate-400 font-semibold uppercase">Add:</span>
                            <button type="button" onclick="showAddResourceForm(this, 'video')" class="text-[11px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 px-3 py-1 rounded-full transition-colors flex items-center gap-1">
                                + Video
                            </button>
                            <button type="button" onclick="showAddResourceForm(this, 'document')" class="text-[11px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 px-3 py-1 rounded-full transition-colors flex items-center gap-1">
                                + Document
                            </button>
                        </div>
                    </div>
                </div>
            </details>
        </li>
    `;
}

function createResourceHTML(id, title, url, type, contextPath) {
    const isVideo = type === 'video';
    const icon = isVideo ? 'play_circle' : 'menu_book';
    const label = isVideo ? 'Video' : 'Document';

    const actionAttr = isVideo
        ? `href="${contextPath}/courseVideo?resourceId=${id}"`
        : `type="button" onclick="openDocModal('${title.replace(/'/g, "\\'")}', '${url.replace(/'/g, "\\'")}')"`;

    const tag = isVideo ? 'a' : 'button';

    return `
        <div class="flex items-center justify-between group/res hover:bg-slate-50 rounded-lg p-2" id="resource-container-${id}">
            <${tag} ${actionAttr} class="flex items-start gap-3 transition-colors cursor-pointer w-full text-left">
                <span class="material-symbols-outlined text-[#10B981] text-xl shrink-0 mt-0.5" style="font-variation-settings: 'FILL' 1;">${icon}</span>
                <div>
                    <p class="text-sm font-semibold text-slate-700 leading-tight res-title-display">${title}</p>
                    <p class="text-xs text-slate-500 mt-1">${label} &bull; 0 min</p>
                    <input type="hidden" class="res-url-hidden" value="${url}">
                </div>
            </${tag}>
            <div class="edit-only flex items-center gap-2 opacity-0 group-hover/res:opacity-100 transition-opacity">
                <button type="button" class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 p-1 rounded"
                    onclick="showResourceEditor(${id}, '${title.replace(/'/g, "\\'")}', '${url.replace(/'/g, "\\'")}')" title="Edit Resource">
                    <span class="material-symbols-outlined text-[16px]">edit</span>
                </button>
                <button type="button" class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 p-1 rounded"
                    onclick="deleteEntity('resource', ${id}, this.closest('#resource-container-${id}'))" title="Delete Resource">
                    <span class="material-symbols-outlined text-[16px]">delete</span>
                </button>
            </div>
        </div>
    `;
}

// === Custom Position Dropdown Helper ===
function createPosDropdownHTML(count, selectedVal, label) {
    let items = '';
    for (let i = 1; i <= count; i++) {
        const sel = (i === selectedVal) ? 'selected' : '';
        items += `
            <div class="pos-dropdown-item ${sel}" data-value="${i}">
                <span class="pos-item-num">${i}</span>
                <span>Position ${i}</span>
                <span class="material-symbols-outlined pos-item-check">check</span>
            </div>`;
    }
    return `
        <div class="pos-dropdown" data-value="${selectedVal}">
            <div class="pos-dropdown-toggle">
                <span class="pos-icon"><span class="material-symbols-outlined" style="font-size:14px">swap_vert</span></span>
                <span class="pos-label">${label} <small>#${selectedVal}</small></span>
                <span class="material-symbols-outlined pos-arrow">expand_more</span>
            </div>
            <div class="pos-dropdown-menu">${items}</div>
        </div>`;
}

// Global active menu tracker to close previous dropdown automatically
let activePosMenuCloseFn = null;

function initPosDropdown(dropdownEl) {
    const toggle = dropdownEl.querySelector('.pos-dropdown-toggle');
    const menu = dropdownEl.querySelector('.pos-dropdown-menu');
    const labelEl = dropdownEl.querySelector('.pos-label');
    const labelText = labelEl.textContent.split('#')[0].trim();

    // Move menu to body to avoid overflow hidden issues from parent elements
    document.body.appendChild(menu);

    const closeMenu = () => {
        menu.classList.remove('open');
        toggle.classList.remove('active');
        document.removeEventListener('click', outsideClickListener);
        document.removeEventListener('scroll', scrollListener, true);
        window.removeEventListener('resize', scrollListener);
        if (activePosMenuCloseFn === closeMenu) activePosMenuCloseFn = null;
    };

    const outsideClickListener = (e) => {
        if (!toggle.contains(e.target) && !menu.contains(e.target)) {
            closeMenu();
        }
    };

    const scrollListener = (e) => {
        // Only close if scrolling outside the menu
        if (menu.contains(e.target)) return;
        closeMenu();
    };

    const openMenu = () => {
        if (activePosMenuCloseFn && activePosMenuCloseFn !== closeMenu) {
            activePosMenuCloseFn();
        }

        const rect = toggle.getBoundingClientRect();
        menu.style.position = 'fixed';
        menu.style.top = `${rect.bottom + 6}px`;
        menu.style.left = `${rect.left}px`;
        menu.style.width = `${rect.width}px`;
        menu.style.zIndex = '999999';
        
        menu.classList.add('open');
        toggle.classList.add('active');
        activePosMenuCloseFn = closeMenu;

        // Add listeners after a timeout to prevent catching the current event or immediate layout shift
        setTimeout(() => {
            document.addEventListener('click', outsideClickListener);
            document.addEventListener('scroll', scrollListener, true);
            window.addEventListener('resize', scrollListener);
        }, 10);
    };

    // Prevent focus loss from input when clicking the toggle
    toggle.addEventListener('mousedown', (e) => {
        e.preventDefault();
    });

    toggle.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        
        if (menu.classList.contains('open')) {
            closeMenu();
        } else {
            openMenu();
        }
    });

    menu.querySelectorAll('.pos-dropdown-item').forEach(item => {
        // Prevent focus loss when clicking items
        item.addEventListener('mousedown', (e) => e.preventDefault());

        item.addEventListener('click', (e) => {
            e.stopPropagation();
            e.preventDefault();
            const val = item.getAttribute('data-value');
            dropdownEl.setAttribute('data-value', val);
            
            menu.querySelectorAll('.pos-dropdown-item').forEach(i => i.classList.remove('selected'));
            item.classList.add('selected');
            
            labelEl.innerHTML = `${labelText} <small>#${val}</small>`;
            closeMenu();
        });
    });

    return menu;
}

// Add Section — show inline input with position selector
function addSection() {
    const addBtn = document.getElementById('addSectionBtn');
    if (!addBtn)
        return;
    if (addBtn.parentElement.querySelector('.inline-add-input'))
        return;

    // Count existing sections to build position options
    const spaceY4Container = addBtn.closest('.space-y-4');
    const allDetailGroups = document.querySelectorAll('details.group').length;
    const existingSections = spaceY4Container ? spaceY4Container.querySelectorAll(':scope > details.group').length : allDetailGroups;
    const nextPos = existingSections + 1;

    const dropdownHTML = createPosDropdownHTML(nextPos, nextPos, 'Section');

    const wrapper = document.createElement('div');
    wrapper.className = 'inline-add-input mt-4 flex justify-center w-full';
    wrapper.innerHTML = `
        <div class="flex flex-col sm:flex-row items-center gap-3 w-full max-w-xl">
            ${dropdownHTML}
            <input type="text" placeholder="Enter new section title..."
                class="w-full sm:flex-1 h-11 border border-slate-300 rounded-lg px-4 text-sm text-slate-900 focus:outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 shadow-sm transition-all" autofocus>
            <button type="button" class="submit-section-btn w-full sm:w-auto h-11 shrink-0 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold text-sm px-6 rounded-lg shadow-sm transition-colors flex items-center justify-center gap-2">
                Add Section
            </button>
        </div>
    `;
    addBtn.parentElement.insertBefore(wrapper, addBtn);
    const input = wrapper.querySelector('input');
    const submitBtn = wrapper.querySelector('.submit-section-btn');
    const posDropdown = wrapper.querySelector('.pos-dropdown');
    const menuEl = initPosDropdown(posDropdown);
    input.focus();

    // Clean up detached menu when wrapper is removed
    const originalRemove = wrapper.remove;
    wrapper.remove = function() {
        if (menuEl && menuEl.parentNode) menuEl.parentNode.removeChild(menuEl);
        originalRemove.call(this);
    };

    async function submitSection() {
        const title = input.value.trim();
        if (!title) {
            wrapper.remove();
            return;
        }

        input.disabled = true;
        posDropdown.style.pointerEvents = 'none';
        posDropdown.style.opacity = '0.6';

        const body = new URLSearchParams();
        body.append('action', 'create');
        body.append('course_id', window.COURSE_ID);
        body.append('title', title);
        body.append('order_index', posDropdown.getAttribute('data-value'));

        try {
            const response = await fetch((window.CONTEXT_PATH || '') + '/sectionAdmin', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            });
            const result = await response.json();
            if (result.status === 'success') {
                wrapper.remove();
                await refreshCourseContent();
            } else {
                alert('Error creating section: ' + (result.message || 'Unknown error'));
                input.disabled = false;
                posDropdown.style.pointerEvents = '';
                posDropdown.style.opacity = '';
                input.focus();
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Request failed');
            wrapper.remove();
        }
    }
    submitBtn.addEventListener('click', submitSection);
    input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            submitSection();
        } else if (e.key === 'Escape') {
            wrapper.remove();
        }
    });
    
    // Using setTimeout to check if focus moved completely outside our wrapper
    input.addEventListener('blur', () => {
        setTimeout(() => {
            if (document.body.contains(wrapper) && !wrapper.contains(document.activeElement) && !menuEl.classList.contains('open')) {
                wrapper.remove();
            }
        }, 150);
    });
}

// Add Lesson — show inline input with position selector
function addLesson(sectionId) {
    const btn = event.currentTarget;
    const container = btn.closest('.edit-only');
    if (!container)
        return;
    if (container.querySelector('.inline-add-input'))
        return;

    // Count existing lessons in this section
    const details = container.closest('details');
    const ul = details ? details.querySelector('ul.lesson-list, ul.space-y-4') : null;
    const existingLessons = ul ? ul.querySelectorAll(':scope > li').length : 0;
    const nextPos = existingLessons + 1;

    const dropdownHTML = createPosDropdownHTML(nextPos, nextPos, 'Lesson');

    const wrapper = document.createElement('div');
    wrapper.className = 'inline-add-input mt-3 flex justify-center w-full';
    wrapper.innerHTML = `
        <div class="flex flex-col sm:flex-row items-center gap-3 w-full max-w-xl">
            ${dropdownHTML}
            <input type="text" placeholder="Enter new lesson title..."
                class="w-full sm:flex-1 h-10 border border-slate-300 rounded-lg px-4 text-sm text-slate-900 focus:outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 shadow-sm transition-all" autofocus>
            <button type="button" class="submit-lesson-btn w-full sm:w-auto h-10 shrink-0 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold text-sm px-5 rounded-lg shadow-sm transition-colors flex items-center justify-center gap-2">
                Add Lesson
            </button>
        </div>
    `;
    container.insertBefore(wrapper, btn);
    const input = wrapper.querySelector('input');
    const submitBtn = wrapper.querySelector('.submit-lesson-btn');
    const posDropdown = wrapper.querySelector('.pos-dropdown');
    const menuEl = initPosDropdown(posDropdown);
    input.focus();

    // Clean up detached menu
    const originalRemove = wrapper.remove;
    wrapper.remove = function() {
        if (menuEl && menuEl.parentNode) menuEl.parentNode.removeChild(menuEl);
        originalRemove.call(this);
    };

    async function submitLesson() {
        const title = input.value.trim();
        if (!title) {
            wrapper.remove();
            return;
        }

        input.disabled = true;
        posDropdown.style.pointerEvents = 'none';
        posDropdown.style.opacity = '0.6';

        const body = new URLSearchParams();
        body.append('action', 'create');
        body.append('course_id', window.COURSE_ID);
        body.append('section_id', sectionId);
        body.append('title', title);
        body.append('order_index', posDropdown.getAttribute('data-value'));

        try {
            const response = await fetch((window.CONTEXT_PATH || '') + '/lessonAdmin', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            });
            const result = await response.json();
            if (result.status === 'success') {
                wrapper.remove();
                await refreshCourseContent();
            } else {
                alert('Error creating lesson: ' + (result.message || 'Unknown error'));
                input.disabled = false;
                posDropdown.style.pointerEvents = '';
                posDropdown.style.opacity = '';
                input.focus();
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Request failed');
            wrapper.remove();
        }
    }

    submitBtn.addEventListener('click', submitLesson);
    input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            submitLesson();
        } else if (e.key === 'Escape') {
            wrapper.remove();
        }
    });
    
    // Using setTimeout to check if focus moved completely outside our wrapper
    input.addEventListener('blur', () => {
        setTimeout(() => {
            if (document.body.contains(wrapper) && !wrapper.contains(document.activeElement) && !menuEl.classList.contains('open')) {
                wrapper.remove();
            }
        }, 150);
    });
}

// Display Resource Edit Form Inline
function showResourceEditor(resourceId, currentTitle, currentUrl) {
    const container = document.getElementById(`resource-container-${resourceId}`);
    const originalContent = container.innerHTML;

    container.innerHTML = `
        <div class="flex flex-col gap-2 p-3 bg-slate-50 border border-emerald-200 rounded-lg w-full editor-active">
            <input type="text" id="edit-res-title-${resourceId}" value="${currentTitle}" class="border rounded px-2 py-1 text-sm w-full" placeholder="Title">
            <input type="text" id="edit-res-url-${resourceId}" value="${currentUrl}" class="border rounded px-2 py-1 text-sm w-full" placeholder="URL">
            <div class="flex justify-end gap-2 mt-2">
                <button type="button" onclick="cancelResourceEdit(${resourceId})" class="text-xs text-slate-500 hover:text-slate-700 px-2 py-1">Cancel</button>
                <button type="button" onclick="saveResourceEdit(${resourceId})" class="text-xs bg-emerald-500 text-white rounded px-3 py-1 hover:bg-emerald-600">Save</button>
            </div>
        </div>
    `;

    container.setAttribute('data-original', originalContent);
}

function cancelResourceEdit(resourceId) {
    const container = document.getElementById(`resource-container-${resourceId}`);
    container.innerHTML = container.getAttribute('data-original');
}

async function saveResourceEdit(resourceId) {
    const titleInput = document.getElementById(`edit-res-title-${resourceId}`);
    const urlInput = document.getElementById(`edit-res-url-${resourceId}`);

    const title = titleInput.value.trim();
    const url = urlInput.value.trim();

    if (!title || !url) {
        alert("Title and URL cannot be empty");
        return;
    }

    const body = new URLSearchParams();
    body.append('action', 'update');
    body.append('resource_id', resourceId);
    body.append('title', title);
    body.append('url', url);

    try {
        const response = await fetch((window.CONTEXT_PATH || '') + '/resourceAdmin', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: body
        });
        const result = await response.json();
        if (result.status === 'success') {
            cancelResourceEdit(resourceId);
            const container = document.getElementById(`resource-container-${resourceId}`);

            const titleElem = container.querySelector('.res-title-display') || container.querySelector('p.font-semibold');
            if (titleElem)
                titleElem.innerText = title;

            const btnTag = container.querySelector('button.flex.items-start');
            if (btnTag) {
                btnTag.setAttribute('onclick', `openDocModal('${title.replace(/'/g, "\\'")}', '${url.replace(/'/g, "\\'")}')`);
            }

            const editBtn = container.querySelector('button[title="Edit Resource"]');
            if (editBtn) {
                editBtn.setAttribute('onclick', `showResourceEditor(${resourceId}, '${title.replace(/'/g, "\\'")}', '${url.replace(/'/g, "\\'")}')`);
            }

            container.setAttribute('data-original', container.innerHTML);

        } else {
            alert('Error updating resource: ' + (result.message || 'Unknown error'));
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Request failed');
        // If an error occurs during save, it's best to refresh the content
        // or at least revert the form, as the state might be inconsistent.
        // For now, just alert and let the user retry or refresh manually.
        // If we want to refresh, we'd call await refreshCourseContent(); here.
    }
}

// Show Add Resource Form Inline
function showAddResourceForm(btn, type) {
    const toolbar = btn.closest('.resource-toolbar');
    const lessonId = toolbar.getAttribute('data-lesson-id');

    if (toolbar.querySelector('.add-resource-form'))
        return;

    const formWrapper = document.createElement('div');
    formWrapper.className = 'add-resource-form mt-3 w-full animate-[fadeInUp_0.2s_ease]';
    formWrapper.innerHTML = `
        <div class="flex flex-col gap-2 p-3 bg-slate-50 border border-emerald-200 rounded-lg w-full shadow-sm">
            <div class="flex items-center gap-2 mb-1">
                <span class="material-symbols-outlined text-[16px] text-[#10B981]">${type === 'video' ? 'play_circle' : (type === 'document' ? 'menu_book' : 'terminal')}</span>
                <span class="text-xs font-bold text-slate-700 uppercase tracking-wide">New ${type}</span>
            </div>
            <input type="text" id="new-res-title" placeholder="${type === 'video' ? 'Video' : (type === 'document' ? 'Document' : 'Assignment')} Title..."
                class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500" autofocus>
            
            ${type !== 'assignment' ? `
            <input type="text" id="new-res-url" placeholder="Resource URL..."
                class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500">
            ` : `
            <textarea id="new-res-desc" placeholder="Assignment Description..." class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500" rows="2"></textarea>
            <textarea id="new-res-reqs" placeholder="Assignment Requirements / Criteria..." class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500" rows="2"></textarea>
            <textarea id="new-res-output" placeholder="Expected Output..." class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500" rows="2"></textarea>
            <input type="text" id="new-res-files" placeholder="File Extensions (e.g. .java, .cpp)" class="border border-emerald-300 rounded px-3 py-1.5 text-sm text-slate-900 w-full focus:outline-none focus:ring-2 focus:ring-emerald-500">
            `}

            <div class="flex justify-end gap-2 mt-2">
                <button type="button" class="cancel-res-btn text-xs text-slate-600 hover:text-slate-900 font-medium px-3 py-1.5 rounded transition-colors">Cancel</button>
                <button type="button" class="submit-res-btn text-xs bg-emerald-500 text-white font-bold rounded px-4 py-1.5 hover:bg-emerald-600 shadow-sm transition-colors">Add ${type === 'video' ? 'Video' : (type === 'document' ? 'Doc' : 'Task')}</button>
            </div>
        </div>
    `;

    toolbar.appendChild(formWrapper);
    const titleInput = formWrapper.querySelector('#new-res-title');
    const urlInput = formWrapper.querySelector('#new-res-url');
    titleInput.focus();

    async function submitAddResource() {
        const title = titleInput.value.trim();
        
        const body = new URLSearchParams();
        body.append('action', 'create');
        body.append('lesson_id', lessonId);
        body.append('title', title);

        let endpoint = '/resourceAdmin';

        if (type === 'assignment') {
            const desc = formWrapper.querySelector('#new-res-desc').value.trim();
            const reqs = formWrapper.querySelector('#new-res-reqs').value.trim();
            const output = formWrapper.querySelector('#new-res-output').value.trim();
            const files = formWrapper.querySelector('#new-res-files').value.trim();
            
            if (!title) return;
            body.append('description', desc);
            body.append('criteria', reqs);
            body.append('expected_output', output);
            body.append('file_extensions', files);
            endpoint = '/assignmentAdmin';
        } else {
            const url = urlInput ? urlInput.value.trim() : '';
            if (!title || !url) return;
            body.append('url', url);
            body.append('resource_type', type);
        }

        const btn = formWrapper.querySelector('.submit-res-btn');
        btn.disabled = true;
        btn.innerText = 'Adding...';

        try {
            const response = await fetch((window.CONTEXT_PATH || '') + endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            });
            const result = await response.json();
            if (result.status === 'success') {
                await refreshCourseContent();
            } else {
                alert('Error creating ' + type + ': ' + (result.message || 'Unknown error'));
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Request failed');
        } finally {
            if (btn) {
                btn.disabled = false;
                btn.innerText = 'Add ' + type;
            }
        }
    }

    formWrapper.querySelector('.cancel-res-btn').addEventListener('click', () => formWrapper.remove());
    formWrapper.querySelector('.submit-res-btn').addEventListener('click', submitAddResource);

    if (urlInput) {
        urlInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                submitAddResource();
            } else if (e.key === 'Escape') {
                formWrapper.remove();
            }
        });
    }

    titleInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            if (urlInput) {
                urlInput.focus();
            } else {
                submitAddResource();
            }
        } else if (e.key === 'Escape') {
            formWrapper.remove();
        }
    });

}

// Reload course content DOM dynamically via HTML partial fetch without full page reload
async function refreshCourseContent() {
    try {
        const response = await fetch(window.location.href);
        if (!response.ok) throw new Error("Fetch failed");
        
        const html = await response.text();
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        
        const currentContent = document.getElementById('course-content-area');
        const newContent = doc.getElementById('course-content-area');
        
        if (currentContent && newContent) {
            currentContent.innerHTML = newContent.innerHTML;
        } else {
            console.warn("Could not find course-content-area, falling back to reload.");
            window.location.reload();
        }
    } catch (e) {
        console.error("Failed to refresh course content", e);
        window.location.reload();
    }
}
