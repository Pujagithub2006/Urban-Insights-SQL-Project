const express = require('express');
const cors = require('cors');
const app = express();
const chartRoutes = require('./routes/charts');

app.use(cors());
app.use('/api', chartRoutes);

app.listen(5000, () => {
    console.log('Server is running on http://localhost:5000');
});

app.get('/', (req, res) => {
    res.send('Urban Insights Server is working!');
});