
const mongoose = require("mongoose");

const connectDb = async () => {
  try {
    const connect = await mongoose.connect(`mongodb+srv://leonronaldotrs_db_user:ronaldo029@MongoDB@cluster0.gq3006b.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`);
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
