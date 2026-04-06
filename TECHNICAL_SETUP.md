# 🔧 Technical Setup & Reproduction Guide

## 📋 Prerequisites

### What You Need Installed
*   **Python 3.8+**
*   **MySQL 5.7+** (or any SQL database)
*   **Git**
*   **Jupyter Notebook** (for running analysis)

### Hardware Requirements
*   **RAM:** 4GB minimum (8GB recommended)
*   **Disk Space:** 2GB
*   **OS:** Windows, macOS, or Linux

---

## 🚀 Quick Start (5 Steps)

### 1. Clone the Repository
```bash
git clone https://github.com/AnalyzeWithVaidehi/Regional-Sales-Analysis-Hybrid.git
cd Regional-Sales-Analysis-Hybrid
```
### 2. Create & Activate Python EnvironmentOn Windows:
```bash
python -m venv venv
venv\Scripts\activate
```
### On macOS/Linux:
```bash
python -m venv venv
source venv/bin/activate

```
### 3. Install Dependencies
```bash
pip install -r 04_scripts/requirements.txt
```
Install these:
* pandas (data processing)
* numpy (numerical computing)
* scikit-learn (machine learning)
* matplotlib & seaborn (visualization)
* sqlalchemy (database connection)
* jupyter (notebooks)
* statsmodels (time-series analysis)

### 4. Configure Database Connection
Edit *04_scripts/config.py* with your database details:
```bash
DB_HOST = "localhost"          # Your database server
DB_USER = "your_username"      # Your MySQL username
DB_PASSWORD = "your_password"  # Your MySQL password
DB_NAME = "sales_hybrid_db"     # Database name
DB_PORT = 3306                 # Default MySQL port
```

### 5. Load Data into Database
```bash
python 04_scripts/upload_data.py
```
This script:
* Reads CSV files from /01_data/
* Creates database tables automatically
* Loads 64,105 sales records

 ### 🧪 Running the Analysis
 * Launch Jupyter Notebook: *jupyter notebook*
 * Navigate to */05_notebooks/* and run notebooks in order:
   * **01_EDA_Sales_Analysis.ipynb**  Data quality checks, basic statistics, and KPIs.
   * **02_Regional_Analysis.ipynb**     State & City deep dives and regional preferences.
   * **03_Sales_Forecasting_2026.ipynb**  Linear regression attempt and model evaluation.
   * **04_Reducing_R_square.ipynb**   Feature engineering and model debugging.
   * **05_Seasonal_Naive_Forecast.ipynb** ⭐ FINAL MODELSeasonal Naïve approach (93% accuracy) and 2026 predictions.
  
# 📂 File Structure Explained
```bash
├── 01_data/           # Raw CSV data files
├── 02_excel/          # Excel analysis & screenshots
├── 03_sql/            # SQL views & queries
├── 04_scripts/        # Config & automation (requirements.txt, upload_data.py)
├── 05_notebooks/      # Jupyter analysis notebooks (RUN THESE)
├── 06_dashboard/      # Power BI dashboard & PDF export
└── 07_results/        # Analysis outputs (charts)
```
### 🛠️ Troubleshooting
* **ModuleNotFoundError** Activate venv and run pip install -r 04_scripts/requirements.txt
* **Can't connect to MySQL** Check config.py credentials; ensure MySQL service is running.
* **File Not Found** Ensure you are running commands from the root directory.
* **Jupyter Not Found** Run pip install jupyter in your activated environment.

### ✅ Key Outputs to Expect

* **Data Quality**: 0 missing values, 0 duplicates.
* **Product Rankings:** Top 10 & bottom 10 identified by revenue.
* **Regional Analysis:** 47 states ranked by performance.
* **2026 Forecast:** Monthly predictions with 93% accuracy.
* **Gap Analysis:** $1.58M shortfall identified vs. growth target.

## Next Step: Review the live visuals in the 
/06_dashboard/ folder!

