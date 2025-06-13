const db = require("../../config/db");

class movieRepo {
  static async getAllMovies() {
    try {
      return await db.any(`
        SELECT * FROM movies
      `);
    } catch (error) {
      console.error("Database error:", error);
      throw new Error(`Error fetching movies: ${error.message}`);
    }
  }
  static async saveMovie(movie) {
    try {
      const { movie_poster, title, year, summary, genres, runtime, director, cast, rating  } = movie;
      return await db.any(`
        INSERT INTO movies (movie_poster, title, year, summary, genres, runtime, director, "cast", rating)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
        RETURNING *
      `, [movie_poster, title, year, summary, genres, runtime, director, cast, rating]);
    } catch (error) {
      console.error("Database error:", error);
      throw new Error(`Error saving movie: ${error.message}`);
    }
  }
}

module.exports = movieRepo;
