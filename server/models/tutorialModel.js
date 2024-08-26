const mongoose = require("mongoose");

const tutorialSchema = mongoose.Schema(
    {
      title: {
        type: String,
        required: [true, 'title is missing'],
      },
      concept: {
        type: String,
        required: [true, 'concept is missing'],
      },
      material: {
        type: String,
        required: [true, 'material is missing'],
      },
      youtubeLinks: [
        {
          type: String,
        },
      ],
      summarizedContent: {
        aboutConcept: {
          type: String,
          required: [true, 'aboutConcept is missing'],
        },
        keyPoints: [
          {
            type: String,
          },
        ],
        summary: {
          type: String,
          required: [true, 'summary is missing'],
        },
      },
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model("Tutorial", tutorialSchema);