const mongoose = require("mongoose");

const smartBoardScheduleSchema = mongoose.Schema(
    {
      scheduleTitle: {
        type: String,
        required: [true, 'scheduleTitle is missing'],
      },
      smartBoardID: {
        type: String,
        required: [true, 'smartBoardID is missing'],
      },
      time: {
        type: Date,
        required: [true, 'time is missing'],
      },
      assignedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Staff', // Assuming 'Staff' is the model for staff
        required: [true, 'assignedBy is missing'],
      },
      executed: {
        type: Boolean,
        required: [true, 'executed is missing'],
      },
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model('SmartBoardSchedule', smartBoardScheduleSchema);