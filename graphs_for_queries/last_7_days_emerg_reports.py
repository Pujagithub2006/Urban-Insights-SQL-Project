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
    SELECT a.area_name, COUNT(*) AS emergencies_count
    FROM area_data a
    JOIN emergency_reports er ON a.area_id = er.area_id
    WHERE er.report_time >= CURDATE() - INTERVAL 7 DAY
    GROUP BY a.area_name
    ORDER BY emergencies_count DESC;

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

plt.barh(df['area_name'], df['emergencies_count'], color = 'darkorange')

plt.title('Areas with Most Emergency Reports in last 7 Days')

plt.xlabel('Area Name')
plt.ylabel('No. of Emergency Reports')

# plt.yticksticks(rotation = 45, ha = 'right')

plt.gca().invert_yaxis()

plt.tight_layout()

plt.savefig('last_7_days_emerg_report.png')

plt.show()
