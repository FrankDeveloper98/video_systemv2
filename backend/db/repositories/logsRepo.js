const db = require('../../config/db');

exports.getAllLogs = async () => {
    return db.manyOrNone(
        `SELECT * FROM user_activity_log ORDER BY id DESC`
    )
}