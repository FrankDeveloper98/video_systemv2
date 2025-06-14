const os = require('os');

async function setDbSessionVars(req, dbClient, username) {
    const browser = req.headers['user-agent'] || 'Unknown';
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    const machine = os.hostname();

    await dbClient.query(`SET app.username = $1`, [username]);
    await dbClient.query(`SET app.browser = $1`, [browser]);
    await dbClient.query(`SET app.ip = $1`, [ip]);
    await dbClient.query(`SET app.machine = $1`, [machine]);
}

module.exports = setDbSessionVars;
