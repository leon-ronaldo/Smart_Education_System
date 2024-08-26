const mongoose = require("mongoose");

const quizSchema = mongoose.Schema(
    {
      title: {
        type: String,
        required: [true, 'title is missing'],
      },
      concept: {
        type: String,
        required: [true, 'concept is missing'],
      },
      quizID: {
        type: String,
        required: [true, 'quizID is missing'],
      },
      material: {
        type: String,
        required: [true, 'material is missing'],
      },
      questions: [
        {
          question: {
            type: String,
            required: [true, 'question is missing'],
          },
          options: [
            {
              type: String,
            },
          ],
          marks: {
            type: Number,
            required: [true, 'marks is missing'],
          },
        },
      ],
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model("Quiz", quizSchema);