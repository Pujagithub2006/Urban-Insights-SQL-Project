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

# OpenWeatherMap API key and URL template
api_key = "27cec26afcd1c26fa23cf7ace3a46d9c"
url_template = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={key}&units=metric"

# Fetching data for cities from database
cursor.execute("SELECT area_id, latitude, longitude FROM area_data")
areas = cursor.fetchall()

for area_id, lat, lon in areas:
    try:
        url = url_template.format(lat = lat, lon = lon, key = api_key)
        response = requests.get(url)
        data = response.json()

        temperature = data['main']['temp']
        humidity = data['main']['humidity']
        wind_speed = data['wind']['speed']
        weather_condition = data['weather'][0]['main']
        source = "OpenWeatherMap"
        reported_time = datetime.now()

        insert_query = """
            INSERT INTO weather_data (area_id, temperature, humidity, wind_speed, weather_condition, reported_time, source, latitude, longitude)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)

        """
        cursor.execute(insert_query, (
            area_id, temperature, humidity, wind_speed, weather_condition, reported_time, source, lat, lon
        ))

        if temperature > 40:
            alert_message = f"Temperature Alert for area_id {area_id}: {temperature}°C"
            send_alert(alert_message)
        
        if weather_condition.lower() in ['rain', 'snow', 'storm', 'extreme']:
            alert_message = f"Weather Alert for area_id {area_id}: {weather_condition}"
            send_alert(alert_message)
    
    except Exception as e:
        print(f"Error fetching data for area_id {area_id}: {e}")

conn.commit()
cursor.close()
conn.close()


