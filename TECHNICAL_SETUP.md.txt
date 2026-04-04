# 🔧 Technical Setup & Reproduction Guide

## Prerequisites

### What You Need Installed
- **Python 3.8+**
- **MySQL 5.7+** (or any SQL database)
- **Git**
- **Jupyter Notebook** (for running analysis)

### Hardware Requirements
- RAM: 4GB minimum (8GB recommended)
- Disk Space: 2GB
- Any operating system (Windows, macOS, Linux)

---

## Quick Start (5 Steps)

### Step 1: Clone the Repository
```bash
git clone https://github.com/AnalyzeWithVaidehi/Regional-Sales-Analysis-Hybrid.git
cd Regional-Sales-Analysis-Hybrid
Step 2: Create & Activate Python Environment
bash
# Create virtual environment
python -m venv venv

# Activate it
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
Step 3: Install Dependencies
bash
pip install -r 04_scripts/requirements.txt
This installs:

pandas (data processing)
numpy (numerical computing)
scikit-learn (machine learning)
matplotlib & seaborn (visualization)
sqlalchemy (database connection)
jupyter (notebooks)
statsmodels (time-series analysis)
Step 4: Configure Database Connection
Edit 04_scripts/config.py with your database details:

Python
DB_HOST = "localhost"          # Your database server
DB_USER = "your_username"      # Your MySQL username
DB_PASSWORD = "your_password"  # Your MySQL password
DB_NAME = "sales_hybrid_db"     # Database name
DB_PORT = 3306                 # Default MySQL port
Step 5: Load Data into Database
bash
python 04_scripts/upload_data.py
This script:

Reads CSV files from /01_data/
Creates database tables automatically
Loads 64,105 sales records
Ready for analysis

Running the Analysis
Launch Jupyter Notebook
bash
jupyter notebook
This opens your browser. Navigate to /05_notebooks/ and run notebooks in order:

01_EDA_Sales_Analysis.ipynb

Data quality checks
Basic statistics & KPIs
Product & regional analysis
02_Regional_Analysis.ipynb

State-level deep dive
City performance analysis
Regional product preferences
03_Sales_Forecasting_2026.ipynb

Linear regression attempt
Model performance evaluation
04_Reducing_R_square.ipynb

Model iteration & debugging
Feature engineering exploration
05_Seasonal_Naive_Forecast.ipynb

Final forecasting model (93% accurate)
2026 predictions
Gap analysis
File Structure Explained
Code
01_data/                    ← Raw CSV data files
02_excel/                   ← Excel analysis & screenshots
03_sql/                     ← SQL views & queries
04_scripts/                 ← Configuration & automation scripts
  ├── config.py             ← Database credentials (UPDATE THIS)
  ├── requirements.txt      ← Python dependencies
  └── upload_data.py        ← Script to load CSV → Database
05_notebooks/               ← Jupyter analysis notebooks (RUN THESE)
06_dashboard/               ← Power BI dashboard & PDF export
07_results/                 ← Analysis outputs (charts, images)
Database Setup (If Needed)
Create Database
SQL
CREATE DATABASE sales_hybrid_db;
Verify Data Load
After running upload_data.py, check:
SQL
SELECT COUNT(*) FROM sales_orders;
Expected: 64,105 rows

Troubleshooting
Issue: "ModuleNotFoundError: No module named 'pandas'"
Solution: Activate virtual environment and reinstall requirements

bash
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r 04_scripts/requirements.txt
Issue: "Can't connect to MySQL"
Solution: Check config.py has correct credentials

bash
mysql -u your_username -p -h localhost
# Then check: SELECT DATABASE(); should show your database
Issue: "No such file or directory: 01_data/Sales_Orders.csv"
Solution: Ensure you're in the repo directory

bash
pwd  # Check current directory
# Should end with: Regional-Sales-Analysis-Hybrid
Issue: Jupyter notebook not found
Solution: Install and run

bash
pip install jupyter
jupyter notebook
What Each Notebook Does
Notebook	Purpose	Input	Output
01_EDA	Data quality & KPIs	MySQL database	Summary statistics
02_Regional	Geographic analysis	MySQL database	Regional insights
03_Forecasting	Linear regression	Sales data	Model performance
04_R_square	Model improvement	Sales data	Feature analysis
05_Seasonal	Final forecast (93% accurate)	Sales data	2026 predictions
Key Outputs to Expect
After running all notebooks, you'll have:

✅ Data Quality Report - 0 missing values, 0 duplicates
✅ Product Rankings - Top 10 & bottom 10 by revenue
✅ Regional Analysis - 47 states ranked by performance
✅ Seasonal Patterns - January peak, April trough identified
✅ 2026 Forecast - Monthly predictions with 93% accuracy
✅ Gap Analysis - $1.58M shortfall vs. growth target
✅ Charts & Visualizations - 7+ analysis graphs saved to /07_results/

Next Steps
✅ Complete setup (steps 1-5 above)
✅ Run all 5 notebooks in order
✅ Review outputs in /07_results/
✅ Check Power BI dashboard in /06_dashboard/
✅ Share findings with stakeholders
