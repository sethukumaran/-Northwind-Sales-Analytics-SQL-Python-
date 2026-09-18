import sqlite3, pathlib
import pandas as pd
import matplotlib.pyplot as plt


def q(conn, sql):
    return pd.read_sql_query(sql, conn)

conn = sqlite3.connect(DB)
kpi = q(conn, '''
SELECT COUNT(DISTINCT o.OrderID) total_orders,
ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)),2) revenue,
SUM(d.Quantity) units_sold
FROM orders o JOIN order_details d USING(OrderID)
''')
print("\nKPIs\n", kpi.to_string(index=False))

year = q(conn, '''
SELECT strftime('%Y',o.OrderDate) year,
ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)),2) revenue
FROM orders o JOIN order_details d USING(OrderID)
GROUP BY year ORDER BY year
''')
cat = q(conn, '''
SELECT c.CategoryName category,
ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)),2) revenue
FROM order_details d JOIN products p USING(ProductID)
JOIN categories c USING(CategoryID)
GROUP BY category ORDER BY revenue DESC
''')
top = q(conn, '''
SELECT p.ProductName product,
ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)),2) revenue
FROM order_details d JOIN products p USING(ProductID)
GROUP BY p.ProductID ORDER BY revenue DESC LIMIT 10
''')
monthly = q(conn, '''
SELECT strftime('%Y-%m',o.OrderDate) month,
ROUND(SUM(d.UnitPrice*d.Quantity*(1-d.Discount)),2) revenue
FROM orders o JOIN order_details d USING(OrderID)
GROUP BY month ORDER BY month
''')

year.plot(x="year", y="revenue", marker="o", legend=False, title="Revenue by Year")
plt.ylabel("Revenue"); plt.tight_layout(); plt.savefig(OUT/"01_revenue_by_year.png", dpi=160); plt.close()

cat.sort_values("revenue").plot.barh(x="category", y="revenue", legend=False, title="Revenue by Category")
plt.xlabel("Revenue"); plt.tight_layout(); plt.savefig(OUT/"02_revenue_by_category.png", dpi=160); plt.close()

top.sort_values("revenue").plot.barh(x="product", y="revenue", legend=False, title="Top 10 Products by Revenue")
plt.xlabel("Revenue"); plt.tight_layout(); plt.savefig(OUT/"03_top_products.png", dpi=160); plt.close()

monthly.plot(x="month", y="revenue", legend=False, title="Monthly Revenue Trend", figsize=(12,4))
plt.xticks(rotation=60); plt.ylabel("Revenue"); plt.tight_layout()
plt.savefig(OUT/"04_monthly_revenue.png", dpi=160); plt.close()

year.to_csv(OUT/"revenue_by_year.csv", index=False)
cat.to_csv(OUT/"revenue_by_category.csv", index=False)
top.to_csv(OUT/"top_products.csv", index=False)
monthly.to_csv(OUT/"monthly_revenue.csv", index=False)
conn.close()
print(f"Charts and result CSV files saved to {OUT}")
