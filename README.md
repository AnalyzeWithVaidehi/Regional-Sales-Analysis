# Regional Sales Analysis — End to End Project

End to end sales analysis project using Python (EDA), Excel, SQL, and Power BI. Includes predictive trend forecasting.

---

## 📰 Project Overview

This project analyzes regional sales data of Acme Consumer Products Co. across 64,104 transactions spanning 2022–2026, covering 30 products, 175 customers, and 48 US states. The goal was to identify revenue concentration risks, uncover seasonal patterns, and produce a reliable 2026 revenue forecast for resource planning.

Initial linear regression models failed to capture the data's seasonal structure. By pivoting to a **Seasonal Naïve Forecasting** approach, I achieved **97.8% accuracy (MAPE: 2.2%)**, identifying a **9.1% gap** between the $289.6M projected revenue and the $318.6M growth target.

> **📌 Data Quality Note:** During post-publish review, a significant data quality issue was identified and resolved. The `Unit Price` column was stored as comma-formatted text (e.g. `"2,499.10"`), causing MySQL to silently truncate values at the comma during type conversion. 79% of rows were affected — all transactions above $1,000. This understated total revenue by 18x ($66.6M → $1.24B). The fix, root cause analysis, and verification steps are fully documented in `03_sql/sql_cleanup.sql` and `05_notebooks/Data_Import.ipynb`. This discovery is what led to structuring later projects around a dedicated data validation phase before any analysis.

---

## 🌟 Hybrid Twist

Unlike traditional BI dashboards, this project combines **descriptive analytics** with **predictive modeling**:
- EDA reveals *what happened* and *why* (2022–2026 analysis)
- Forecasting reveals *what will happen* (2026 projections)
- Gap analysis reveals *what actions to take* (strategic roadmap)

---

## 🛠 Tech Stack

- **Data Loading:** Python (pandas, SQLAlchemy)
- **Data Storage:** MySQL 8.0
- **Analysis:** Python (Pandas, NumPy, Matplotlib, Seaborn)
- **Visualization:** Power BI
- **Predictive Modeling:** Linear Regression, Feature Engineering, Seasonal Naïve Forecasting

| Approach | Metric | Status | Key Learning |
| :--- | :--- | :--- | :--- |
| **Linear Regression** | R²: 0.0024 | ❌ Rejected | No linear trend exists — revenue is flat for 50 months |
| **Feature Engineering** | R²: -0.0057 | ❌ Rejected | Adding month/quarter/lag features made performance worse |
| **Seasonal Naïve** | **MAPE: 2.2%** | ✅ **Deployed** | Best for stationary seasonal data — 2026 inherits 2025 pattern + trend |

---

## 📁 Project Structure

```
.
├── 📂 01_data               # Raw datasets & budget targets (64K+ records)
├── 📂 02_excel              # XLOOKUP regional analysis & pivot tables
├── 📂 03_sql                # SQL cleanup, master view, validation queries
├── 📂 04_scripts            # Python config & connection utilities
├── 📂 05_notebooks          # End-to-end analysis & forecasting
│   ├── Data_Import.ipynb              # Data loading & cleaning pipeline
│   ├── 01_EDA_Sales_Analysis.ipynb    # Data quality & KPI discovery
│   ├── 02_Regional_Analysis.ipynb     # State-level deep dive & city rankings
│   ├── 03_Sales_Forecasting_2026.ipynb # Linear regression baseline
│   ├── 04_Reducing_R_square.ipynb     # Feature engineering & model diagnostics
│   └── 05_Seasonal_Naaive_Forecast.ipynb # ⭐ Final model & gap analysis
├── 📂 06_dashboard          # Power BI (.pbix) & PDF reports
├── 📂 07_results            # Exported charts & gap analysis visuals
├── 📂 .github/workflows     # CI/CD: Automated data validation
├── 📄 BUSINESS_INSIGHTS.md  # Summary for stakeholders
├── 📄 DATA_DICTIONARY.md    # Column definitions for all tables
├── 📄 METHODOLOGY.md        # Technical approach & logic
├── 📄 TECHNICAL_SETUP.md    # How to reproduce this project
└── 📄 Regonal_Sales_ER_Diagram.png   # Entity relationship diagram
```

---

## 📈 Key Business Questions

- Which region and state drives the most revenue?
- What is the monthly revenue trend and are there seasonal patterns?
- Which products are top and bottom performers?
- What is the 2026 revenue forecast and how does it compare to budget targets?

---

## 🔍 Key Analytical Findings

### 1️⃣ Revenue Concentration Risk

- **California alone drives 18.5%** of total revenue ($228.8M of $1.24B)
- Top 5 states (CA, IL, FL, TX, NY) = **~57%** of all revenue
- **Top trio** of products (Products 26, 25, 13) = **~24.7%** of total revenue
- Products 26 and 25 rank **#1 and #2 in every top-5 state** — no regional product variation detected
- **Action:** Reduce CA dependency from 18.5% → 12% — pilot expansion in underperforming states with proven top products

