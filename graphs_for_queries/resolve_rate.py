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
        feedback_department,
        COUNT(*) AS count_of_reports,
        SUM(CASE WHEN TRIM(LOWER(request_status)) = 'resolved' THEN 1 ELSE 0 END) AS total_resolved_reports,
        ROUND(100 * SUM(CASE WHEN request_status = 'resolved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS resolve_rate
    FROM citizen_feedback
    GROUP BY feedback_department;

"""

df = pd.read_sql(query, conn)

plt.figure(figsize=(8, 5))

colors = plt.cm.Paired.colors
plt.pie(
    df['resolve_rate'],
    labels=df['feedback_department'],
    autopct='%1.1f%%',
    colors = colors,
    wedgeprops=dict(width=0.4)
)

plt.title('Resolve Rate by Department')

plt.savefig('resolve_rate.png')

plt.show()
