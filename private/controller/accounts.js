const express = require('express');
const router = express.Router();
const db = require('../model/db');
const jwt = require('jsonwebtoken');
const JWT_SECRET = "your_super_secret_key_123";
router.use(express.json());

router.post('/register', (req, res) => {
    const { email, password } = req.body;
    const sql = "INSERT INTO accounts (email, password) VALUES (?, ?)";

    db.query(sql, [email, password], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });

        res.status(201).json({
            success: true,
            message: "Registration successful",
            userId: result.insertId,
            userEmail: email
        });

    });
});

router.post('/login', (req, res) => {
    const { email, password } = req.body;
    const sql = "SELECT * FROM accounts WHERE email = ?";

    db.query(sql, [email], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });

        if (results.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Email not found"
            });
        }

        const user = results[0];

        if (user.password !== password) {
            return res.status(401).json({
                success: false,
                message: "Incorrect password"
            });
        }

        // --- JWT IMPLEMENTATION ---
                // Create a token containing userId and email
                const token = jwt.sign(
                    { id: user.id, email: user.email },
                    JWT_SECRET,
                    { expiresIn: '1h' }
                );

        res.status(200).json({
            success: true,
            message: "Login successful",
            userId: user.id,
            token: token,
            userEmail: user.email
        });

    });
});

module.exports = router;