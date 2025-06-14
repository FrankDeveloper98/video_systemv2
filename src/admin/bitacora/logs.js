import api from "../../utils/apiHelper.js";

let logsData = [];
let filteredLogs = [];
let currentPage = 1;
let entriesPerPage = 5;

// DOM Elements
const logsTable = document.getElementById("logsTable");
const tbody = logsTable.querySelector("tbody");
const entriesSelect = document.getElementById("entriesPerPage");
const searchInput = document.getElementById("searchInput");
const pagination = document.getElementById("pagination");

// Fetch and render logs on load
window.addEventListener("DOMContentLoaded", async () => {
  logsData = await getData();
  filteredLogs = [...logsData];
  renderTable();
  renderPagination();
});

entriesSelect.addEventListener("change", (e) => {
  entriesPerPage = parseInt(e.target.value, 10);
  currentPage = 1;
  renderTable();
  renderPagination();
});

searchInput.addEventListener("input", (e) => {
  const term = e.target.value.trim().toLowerCase();
  filteredLogs = logsData.filter((log) =>
    Object.values(log).some((val) =>
      String(val).toLowerCase().includes(term)
    )
  );
  currentPage = 1;
  renderTable();
  renderPagination();
});

function renderTable() {
  tbody.innerHTML = "";
  const start = (currentPage - 1) * entriesPerPage;
  const end = start + entriesPerPage;
  const pageLogs = filteredLogs.slice(start, end);
  if (pageLogs.length === 0) {
    tbody.innerHTML = `<tr><td colspan="11" style="text-align:center;">No hay registros</td></tr>`;
    return;
  }
  pageLogs.forEach((log) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td title="${log.id}">${log.id}</td>
      <td title="${log.username}">${log.username}</td>
      <td title="${log.login_time ?? ''}">${log.login_time ?? ""}</td>
      <td title="${log.logout_time ?? ''}">${log.logout_time ?? ""}</td>
      <td title="${log.browser}">${log.browser}</td>
      <td title="${log.ip_address}">${log.ip_address}</td>
      <td title="${log.machine_name}">${log.machine_name}</td>
      <td title="${log.table_name ?? ''}">${log.table_name ?? ""}</td>
      <td title="${log.action_type}">${log.action_type}</td>
      <td title="${log.description}">${log.description}</td>
      <td title="${log.action_time}">${log.action_time}</td>
    `;
    tbody.appendChild(row);
  });
}

function renderPagination() {
  pagination.innerHTML = "";
  const totalPages = Math.ceil(filteredLogs.length / entriesPerPage) || 1;
  for (let i = 1; i <= totalPages; i++) {
    const btn = document.createElement("button");
    btn.textContent = i;
    btn.className = i === currentPage ? "active" : "";
    btn.disabled = i === currentPage;
    btn.addEventListener("click", () => {
      currentPage = i;
      renderTable();
      renderPagination();
    });
    pagination.appendChild(btn);
  }
}

async function getData() {
  const response = await api.get("/logs");
  return response.data;
}