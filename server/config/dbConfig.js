
const mongoose = require("mongoose");

const connectDb = async () => {
  try {
    const connect = await mongoose.connect(`mongodb+srv://ronaldoleon029:ronaldo%40mongoDB@database.qzre7.mongodb.net/?retryWrites=true&w=majority&appName=DataBase`);
    console.log(
      "Database connected: ",
      connect.connection.host,
      connect.connection.name
    );
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
};

module.exports = connectDb;
