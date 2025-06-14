import api from "../../utils/apiHelper";
import { logout } from "../../utils/authHelper";

document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("myModal");
  // const openBtn = document.getElementById("openModalBtn");
  const closeBtn = modal.querySelector(".close-btn");
  const gridItems = document.querySelectorAll(".grid-item");
  const modalTitle = modal.querySelector("#modalTitle");
  const modalBody = modal.querySelector("#modalBody");
  gridItems.forEach((item) => {
    item.addEventListener("click", () => {
      const title = item.getAttribute("data-title");
      if (title === "Añadir Pelicula") {
        modalTitle.textContent = title;
        modalBody.innerHTML = `
            <form id="addMovieForm">
              <div class="form-group">
                <label for="movieTitle">Título</label>
                <input type="text" id="movieTitle" name="movieTitle" required>
                <label for="moviePoster">URL del Poster</label>
                <input type="text" id="moviePoster" name="moviePoster" required>
                <label for="movieYear">Año</label>
                <input type="number" id="movieYear" name="movieYear"></input>
                <label for="summary">Resumen</label>
                <input type="text" id="summary" name="summary"></input>
                <label for="genres">Generos</label>
                <input type="text" id="genres" name="genres"></input>
                <label for="runtime">Runtime</label>
                <input type="text" id="runtime" name="runtime"></input>
                <label for="director">Director</label>
                <input type="text" id="director" name="director"></input>
                <label for="cast">Cast</label>
                <input type="text" id="cast" name="cast"></input>
                <label for="rating">Rating</label>
                <input type="text" id="rating" name="rating"></input>
                <button type="submit">Añadir Película</button>
              </div>
            </form>`;

        const addMovieForm = document.querySelector("#addMovieForm");

        addMovieForm.addEventListener("submit", async (event) => {
          event.preventDefault();
          const movieTitle = document.getElementById("movieTitle").value;
          const poster = document.getElementById("moviePoster").value;
          const movieYear = document.getElementById("movieYear").value;
          const summary = document.getElementById("summary").value;
          const genres = document.getElementById("genres").value;
          const runtime = document.getElementById("runtime").value;
          const director = document.getElementById("director").value;
          const cast = document.getElementById("cast").value;
          const rating = document.getElementById("rating").value;

          const email = localStorage.getItem("userEmail");
          const movieData = {
            movie_poster: poster,
            title: movieTitle,
            year: movieYear,
            summary: summary,
            genres: genres,
            runtime: runtime,
            director: director,
            cast: cast,
            rating: rating,
            email: email,
          };
          const response = await api.post("/movies", movieData);
          console.log(movieData);
          console.log(response);
          if (response.status === 201) {
            alert("Película añadida correctamente.");
            addMovieForm.reset();
            modal.classList.remove("active");
          } else {
            alert("Error al añadir la película.");
          }
        });

        modal.classList.add("active");
      } else if (title === "Bitacora") {
        window.location.href = "../logs/logs.html";
      } else if (title === "Administrar Usuarios") {
        window.location.href = "../users/users.html";
      } else if (title === "Administrar Peliculas") {
        window.location.href = "../movies/movies.html";
      } else {
        modalTitle.textContent = title;
        modalBody.innerHTML = `
            <p>Funcionalidad para "${title}" aún no implementada.</p>`;
        modal.classList.add("active");
      }
    });
  });
  //   openBtn.onclick = () => modal.classList.add("active");
  closeBtn.onclick = () => modal.classList.remove("active");
  window.onclick = (e) => {
    if (e.target === modal) modal.classList.remove("active");
  };
  document.getElementById("logout-btn").addEventListener("click", () => {
    logout();
  });
});
