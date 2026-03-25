// db.js
const mysql = require('mysql2');

// 1. Configure the connection details
const pool = mysql.createPool({
  host: 'localhost',      // Usually localhost for development
  user: 'root',           // Your MySQL username
  password: 'Phanuth25102004', // Your MySQL password
  database: 'youtube', // The name of your database
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// 3. Test the connection on startup
pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('Database connection was closed.');
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('Database has too many connections.');
    }
    if (err.code === 'ECONNREFUSED') {
      console.error('Database connection was refused.');
    }
    console.error('Database connection error: ', err.message);
  } else {
    if (connection) connection.release();
    console.log('Database connected successfully!');
  }
});

// 2. Export the pool so other files can use it
module.exports = pool;
