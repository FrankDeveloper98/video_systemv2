const db = require('../../config/db');

exports.getAllUsers = async () => {
  return db.manyOrNone('SELECT * FROM users ORDER BY id');
}

exports.create = async (userData) => {
  const { name, lastname, email, password, phone } = userData;
  
  return db.one(
    'INSERT INTO users (name, lastname, email, password, phone) VALUES ($1, $2, $3, $4, $5) RETURNING id, name, email, phone',
    [name, lastname, email, password, phone]
  );
};

exports.deleteUser = async (id) => {
  return db.none('DELETE FROM users WHERE id = $1', [id]);
}

exports.findByEmail = async (email) => {
  return db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
};

exports.findById = async (id) => {
  return db.oneOrNone('SELECT id, name, lastname, email, phone FROM users WHERE id = $1', [id]);
};

exports.updateUser = async (id, data) => {
  const { name, lastname, email, phone } = data;
  const result = await db.result(
    'UPDATE users SET name = $1, lastname = $2, email = $3, phone = $4, updated_at = NOW() WHERE id = $5',
    [name, lastname, email, phone, id]
  );
  return result.rowCount > 0;
};

exports.addToFavorites = async (userId, movieId) => {
  return db.none(
    'INSERT INTO user_favorites (id_user, id_movie) VALUES ($1, $2)',
    [userId, movieId]
  );
};

exports.removeFromFavorites = async (userId, movieId) => {
  return db.none(
    'DELETE FROM user_favorites WHERE id_user = $1 AND id_movie = $2',
    [userId, movieId]
  );
};

exports.getFavoriteByUserAndMovie = async (userId, movieId) => {
  return db.oneOrNone(
    'SELECT * FROM user_favorites WHERE id_user = $1 AND id_movie = $2',
    [userId, movieId]
  );
};

exports.getFavoriteMovies = async (userId) => {
  return db.manyOrNone(`
    SELECT m.*, uf.id_user 
    FROM movies m 
    INNER JOIN user_favorites uf ON m.id = uf.id_movie 
    WHERE uf.id_user = $1
    ORDER BY m.title
  `, [userId]);
};

exports.getUsersPaginated = async (limit, offset, search = "") => {
  let users, totalResult;
  if (search) {
    const searchQuery = `%${search.toLowerCase()}%`;
    users = await db.manyOrNone(
      `SELECT * FROM users WHERE 
        LOWER(name) LIKE $1 OR 
        LOWER(lastname) LIKE $1 OR 
        LOWER(email) LIKE $1 OR 
        phone LIKE $1 
      ORDER BY id LIMIT $2 OFFSET $3`,
      [searchQuery, limit, offset]
    );
    totalResult = await db.one(
      `SELECT COUNT(*) FROM users WHERE 
        LOWER(name) LIKE $1 OR 
        LOWER(lastname) LIKE $1 OR 
        LOWER(email) LIKE $1 OR 
        phone LIKE $1`,
      [searchQuery]
    );
  } else {
    users = await db.manyOrNone('SELECT * FROM users ORDER BY id LIMIT $1 OFFSET $2', [limit, offset]);
    totalResult = await db.one('SELECT COUNT(*) FROM users');
  }
  return [users, parseInt(totalResult.count, 10)];
};
