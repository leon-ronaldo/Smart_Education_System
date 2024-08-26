const express = require("express");
const router = express.Router();
const multer = require('multer');
const { Buffer } = require('buffer');

const upload = multer({ storage: multer.memoryStorage(), limits: { fileSize: 1024 * 1024 * 10 }});

const {
    createClassRoom,
    getClassRoom,
    addAttendance,
    runAttendanceScript
} = require('../controllers/classRoomController');

const ensureAuthenticated=require("../middleware/authMiddleware");

router.route("/").post(createClassRoom);
router.route("/:id").get(getClassRoom);
router.route("/:id/addAttendance").post(upload.single('picture'), async (req, res) => {
    if (!req.file) {
        console.log("no file uploaded");
        res.end(400).json({message: 'no file uploaded'});
        return;
    }

    const photo = req.file;

    const base64String = Buffer.from(photo.buffer).toString('base64');

    const attendance = await runAttendanceScript(base64String);
    console.log(attendance);
    res.status(200).json();
    res.end();
});

module.exports = router;