const mongoose = require("mongoose");

const classRoomSchema = mongoose.Schema(
    {
      classRoomID: {
        type: String,
        required: [true, 'class is missing'],
      },
      collegeCode: {
        type: String,
        required: [true, 'collegeCode is missing'],
      },
      grade: {
        type: Number,
        required: [true, 'class is missing'],
      },
      section: {
        type: String,
        required: [true, 'section is missing'],
      },
      mentor: {
        type: String,
        required: [true, 'mentor is missing'],
      },
      students: {
        type: Array
      },
      smartBoardID: {
        type: String,
      },
      noiseControllerID: {
        type: String,
      },
      fireSensorID: {
        type: String,
      },
      attendances: {
        type: Array,
      },
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model("ClassRoom", classRoomSchema);