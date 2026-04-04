import pandas as pd
from sqlalchemy import create_engine
import sys
sys.path.append(r'D:\Vaidehi Study\Regional_Sales_Analysis\04_scripts')
from config import DB_CONFIG, CSV_PATHS

# Create MySQL connection
engine = create_engine(f"mysql+pymysql://{DB_CONFIG['user']}:{DB_CONFIG['password']}@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}")

# List of tables to upload
tables = [
    ('Sales_Orders', 'sales_orders'),
    ('Customers', 'customers'),
    ('Products', 'products'),
    ('Regions', 'regions'),
    ('State Regions', 'state_regions'),
    ('budgets_2026', 'budgets_2026')
]

print("=" * 80)
print("UPLOADING DATA TO MYSQL")
print("=" * 80)

for csv_name, table_name in tables:
    try:
        # Read CSV
        print(f"\n📥 Reading {csv_name}.csv...")
        df = pd.read_csv(CSV_PATHS[csv_name.lower().replace(' ', '_')])
        
        # Upload to MySQL
        print(f"   Uploading {len(df):,} rows to table '{table_name}'...")
        df.to_sql(table_name, con=engine, if_exists='replace', index=False)
        
        print(f"   ✅ Success! {len(df):,} rows uploaded")
        
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")

print("\n" + "=" * 80)
print("ALL DATA UPLOADED SUCCESSFULLY!")
print("=" * 80)

engine.dispose()