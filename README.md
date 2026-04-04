# Regional-Sales-Analysis-Hybrid (A Quick Overview)
End to end sales analysis project using Python (EDA), Excel, SQL, and PowerBI. Includes predictive trend forecasting.

## 📰**Project Overview:** 
This project analyzes regional sales data of Acme Consumer Products Co. to identify growth opportunities. The business required a 2026 revenue forecast for resource planning. Initial machine learning models failed to account for high seasonality. By pivoting to a **Seasonal Naïve Forecasting** approach, I achieved 93% accuracy, identifying a 9.1% gap between projected revenue and management targets.

## 🌟**Hybrid Twist:** 
Unlike traditional BI dashboards, this project combines **descriptive analytics** with **predictive modeling**:
- EDA reveals *what happened* and *why* (2022–2026 analysis)
- Forecasting reveals *what will happen* (2026 projections)
- Gap analysis reveals *what actions to take* (strategic roadmap)

## 🛠 Tech Stack
- **Data Extraction:** Excel, MySQL
- **Analysis:** Python (Pandas, Numpy, Matplotlib, Seaborn)
- **Visualization:** Power BI 
- **Predictive Modeling:** Linear Regression (Trend Analysis), Seasonal Naïve Forecasting
  
| Approach | Metrics | Status | Key Learning |
| :--- | :--- | :--- | :--- |
| **Linear Regression** | $R^2: 0.0057$ | ❌ Rejected | Straight lines cannot capture Jan-peaks and Apr-troughs. |
| **Feature Engineering** | $R^2: -0.34$ | ❌ Rejected | "Feature Conflict": Time-trend and Months contradicted each other. |
| **Seasonal Naïve** | **MAPE: 7.0%** | ✅ **Deployed** | Best for retail/sales; 2026 will look like 2025 + Trend. |

## 📁 Project Structure

```bash
.
├── 📂 01_data               # Raw datasets & budget targets (64K+ records)
├── 📂 02_excel              # XLOOKUP & Power Query logic validation
├── 📂 03_sql                # Master Sales View & complex aggregations
├── 📂 04_scripts            # Python ETL & automation utilities
├── 📂 05_notebooks          # End-to-end Analysis & Forecasting
│   ├── 01_EDA_Sales_Analysis.ipynb   # Data Quality & KPI Discovery
│   ├── 02_Regional_Analysis.ipynb    # State-level deep dive, regional preferences, city rankings
│   ├── 03_Sales_Forecasting_2026.ipynb    #Initial Linear Regression model (baseline approach)
│   ├── 04_Reducing_R_square.ipynb     # Feature engineering & model diagnostics
│   └── 05_Seasonal_Naaive_Forecast.ipynb  # ⭐ FINAL MODEL Seasonal Naïve approach (copy 2025 pattern with trend adjustment)
├── 📂 06_dashboard          # Power BI (.pbix) & PDF Reports
├── 📂 07_results            # Exported insights & gap analysis visuals
├── 📂 .github/workflows     # CI/CD: Automated data validation
├── 📄 BUSINESS_INSIGHTS.md  # Summary for stakeholders
├── 📄 DATA_DICTIONARY.md    # Mapping of 64K transaction columns
├── 📄 METHODOLOGY.md        # Technical approach & logic
├── 📄 TECHNICAL_SETUP.md    # How to reproduce this project
└── 📄 requirements.txt      # Python dependencies
```

## 📈 Key Business Questions
- Which region drives the most profit?
- What is the monthly revenue trend?
- Uncover seasonal trends and outliers in 4+ years of data
- Align performance against 2026 budget targets

### 🔍 Key Analytical Findings

## 1️⃣ **Revenue Concentration Risk** 
- **California alone drives 18.8%** of total revenue ($12.5M of $66.7M)
- Top 3 states (CA + IL + FL) = **34.6%** of all revenue
- **Power Trio** of products (Products 25, 26, 13) = **15.3%** of revenue
- **Action**: Pilot expansion in Texas & Florida to diversify revenue base

## 2️⃣ **Seasonal Patterns (Volume vs. Value Decomposition)**
- **January Peak**: $6.88M (highest volume, ~5,000 orders)
  - Driver: **Volume-based** (10% above average)
  - Implication: Operational scalability (staffing/logistics) is critical
  
- **March Value Peak**: Highest average unit price at **$131**
  - Driver: **Price-based** (customers willing to pay more)
  - Implication: Opportunity for premium marketing & bundling
  
- **April Trough**: $5.0M (lowest revenue)
  - Driver: Simultaneous crash in volume AND unit price
  - Action: Launch "Spring Recovery" campaigns

## 3️⃣ **Portfolio Performance Gap**
- **Top 10 products**: 59.82% of total revenue
- **Bottom 10 products**: Only 7.15% of total revenue
- **8x revenue delta** between top and bottom performers
- **Action**: Perform margin audit; discontinue or bundle low performers

## 4️⃣ **2026 Forecast & Revenue Gap**
- **Seasonal Naïve Forecast**: $15.79M (based on 2025 trends + -1.50% YoY contraction)
- **10% Growth Budget Target**: $17.37M
- **Gap to Close**: **$1.58M (-9.1%)**
- **Official Stakeholder Budget**: $62.7M
- **Model Accuracy**: 93% (MAPE: 7.0% via backtesting on 2024)

### 💼 Business Impact
- **Gap Analysis:** Forecasted $15.7M revenue vs $17.3M target.
- **Risk Mitigation:** Alerted management to a potential 9.1% shortfall 10 months in advance.
- **Accuracy:** Backtested on 2024 data with 93% reliability.
---

### 💡 Strategic Recommendations- Whats Next? (2026 Roadmap)

## 🚀 **Strategy 1: January "Logistics" Play**
- Since January is volume-driven, success requires **10% higher operational capacity**
- Focus: Staffing, shipping, fulfillment infrastructure
- ROI: Handle 5,000+ orders without quality degradation

## 🎁 **Strategy 2: March "Premium" Play**
- Capitalize on customers' willingness to pay more ($131 avg unit price)
- Focus: High-margin bundles, premium product marketing
- Expected Lift: 5–10% improvement in average order value

## 📈 **Strategy 3: April "Spring Recovery" Campaign**
- Counter natural double-crash in volume AND price
- Focus: Aggressive promotional campaigns, flash sales, discounts
- Objective: Bridge April trough back to $5.5M+ baseline

## 🌍 **Strategy 4: Regional Expansion (Concentration Risk)**
- Pilot "California Playbook" in Texas & Florida
- Leverage top products (25, 26, 13) in underperforming states
- Goal: Reduce CA dependency from 18.8% → 12% within 18 months

---
## 📞 Contact & Support

| Platform | Details |
| :--- | :--- |
| **👤 Author** | Vaidehi (AnalyzeWithVaidehi) |
| **💼 LinkedIn** | [vaidehibharambeaulagar](www.linkedin.com/in/vaidehibharambeaulagar) |
| **📧 Email** | [vaidehibh@gmail.com](mailto:vaidehibh@gmail.com) |
| **🐙 GitHub** | [@AnalyzeWithVaidehi](https://github.com/AnalyzeWithVaidehi) |

---

---

## ⭐ Show Your Support

> **Did this project help you?**  
> If you find this analysis or the forecasting methodology useful, please give this repository a **Star**! It helps others in the community discover the work and supports my journey as a Data Scientist.

---
