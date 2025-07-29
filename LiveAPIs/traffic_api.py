import requests
import mysql.connector
from datetime import datetime
from twilio_alert import send_alert

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='PujaSQL@2006',
    database='urban_insights'
)

cursor = conn.cursor()

# tomtom API key and URL template
api_key = "ODF2iqVKMbdrFQJ2D4AVykh4OGzPaacF"
url_template = "https://api.tomtom.com/traffic/services/4/flowSegmentData/absolute/10/json?point={lat},{lon}&key={key}"

# Fetching data for cities from database
cursor.execute("SELECT area_id, latitude, longitude FROM area_data")
areas = cursor.fetchall()

for area_id, lat, lon in areas:
    try:
        url = url_template.format(lat = lat, lon = lon, key = api_key)
        response = requests.get(url)
        data = response.json()

        speed_kmph = data['flowSegmentData']['currentSpeed']
        free_flow_speed = data['flowSegmentData']['freeFlowSpeed']

        if speed_kmph < free_flow_speed * 0.5:
            congestion_level = "High"
        elif speed_kmph < free_flow_speed * 0.8:
            congestion_level = "Medium"
        else:
            congestion_level = "Low"

        source = "TomTom"
        reported_time = datetime.now()

        insert_query = """
            INSERT INTO traffic_insights (area_id, congestion_level, speed_kmph, reported_time, latitude, longitude, source, free_flow_speed)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)

        """
        cursor.execute(insert_query, (
            area_id, congestion_level, speed_kmph, reported_time, lat, lon, source, free_flow_speed
        ))

        if congestion_level == "High":
            alert_message = f"High congestion alert for area_id {area_id}: Speed is {speed_kmph} km/h"
            send_alert(alert_message)
    
    except Exception as e:
        print(f"Error fetching data for area_id {area_id}: {e}")

conn.commit()
cursor.close()
conn.close()
