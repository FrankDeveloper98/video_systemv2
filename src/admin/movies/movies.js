import api from "../../utils/apiHelper.js";

let allMovies = [];
let filteredMovies = [];
let currentPage = 1;
const pageSize = 8;

const movieList = document.getElementById("movieList");
const searchInput = document.getElementById("searchInput");
const yearFilter = document.getElementById("yearFilter");
const pagination = document.getElementById("pagination");
const modal = document.getElementById("movieModal");
const modalContent = document.getElementById("modalContent");
const closeModalBtn = document.getElementById("closeModal");

document.addEventListener("DOMContentLoaded", async function () {
  allMovies = await fetchMovies();
  populateFilters(allMovies);
  applyFiltersAndRender();

  searchInput.addEventListener("input", () => {
    currentPage = 1;
    applyFiltersAndRender();
  });
  yearFilter.addEventListener("change", () => {
    currentPage = 1;
    applyFiltersAndRender();
  });
  pagination.addEventListener("click", (e) => {
    if (e.target.tagName === "BUTTON" && e.target.dataset.page) {
      currentPage = Number(e.target.dataset.page);
      renderMovies();
      renderPagination();
    }
  });
  closeModalBtn.addEventListener("click", closeModal);
  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal();
  });
});

async function fetchMovies() {
  const response = await api.get("/movies");
  return response.data;
}

function populateFilters(movies) {
  const years = Array.from(new Set(movies.map((m) => m.year))).sort(
    (a, b) => b - a
  );
  yearFilter.innerHTML =
    '<option value="">Todos los años</option>' +
    years.map((y) => `<option value="${y}">${y}</option>`).join("");
}

function applyFiltersAndRender() {
  const search = searchInput.value.trim().toLowerCase();
  const year = yearFilter.value;

  filteredMovies = allMovies.filter((movie) => {
    const matchesSearch =
      movie.title.toLowerCase().includes(search) ||
      movie.director.toLowerCase().includes(search);
    const matchesYear = !year || String(movie.year) === year;
    return matchesSearch && matchesYear;
  });
  renderMovies();
  renderPagination();
}

function renderMovies() {
  movieList.innerHTML = "";
  if (filteredMovies.length === 0) {
    movieList.innerHTML =
      '<div style="padding:2rem;text-align:center;color:var(--text-secondary)">No se encontraron peliculas</div>';
    return;
  }
  const start = (currentPage - 1) * pageSize;
  const end = start + pageSize;
  filteredMovies.slice(start, end).forEach((movie) => {
    const card = document.createElement("div");
    card.className = "list-card";
    card.innerHTML = `
            <div class="movie-card">
                <img class="poster" src=${movie.movie_poster}></img>
                <div>
                    <div class="movie-title">${movie.title}</div>
                    <div class="movie-meta">${movie.year} &bull; ${movie.director}</div>
                </div>
                <button class="deleteMovieBtn" data-id="${movie.id}">
                  <svg xmlns="http://www.w3.org/2000/svg" width="64px" height="64px" viewBox="0 0 24 24"><path fill="#ff5555" d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6zM19 4h-3.5l-1-1h-5l-1 1H5v2h14z"/></svg>
                </button>
            </div>
        `;
    card.addEventListener("click", () => openModal(movie.id));
    card.querySelector(".deleteMovieBtn").addEventListener("click", async (e) => {
      e.stopPropagation();
      const movieId = e.currentTarget.dataset.id;
      const email = localStorage.getItem("userEmail");
      try {
        const response = await api.delete(`/movies/${movieId}?email=${email}`);
        if (response.status === 200) {
          allMovies = allMovies.filter((m) => m.id !== movieId);
          filteredMovies = filteredMovies.filter((m) => m.id !== movieId);
          applyFiltersAndRender();
          closeModal();
          alert("Pelicula eliminada exitosamente");
        } else {
          alert("Error al eliminar la pelicula");
        }
      } catch (error) {}
    });
    movieList.appendChild(card);
  });
}

function renderPagination() {
  const totalPages = Math.ceil(filteredMovies.length / pageSize) || 1;
  let html = "";
  for (let i = 1; i <= totalPages; i++) {
    html += `<button data-page="${i}" class="${
      i === currentPage ? "active" : ""
    }">${i}</button>`;
  }
  pagination.innerHTML = html;
}

async function openModal(movieId) {
  const movie = allMovies.find((m) => m.id === movieId);
  if (!movie) return;
  modalContent.innerHTML = `
        <span class="close" id="closeModal">&times;</span>
        <div class="moviePoster">
            <img class="modalPoster" src="${movie.movie_poster}" alt="${movie.title}">
        </div>
        <form id="updateMovieForm">
          <div class="form-col">
            <label for="moviePoster"><strong>Poster URL:</strong></label>
            <input type="url" name="moviePoster" id="moviePoster" value="${movie.movie_poster}">
            <label for="title"><strong>Titulo:</strong></label>
            <input type="text" name="title" id="title" value="${movie.title}">
            <label for="year"><strong>Año:</strong></label>
            <input type="text" name="year" id="year" value="${movie.year}">
            <label for="director"><strong>Director:</strong></label>
            <input type="text" name="director" id="director" value="${movie.director}">
            <label for="cast"><strong>Elenco:</strong></label>
            <input type="text" name="cast" id="cast" value="${movie.cast}">
          </div>
          <div class="form-col">
            <label for="summary"><strong>Resumen:</strong></label>
            <textarea name="summary" id="summary">${movie.summary}</textarea>
            <label for="genres"><strong>Generos:</strong></label>
            <input type="text" name="genres" id="genres" value="${movie.genres}">
            <label for="runtime"><strong>Duracion:</strong></label>
            <input type="text" name="runtime" id="runtime" value="${movie.runtime}">
          </div>
          <button type="submit">Actualizar</button>
        </form>
    `;
  document.getElementById("closeModal").onclick = closeModal;
  modal.classList.add("show");
  document.getElementById("updateMovieForm").onsubmit = async (e) => {
    e.preventDefault();
    const updatedMovie = {
      movie_poster: document.getElementById("moviePoster").value,
      title: document.getElementById("title").value,
      year: document.getElementById("year").value,
      summary: document.getElementById("summary").value,
      genres: document.getElementById("genres").value,
      runtime: document.getElementById("runtime").value,
      director: document.getElementById("director").value,
      cast: document.getElementById("cast").value,
    };
    const email = localStorage.getItem("userEmail");
    const response = await api.put(`/movies/${movieId}?email=${email}`, updatedMovie);
    if (response.status === 200) {
      const index = allMovies.findIndex((m) => m.id === movieId);
      allMovies[index] = { ...allMovies[index], ...updatedMovie };
      applyFiltersAndRender();
      alert("Pelicula actualizada exitosamente");
      closeModal();
    } else {
      alert("Error al actualizar la pelicula");
    }
  };
}

function closeModal() {
  modal.classList.remove("show");
}
