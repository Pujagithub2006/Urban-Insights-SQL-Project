CREATE TABLE area_data (
	area_id INT PRIMARY KEY AUTO_INCREMENT,
    area_name VARCHAR(100) NOT NULL,
    ward_id VARCHAR(20),
    city_name VARCHAR(50) DEFAULT 'Pune'
);

CREATE TABLE traffic_data (
	traffic_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT,
    traffic_level ENUM('Low', 'Medium', 'High'),
    reported_time DATETIME,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    source VARCHAR(100),
    FOREIGN KEY (area_id) REFERENCES area_data(area_id)    
);

CREATE TABLE pollution_data (
	pollution_id INT PRIMARY KEY AUTO_INCREMENT,
	area_id INT,
    pm10 FLOAT,
    pm2_5 FLOAT,
    o3 FLOAT,
    so2 FLOAT,
    no2 FLOAT,
    aqi INT,
    reported_time DATETIME,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    source VARCHAR(100),
    FOREIGN KEY (area_id) REFERENCES area_data (area_id)
);

CREATE TABLE citizen_feedback (
	feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    citizen_name VARCHAR(50),
    citizen_phone VARCHAR(5),
    area_id INT,
    feedback_department ENUM('Traffic', 'Pollution', 'Electricity', 'Other'),
    feedback_description VARCHAR(500),
    submitted_time DATETIME,
    request_status ENUM('resolved', 'not resolved') DEFAULT 'not resolved',    
    source VARCHAR(100),
    FOREIGN KEY (area_id) REFERENCES area_data(area_id)    
);

CREATE TABLE utility_usage (
	utility_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT,
    utility_type ENUM('Electricity', 'Water'),
    elec_usage_kwh FLOAT,
    water_usage_lts FLOAT,
    usage_month DATE, -- Why date?    
    source VARCHAR(100),
    FOREIGN KEY (area_id) REFERENCES area_data(area_id)    
);

CREATE TABLE emergency_reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT,
    location_desc VARCHAR(100),
    emergency_type ENUM('Fire', 'Theft', 'Accident', 'Other'),
    emergency_desc VARCHAR(500),
    report_time DATETIME,
    reported_by VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    source VARCHAR(100),
    resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (area_id) REFERENCES area_data(area_id)
);

INSERT INTO area_data (area_name, ward_id, city_name) VALUES
('Ronaldberg', 'W16', 'Port Ronald'),
('North Lucas', 'W17', 'East Courtneystad'),
('West Julian', 'W18', 'Lake Robertfurt'),
('South Tanya', 'W19', 'West Mistyview'),
('South Tammyville', 'W20', 'East Clintmouth'),
('Port Rachelport', 'W21', 'Lake Paulfurt'),
('Hernandezborough', 'W22', 'Port Katherinetown'),
('Lake Anthony', 'W23', 'New Kevintown'),
('New Christinemouth', 'W24', 'South Scottland'),
('Michaelfurt', 'W25', 'East Tiffany'),
('Lake Amy', 'W26', 'Karinbury'),
('New Lisaport', 'W27', 'Port Rogerland'),
('Jenkinsfort', 'W28', 'West Eric'),
('Lake Craig', 'W29', 'Jessicaville'),
('North Victor', 'W30', 'Mccoyburgh');

INSERT INTO traffic_data (area_id, traffic_level, reported_time, latitude, longitude, source) VALUES
(6, 'High', '2025-07-06 20:09:49', 32.572524, 36.168565, 'TrafficApp'),
(12, 'High', '2025-07-06 22:45:30', -10.918519, -25.886644, 'SensorNode'),
(4, 'Medium', '2025-07-07 08:15:00', 18.5612, 73.7590, 'Google Maps'),
(8, 'Low', '2025-07-08 17:10:15', 18.5344, 73.8003, 'Manual Survey'),
(7, 'High', '2025-07-07 21:45:55', 18.5021, 73.8760, 'TrafficApp'),
(3, 'Medium', '2025-07-08 12:00:45', 18.5301, 73.8501, 'TrafficApp'),
(10, 'High', '2025-07-07 18:39:00', 18.5282, 73.8439, 'SensorNode'),
(1, 'Low', '2025-07-06 23:59:59', 18.5911, 73.7385, 'Manual Survey'),
(5, 'Medium', '2025-07-07 06:00:00', 18.5035, 73.7860, 'Google Maps'),
(11, 'Low', '2025-07-08 10:15:00', 18.5040, 73.8470, 'SensorNode'),
(9, 'High', '2025-07-08 19:00:00', 18.5555, 73.7920, 'Google Maps'),
(2, 'Low', '2025-07-09 00:30:00', 18.5500, 73.7800, 'Manual Survey'),
(14, 'Medium', '2025-07-08 16:00:00', 18.5200, 73.8300, 'SensorNode'),
(13, 'High', '2025-07-09 01:00:00', 18.5150, 73.8200, 'Google Maps'),
(15, 'Low', '2025-07-07 03:15:00', 18.5100, 73.8100, 'TrafficApp');


