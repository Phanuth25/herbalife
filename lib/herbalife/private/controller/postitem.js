const express = require('express');
const router = express.Router();
const db = require('../model/db');

// Fixed the closing braces and parentheses here
router.post('/postitem', (req, res) => {
    const { userid, product, quantity } = req.body;
    const sql = "INSERT INTO invoices (userid, product, quantity) VALUES (?, ?, ?)";

    db.query(sql, [userid, product, quantity], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        res.status(200).json({
            success: true,
            message: "Purchased successfully",
            invoiceId: results.insertId // Optional: returns the ID of the new row
        });
    }); // Added missing closing parenthesis for db.query
}); // Removed extra braces and fixed router.post closing

module.exports = router;