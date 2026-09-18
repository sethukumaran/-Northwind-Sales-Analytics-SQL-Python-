import sqlite3, pandas as pd, pathlib


def build_database():
    xls = pd.ExcelFile(DATA)
    conn = sqlite3.connect(DB)
    pd.read_excel(DATA, "Categories").to_sql("categories", conn, if_exists="replace", index=False)
    p = pd.read_excel(DATA, "Products")
    p.to_sql("products", conn, if_exists="replace", index=False)
    cust = pd.read_excel(DATA, "Customers")
    cust.to_sql("customers", conn, if_exists="replace", index=False)
    o = pd.read_excel(DATA, "Orders")
    for col in ["OrderDate","RequiredDate","ShippedDate"]:
        o[col] = pd.to_datetime(o[col], errors="coerce").dt.strftime("%Y-%m-%d")
    o.to_sql("orders", conn, if_exists="replace", index=False)
    d = pd.read_excel(DATA, "Order_Details")
    d.to_sql("order_details", conn, if_exists="replace", index=False)
    return conn

if __name__ == "__main__":
    build_database()
    print(f"Database created: {DB}")
