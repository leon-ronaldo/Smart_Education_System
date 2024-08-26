const mongoose = require("mongoose");

const adminSchema = mongoose.Schema(
    {
      adminID: {
        type: String,
        required: [true, 'adminID is missing'],
      },
      password: {
        type: String,
        required: [true, 'password is missing'],
      },
    },
    {
      timestamps: true,
    }
  );

module.exports = mongoose.model("Admin", adminSchema);