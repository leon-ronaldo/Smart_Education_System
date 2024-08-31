const connectDb = require("./config/dbConfig");
const express = require('express');

connectDb();
const app = express();

const port = 5000;

app.use(express.json());

app.use('/classRoom', require('./routes/classRoomRoute'));
app.use('/students', require('./routes/stuentsRoute'));
app.use('/admin', require('./routes/adminRoute'));
app.use('/staffs', require('./routes/staffsRoute'));
app.use(require('./middleware/errorHandler'))

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
    const https = require('https');
    const interval = 8 * 60 * 1000; // 8 minutes in milliseconds
    
    function sendRequest(url) {
      https.get(url, (res) => {
        res.on('data', (d) => {
          process.stdout.write(d);
        });
      }).on('error', (err) => {
        console.error(err);
      });
    }
    
    setInterval(() => {
      const url = 'https://smart-education-system.onrender.com/classRoom/';
      sendRequest(url);
    }, interval);
});
