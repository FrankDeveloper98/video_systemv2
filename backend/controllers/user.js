const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const userRepo = require("../db/repositories/userRepo");
const config = require("../config/server");
const setDbSessionVars = require('../middleware/dbSessionVars');
const db = require('../config/db');
const { logLogin, logLogout } = require('../utils/logUserSession');

exports.register = async (req, res, next) => {
  try {
    const { name, lastname, email, password, phone } = req.body;
    const username = req.body.userAction || 'anonymous';
    await setDbSessionVars(req, db, username);

    const existingUser = await userRepo.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: "El usuario ya existe" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = await userRepo.create({
      name,
      lastname,
      email,
      password: hashedPassword,
      phone,
    });

    // Generate token
    const token = jwt.sign({ id: newUser.id }, config.jwtSecret, {
      expiresIn: config.jwtExpiresIn,
    });

    res.status(201).json({
      message: "User registered successfully",
      token,
      user: {
        id: newUser.id,
        name: newUser.name,
        lastname: newUser.lastname,
        email: newUser.email,
        phone: newUser.phone,
      },
    });
  } catch (error) {
    next(error);
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = await userRepo.findByEmail(email);
    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // Verify password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // Generate token
    const token = jwt.sign({ id: user.id }, config.jwtSecret, {
      expiresIn: config.jwtExpiresIn,
    });

    await logLogin(req, email);

    res.json({
      message: "Login successful",
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role_id
      },
    });
  } catch (error) {
    next(error);
  }
};

exports.getAllUsers = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page, 10) || 1;
    const limit = parseInt(req.query.limit, 10) || 10;
    const offset = (page - 1) * limit;
    const search = req.query.search || "";
    let sort = { key: null, asc: true };
    if (req.query.sort) {
      sort.key = req.query.sort;
      sort.asc = req.query.asc === "false" ? false : true;
    }
    const [users, total] = await userRepo.getUsersPaginated(limit, offset, search, sort);
    res.status(200).json({ users, total });
  } catch (error) {
    next(error);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    const userId = req.params.userId;
    const username = req.query.email || 'anonymous';
    if (username) {
      await userRepo.deleteUser(userId, req, username);
      res.status(200).json({ message: "Usuario eliminado correctamente" });
    }
  } catch (error) {
    next(error);
  }
};

exports.addToFavorites = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { movieId } = req.body;
    const username = req.body.email || 'anonymous';

    const existingFavorite = await userRepo.getFavoriteByUserAndMovie(
      userId,
      movieId
    );
    if (existingFavorite) {
      return res
        .status(400)
        .json({ message: "La película ya está en favoritos" });
    }

    await userRepo.addToFavorites(userId, movieId, req, username);
    res.status(200).json({ message: "Película agregada a favoritos" });
  } catch (error) {
    next(error);
  }
};

exports.removeFromFavorites = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { movieId } = req.params;
    const username = req.query.email || 'anonymous';

    await userRepo.removeFromFavorites(userId, movieId, req, username);
    res.status(200).json({ message: "Película eliminada de favoritos" });
  } catch (error) {
    next(error);
  }
};

exports.getFavorites = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const favorites = await userRepo.getFavoriteMovies(userId);
    res.status(200).json(favorites);
  } catch (error) {
    next(error);
  }
};

exports.getUserById = async (req, res, next) => {
  try {
    const user = await userRepo.findById(req.params.userId);
    if (!user) return res.status(404).json({ message: "Usuario no encontrado" });
    res.json(user);
  } catch (error) {
    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  try {
    const { name, lastname, email, phone } = req.body;
    const userId = req.params.userId;
    const updated = await userRepo.updateUser(userId, { name, lastname, email, phone });
    if (!updated) return res.status(404).json({ message: "Usuario no encontrado" });
    res.json({ message: "Usuario actualizado" });
  } catch (error) {
    next(error);
  }
};

exports.logout = async (req, res, next) => {
  try {
    const username = req.body.email || 'anonymous';
    await logLogout(req, username);
    res.status(200).json({ message: "Logout exitoso" });
  } catch (error) {
    next(error);
  }
};
