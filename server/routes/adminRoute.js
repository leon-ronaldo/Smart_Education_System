const express = require("express");
const router = express.Router();

const {
    getClassRoom,
    getClassRooms
} = require('../controllers/adminController');

router.route('/:id').get(getClassRooms);
router.route('/:id/:classID').get(getClassRoom);
router.route('/:id/:classID/confirm').get(getClassRoom);

module.exports = router