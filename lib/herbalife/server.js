const express = require('express');
const app = express();
const cors = require('cors');
const loginRoute = require('./private/controller/login');
const profileRoute = require('./private/controller/profile');

// http://10.0.2.2:3000/api/profile/:id

app.use(cors());
app.use(express.json()); // Essential for parsing JSON bodies

// Route definition
app.use('/api', loginRoute);
app.use('/api', profileRoute);
app.listen(3000, () => console.log('Server started on port 3000'));
