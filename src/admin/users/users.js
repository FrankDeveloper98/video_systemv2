import api from "../../utils/apiHelper.js";

let USERS_PER_PAGE = 5;
let currentPage = 1;
let totalPages = 1;
let currentSort = { key: null, asc: true };
let currentSearch = "";

async function renderUsers(page = 1) {
  const table = document.getElementById("usersTable");
  const tbody = table.querySelector("tbody");
  tbody.innerHTML = "";
  const { users, total } = await getUsers(page, USERS_PER_PAGE, currentSearch, currentSort);
  users.forEach((user) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${user.id}</td>
      <td>${user.name}</td>
      <td>${user.lastname}</td>
      <td>${user.email}</td>
      <td>${user.phone}</td>
      <td>
        <button class="edit-btn" data-id="${user.id}">Editar</button>
        <button class="delete-btn" data-id="${user.id}">Eliminar</button>
      </td>
    `;
    tbody.appendChild(row);
  });
  addDeleteListeners();
  addEditListeners();
  totalPages = Math.ceil(total / USERS_PER_PAGE);
  renderPagination();
}

function renderPagination() {
  let pagination = document.getElementById("pagination");
  pagination.innerHTML = "";
  for (let i = 1; i <= totalPages; i++) {
    const btn = document.createElement("button");
    btn.textContent = i;
    btn.disabled = i === currentPage;
    if (i === currentPage) btn.classList.add("active");
    btn.addEventListener("click", () => {
      currentPage = i;
      renderUsers(currentPage);
    });
    pagination.appendChild(btn);
  }
}

function addDeleteListeners() {
  const table = document.getElementById("usersTable");
  const deleteButtons = table.querySelectorAll(".delete-btn");
  deleteButtons.forEach((btn) => {
    btn.addEventListener("click", async (e) => {
      const userId = e.target.getAttribute("data-id");
      const email = localStorage.getItem("userEmail"); 
      try {
        await api.delete(`/users/${userId}?email=${email}`);
        e.target.closest("tr").remove();
        alert("Usuario eliminado correctamente.");
        renderUsers(currentPage); // Refresh after delete
      } catch (error) {
        console.error("Error al eliminar el usuario:", error);
        alert("Error al eliminar el usuario.");
      }
    });
  });
}

// Modal logic
const modal = document.getElementById("userModal");
const closeModal = () => { modal.style.display = "none"; };
const openModal = (user = null) => {
  document.getElementById("userForm").reset();
  document.getElementById("userId").value = user ? user.id : "";
  document.getElementById("modalName").value = user ? user.name : "";
  document.getElementById("modalLastname").value = user ? user.lastname : "";
  document.getElementById("modalEmail").value = user ? user.email : "";
  document.getElementById("modalPhone").value = user ? user.phone : "";
  document.getElementById("modalTitle").textContent = user ? "Editar Usuario" : "Agregar Usuario";
  document.getElementById("passwordGroup").style.display = user ? "none" : "flex";
  modal.style.display = "block";
};
document.querySelector(".close").onclick = closeModal;
window.onclick = function(event) { if (event.target === modal) closeModal(); };
document.getElementById("addUserBtn").onclick = () => openModal();

// Edit button logic
function addEditListeners() {
  document.querySelectorAll(".edit-btn").forEach(btn => {
    btn.onclick = async (e) => {
      const userId = e.target.getAttribute("data-id");
      const user = await getUserById(userId);
      openModal(user);
    };
  });
}

async function getUserById(id) {
  const res = await api.get(`/users/${id}`);
  return res.data;
}

// Save (add/edit) user
const userForm = document.getElementById("userForm");
userForm.onsubmit = async (e) => {
  e.preventDefault();
  const id = document.getElementById("userId").value;
  const name = document.getElementById("modalName").value;
  const lastname = document.getElementById("modalLastname").value;
  const email = document.getElementById("modalEmail").value;
  const phone = document.getElementById("modalPhone").value;
  const password = document.getElementById("modalPassword").value;
  const userAction = localStorage.getItem("userEmail");
  try {
    if (id) {
      await api.put(`/users/${id}`, { name, lastname, email, phone });
    } else {
      await api.post(`/users/register`, { name, lastname, email, phone, password, userAction });
    }
    closeModal();
    renderUsers(currentPage);
  } catch (err) {
    alert("Error al guardar usuario");
  }
};

function addFiltersListeners() {
  // Entries per page
  document.getElementById("entriesPerPage").addEventListener("change", (e) => {
    USERS_PER_PAGE = parseInt(e.target.value, 10);
    currentPage = 1;
    renderUsers(currentPage);
  });
  // Search
  document.getElementById("searchInput").addEventListener("input", (e) => {
    currentSearch = e.target.value;
    currentPage = 1;
    renderUsers(currentPage);
  });
  // Sort
  document.querySelectorAll("#usersTable th[data-sort]").forEach((th) => {
    th.style.cursor = "pointer";
    th.addEventListener("click", () => {
      const key = th.getAttribute("data-sort");
      if (currentSort.key === key) {
        currentSort.asc = !currentSort.asc;
      } else {
        currentSort.key = key;
        currentSort.asc = true;
      }
      renderUsers(currentPage);
    });
  });
}

document.addEventListener("DOMContentLoaded", () => {
  addFiltersListeners();
  renderUsers(currentPage);
});

async function getUsers(page = 1, limit = USERS_PER_PAGE, search = "", sort = { key: null, asc: true }) {
  const params = new URLSearchParams();
  params.append("page", page);
  params.append("limit", limit);
  if (search) params.append("search", search);
  if (sort.key) {
    params.append("sort", sort.key);
    params.append("asc", sort.asc);
  }
  const response = await api.get(`/users?${params.toString()}`);
  return response.data;
}
