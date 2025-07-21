const express = require('express');
const router = express.Router();
const conn = require('../db');

// Route to get chart data


// Route to get top 5 areas with highest AQI
router.get('/top-aqi', (req, res) => {
    const query = `
        SELECT 
            a.area_name, 
            a.latitude,
            a.longitude,
            pd.aqi, 
            pd.reported_time
        FROM area_data a
        JOIN pollution_data pd ON a.area_id = pd.area_id
        WHERE (
            SELECT MAX(inner_pd.reported_time)
            FROM pollution_data inner_pd
            WHERE inner_pd.area_id = pd.area_id
        )
        ORDER BY pd.aqi DESC
        LIMIT 5; 

    `;

    conn.query(query, (err, results) =>  {
        if (err)
            return res.status(500).json({ error: 'err.message'})

        res.json(results);
    });

});

// Route to get emergency types by area
router.get('/emergency-types', (req, res) => {
    const query = `
        SELECT 
            area_name,
            SUM(CASE WHEN emergency_type="Accident" THEN 1 ELSE 0 END) AS Accident,
            SUM(CASE WHEN emergency_type="Fire" THEN 1 ELSE 0 END) AS Fire,
            SUM(CASE WHEN emergency_type="Theft" THEN 1 ELSE 0 END) AS Theft,
            SUM(CASE WHEN emergency_type="Other" THEN 1 ELSE 0 END) AS Other        
        FROM emergency_reports er
        JOIN area_data a ON er.area_id = a.area_id
        GROUP BY a.area_name;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to monthly average electricity usage
router.get('/avg-monthly-elec-usage', (req, res) => {
    const query = `
        SELECT 
            DATE_FORMAT(usage_date, '%Y-%m') AS month,
            ROUND(AVG(eu.elec_usage_kwh), 2) as elec_usage
        FROM area_data a 
        JOIN utility_usage eu ON a.area_id = eu.area_id
        WHERE eu.utility_type = 'Electricity'
        GROUP BY month
        ORDER BY month ASC;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to find areas with most emergency reports in last 7 days
router.get('/areas-most-emerg-reports-last-7-days', (req, res) => {
    const query = `
        SELECT a.area_name, COUNT(*) AS emergencies_count
        FROM area_data a
        JOIN emergency_reports er ON a.area_id = er.area_id
        WHERE er.report_time >= CURDATE() - INTERVAL 7 DAY
        GROUP BY a.area_name
        ORDER BY emergencies_count DESC;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to find resolve rate by department
router.get('/resolve-rate-by-department', (req, res) => {
    const query = `
        SELECT 
            feedback_department,
            COUNT(*) AS count_of_reports,
            SUM(CASE WHEN TRIM(LOWER(request_status)) = 'resolved' THEN 1 ELSE 0 END) AS total_resolved_reports,
            ROUND(100 * SUM(CASE WHEN request_status = 'resolved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS resolve_rate
        FROM citizen_feedback
        GROUP BY feedback_department;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to find total emergency types by area using heatmap
router.get('/total-emerg-types-by-area-heatmap', (req, res) => {
    const query = `
        SELECT 
            area_name,
            emergency_type,
            COUNT(*) AS total_emergency_types
        FROM emergency_reports er
        JOIN area_data a ON er.area_id = a.area_id
        GROUP BY area_name, emergency_type
        ORDER BY total_emergency_types DESC;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to find top polluted areas by bubble chart
router.get('/top-polluted-areas-bubble', (req, res) => {
    const query = `
        SELECT 
            a.area_name, 
            a.latitude,
            a.longitude,
            pd.aqi, 
            pd.reported_time
        FROM area_data a
        JOIN pollution_data pd ON a.area_id = pd.area_id
        WHERE (
            SELECT MAX(inner_pd.reported_time)
            FROM pollution_data inner_pd
            WHERE inner_pd.area_id = pd.area_id
        )
        ORDER BY pd.aqi DESC
        LIMIT 5;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

// Route to find total traffic incidents by hour of day
router.get('/total-traffic-incidents-by-hour', (req, res) => {
    const query = `
        SELECT 
            HOUR(reported_time) AS hour_of_day,
            COUNT(*) AS total_traffic_incidents
        FROM traffic_data
        GROUP BY hour_of_day
        ORDER BY total_traffic_incidents DESC;
    `;

    conn.query(query, (err, results) => {
        if (err)
            return res.status(500).json({error: err.message});
        
        res.json(results);
    });
});

module.exports = router;

