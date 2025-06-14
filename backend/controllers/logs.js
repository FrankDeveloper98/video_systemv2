const logsModel = require("../db/repositories/logsRepo.js");

exports.logs = async (req, res, next) => {
    try {
        const logs = await logsModel.getAllLogs();
        res.status(200).json(logs);
    } catch (error) {
        next(error);
    }
}