const express = require("express");
const router = express.Router();
const multer = require('multer');
const { Buffer } = require('buffer');

const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 1024 * 1024 * 10 }});

const {
    createClassRoom,
    getClassRooms,
    getClassRoom,
    addAttendance,
} = require('../controllers/classRoomController');

const ensureAuthenticated=require("../middleware/authMiddleware");

router.route("/").post(createClassRoom).get(getClassRooms);
router.route("/:id").get(getClassRoom);
router.route("/:id/addAttendance").post(upload.single('picture'), addAttendance);

module.exports = router;