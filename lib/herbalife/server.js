const express = require('express');
const app = express();
const cors = require('cors');
const loginRoute = require('./private/controller/login');
const profileRoute = require('./private/controller/profile');
const postitemRoute = require('./private/controller/postitem');
const deleteitemRoute = require('./private/controller/deleteitem');

app.use(cors());
app.use(express.json());

// Routes
app.use('/api', loginRoute);
app.use('/api', profileRoute);
app.use('/api', postitemRoute);
app.use('/api/deleteitem', deleteitemRoute); // Specific path for delete

app.listen(3000, () => console.log('Server started on port 3000'));
