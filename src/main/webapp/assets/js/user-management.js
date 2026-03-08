// ===============================
// ADD MODAL
// ===============================

function openAddUserModal() {
    const modal = document.getElementById("addUserModal");
    if (!modal) return;

    modal.classList.remove("hidden");
    modal.classList.add("flex");
    document.body.style.overflow = "hidden";
}

function closeAddUserModal() {
    const modal = document.getElementById("addUserModal");
    if (!modal) return;

    modal.classList.add("hidden");
    modal.classList.remove("flex");
    document.body.style.overflow = "auto";
}

// ===============================
// UPDATE MODAL
// ===============================

function confirmDelete(id) {
    if (confirm("Are you sure you want to delete this user?")) {
        document.getElementById("deleteUserId").value = id;
        document.getElementById("deleteForm").submit();
    }
}

function openUpdateUserModal(id) {
    // find context path
    const pathParts = window.location.pathname.split('/');
    const contextPath = '/' + pathParts[1];
    
    fetch(contextPath + "/admin/users?action=getById&id=" + id)
        .then(response => {
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            return response.json();
        })
        .then(data => {
            document.getElementById("updateUserId").value = data.userId;
            document.getElementById("updateFullName").value = data.fullName;
            document.getElementById("updateEmail").value = data.email;
            document.getElementById("updatePassword").value = ""; // Don't pre-fill password
            document.getElementById("updateRole").value = data.role;
            document.getElementById("updateStatus").value = data.status;

            const modal = document.getElementById("updateUserModal");
            modal.classList.remove("hidden");
            modal.classList.add("flex");
            document.body.style.overflow = "hidden";
        })
        .catch(error => {
            console.error("Fetch error:", error);
            alert("Could not retrieve user data!");
        });
}

function closeUpdateUserModal() {
    const modal = document.getElementById("updateUserModal");
    if (!modal) return;

    modal.classList.add("hidden");
    modal.classList.remove("flex");
    document.body.style.overflow = "auto";
}

// ===============================
// ESC CLOSE
// ===============================

document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
        const addModal = document.getElementById("addUserModal");
        const updateModal = document.getElementById("updateUserModal");

        if (addModal && !addModal.classList.contains("hidden")) {
            closeAddUserModal();
        }

        if (updateModal && !updateModal.classList.contains("hidden")) {
            closeUpdateUserModal();
        }
    }
});
