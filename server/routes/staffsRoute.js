const express = require("express");
const router = express.Router();
const multer = require('multer');
const { Buffer } = require('buffer');

const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 1024 * 1024 * 10 }});

const {
    createStaff
} = require('../controllers/staffsController');

router.route('/').post(upload.array('timeTable', 1), createStaff);

module.exports = router;