### 2️⃣ Seasonal Patterns — Volume vs. Value Decomposition

- **January Peak:** ~$24.7M monthly average — highest order volume (~5,000 orders)
  - Driver: **Volume-based** — highest order count of the year but lowest avg unit price (~$2,222)
  - Implication: January growth requires operational capacity (staffing, logistics), not pricing strategy

- **April Trough:** Consistent lowest-revenue month across all 4 years
  - Driver: Simultaneous drop in both volume and price
  - Action: Launch "Spring Recovery" promotional campaigns in March to pre-empt the dip

- **August/November:** Highest average unit prices (~$2,320+) despite average order volumes
  - Opportunity: Premium product marketing during these months could lift revenue without volume pressure

- **Revenue is stationary:** Flat at ~$24M–$25.5M/month for 50 consecutive months — no year-on-year growth detected

### 3️⃣ Portfolio Performance Gap

- **Top 10 products:** 59.9% of total revenue
- **Bottom 10 products:** ~14% of total revenue
- **~8x revenue delta** between top performer (Product 26: $117.3M) and bottom (Product 24: $14.6M)
- **Action:** Perform margin audit on bottom 10 — consider bundling with top performers or discontinuation

### 4️⃣ 2026 Forecast & Revenue Gap

- **Seasonal Naïve Forecast:** $289,624,880 (based on 2025 actuals × -1.43% YoY trend)
- **10% Growth Budget Target:** $318,587,368
- **Gap to Close:** **-$28,962,487 (-9.1%)**
- **Model Accuracy:** 97.8% (MAPE: 2.2% via back-testing on 2024 data)

> ⚠️ **Budget Note:** The official `budgets_2026` product budget totals $62.7M across 30 products — only ~21% of the $290M the business actually generates annually. Evidence suggests this budget was set when revenue data was corrupted at $66.6M. This is a direct example of how upstream data quality issues corrupt downstream business decisions.

---

## 📊 Core KPIs (2022–2026)

| Metric | Value |
| :--- | :--- |
| **Total Revenue** | $1,235,968,899 |
| **Total Transactions** | 64,104 |
| **Total Customers** | 175 |
| **Total Products** | 30 |
| **Avg Order Value** | $19,280.68 |
| **Top State** | California ($228.8M) |
| **Top Product** | Product 26 ($117.3M) |
| **Forecast Accuracy** | 97.8% (MAPE 2.2%) |

---

## 💼 Business Impact

- **Gap Analysis:** $289.6M forecast vs $318.6M target — 9.1% shortfall quantified 10 months in advance
- **Risk Flag:** Business has been flat for 4 years with no growth trend — revenue plateau identified
- **Data Quality:** Resolved an 18x revenue undercount affecting 79% of transactions — demonstrated that budgets set on corrupted data ($62.7M vs $290M actual) can fundamentally misdirect resource planning
- **Model Validation:** 97.8% back-test accuracy on 2024 holdout confirms seasonal naive is the appropriate model for this dataset

---

## 💡 Strategic Recommendations — 2026 Roadmap

### 🚀 Strategy 1: January "Logistics" Play
- January is volume-driven (~5,000 orders, ~$24.7M revenue) with the lowest avg unit price of the year
- Focus: Staffing, shipping, and fulfillment infrastructure to handle volume without degradation
- Do NOT raise prices in January — volume is the lever, not price

### 📈 Strategy 2: August/November "Premium" Play
- August and November show the highest average unit prices (~$2,320+) despite normal order volumes
- Focus: High-margin bundles and premium product marketing during these months
- Expected lift: 5–10% improvement in average order value

### 🎯 Strategy 3: April "Spring Recovery" Campaign
- April is the consistent annual trough — simultaneous drop in both volume and price across all 4 years
- Focus: Aggressive promotional campaigns and flash sales launched in late March
- Objective: Bridge April revenue back toward the ~$24.5M monthly baseline

### 🌍 Strategy 4: Regional Diversification
- Top 5 states generate ~57% of revenue — over-concentration in CA, IL, FL, TX, NY
- Products 26 and 25 win in every major market — proven products ready for new markets
- Goal: Pilot the California playbook in mid-tier states showing above-average order values (Louisiana, Maine)
- Target: Reduce CA dependency from 18.5% toward 12% within 18 months

---

## 📞 Contact

| Platform | Details |
| :--- | :--- |
| **👤 Author** | Vaidehi (AnalyzeWithVaidehi) |
| **💼 LinkedIn** | [vaidehibharambeaulagar](https://www.linkedin.com/in/vaidehibharambeaulagar/) |
| **📧 Email** | [vaidehibh@gmail.com](mailto:vaidehibh@gmail.com) |
| **🐙 GitHub** | [@AnalyzeWithVaidehi](https://github.com/AnalyzeWithVaidehi) |

---

## ⭐ Show Your Support

> If you find this analysis or forecasting methodology useful, please give this repository a **Star** — it helps others discover the work and supports my journey as a Data Analyst.
