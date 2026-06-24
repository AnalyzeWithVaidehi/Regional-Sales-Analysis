# 🔧 Technical Setup & Reproduction Guide

## 📋 Prerequisites

### What You Need Installed
- **Python 3.8+**
- **MySQL 8.0+**
- **Jupyter Notebook**
- **Git** (optional — you can also download the repo as a ZIP)

### Hardware Requirements
- **RAM:** 4GB minimum (8GB recommended)
- **Disk Space:** 2GB
- **OS:** Windows, macOS, or Linux

---

## 🚀 Quick Start

### Step 1 — Clone the Repository
```bash
git clone https://github.com/AnalyzeWithVaidehi/Regional-Sales-Analysis.git
cd Regional-Sales-Analysis
```

### Step 2 — Create & Activate Python Environment

On Windows:
```bash
python -m venv venv
venv\Scripts\activate
```

On macOS/Linux:
```bash
python -m venv venv
source venv/bin/activate
```

### Step 3 — Install Dependencies
```bash
pip install -r 04_scripts/requirements.txt
```

Libraries used:
- `pandas` — data loading, cleaning, transformation
- `numpy` — numerical computing
- `scikit-learn` — linear regression models
- `matplotlib` & `seaborn` — visualisation
- `sqlalchemy` + `pymysql` — MySQL connection via Python
- `jupyter` — notebook environment

### Step 4 — Set Up MySQL Database

Open MySQL Workbench and run:
```sql
CREATE DATABASE IF NOT EXISTS sales_hybrid_db;
USE sales_hybrid_db;
```

Then load the **dimension tables** (small files — Workbench wizard is fine for these):

Right-click each table in Navigator → Table Data Import Wizard → import from `01_data/`:
- `customers.csv` → table: `customers`
- `products.csv` → table: `products`
- `regions.csv` → table: `regions`
- `state_regions.csv` → table: `state_regions`
- `budgets_2026.csv` → table: `budgets_2026`

After importing, run `03_sql/sql_cleanup.sql` in Workbench to:
- Fix `budgets_2026` data types
- Create the `v_master_sales_report` master view

### Step 5 — Load Sales Orders via Python

> ⚠️ **Do NOT use the Workbench wizard for `Sales Orders.csv`.**
> The file contains 64,000+ rows (too slow) and comma-formatted prices like `"2,499.10"` that MySQL will silently truncate during import. Python handles both issues.

Edit `04_scripts/config.py` with your database credentials:
```python
DB_CONFIG = {
    'user': 'root',
    'password': 'your_password',
    'host': 'localhost',
    'port': 3306,
    'database': 'sales_hybrid_db'
}
```

Then open `05_notebooks/Data_Import.ipynb` and run all cells.

The notebook:
- Reads `Sales Orders.csv` with all columns as text
- Strips comma formatting from `Unit Price`, `Line Total`, `Total Unit Cost`
- Converts `OrderDate` to proper datetime using explicit `%m/%d/%Y` format
- Skips the two unnamed extra columns in the source file
- Prints `max(Unit Price)` before loading — **must show ~6566, not 998**
- Loads 64,104 clean rows into MySQL via SQLAlchemy

### Step 6 — Validate Before Running Any Analysis

Run `03_sql/final_metrics_verification.sql` in Workbench. All checks must pass:

```sql
SELECT COUNT(*) FROM v_master_sales_report;
-- Expected: 64104

SELECT SUM(Revenue) FROM v_master_sales_report;
-- Expected: ~1,235,968,899

SELECT MIN(OrderDate), MAX(OrderDate) FROM v_master_sales_report;
-- Expected: 2022-01-01 to 2026-02-28

SELECT MAX(`Unit Price`) FROM sales_orders;
-- Expected: ~6566 (if this shows 998, the comma truncation bug is still present — re-run Data_Import.ipynb)
```

**If `SUM(Revenue)` shows ~$66.6M instead of ~$1.24B — stop. Do not run the analysis notebooks.** The Unit Price cleaning step did not run correctly. Re-run `Data_Import.ipynb` from the top.

### Step 7 — Run the Analysis Notebooks

Launch Jupyter:
```bash
jupyter notebook
```

Navigate to `05_notebooks/` and run in this order:

| Notebook | What it does |
|---|---|
| `Data_Import.ipynb` | ✅ Already done in Step 5 |
| `01_EDA_Sales_Analysis.ipynb` | Data quality, KPIs, product rankings, seasonality |
| `02_Regional_Analysis.ipynb` | State rankings, city performance, product-region matrix |
| `03_Sales_Forecasting_2026.ipynb` | Linear regression baseline (rejected — R²: 0.0024) |
| `04_Reducing_R_square.ipynb` | Feature engineering attempt (rejected — R²: -0.0057) |
| `05_Seasonal_Naaive_Forecast.ipynb` | ⭐ Final model — 97.8% accuracy, 2026 forecast, gap analysis |

---

## 📂 File Structure

```
.
├── 01_data/             # Raw CSV files (source data)
├── 02_excel/            # Excel regional analysis and XLOOKUP work
├── 03_sql/
│   ├── sql_cleanup.sql              # Full cleanup steps + master view creation
│   └── final_metrics_verification.sql  # Validation queries with expected values
├── 04_scripts/
│   ├── config.py        # Database connection settings (edit this)
│   └── requirements.txt # Python dependencies
├── 05_notebooks/
│   ├── Data_Import.ipynb              # Data loading & cleaning pipeline
│   ├── 01_EDA_Sales_Analysis.ipynb
│   ├── 02_Regional_Analysis.ipynb
│   ├── 03_Sales_Forecasting_2026.ipynb
│   ├── 04_Reducing_R_square.ipynb
│   └── 05_Seasonal_Naaive_Forecast.ipynb
├── 06_dashboard/        # Power BI (.pbix) and PDF dashboard exports
└── 07_results/          # Exported charts and gap analysis visuals
```

---

## 🛠 Troubleshooting

| Problem | Fix |
|---|---|
| `ModuleNotFoundError` | Activate venv and run `pip install -r 04_scripts/requirements.txt` |
| `Can't connect to MySQL` | Check `config.py` credentials; confirm MySQL service is running |
| `File Not Found` on CSV | Run commands from the repo root directory, not a subfolder |
| `Jupyter Not Found` | Run `pip install jupyter` in your activated environment |
| `SUM(Revenue)` shows ~$66M | Unit Price cleaning didn't run — re-run `Data_Import.ipynb` from the top |
| `MAX(Unit Price)` shows 998 | Same as above — comma truncation still present |
| `LOAD DATA INFILE` error | Expected on Windows — use `Data_Import.ipynb` instead (Step 5) |
| Workbench wizard too slow | Only use wizard for small dimension tables — use Python for `sales_orders` |

---

## ✅ Expected Outputs

| Check | Expected Value |
|---|---|
| Total rows | 64,104 |
| Total revenue | ~$1,235,968,899 |
| Max Unit Price | ~$6,566 |
| Date range | 2022-01-01 to 2026-02-28 |
| Top product | Product 26 (~$117.3M) |
| Top state | California (~$228.8M) |
| Forecast accuracy | 97.8% (MAPE 2.2%) |
| 2026 forecast | ~$289.6M |
| Gap to growth target | ~$28.96M (-9.1%) |

---

## Next Step

After all notebooks run successfully, review the dashboard in `/06_dashboard/` and the exported charts in `/07_results/`.

---

**Last Updated:** June 2026
**Python Version:** 3.8+
**MySQL Version:** 8.0+
