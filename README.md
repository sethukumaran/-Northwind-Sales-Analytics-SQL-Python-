# Northwind-Sales-Analytics-SQL-Python
This project analyzes a Northwind-style sales database using **SQL for business questions and **Python for data preparation, validation, and visualization. The objective is to identify revenue trends, high-performing categories/products, customer concentration, discount impact, shipment performance, and inventory risks.

## 2. Business Questions
- What are the total orders, revenue, and units sold?
- How does revenue change by year and month?
- Which product categories and products generate the most revenue?
- Which customers contribute the most sales?
- How large is the discount impact?
- How many orders were shipped late?
- Which products need inventory attention?

## 3. Dataset
Source file: `data/Live_file_data.xlsx`
Important sheets used:
- `Categories`
- `Products`
- `Customers`
- `Orders`
- `Order_Details`

The workbook also contains precomputed report sheets, but this project rebuilds the core analysis from transactional tables.

## 4. Tech Stack
- SQL / SQLite
- Python 3.x
- pandas
- matplotlib
- openpyxl

## 5. Revenue Logic
Line-item revenue is calculated as:
`Revenue = UnitPrice × Quantity × (1 − Discount)`
This formula is used consistently in SQL and Python.

## 6. Key Findings from the Provided Workbook
The transaction-level analysis identifies:
- **830 orders** across the available order records.
- Approximate gross line-item revenue after discounts of **1.266 million** in the workbook's currency units.
- The strongest revenue categories are **Beverages** and **Dairy Products**, followed by **Confections** and **Meat/Poultry**.
- Revenue is concentrated in a relatively small group of products, making a Top-10 product view useful for commercial prioritization.
- The time-series output supports year-over-year and month-level review rather than relying only on a single total.

These findings are descriptive and should be interpreted together with the generated CSV outputs and charts.

## 7. Visualizations
The Python script creates:
1. Revenue by year — trend analysis.
2. Revenue by category — category comparison.
3. Top 10 products by revenue — product prioritization.
4. Monthly revenue trend — seasonality and fluctuations.

## 8. Conclusion
The project demonstrates an end-to-end data analyst workflow: importing a business workbook, modelling transactional data in SQLite, answering business questions with SQL, and communicating results through Python visualizations. The analysis can support decisions around product prioritization, category strategy, customer retention, inventory replenishment, and operational performance.The most important next step for a business stakeholder would be to combine revenue findings with profit margin, customer acquisition cost, stock availability, and shipping-service-level data before making commercial decisions.
