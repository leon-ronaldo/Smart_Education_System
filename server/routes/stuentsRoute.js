const express = require("express");
const router = express.Router();
const multer = require('multer');

const {
    createStudent
} = require('../controllers/studentsController')

const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 1024 * 1024 * 10 }});

router.route('/').post(upload.array('file', 2), createStudent);

module.exports = router;