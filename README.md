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

## 📂 Project Structure

Regional-Sales-Analysis/
│ ├── 📁 01_data/ # Raw datasets 
│      ├── Sales_Orders.csv   # 64K transactions (5.6 MB) 
│      ├── State_Regions.csv  # State mapping 
│      ├── Regions.csv        # Regional groupings 
│      ├── Products.csv       # Product catalog 
│      ├── Customers.csv      # Customer master 
│      ├── budgets_2026.csv   # 2026 budget targets 
│ ├── 📁 02_excel/            # Excel-based analysis
│      ├── Sales_Analysis_Master.xlsx      # Advanced analytics workbook 
│      ├── Business_Region_Xlookup.png     # XLOOKUP formula screenshot 
│      ├── State_Code_Xlookup.png          # Data lookup formula screenshot 
│ ├── 📁 03_sql/             # SQL queries & views 
│      ├── v_master_sales_report.sql       # Main aggregation view 
│      └── Screenshot-master-view-sql.png  # Query results
│ ├── 📁 04_scripts/         # Python utilities
│      ├── config.py                       # Database credentials (excluded from git) 
│      ├── requirements.txt                # pip dependencies 
│      └── upload_data.py                  # Automated CSV-to-MySQL loader 
│ ├── 📁 05_notebooks/       # Jupyter notebooks (main analysis) 
│      ├── 01_EDA_Sales_Analysis.ipynb     # Data quality, KPIs, top products/states 
│      ├── 02_Regional_Analysis.ipynb      # State-level deep dive 
│      ├── 03_Sales_Forecasting_2026.ipynb # Initial modeling attempts 
│      ├── 04_Reducing_R_square.ipynb      # Model iteration & diagnosis
│      └── 05_Seasonal_Naaive_Forecast.ipynb # <-- The Winner Final forecasting approach
│ ├── 📁 06_dashboard/       # Power BI & visualizations
│ ├── Regional_Sales_Forecasting_2026.pbix # Interactive dashboard 
│ └── Regional_Sales_Forecasting_2026.pdf # Dashboard export 
│ ├── 📁 07_results/         # Output charts & exports
│ ├── Top_10_Products_Revenue.png 
│ ├── Bottom_10_Products_Revenue.png 
│ ├── Revenue_by_State.png 
│ ├── Monthly_Trend_Analysis.png
│ ├── Seasonal_Decomposition.png
│ ├── Regional_Performance_Matrix.png
│ └── 2026_Forecast_Gap_Analysis.png 
│ ├── 📁 .github/workflows/   # CI/CD automation 
│ └── data_validation.yml     # Automated data quality checks 
│ ├── README.md # This file
├── DATA_DICTIONARY.md # Column definitions 
├── METHODOLOGY.md # Technical approach 
├── TECHNICAL_SETUP.md # How to run the project 
├── BUSINESS_INSIGHTS.md # Detailed findings 
├── .gitignore # Files to exclude from git 
── requirements.txt # Project dependencies

## 📈 Key Business Questions
- Which region drives the most profit?
- What is the monthly revenue trend?
- Uncover seasonal trends and outliers in 4+ years of data
- Align performance against 2026 budget targets

# (My Science Goal): 
Can we predict next month's sales based on current trends i.e 2026 Sales Forecasting?

## 🔍 Key Analytical Findings

### 1️⃣ **Revenue Concentration Risk** 
- **California alone drives 18.8%** of total revenue ($12.5M of $66.7M)
- Top 3 states (CA + IL + FL) = **34.6%** of all revenue
- **Power Trio** of products (Products 25, 26, 13) = **15.3%** of revenue
- **Action**: Pilot expansion in Texas & Florida to diversify revenue base

### 2️⃣ **Seasonal Patterns (Volume vs. Value Decomposition)**
- **January Peak**: $6.88M (highest volume, ~5,000 orders)
  - Driver: **Volume-based** (10% above average)
  - Implication: Operational scalability (staffing/logistics) is critical
  
- **March Value Peak**: Highest average unit price at **$131**
  - Driver: **Price-based** (customers willing to pay more)
  - Implication: Opportunity for premium marketing & bundling
  
- **April Trough**: $5.0M (lowest revenue)
  - Driver: Simultaneous crash in volume AND unit price
  - Action: Launch "Spring Recovery" campaigns

### 3️⃣ **Portfolio Performance Gap**
- **Top 10 products**: 59.82% of total revenue
- **Bottom 10 products**: Only 7.15% of total revenue
- **8x revenue delta** between top and bottom performers
- **Action**: Perform margin audit; discontinue or bundle low performers

### 4️⃣ **2026 Forecast & Revenue Gap**
- **Seasonal Naïve Forecast**: $15.79M (based on 2025 trends + -1.50% YoY contraction)
- **10% Growth Budget Target**: $17.37M
- **Gap to Close**: **$1.58M (-9.1%)**
- **Official Stakeholder Budget**: $62.7M
- **Model Accuracy**: 93% (MAPE: 7.0% via backtesting on 2024)

## 💼 Business Impact
- **Gap Analysis:** Forecasted $15.7M revenue vs $17.3M target.
- **Risk Mitigation:** Alerted management to a potential 9.1% shortfall 10 months in advance.
- **Accuracy:** Backtested on 2024 data with 93% reliability.
