# 🌆 UrbanPulse

> A full-stack, AI-integrated real-time dashboard to monitor, predict, and respond to urban crises such as pollution spikes, weather alerts, traffic congestion, and public health indicators.

## 🚀 Overview

This project is part of a capstone designed to showcase full-stack engineering + analytics + smart alert systems.

Currently implemented:
- MySQL storage with normalized schema
- Static dashboard charts for top cities by AQI, pollution component averages, and pollutant trends


Upcoming:
- Live AQI data collection from OpenWeatherMap
- Machine learning predictions for AQI spikes and city-level warnings
- Interactive map with zone highlights
- SMS/email notifications based on thresholds
- Admin and user dashboards
- SMS-based emergency alert system in pipeline

---

## 🧩 Project Features

| Feature                             | Status         | Description |
|------------------------------------|----------------|-------------|
| MySQL Normalized Schema            | ✅ Completed    | 6 interlinked tables for AQI, weather, traffic |
| API-based AQI Data Collection      | ✅ Completed    | Python script collects and pushes data every hour |
| Real-time Chart Dashboard          | ✅ In Progress  | Charts using React + Recharts (Top AQI, Trends, Components) |
| Interactive Map View               | 🔜 Upcoming     | Map with location-based AQI indicators |
| SMS Alert System (via Twilio/API)  | 🔜 Upcoming     | Sends alerts to authorities and users |
| ML AQI Spike Predictor             | 🔜 Upcoming     | Predicts high-risk cities based on past data |
| Admin Panel                        | 🔜 Upcoming     | Manage zones, limits, alert thresholds |
| Detailed ERD Diagram               | 🔜 Upcoming     | Detailed ERD Diagram to understand the structure of the database

---

## 💻 Tech Stack

| Layer         | Technology           |
|---------------|----------------------|
| Frontend      | React, Recharts, Tailwind |
| Backend       | Python (Flask/FastAPI), Node.js (for alerts) |
| Database      | MySQL (ERD in DrawSQL) |
| APIs          | OpenWeatherMap, MapBox/Leaflet, Twilio (for SMS) |
| ML Toolkit    | Scikit-learn, Pandas, NumPy |
| Deployment    | Render / Railway / GitHub Pages (Frontend) |
| Hosting Tools | Docker (optional), CronJob for scheduling |

---

## 📁 Folder Structure (Expected)

