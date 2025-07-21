import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = 'PujaSQL@2006',
    database = 'urban_insights'
)

query = """
    SELECT a.area_name, pd.aqi, pd.reported_time
    FROM area_data a
    JOIN pollution_data pd ON a.area_id = pd.area_id
    WHERE (
        SELECT MAX(inner_pd.reported_time)
        FROM pollution_data inner_pd
        WHERE inner_pd.area_id = pd.area_id
    )
    ORDER BY pd.aqi DESC
    LIMIT 5;

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

plt.bar(df['area_name'], df['aqi'], color = 'crimson')

plt.title('Top 5 Areas with Highest AQI')

plt.xlabel('Area Name')
plt.ylabel('Air Quality Index (AQI)')

plt.xticks(rotation = 45, ha = 'right')

plt.tight_layout()

plt.savefig('top_5_areas_highest_aqi.png')

plt.show()
