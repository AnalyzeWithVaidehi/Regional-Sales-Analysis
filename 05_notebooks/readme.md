# 📓 Notebooks — Regional Sales Analysis

This folder contains the complete Python analysis pipeline, from data import through EDA, forecasting, and gap analysis. Run notebooks in order. All notebooks read from `v_master_sales_report` in MySQL (built by `03_sql/sql_cleanup.sql`).

---

## Execution Order

```
Data_Import.ipynb              ← Run once to load data into MySQL
01_EDA_Sales_Analysis.ipynb    ← Run first for analysis
02_Regional_Analysis.ipynb     ← Run second
03_Sales_Forecasting_2026.ipynb ← Run third
04_Reducing_R_square.ipynb     ← Run fourth
05_Seasonal_Naaive_Forecast.ipynb ← Run last
```

---

## Data_Import.ipynb
**Purpose:** Load and clean `Sales Orders.csv` into MySQL

**What it does:**
- Reads raw CSV with all columns as text (`dtype=str`) to prevent any silent type conversion
- Strips comma formatting from `Unit Price`, `Line Total`, `Total Unit Cost` (e.g. `"2,499.10"` → `2499.10`)
- Converts `OrderDate` to proper datetime using explicit `%m/%d/%Y` format
- Skips two unnamed extra columns from the source file (`usecols=range(12)`)
- Verifies `max(Unit Price) = 6566` before loading — confirms no truncation occurred
- Pushes clean data to MySQL via SQLAlchemy

**Why Python instead of Workbench wizard:**
- Workbench wizard: too slow for 64,000 rows
- `LOAD DATA INFILE`: blocked by MySQL `secure-file-priv` on Windows
- Python: fast, cleaning is verifiable before loading, repeatable every time data refreshes

**Key output:** `sales_orders` table in MySQL with correct datatypes, ready for the view

---

## 01_EDA_Sales_Analysis.ipynb
**Purpose:** Understand the data and establish baseline KPIs

**What it does:**
- Connects to `v_master_sales_report` and runs data quality checks
- Calculates business metrics: total revenue, order count, avg order value
- Ranks products by revenue (top 10 and bottom 10)
- Analyses monthly revenue trend across 2022–2026
- Decomposes January peak into volume vs. price components
- Volume vs. value scatter analysis

**Key findings:**

| Metric | Value |
|---|---|
| Total Revenue (2022–2026) | $1,235,968,899 |
| Total Orders | 64,104 |
| Avg Order Value | $19,280.68 |
| Total Products | 30 |
| Total Customers | 175 |

**Top 5 products by revenue:**
| Rank | Product | Revenue |
|---|---|---|
| 1 | Product 26 | $117,291,821 |
| 2 | Product 25 | $109,473,967 |
| 3 | Product 13 | $78,281,380 |
| 4 | Product 14 | $75,390,397 |
| 5 | Product 5 | $70,804,381 |

- Top 10 products = **59.9% of total revenue** — high concentration risk
- Bottom 3 (Products 24, 9, 29) generate under $15M each over 4 years

**Seasonal findings:**
- **January peak is volume-driven** — highest order count (~5,000) but lowest avg unit price (~$2,222)
- **April is the consistent trough** across all 4 years — lowest volume and below-average prices
- Revenue is **stationary** — flat at ~$24M–$25.5M/month with no year-on-year growth trend
- February 2025 anomaly: $21.2M vs avg February of ~$23.5M — one-off dip, not a trend

---

## 02_Regional_Analysis.ipynb
**Purpose:** Identify which states and cities drive revenue and whether product preferences vary by region

**What it does:**
- State-level revenue ranking and share analysis
- Average order value by state (volume vs. premium markets)
- Top 20 cities by revenue
- Top 5 products within each of the top 5 states

**Key findings:**

**Top 5 states:**
| State | Revenue | Share |
|---|---|---|
| California | $228,785,436 | 18.5% |
| Illinois | $111,050,966 | 9.0% |
| Florida | $90,204,679 | 7.3% |
| Texas | $84,011,903 | 6.8% |
| New York | $55,534,960 | 4.5% |

- Top 5 states = **~57% of total revenue** — significant geographic concentration
- California leads on **order volume** (12,000+ orders), not on avg order value
- Avg order value is consistent across all states ($16,600–$21,400) — pricing is nationally uniform, not regionally differentiated
- Several smaller states (Louisiana, Maine) show above-average order values despite low volumes — potentially underserved premium markets

