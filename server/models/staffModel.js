const mongoose = require("mongoose");

const staffSchema = mongoose.Schema(
    {
      staffID: {
        type: String,
        required: [true, 'staffID is missing'],
      },
      firstName: {
        type: String,
        required: [true, 'firstName is missing'],
      },
      lastName: {
        type: String,
        required: [true, 'lastName is missing'],
      },
      age: {
        type: Number,
        required: [true, 'age is missing'],
      },
      dateOfBirth: {
        type: Date,
        required: [true, 'dateOfBirth is missing'],
      },
      gender: {
        type: String,
        required: [true, 'gender is missing'],
      },
      department: {
        type: String,
        required: [true, 'handling subject is missing'],
      },
      phone: {
        type: String,
        required: [true, 'phone is missing'],
      },
      email: {
        type: String,
        required: [true, 'email is missing'],
      },
      photoUrl: {
        type: String,
      },
      mentoringClass: {
        type: String,
      },
      timetable: {
        type: String,
        // monday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
        // tuesday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
        // wednesday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
        // thursday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
        // friday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
        // saturday: [
        //   {
        //     hourName: {
        //       type: String,
        //     },
        //     class: {
        //       type: Number,
        //     },
        //     section: {
        //       type: String,
        //     },
        //     hourStart: {
        //       type: Date,
        //     },
        //     hourEnd: {
        //       type: Date,
        //     },
        //   },
        // ],
      },
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model("Staff", staffSchema);