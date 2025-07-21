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
        DATE_FORMAT(usage_date, '%Y-%m') AS month,
        ROUND(AVG(eu.elec_usage_kwh), 2) as elec_usage
    FROM area_data a 
    JOIN utility_usage eu ON a.area_id = eu.area_id
    WHERE eu.utility_type = 'Electricity'
    GROUP BY month
    ORDER BY month ASC;

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

plt.plot(df['month'], df['elec_usage'], marker='o', color='darkgreen', linestyle='-')

plt.title('Monthly Average Electricity Usage')

plt.xlabel('Month')
plt.ylabel('Average Electricity Usage (kWh)')

plt.xticks(rotation = 45, ha = 'right')

plt.grid(True)

plt.tight_layout()

plt.savefig('electricity_usage_month.png')

plt.show()
