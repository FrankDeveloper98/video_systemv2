
import api from '../../utils/apiHelper.js'

document.addEventListener('DOMContentLoaded', async function() {
    const moviesData = await fetchMovies();
    moviesData.forEach(movie => {
        const movieElement = document.createElement('div');
        movieElement.textContent = `${movie.title} (${movie.year}) - Directed by ${movie.director}`;
        document.body.appendChild(movieElement);
    });
})

async function fetchMovies() {
    const response = await api.get('/movies');
    return response.data;
}   