INSERT INTO pollution_data (
    area_id, pm10, pm2_5, o3, so2, no2, aqi,
    reported_time, latitude, longitude, source
) VALUES
(1, 130.8, 78.7, 28.2, 6.2, 43.7, 180, '2025-07-08 13:40:35', -46.130688, 120.348385, 'IoT Sensor'),
(5, 136.3, 81.5, 30.4, 12.7, 24.3, 184, '2025-07-09 02:45:27', -78.420513, -21.423903, 'OpenWeatherMap'),
(3, 108.9, 60.2, 33.1, 10.3, 29.9, 163, '2025-07-08 09:10:00', 18.5301, 73.8495, 'CPCB'),
(6, 122.5, 72.0, 25.6, 8.2, 35.5, 192, '2025-07-07 22:00:00', 18.5440, 73.8800, 'OpenWeatherMap'),
(7, 115.4, 69.3, 29.2, 6.5, 38.2, 170, '2025-07-08 15:30:00', 18.5011, 73.8752, 'IoT Sensor'),
(4, 143.2, 95.1, 36.4, 11.5, 42.0, 210, '2025-07-07 10:20:00', 18.5120, 73.8650, 'CPCB'),
(2, 98.7, 55.6, 31.0, 7.3, 30.1, 150, '2025-07-09 08:00:00', 18.5400, 73.7800, 'OpenWeatherMap'),
(9, 152.0, 101.3, 35.5, 9.9, 40.7, 220, '2025-07-08 14:40:00', 18.5550, 73.7930, 'IoT Sensor'),
(11, 88.5, 44.5, 26.0, 5.0, 25.0, 120, '2025-07-07 06:00:00', 18.5041, 73.8490, 'Manual Reading'),
(10, 165.3, 109.0, 38.1, 13.3, 50.0, 240, '2025-07-08 18:10:00', 18.5290, 73.8432, 'CPCB'),
(12, 75.2, 39.0, 20.3, 6.0, 23.2, 100, '2025-07-09 07:30:00', 18.5060, 73.8460, 'OpenWeatherMap'),
(8, 125.6, 80.4, 32.0, 10.1, 36.0, 195, '2025-07-07 12:45:00', 18.5220, 73.8100, 'IoT Sensor'),
(13, 118.0, 67.3, 30.2, 9.2, 34.7, 170, '2025-07-08 16:00:00', 18.5170, 73.8210, 'OpenWeatherMap'),
(14, 140.5, 92.0, 34.6, 11.0, 44.5, 200, '2025-07-09 09:00:00', 18.5210, 73.8290, 'CPCB'),
(15, 160.0, 104.5, 37.0, 12.5, 47.8, 230, '2025-07-09 10:15:00', 18.5090, 73.8120, 'IoT Sensor');


INSERT INTO citizen_feedback (
    citizen_name, citizen_phone, area_id, feedback_department,
    feedback_description, submitted_time, request_status, source
) VALUES
('Austin Leonard', '5500178527', 13, 'Other', 'Arrive else account board because.', '2025-07-09 13:10:15', 'not resolved', 'UrbanVoiceApp'),
('Steven Smith', '4139846944', 9, 'Other', 'Last involve threat choice material sport manager board.', '2025-07-09 01:53:00', 'not resolved', 'UrbanVoiceApp'),
('Ashley Garcia', '3458721032', 3, 'Pollution', 'Air smells strange near college area.', '2025-07-08 22:31:10', 'resolved', 'FeedbackPortal'),
('Rohit Mehra', '8965423170', 5, 'Traffic', 'Too much congestion near signal.', '2025-07-07 16:11:00', 'not resolved', 'SmartCityApp'),
('Neha Kulkarni', '7832154980', 12, 'Electricity', 'Power cuts during day time.', '2025-07-08 10:21:00', 'resolved', 'Manual Entry'),
('Meera Joshi', '6587491230', 6, 'Other', 'Request for CCTV installation.', '2025-07-08 13:14:00', 'not resolved', 'FeedbackPortal'),
('Sandeep Kumar', '9023412780', 14, 'Pollution', 'Trash burning happening at corner.', '2025-07-07 09:47:00', 'not resolved', 'UrbanVoiceApp'),
('Anjali Patel', '7995467821', 1, 'Traffic', 'Accident-prone spot not marked.', '2025-07-08 12:00:00', 'resolved', 'SmartCityApp'),
('Kiran Naik', '9098765421', 10, 'Electricity', 'Voltage fluctuations noticed.', '2025-07-09 03:40:00', 'not resolved', 'FeedbackPortal'),
('Farhan Shaikh', '9812348756', 8, 'Other', 'No street lights on road.', '2025-07-07 23:55:00', 'resolved', 'UrbanVoiceApp'),
('Nikita Sharma', '8754123698', 2, 'Traffic', 'Heavy traffic daily.', '2025-07-06 07:30:00', 'not resolved', 'SmartCityApp'),
('Rajeev Malhotra', '9934567812', 4, 'Pollution', 'Dust levels are very high.', '2025-07-09 15:45:00', 'resolved', 'Manual Entry'),
('Sneha Rao', '9632587410', 7, 'Other', 'Footpaths are broken.', '2025-07-08 18:20:00', 'not resolved', 'CitizenApp'),
('Aditya Sen', '8123456798', 11, 'Electricity', 'Transformer needs repair.', '2025-07-08 20:10:00', 'resolved', 'SmartCityApp'),
('Ritika Nair', '7894561230', 15, 'Other', 'Street dogs causing issue.', '2025-07-09 05:55:00', 'resolved', 'UrbanVoiceApp');


