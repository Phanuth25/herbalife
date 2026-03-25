// auth.js
const express = require('express');
require('dotenv').config();
const jwt = require('jsonwebtoken');
const router = express.Router();
const db = require('../model/db');

router.use(express.json());

router.post('/register', (req, res) => {
    const { email, password, type } = req.body;

    // 1. Insert the new user
    const sql = "INSERT INTO users (email, password, type) VALUES (?, ?, ?)";
    db.query(sql, [email, password, type], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });

        // 2. If insert worked, fetch that user back
        const sql2 = "SELECT * FROM users WHERE email = ? AND password = ?";
        db.query(sql2, [email, password], (err, results) => {
            if (err) return res.status(500).json({ error: err.message });

            if (results.length > 0) {
                const user = results[0];

                // 3. Create the JWT
                const token = jwt.sign(
                    { email: user.email, type: user.type },
                    process.env.TOKEN_SECRET,
                    { expiresIn: '744h' }
                );

                // FIXED: Now sending both token AND email back to Flutter
                res.json({
                    success: true,
                    token: token,
                    type: user.type,
                    email: user.email // Added this line
                });
            }
        });
    });
});

module.exports = router;
