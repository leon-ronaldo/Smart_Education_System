const asyncHandler = require("express-async-handler");
const classRoomModel = require("../models/classRoomModel");
const { Buffer } = require('buffer');
const path = require('path');

//create a classroom

const createClassRoom = asyncHandler(async (req, res) => {
    if (!req.body) {
        console.log("body cannot be null");
    }

    console.log(req.body);

    try {
        const classRoom = await classRoomModel.create({
            classRoomID: req.body.classRoomID,
            collegeCode: req.body.collegCode,
            grade: req.body.grade,
            section: req.body.class,
            mentor: req.body.mentor,
            smartBoardID: req.body.smartBoardID,
            noiseControllerID: req.body.noiseControllerID,
            fireSensorID: req.body.fireSensorID,
            collegeCode: req.body.collegeCode
        });
        res.status(200).json(classRoom);
        res.end();
    } catch (error) {
        res.status(400).json({ 'error': error });
        res.end();
    }
});

//get all classroom

const getClassRooms = asyncHandler(async (req, res) => {
    const classRooms = await classRoomModel.find({});

    console.log(classRooms);
    res.status(200).json(classRooms);
    res.end();
});

//get single classroom

const getClassRoom = asyncHandler(async (req, res) => {
    const classRoom = await classRoomModel.findOne({ classRoomID: req.params.id });

    if (!classRoom) {
        console.log('no such classroom');
        res.status(404).json({ message: 'no such classroom in your institution, please create one or check again.' });
        res.end();
    }

    console.log(classRoom);
    res.status(200).json(classRoom);
    res.end();
});

const addAttendance = asyncHandler(async (req, res) => {
    const classRoom = await classRoomModel.findOne({ classRoomID: req.params.id });

    if (!classRoom) {
        console.log('no such classroom');
        res.status(404).json({ message: 'no such classroom in your institution, please create one or check again.' });
        res.end();
    }

    if (!req.file) {
        console.log("no file uploaded");
        res.end(400).json({message: 'no file uploaded'});
        return;
    }

    const photo = req.file;

    const base64String = Buffer.from(photo.buffer).toString('base64');

    const attendance = await runAttendanceScript(base64String, classRoom);
    console.log(attendance);
    res.status(200).json(attendance);
    res.end();
});

async function runAttendanceScript(fileBuffer, classroom) {
    return new Promise((resolve, reject) => {
        // Create a temporary file to store the image data
        const fs = require('fs');
        let base64Image = fileBuffer.split(';base64,').pop()

        const tmpFileName = `${classroom.classRoomID}${Math.random().toString(36).substring(2, 15)}.jpg`;
        const tmpFilePath = path.join(__dirname, '../face_recognition_system/test', tmpFileName);

        const encodingsFileName = `${classroom.classRoomID}Encodings.pkl`;
        const encodingsFilePath = path.join(__dirname, '../face_recognition_system/test', encodingsFileName);

        console.log(tmpFilePath);

        fs.writeFileSync(tmpFilePath, base64Image, { encoding: 'base64' }, (err) => {
            if (err) {
                console.log('errr bro');
                return reject(err);
            }
        });

        fs.writeFileSync(encodingsFilePath, classroom.encodings.split(';base64,').pop(), { encoding: 'base64' }, (err) => {
            if (err) {
                console.log('errr bro');
                return reject(err);
            }
        });

        const spawn = require('child_process').spawn;

        // Spawn the Python process with the file path as an argument
        const pythonProcess = spawn(path.join(__dirname, '../face_recognition_system/Scripts/python.exe'), [path.join(__dirname, '../face_recognition_system/main.py'), 'recognize', tmpFileName, encodingsFileName]);

        let currentAttendance = "";

        // Capture Python script output
        pythonProcess.stdout.on('data', (data) => {
            currentAttendance += data.toString();
        });

        // Handle errors during execution
        pythonProcess.stderr.on('err', (err) => {
            console.error(`Error from Python script: ${err}`);
            reject(new Error("Error running Python script"));
        });

        // Handle process exit
        pythonProcess.on('close', async (code) => {
            // Ensure the temporary file is deleted regardless of success or failure
            await fs.rm(tmpFilePath, { recursive: true, force: true }, (err) => {
                if (err) {
                    console.log(err);
                }
            });

            await fs.rm(encodingsFilePath, { recursive: true, force: true }, (err) => {
                if (err) {
                    console.log(err);
                }
            });

            if (code === 0) {
                try {
                    resolve(JSON.parse(currentAttendance));
                } catch (error) {
                    reject(new Error("Invalid JSON data from Python script"));
                }
            } else {
                reject(new Error(`Python script exited with code ${code}`));
            }
        });
    });
}

module.exports = { createClassRoom, getClassRooms, getClassRoom, addAttendance, runAttendanceScript };