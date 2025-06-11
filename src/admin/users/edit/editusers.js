import api from "../../../utils/apiHelper.js";

document.addEventListener("DOMContentLoaded", async () => {
  const table = document.getElementById("usersTable");
  const users = await getUsers();
  const tbody = table.querySelector("tbody");
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
  const deleteButtons = table.querySelectorAll(".delete-btn");
  deleteButtons.forEach(async (btn) => {
    btn.addEventListener("click", async (e) => {
      const userId = e.target.getAttribute("data-id");
      try {
        await api.delete(`/users/${userId}`);
        e.target.closest("tr").remove();
        alert("Usuario eliminado correctamente.");
      } catch (error) {
        console.error("Error al eliminar el usuario:", error);
        alert("Error al eliminar el usuario.");
      }
    });
  });
});

async function getUsers() {
  const response = await api.get("/users/");
  const data = await response.data;
  return data;
}
