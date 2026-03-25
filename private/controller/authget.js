const express = require('express');
const router = express.Router();

router.use(express.json());

router.get('/get/weather', async (req, res) => {
    const externalUrl = 'https://api.open-meteo.com/v1/forecast?latitude=51.5074&longitude=-0.1278&current_weather=true';

    try {
        // Changed variable name to 'response' to avoid shadowing Express 'res'
        const response = await fetch(externalUrl);

        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }

        const data = await response.json();

        // Use 'data' instead of 'weatherData'
        const simplifiedData = {
            temp: data.current_weather.temperature,
            wind: data.current_weather.windspeed,
            fetchedAt: new Date().toLocaleString()
        };

        // Send the simplified data back to the client
         console.log(simplifiedData);
        res.status(200).json(simplifiedData);


    } catch (error) {
        console.error('Error fetching data:', error);
        // Changed .message() to .send() or .json()
        res.status(500).json({ error: 'Error fetching data' });
    }
}); // Removed the extra closing brace that was here

module.exports = router;