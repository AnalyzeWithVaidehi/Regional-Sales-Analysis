# 🔬 Analytical Methodology

## Analysis Approach

| Phase | Focus | Output |
|---|---|---|
| **Phase 0: Data Pipeline** | Load, clean, validate source data | Clean MySQL tables + master view |
| **Phase 1: EDA** | Understand distributions, KPIs, product performance | Baseline metrics + top/bottom rankings |
| **Phase 2: Regional Analysis** | Geographic performance patterns | State + city rankings, product-region matrix |
| **Phase 3: Seasonal Decomposition** | Volume vs. value drivers by month | Seasonality chart, January peak analysis |
| **Phase 4: Forecasting** | Model selection, validation, gap analysis | 2026 forecast + budget gap |
| **Phase 5: Strategic Recommendations** | Actionable insights from findings | 4-strategy 2026 roadmap |

---

## Phase 0: Data Pipeline & Quality

### Data Loading
Source data was loaded via Python (pandas + SQLAlchemy) rather than MySQL Workbench's import wizard or `LOAD DATA INFILE`:
- **Workbench wizard**: Too slow for 64,000 rows — abandoned
- **LOAD DATA INFILE**: Blocked by MySQL `secure-file-priv` security setting on Windows
- **Python (chosen)**: Fast, cleaning verifiable before loading, repeatable on data refresh

```python
# All columns loaded as text first, cleaned in pandas before MySQL load
df_raw = pd.read_csv('Sales_Orders.csv', dtype=str, usecols=range(12))
for col in ['Unit Price', 'Line Total', 'Total Unit Cost', 'Order Quantity']:
    df_raw[col] = pd.to_numeric(df_raw[col].str.replace(',', '', regex=False))
df_raw['OrderDate'] = pd.to_datetime(df_raw['OrderDate'], format='%m/%d/%Y')
```

### Critical Data Quality Issue — Discovered Post-Publish

**Problem:** `Unit Price` was stored as comma-formatted text (e.g. `"2,499.10"`). MySQL's `CAST` silently truncated at the comma — `"2,499.10"` → `2` — with no error, no null, no warning.

**Scope:** 50,352 of 64,104 rows affected (78.5%) — every transaction above $1,000.

**Impact:**

| Metric | Corrupted Value | Correct Value |
|---|---|---|
| Total Revenue | $66,659,528 | $1,235,968,899 |
| Avg Order Value | $1,039.87 | $19,280.68 |
| Top Product | Product 25 | Product 26 |
| Max Unit Price | $998.30 | $6,566.00 |

**Root cause:** Excel stores numbers and display formatting separately. A cell showing `"2,499.10"` with thousands-separator formatting stores `2499.10` internally — Excel is clean. But when exported to CSV, the comma gets baked into the text. MySQL received `"2,499.10"` as a string and truncated silently during `CAST`.

**Detection method:**
```sql
-- This returned 50,352 — not the 2 rows originally expected
SELECT COUNT(*) FROM sales_orders
WHERE `Unit Price` REGEXP '[^0-9.]';

-- Confirmed truncation: MAX was 998.30, not ~6566
SELECT MAX(`Unit Price`), MIN(`Unit Price`) FROM sales_orders;

-- Verified fix: raw table total must match view total
SELECT SUM(`Order Quantity` * `Unit Price`) FROM sales_orders;
-- Correct: 1,235,968,899
```

**Fix:** Strip commas in Python before loading. Verified `max(Unit Price) = 6566` before `to_sql()`.

**Downstream consequence discovered:** The official `budgets_2026` table totals $62.7M across 30 products — only 21% of actual annual revenue. Evidence that this budget was set when revenue appeared to be $66.6M, making it non-comparable to the corrected $290M forecast. A direct example of how upstream data quality issues corrupt downstream business decisions.

**Lesson learned:** Data validation must happen at the layer where computation runs, not just at the source. Checking Excel showed clean numbers — the truncation only appeared in MySQL after import.

### Data Quality Metrics (Post-Fix)

| Check | Result |
|---|---|
| Missing values | 0 across all columns |
| Duplicate rows | 0 |
| Orphaned foreign keys (products) | 0 |
| Orphaned foreign keys (customers) | 0 |
| Orphaned foreign keys (regions) | 0 |
| Unit Price REGEXP `[^0-9.]` | 0 (confirmed clean) |
| Line Total cross-check | 0 mismatches |
| Date range | 2022-01-01 to 2026-02-28 ✅ |
| Max Unit Price | $6,566 ✅ |
| Total Revenue (view) | $1,235,968,899 ✅ |

---

## Key Analytical Findings

