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
        HOUR(reported_time) AS hour_of_day,
        COUNT(*) AS total_traffic_incidents
    FROM traffic_data
    GROUP BY hour_of_day
    ORDER BY total_traffic_incidents DESC;

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

plt.fill_between(df['hour_of_day'], df['total_traffic_incidents'], color='orange', alpha=0.5)
plt.plot(df['hour_of_day'], df['total_traffic_incidents'], marker='o', color='red', linestyle='-')

plt.title('Total Traffic Incidents by Hour of Day')

plt.xlabel('Hour of the Day (0-23)')
plt.ylabel('Total Traffic Incidents')

plt.xticks(rotation = 45, ha = 'right')

plt.grid(True)

plt.tight_layout()

plt.savefig('traffic_load_by_hour.png')

plt.show()
