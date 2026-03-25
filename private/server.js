const express = require('express');
const app = express();
const cors = require('cors'); // Import CORS
const authRoutes = require('./controller/auth');
const weatherRoutes = require('./controller/authget');
const accountRoutes = require('./controller/accounts');
app.use(cors()); // Enable CORS for all routes

app.use('/api', authRoutes); // This makes the URL: http://localhost:3000/api/login
app.use('/api0', weatherRoutes); // This makes the URL: http://localhost:3000/api/weather')
app.use('/api/accounts', accountRoutes);



app.listen(3000, () => console.log('Server started on port 3000'));
