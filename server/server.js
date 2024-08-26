const connectDb = require("./config/dbConfig");
const express = require('express');

connectDb();
const app = express();

const port = 5000;

app.use(express.json());

app.use('/classRoom', require('./routes/classRoomRoute'));
app.use(require('./middleware/errorHandler'))

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});