const asyncHandler = require("express-async-handler");
const classRoomModel = require("../models/classRoomModel");
const studentModel = require("../models/studentModel");
const fs = require('fs');
const path = require("path");
const buffer = require('buffer');

const getClassRooms = asyncHandler(async (req, res) => {
    const classRooms = await classRoomModel.find({ collegeCode: req.params.id });

    if (!classRooms) {
        res.status(404).json({ message: "no such classrooms create some" });
        res.end();
        return;
    }

    res.status(200).json(classRooms);
    res.end();
});

const getClassRoom = asyncHandler(async (req, res) => {
    console.log(req.params.classID);

    const classRoom = await classRoomModel.findOne({ classRoomID: req.params.classID });
    const students = await studentModel.find({ classRoomID: req.params.classID }).select('studentID firstName lastName');

    if (!classRoom) {
        res.status(404).json({ message: "no such classrooms create some" });
        res.end();
        return;
    }

    console.log({ classRoom: classRoom, students: students });
    res.status(200).json({ classRoom: classRoom, students: students });
    res.end();
});

const confirmClassRoom = asyncHandler(async (req, res) => {
    console.log(req.params.classID);

    const classRoom = await classRoomModel.findOne({ classRoomID: req.params.classID });
    var students = [];

    console.log(req.body.students[0].studentID);
    
    for (var index = 0; index < req.body.students.length; index++) {
        console.log(req.body.students[index]);
        students.push(await studentModel.findOne({ studentID: req.body.students[index].studentID }));
    }

    if (!classRoom) {
        res.status(404).json({ message: "no such classrooms create some" });
        res.end();
        return;
    }

    //image creation of each student

    students.forEach(async student => {
        var dirname = path.join(__dirname, '../face_recognition_system/training/', `${req.params.id}/${req.params.classID}/${student.studentID}`);

        await fs.promises.mkdir(dirname, { recursive: true })
            .catch(error => {
                console.error('Error creating directory:', error);
            });

        let base64Image = student.photoData1.split(';base64,').pop()
        const tmpFileName = `${student.studentID}-first.jpg`;
        const tmpFilePath = path.join(dirname, tmpFileName);
        console.log(__dirname);

        fs.writeFileSync(tmpFilePath, base64Image, { encoding: 'base64' }, (err) => {
            if (err) {
                console.log('errr bro');
                return reject(err);
            }
        });

        let base64Image2 = student.photoData2.split(';base64,').pop()
        const tmpFileName2 = `${student.studentID}-second.jpg`;
        const tmpFilePath2 = path.join(dirname, tmpFileName2);
        console.log(__dirname);

        fs.writeFileSync(tmpFilePath2, base64Image2, { encoding: 'base64' }, (err) => {
            if (err) {
                console.log('errr bro');
                return reject(err);
            }
        });
    });

    const status = await runEncodingScript(`${req.params.id}/${req.params.classID}`);

    if (!status) {
        console.log("error");
        res.json(400).json({ message: 'error' });
        res.end();
        return;
    }

    const filePath = path.join(__dirname, '../face_recognition_system/training/', `${req.params.id}/${req.params.classID}/encodings.pkl`);

    // Open the file in asynchronous mode
    await fs.readFile(filePath, async (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return;
        }

        // Data is a buffer containing the file's contents
        console.log('File contents:', data);

        const encodingScript = Buffer.from(data).toString('base64');

        var studentsIDs = [];
        students.forEach(student => {
            studentsIDs.push({ studentID: student.studentID });
        });

        classRoomModel.updateOne({ classRoomID: req.params.classID }, { $set: { encodings: encodingScript, students: studentsIDs } })
            .then(result => {
                console.log('Document updated:', result);
            })
            .catch(err => console.error('Error updating document:', err));

        try {
            await fs.rm(path.join(__dirname, '../face_recognition_system/training/', `${req.params.id}/${req.params.classID}`), { recursive: true, force: true }, (err) => {
                if (err) {
                    console.log(err);
                }
            });
            console.log(`${req.params.classID} Directory and its contents deleted successfully.`);
        } catch (error) {
            console.error('Error deleting directory:', error);
        }

        console.log({ mesage: status });
        res.status(200).json({ message: status.message });
        res.end();
    });
});

function runEncodingScript(classFolder) {
    return new Promise((resolve, reject) => {
        const spawn = require('child_process').spawn;

        // Spawn the Python process with the file path as an argument
        const pythonProcess = spawn(path.join(__dirname, '../face_recognition_system/Scripts/python.exe'), [path.join(__dirname, '../face_recognition_system/main.py'), "setup", classFolder]);

        let status = "";

        // Capture Python script output
        pythonProcess.stdout.on('data', (data) => {
            status += data.toString();
        });

        // Handle errors during execution
        pythonProcess.stderr.on('err', (err) => {
            console.error(`Error from Python script: ${err}`);
            reject(new Error("Error running Python script"));
        });

        // Handle process exit
        pythonProcess.on('close', (code) => {
            if (code === 0) {
                try {
                    resolve(JSON.parse(status));
                } catch (error) {
                    reject(new Error("Invalid JSON data from Python script"));
                }
            } else {
                reject(new Error(`Python script exited with code ${code}`));
            }
        });
    });
}

module.exports = { getClassRooms, getClassRoom, confirmClassRoom };