### Finding #1: Revenue Concentration Risk
- **California**: $228.8M (18.5% of total revenue)
- **Top 5 States**: ~$570M (~57% of revenue)
- **Risk**: Over-reliance on 5 states — any regional disruption has outsized impact
- **Opportunity**: Louisiana and Maine show above-average order values ($20,400–$21,400) despite low volumes — underserved premium markets
- **Action**: Pilot Texas and Florida expansion using proven top products

### Finding #2: Seasonal Patterns
- **January Peak**: Volume-driven (~5,000 orders, lowest avg unit price ~$2,222)
- **April Trough**: Consistent double-crash across all 4 years — volume AND price both drop
- **August & November**: Highest avg unit prices (~$2,320+) — natural premium opportunity windows
- **Note**: March "premium peak" previously reported ($131.22 avg price) was an artefact of the corrupted data — not present in corrected analysis
- **Action**: Season-specific operational and marketing strategies per pattern

### Finding #3: Portfolio Imbalance
- **Top 10 Products**: 59.9% of revenue
- **Bottom 10 Products**: ~14% of revenue
- **~8x revenue delta**: Product 26 ($117.3M) vs Product 24 ($14.6M) over 4 years
- **Action**: Margin audit and discontinuation review for bottom performers

### Finding #4: 2026 Forecast
- **Model**: Seasonal Naïve with YoY growth adjustment
- **Accuracy**: 97.8% (MAPE: 2.2% backtested on 2024 holdout)
- **2026 Forecast**: $289,624,880
- **Gap to 10% Growth Target**: -$28,962,487 (-9.1%)

---

## Model Selection Process

Revenue is **stationary** — flat at ~$24M–$25.5M/month for 50 consecutive months with no upward or downward trend. This makes linear regression fundamentally inappropriate — it looks for trends where none exist.

| Model | Metric | Status | Reason |
|---|---|---|---|
| Linear Regression | R²: 0.0024 | ❌ Rejected | Explains <1% of variance — no linear trend exists |
| Feature Engineering | R²: -0.0057 | ❌ Rejected | Worse than predicting the mean — adding month/quarter/lag features made it worse |
| **Seasonal Naïve** | **MAPE: 2.2%** | ✅ Deployed | Correct tool for stationary seasonal data — 97.8% accuracy on holdout |

**Why Seasonal Naïve works here:**
- Revenue has no trend — each year looks like the last
- There is a repeatable seasonal rhythm (January peak, April trough)
- Seasonal Naïve captures the rhythm without assuming growth
- The -1.43% YoY adjustment accounts for the slight 2024→2025 contraction

---

## Notebooks Summary

| Notebook | Purpose | Key Output |
|---|---|---|
| `Data_Import.ipynb` | Load and clean source data | Clean `sales_orders` table in MySQL |
| `01_EDA_Sales_Analysis.ipynb` | Data quality, KPIs, product ranking, seasonality | Top/bottom 10, January peak analysis |
| `02_Regional_Analysis.ipynb` | State rankings, city performance, product-region matrix | CA dominance, uniform pricing finding |
| `03_Sales_Forecasting_2026.ipynb` | Linear regression baseline | R²=0.0024 — model rejected |
| `04_Reducing_R_square.ipynb` | Feature engineering attempt | R²=-0.0057 — confirms wrong tool |
| `05_Seasonal_Naaive_Forecast.ipynb` | Final model, backtesting, gap analysis | 97.8% accuracy, $28.96M gap identified |

---

## Strategic Recommendations

### 1. January "Logistics" Play
- **Driver**: Volume spike (~5,000 orders, lowest avg unit price of year)
- **Action**: +10% operational capacity — staffing, shipping, fulfilment
- **Key insight**: Do NOT raise prices in January — volume is the lever

### 2. August & November "Premium" Play
- **Driver**: Highest avg unit prices of the year (~$2,320+)
- **Action**: Premium bundles, reduced discounting, high-margin product marketing
- **Lift**: 5–10% improvement in average order value

### 3. April "Spring Recovery"
- **Driver**: Structural seasonal trough — confirmed all 4 years
- **Action**: Flash sales and promotions launched in mid-March before the dip starts
- **Goal**: Bring April revenue toward ~$24.5M monthly baseline

### 4. Regional Expansion
- **Driver**: CA dependency at 18.5% of total revenue
- **Action**: Pilot Texas and Florida using top products (26, 25, 13) as anchors
- **Secondary**: Explore Louisiana and Maine as premium niche markets
- **Goal**: Reduce CA from 18.5% → 12% within 18 months

---

**Last Updated:** June 2026
**Data Period:** January 2022 — February 2026
**Status:** All findings based on validated, corrected dataset
