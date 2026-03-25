const express = require('express');
const router = express.Router();
const db = require('../model/db');

router.get('/profile/:id', (req, res) => {
    const userId = req.params.id;
    
    // Check if the columns match exactly with your database table 'infos'
    const sql = "SELECT i.name, i.address, i.phone, i.email FROM users u INNER JOIN infos i ON u.userids = i.id WHERE u.userids = ?";

    db.query(sql, [userId], (err, results) => {
        if (err) {
            console.error("Database Error:", err.message);
            return res.status(500).json({ error: err.message });
        }

        console.log("Database results for ID " + userId + ":", results);

        if (results.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User record not found in database"
            });
        }

        const info = results[0];
        
        // We use || null to ensure we don't send 'undefined'
        res.status(200).json({
            success: true,
            email: info.email || "No Email",
            phone: info.phone || "No Phone",
            address: info.address || "No Address",
            name: info.name || "No Name"
        });
    });
});

module.exports = router;
