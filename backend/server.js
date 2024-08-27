const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.applicationDefault()
});

const app = express();
app.use(bodyParser.json());

app.post('/uploadVideo', async (req, res) => {
  // Handle video upload and processing
  res.send('Video uploaded');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
