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

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

bubble = plt.scatter(
    df['longitude'],
    df['latitude'],
    s=df['aqi'] * 5,
    c=df['aqi'], cmap='Reds',
    alpha=0.6, edgecolors='black'
)

plt.colorbar(bubble, label='Air Quality Index (AQI)')

plt.title('Top Polluted Areas')

plt.xlabel('Area Name')
plt.ylabel('Air Quality Index (AQI)')

plt.xticks(rotation = 45, ha = 'right')

plt.grid(True)

for i, row in df.iterrows():
    plt.text(
        row['longitude'],
        row['latitude'],
        row['area_name'],
        fontsize=8
    )


plt.tight_layout()

plt.savefig('top_polluted_areas_bubble.png')

plt.show()
