const express = require("express");
const logsController = require("../controllers/logs");
const router = express.Router();

router.get("/", logsController.logs);

module.exports = router;