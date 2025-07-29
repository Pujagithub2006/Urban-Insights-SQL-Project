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

cities = [
    {"area_id": 1, "lat": 28.6139, "lon": 77.2090, "name": "Delhi"},
    {"area_id": 2, "lat": 19.0760, "lon": 72.8777, "name": "Mumbai"},
]

# Fetching data from the API
API_KEY = "27cec26afcd1c26fa23cf7ace3a46d9c"

for city in cities:
    try:
        url = f"http://api.openweathermap.org/data/2.5/air_pollution?lat={city['lat']}&lon={city['lon']}&appid={API_KEY}"
        response = requests.get(url)
        data = response.json()

        components = data['list'][0]['components']
        aqi_index = data['list'][0]['main']['aqi'] * 50 # for aqi between 0 to 250, i.e. 0 to 5 scale
        time = datetime.utcnow()


        insert_query = """
            INSERT INTO pollution_data(area_id, pm10, pm2_5, o3, so2, no2, aqi, reported_time, latitude, longitude, source)
            VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        cursor.execute(insert_query,(
            city['area_id'],
            components.get('pm10'),
            components.get('pm2_5'),
            components.get('o3'),
            components.get('so2'),
            components.get('no2'),
            aqi_index, 
            time, 
            city['lat'],
            city['lon'],
            'OpenWeatherMap'
        ))

        if aqi_index > 50:
            alert_message = f"High AQI Alert for {city['name']}"
            send_alert(alert_message)
    
    except Exception as e:
        print(f"Error fetching data for {city['name']}: {e}")

conn.commit()
cursor.close()
conn.close()