INSERT INTO utility_usage (
    area_id, utility_type, elec_usage_kwh, water_usage_lts, usage_month, source
) VALUES
(12, 'Electricity', 4991.34, NULL, '2025-06-01', 'Manual Reading'),
(11, 'Water', NULL, 598476.30, '2025-06-01', 'PMC Board'),
(1, 'Electricity', 5321.60, NULL, '2025-06-01', 'SmartMeter'),
(2, 'Water', NULL, 786421.12, '2025-06-01', 'PMC Board'),
(5, 'Electricity', 4220.14, NULL, '2025-06-01', 'Manual Reading'),
(3, 'Water', NULL, 621345.78, '2025-06-01', 'Manual Reading'),
(6, 'Electricity', 5778.80, NULL, '2025-06-01', 'SmartMeter'),
(7, 'Water', NULL, 893245.52, '2025-06-01', 'PMC Board'),
(9, 'Electricity', 4890.50, NULL, '2025-06-01', 'PMC Board'),
(8, 'Water', NULL, 512367.29, '2025-06-01', 'Manual Reading'),
(10, 'Electricity', 3510.60, NULL, '2025-06-01', 'SmartMeter'),
(13, 'Water', NULL, 745200.67, '2025-06-01', 'PMC Board'),
(14, 'Electricity', 4231.20, NULL, '2025-06-01', 'Manual Reading'),
(4, 'Water', NULL, 678123.45, '2025-06-01', 'Manual Reading'),
(15, 'Electricity', 5087.00, NULL, '2025-06-01', 'SmartMeter');


INSERT INTO emergency_reports (
    area_id, location_desc, emergency_type, emergency_desc, report_time,
    reported_by, latitude, longitude, source, resolved
) VALUES
(14, 'Annette Parkways', 'Fire', 'Several instead wife charge.', '2025-07-06 23:46:26', 'Jeffrey', -58.337940, -14.022899, 'PoliceDesk', FALSE),
(2, 'Stewart Ville', 'Accident', 'Mission past tree people imagine identify try.', '2025-07-06 18:43:22', 'Cynthia', 71.394274, -103.178410, 'Citizen App', TRUE),
(4, 'Park Avenue', 'Theft', 'Mobile stolen near bus stop.', '2025-07-07 14:22:00', 'Vikram', 18.5204, 73.8567, 'PoliceDesk', FALSE),
(1, 'Infosys Circle', 'Accident', 'Car crash, minor injuries.', '2025-07-09 07:30:00', 'Ramesh', 18.5912, 73.7386, 'EmergencyApp', TRUE),
(5, 'Nal Stop', 'Fire', 'Short circuit in building.', '2025-07-08 18:00:00', 'Meena', 18.5012, 73.7890, 'FireDept App', TRUE),
(3, 'Railway Station', 'Other', 'Suspicious object found.', '2025-07-08 21:45:00', 'Imran', 18.5300, 73.8500, 'Citizen App', FALSE),
(6, 'Bridge Point', 'Theft', 'Bag stolen on bridge.', '2025-07-07 10:00:00', 'Asha', 18.5400, 73.8600, 'PoliceDesk', TRUE),
(7, 'Library Street', 'Accident', 'Scooter skid in rain.', '2025-07-08 09:15:00', 'Kunal', 18.5000, 73.8900, 'EmergencyApp', FALSE),
(8, 'Main Market', 'Other', 'Street fight reported.', '2025-07-07 22:00:00', 'Pooja', 18.5196, 73.8553, 'Citizen App', TRUE),
(9, 'Opposite IT Park', 'Fire', 'Small fire behind canteen.', '2025-07-08 15:30:00', 'Rahul', 18.5560, 73.7820, 'FireDept App', FALSE),
(10, 'Airport Road', 'Accident', 'Bus and car collision.', '2025-07-09 06:45:00', 'Fatima', 18.5800, 73.9100, 'EmergencyApp', TRUE),
(11, 'Mandai Chowk', 'Theft', 'Chain snatching reported.', '2025-07-09 11:20:00', 'Sachin', 18.5142, 73.8481, 'PoliceDesk', TRUE),
(12, 'Law College Road', 'Other', 'Animal stuck in drain.', '2025-07-08 13:10:00', 'Manisha', 18.5235, 73.8476, 'Citizen App', FALSE),
(13, 'Canal Path', 'Fire', 'Burning garbage pile.', '2025-07-08 16:00:00', 'Sonal', 18.5215, 73.8410, 'FireDept App', FALSE),
(15, 'Camp Post Office', 'Accident', 'Two-wheeler and rickshaw crash.', '2025-07-09 09:35:00', 'Zaid', 18.5200, 73.8620, 'EmergencyApp', TRUE);


select * from area_data;
