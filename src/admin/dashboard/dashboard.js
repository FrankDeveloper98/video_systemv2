document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("myModal");
  const openBtn = document.getElementById("openModalBtn");
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
                <button type="submit">Añadir Película</button>
              </div>
            </form>`;
        modal.classList.add("active");
      } else if (title === "Editar Peliculas") {
        modalTitle.textContent = title;
        modalBody.innerHTML = `
            <form id="editMovieForm">
              <label for="movieId">ID de Película:</label>
              <input type="text" id="movieId" name="movieId" required>
              <label for="newMovieTitle">Nuevo Título:</label>
              <input type="text" id="newMovieTitle" name="newMovieTitle" required>
              <button type="submit">Editar Película</button>
            </form>`;
        modal.classList.add("active");
      } else if (title === "Editar Usuarios") {
        window.location.href = "../users/edit/editusers.html";
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
});
