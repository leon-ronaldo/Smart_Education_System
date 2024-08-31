const asyncHandler = require("express-async-handler");
const classRoomModel = require("../models/staffModel");
const { Buffer } = require('buffer');
const staffModel = require("../models/staffModel");

const createStaff = asyncHandler(async (req, res) => {
    if (!req.body) {
        console.log("body cannot be null");
        res.status(400).json({message: 'body cannot be null'});
    }

    console.log(req.body);

    const timetable = req.files[0];
    const timetable64string = Buffer.from(timetable.buffer).toString('base64');

    try {
        const staff = await staffModel.create({
            staffID: req.body.staffID,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            age: req.body.age,
            dateOfBirth: req.body.dateOfBirth,
            gender: req.body.gender,
            department: req.body.department,
            phone: req.body.phone,
            email: req.body.email,
            photoUrl: req.body.photoUrl,
            mentoringClass: req.body.mentoringClass,
            timetable: timetable64string,
        });

        if (!staff) {
            console.log('error creating student');
            res.status(400).json({message: 'error creating student'});
        }

        res.status(200).json(staff);
    }
    
    catch (error) {
        console.log(error);
        res.status(400).json({error: error});
    }
});

module.exports = { createStaff };