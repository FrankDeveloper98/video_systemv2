const movieModel = require("../db/repositories/movieRepo");
const setDbSessionVars = require('../middleware/dbSessionVars');
const db = require('../config/db');

exports.getAllMovies = async (req, res, next) => {
  try {
    const movies = await movieModel.getAllMovies();
    res.status(200).json(movies);
  } catch (error) {
    next(error);
  }
};

exports.saveMovie = async (req, res, next) => {
  try {
    const username = req.body.email || 'anonymous';
    await setDbSessionVars(req, db, username);
    const movies = await movieModel.saveMovie(req.body);
    res.status(201).json(movies);
  } catch (error) {
    next(error);
  }
};

exports.updateMovie = async (req, res, next) => {
  try {
    const username = req.query.email || 'anonymous';
    await setDbSessionVars(req, db, username);
    const { movieId } = req.params;
    const updatedMovie = await movieModel.updateMovie(movieId, req.body);
    res.status(200).json(updatedMovie);
  } catch (error) {
    next(error);
  }
};

exports.deleteMovie = async (req, res, next) => {
  try {
    const username = req.query.email || 'anonymous';
    await setDbSessionVars(req, db, username);
    const { movieId } = req.params;
    await movieModel.deleteMovie(movieId);
    res.status(200).json({ message: "Movie deleted successfully" });
  } catch (error) {
    next(error);
  }
};