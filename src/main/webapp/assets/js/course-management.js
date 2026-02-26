// ===============================
// ADD MODAL
// ===============================

function openAddCourseModal() {
    const modal = document.getElementById("addCourseModal");
    if (!modal)
        return;

    modal.classList.remove("hidden");
    modal.classList.add("flex");
    document.body.style.overflow = "hidden";
}

function closeAddCourseModal() {
    const modal = document.getElementById("addCourseModal");
    if (!modal)
        return;

    modal.classList.add("hidden");
    modal.classList.remove("flex");
    document.body.style.overflow = "auto";
}

// ===============================
// UPDATE MODAL
// ===============================
function confirmDelete(id) {
    if (confirm("Bạn có chắc muốn xóa khóa học này không?")) {

        document.getElementById("deleteCourseId").value = id;
        document.getElementById("deleteForm").submit();

    }
}
function openUpdateCourseModal(id) {

    fetch("courseAdmin?action=getById&id=" + id)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(data => {

                document.getElementById("updateCourseId").value = data.courseId;
                document.getElementById("updateTitle").value = data.title;
                document.getElementById("updateDescription").value = data.description;
                document.getElementById("updatePrice").value = data.price;
                document.getElementById("updateLevelInput").value = data.level;
                document.getElementById("updateCategory").value = data.categoryId;
                document.getElementById("updateTeacher").value = data.teacherId;

                // Nếu thumbnail là <img> thì phải set src
                const thumbnailImg = document.getElementById("updateThumbnailUrl");
                if (thumbnailImg) {
                    thumbnailImg.src = data.thumbnailUrl;
                    document.getElementById("updatePreviewBox").classList.remove("hidden");
                    document.getElementById("updateUploadBox").classList.add("hidden");
                }

                const modal = document.getElementById("updateCourseModal");
                modal.classList.remove("hidden");
                modal.classList.add("flex");

                document.body.style.overflow = "hidden";
            })
            .catch(error => {
                console.error("Fetch error:", error);
                alert("Không lấy được dữ liệu course!");
            });
}

function closeUpdateCourseModal() {
    const modal = document.getElementById("updateCourseModal");
    if (!modal)
        return;

    modal.classList.add("hidden");
    modal.classList.remove("flex");
    document.body.style.overflow = "auto";
}

// ===============================
// ESC CLOSE (GỘP 1 LẦN DUY NHẤT)
// ===============================

document.addEventListener("keydown", function (e) {

    if (e.key === "Escape") {

        const addModal = document.getElementById("addCourseModal");
        const updateModal = document.getElementById("updateCourseModal");

        if (addModal && !addModal.classList.contains("hidden")) {
            closeAddCourseModal();
        }

        if (updateModal && !updateModal.classList.contains("hidden")) {
            closeUpdateCourseModal();
        }
    }
});

// ===============================
// DOM READY
// ===============================

document.addEventListener("DOMContentLoaded", function () {

    // ===============================
    // ADD - Thumbnail preview
    // ===============================

    const thumbnailInput = document.getElementById("thumbnailInput");

    if (thumbnailInput) {
        thumbnailInput.addEventListener("change", function () {

            const file = this.files[0];
            if (!file)
                return;

            if (!file.type.startsWith("image/")) {
                alert("Please select an image file!");
                return;
            }

            const reader = new FileReader();

            reader.onload = function (e) {
                document.getElementById("thumbnailPreview").src = e.target.result;
                document.getElementById("previewBox").classList.remove("hidden");
                document.getElementById("uploadBox").classList.add("hidden");
            };

            reader.readAsDataURL(file);
        });
    }
// ===============================
// UPDATE - Thumbnail preview
// ===============================

    const updateThumbnailInput = document.getElementById("updateThumbnailInput");

    if (updateThumbnailInput) {
        updateThumbnailInput.addEventListener("change", function () {

            const file = this.files[0];
            if (!file)
                return;

            if (!file.type.startsWith("image/")) {
                alert("Please select an image file!");
                return;
            }

            const reader = new FileReader();

            reader.onload = function (e) {
                document.getElementById("updateThumbnailUrl").src = e.target.result;
                document.getElementById("updatePreviewBox").classList.remove("hidden");
                document.getElementById("updateUploadBox").classList.add("hidden");
            };

            reader.readAsDataURL(file);
        });
    }
    // ===============================
    // ADD - Remove thumbnail
    // ===============================

    window.removeThumbnail = function () {
        document.getElementById("thumbnailInput").value = "";
        document.getElementById("previewBox").classList.add("hidden");
        document.getElementById("uploadBox").classList.remove("hidden");
    };

    // ===============================
    // UPDATE - Remove thumbnail
    // ===============================

    window.removeUpdateThumbnail = function () {
        document.getElementById("updateThumbnailInput").value = "";
        document.getElementById("updatePreviewBox").classList.add("hidden");
        document.getElementById("updateUploadBox").classList.remove("hidden");
    };

    // ===============================
    // LEVEL BUTTON
    // ===============================
// ===============================
// ADD LEVEL BUTTON
// ===============================

    document.querySelectorAll(".add-level-btn").forEach(button => {

        button.addEventListener("click", function () {

            document.querySelectorAll(".add-level-btn").forEach(btn => {
                btn.classList.remove(
                        "bg-white",
                        "dark:bg-primary",
                        "text-slate-700",
                        "dark:text-background-dark",
                        "shadow-sm"
                        );
                btn.classList.add(
                        "text-slate-500",
                        "dark:text-primary/60"
                        );
            });

            this.classList.add(
                    "bg-white",
                    "dark:bg-primary",
                    "text-slate-700",
                    "dark:text-background-dark",
                    "shadow-sm"
                    );

            this.classList.remove(
                    "text-slate-500",
                    "dark:text-primary/60"
                    );

            document.getElementById("levelInput").value = this.dataset.level;
        });
    });

// ===============================
// UPDATE LEVEL BUTTON
// ===============================

    document.querySelectorAll(".update-level-btn").forEach(button => {

        button.addEventListener("click", function () {

            document.querySelectorAll(".update-level-btn").forEach(btn => {
                btn.classList.remove(
                        "bg-white",
                        "dark:bg-primary",
                        "text-slate-700",
                        "dark:text-background-dark",
                        "shadow-sm"
                        );
                btn.classList.add(
                        "text-slate-500",
                        "dark:text-primary/60"
                        );
            });

            this.classList.add(
                    "bg-white",
                    "dark:bg-primary",
                    "text-slate-700",
                    "dark:text-background-dark",
                    "shadow-sm"
                    );

            this.classList.remove(
                    "text-slate-500",
                    "dark:text-primary/60"
                    );

            document.getElementById("updateLevelInput").value = this.dataset.level;
        });
    });

    // ===============================
    // ADD FORM SUBMIT
    // ===============================

    const addForm = document.getElementById("addCourseForm");
    if (addForm) {
        addForm.addEventListener("submit", function () {
            document.getElementById("loadingOverlay")
                    .classList.remove("hidden");
        });
    }

    // ===============================
    // UPDATE FORM SUBMIT
    // ===============================

    const updateForm = document.getElementById("updateCourseForm");
    if (updateForm) {
        updateForm.addEventListener("submit", function () {
            document.getElementById("updateLoadingOverlay")
                    .classList.remove("hidden");
        });
    }

});