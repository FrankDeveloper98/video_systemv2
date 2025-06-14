const db = require('../config/db');
const os = require('os');

async function logLogin(req, username) {
    const browser = req.headers['user-agent'] || 'Unknown';
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    const machine = os.hostname();
    await db.none(
        `INSERT INTO user_activity_log (username, login_time, browser, ip_address, machine_name, action_type, description)
         VALUES ($1, NOW(), $2, $3, $4, 'LOGIN', 'User logged in')`,
        [username, browser, ip, machine]
    );
}

async function logLogout(req, username) {
    const browser = req.headers['user-agent'] || 'Unknown';
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    const machine = os.hostname();
    await db.none(
        `INSERT INTO user_activity_log (username, logout_time, browser, ip_address, machine_name, action_type, description)
         VALUES ($1, NOW(), $2, $3, $4, 'LOGOUT', 'User logged out')`,
        [username, browser, ip, machine]
    );
}

module.exports = { logLogin, logLogout };
