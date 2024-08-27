const asyncHandler = require("express-async-handler");
const studentModel = require("../models/studentModel");
const classRoomModel = require('../models/classRoomModel');

const createStudent = asyncHandler(async (req, res) => {
    if (!req.body) {
        console.log("body cannot be null");
    }

    const firstPhoto = req.files[0];
    const secondPhoto = req.files[1];

    const firstBase64String = Buffer.from(firstPhoto.buffer).toString('base64');
    const secondBase64String = Buffer.from(secondPhoto.buffer).toString('base64');

    const classRoom = await classRoomModel.findOne({classRoomID: req.body.classRoomID});

    if (!classRoom) {
        res.status(404).json({message: "no such classroom"});
        res.end();
        return;
    }

    try {
        const student = await studentModel.create({
            studentID: req.body.studentID,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            age: req.body.age,
            gender: req.body.gender,
            section: classRoom.section,
            class: classRoom.grade,
            dateOfBirth: req.body.bDay,
            phone: req.body.phone,
            email: req.body.email,
            address: req.body.address,
            classRoomID: req.body.classRoomID,
            photoData1: firstBase64String,
            photoData2: secondBase64String,
            // Add other fields from your Dart client
          });
          console.log(student);
        res.status(200).json(student);
        res.end();
    } catch (error) {
        console.log(error);
        res.status(400).json({ 'error': error });
        res.end();
    }
});

module.exports = {createStudent};