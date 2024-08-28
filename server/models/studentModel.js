const mongoose = require("mongoose");

const studentSchema = mongoose.Schema(
    {
        studentID: {
            type: String,
            required: [true, 'studentId is missing'],
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
            type: String,
            required: [true, 'dateOfBirth is missing'],
        },
        class: {
            type: Number,
            required: [true, 'class is missing'],
        },
        section: {
            type: String,
            required: [true, 'section is missing'],
        },
        classRoomID: {
            type: String,
            required: [true, 'class id is missing'],
        },
        gender: {
            type: String,
            required: [true, 'gender is missing'],
        },
        phone: {
            type: String,
            required: [true, 'phone is missing'],
        },
        email: {
            type: String,
            required: [true, 'email is missing'],
        },
        address: {
            type: String,
            required: [true, 'address is missing'],
        },
        photoUrl: {
            type: String,
        },
        photoData1: {
            type: String,
            required: [true, 'photodata is missing'],
        },
        photoData2: {
            type: String,
            required: [true, 'photodata is missing'],
        },
        analyticsData: {
            type: Map, 
                // questionsAsked: [
                //     {
                //         topic: {
                //             type: String,
                //             required: [true, 'topic is missing'],
                //         },
                //         question: {
                //             type: String,
                //             required: [true, 'question is missing'],
                //         },
                //         questionValue: {
                //             type: String,
                //             required: [true, 'questionValue is missing'],
                //         },
                //         questionCleared: {
                //             type: Boolean,
                //             required: [true, 'questionCleared is missing'],
                //         },
                //     },
                // ],
                // answers: [
                //     {
                //         topic: {
                //             type: String,
                //             required: [true, 'topic is missing'],
                //         },
                //         answer: {
                //             type: String,
                //             required: [true, 'answer is missing'],
                //         },
                //         answerValue: {
                //             type: String,
                //             required: [true, 'answerValue is missing'],
                //         },
                //     },
                // ],
                // attendedQuizzes: [
                //     {
                //         quizTitle: {
                //             type: String,
                //             required: [true, 'quizTitle is missing'],
                //         },
                //         score: {
                //             type: Number,
                //             required: [true, 'score is missing'],
                //         },
                //         dateAttended: {
                //             type: Date,
                //             required: [true, 'dateAttended is missing'],
                //         },
                //     },
                // ],
                // questionCount: {
                //     type: Number,
                //     required: [true, 'questionCount is missing'],
                // },
                // answerCount: {
                //     type: Number,
                //     required: [true, 'answerCount is missing'],
                // },
                // sessionsAttended: {
                //     type: Number,
                //     required: [true, 'sessionsAttended is missing'],
                // },
                // activeLearningTime: {
                //     type: Number,
                //     required: [true, 'activeLearningTime is missing'],
                // },
        },
        analyticsResult: {
            type: Map
                // iq: {
                //     type: Number,
                //     required: [true, 'iq is missing'],
                // },
                // weakConcepts: [
                //     {
                //         topic: {
                //             type: String,
                //             required: [true, 'topic is missing'],
                //         },
                //         issue: {
                //             type: String,
                //             required: [true, 'issue is missing'],
                //         },
                //         suggestion: {
                //             type: String,
                //             required: [true, 'suggestion is missing'],
                //         },
                //     },
                // ],
                // strongConcepts: [
                //     {
                //         topic: {
                //             type: String,
                //             required: [true, 'topic is missing'],
                //         },
                //     },
                // ],
                // questioningAbility: {
                //     type: String,
                //     enum: ['low', 'medium', 'high'],
                //     required: [true, 'questioningAbility is missing'],
                // },
                // remarks: {
                //     type: String,
                //     required: [true, 'remarks is missing'],
                // },
                // suggestion: {
                //     type: String,
                //     required: [true, 'suggestion is missing'],
                // },
        },
    },
    {
        timestamps: true,
    }
);

module.exports = mongoose.model("Student", studentSchema);
