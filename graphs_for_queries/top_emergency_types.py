import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

conn = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = 'PujaSQL@2006',
    database = 'urban_insights'
)

query = """
    SELECT 
        area_name,
        emergency_type,
        COUNT(*) AS total_emergency_types
    FROM emergency_reports er
    JOIN area_data a ON er.area_id = a.area_id
    GROUP BY area_name, emergency_type
    ORDER BY total_emergency_types DESC;

"""

df = pd.read_sql(query, conn)

pivot_df = df.pivot(index='area_name', columns='emergency_type', values='total_emergency_types').fillna(0)

plt.figure(figsize=(8, 5))

sns.heatmap(pivot_df, annot=True, fmt='g',cmap='OrRd')

plt.title('Total emergency Types by Area')

plt.xlabel('Area Name')
plt.ylabel('Total Emergency Types')

plt.xticks(rotation = 45, ha = 'right')

plt.tight_layout()

plt.savefig('top_emergency_types.png')

plt.show()
