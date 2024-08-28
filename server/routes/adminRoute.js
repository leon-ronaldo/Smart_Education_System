const express = require("express");
const router = express.Router();

const {
    getClassRoom,
    getClassRooms,
    confirmClassRoom
} = require('../controllers/adminController');

router.route('/:id').get(getClassRooms);
router.route('/:id/:classID').get(getClassRoom);
router.route('/:id/:classID/confirm').get(confirmClassRoom);

module.exports = router