**City findings:**
- Lakewood ($6.6M) and Springfield ($6.3M) lead top 20 cities by a significant margin
- Note: both are common city names that exist across multiple states — totals are aggregated across all states with that city name

**Product geography:**
- Products 26 and 25 rank #1 and #2 in **every single top-5 state** — no regional variation
- Product 13 consistently ranks #3 across all major states
- No geographic product preference detected — the same products win everywhere

---

## 03_Sales_Forecasting_2026.ipynb
**Purpose:** Establish a baseline forecast model and test whether linear regression is appropriate for this data

**What it does:**
- Prepares 50 months of historical monthly revenue (2022-01 to 2026-02)
- Trains a simple linear regression on `TimeIndex → Revenue`
- Evaluates on a holdout test set

**Results:**

| Metric | Value |
|---|---|
| R² Score | 0.0024 |
| RMSE | $1,008,278 |
| Trend | -$3,402/month |

**Conclusion:** R² ≈ 0 means linear regression explains essentially none of the revenue variance. Revenue has been flat for 50 months with no consistent upward or downward trend — there is no linear relationship to find. The -$3,402/month trend is statistically meaningless noise.

**→ Linear regression is the wrong tool for this dataset. Proceeding to feature engineering to confirm.**

---

## 04_Reducing_R_square.ipynb
**Purpose:** Attempt to improve the linear regression model with feature engineering before concluding it cannot work

**What it does:**
- Adds features: month number, quarter, previous month revenue (lag), time index
- Retrains and evaluates

**Results:**

| Metric | Value |
|---|---|
| R² Score | -0.0057 |
| MAE | $542,238 |

**Conclusion:** Negative R² means the feature-engineered model is worse than simply predicting the mean every month. Adding month, quarter, and lag features made performance worse, not better — because none of these variables have a consistent relationship with revenue in this dataset.

**Both linear models have now failed. This is informative, not a failure:**
- The data is stationary (no growth trend)
- Revenue follows a seasonal rhythm, not a formula
- The correct approach for stationary seasonal data is Seasonal Naive forecasting

**→ Proceeding to Seasonal Naive model.**

---

## 05_Seasonal_Naaive_Forecast.ipynb
**Purpose:** Forecast 2026 revenue using Seasonal Naive method and quantify the gap against budget targets

**What it does:**
- Calculates YoY growth factor from 2024→2025 actuals (-1.43%)
- Generates 2026 monthly forecast: same month last year × growth factor
- Sets budget target: forecast × 1.10 (10% stretch above forecast)
- Back-tests on 2024 data (predicting 2024 using 2023 actuals)
- Builds cumulative YTD gap analysis chart
- Analyses the April slump pattern across all years
- Loads official `budgets_2026` product-level budget for comparison

**Validation:**

| Metric | Value |
|---|---|
| Back-test MAPE | 2.2% |
| Accuracy | 97.8% |
| Back-test period | 2024 (using 2023 as base) |

**2026 Forecast results:**

| Target | Value |
|---|---|
| Seasonal Naive Forecast | $289,624,880 |
| 10% Growth Budget | $318,587,368 |
| Gap to Growth Target | -$28,962,487 (-9.1%) |

**Notable finding — budgets_2026 vs actual revenue:**
- Official product budget total: $62,700,262 across 30 products
- This represents only ~21% of the $290M annual revenue the business generates
- Budget range: $594K to $5.69M per product vs actual product revenues of $14M–$117M/year
- Strong evidence this budget was set when revenue data was corrupted ($66.6M apparent vs $1.24B actual) — a direct example of how upstream data quality issues corrupt downstream business decisions

**Key seasonal findings confirmed:**
- January/February: volume-driven revenue peaks (high orders, lower avg price)
- April: consistent slump across all 4 years — drop in both volume and price simultaneously
- Business is essentially flat YoY — no growth trend detected in 4 years of data

**Strategic implication:**
- To hit the 10% growth budget, the business needs ~$2.4M additional revenue per month above the seasonal forecast baseline
- February 2026 forecast ($20.9M) carries the highest uncertainty — it inherits the anomalous Feb 2025 base

---

## Prerequisites

```python
# Required libraries
pip install pandas numpy matplotlib seaborn sqlalchemy pymysql

# Database
MySQL 8.0+ with sales_hybrid_db schema
Run 03_sql/sql_cleanup.sql first
Run Data_Import.ipynb once before any analysis notebook
```

Config file at `04_scripts/config.py`:
```python
DB_CONFIG = {
    'user': 'root',
    'password': 'your_password',
    'host': 'localhost',
    'port': 3306,
    'database': 'sales_hybrid_db'
}
```
