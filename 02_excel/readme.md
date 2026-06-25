# 📊 Excel Analysis — Regional Sales

Quick regional analysis built in Excel as the first-pass answer to: **"Which business region is performing best?"**

---

## File

**`Sales_Analysis_Master.xlsx`** — contains all source data across five sheets (Sales Orders, Customers, Regions, State Regions, Products) plus a dedicated `Regional Analysis` sheet.

---

## What's in Regional Analysis sheet

**Two XLOOKUP columns added to Sales Orders:**
- `State_Code` — looks up state abbreviation from the Regions table
- `Business_Region` — looks up US business region (West, Midwest, South, Northeast) from the State Regions table

These were used to group transactions by region before SQL was set up.

**Pivot Table** — summarises by Business Region:
- Total Revenue
- Total Units Sold
- Average Unit Price
- Average Order Value (calculated field)

**Two charts** built from the pivot data:
- Total Revenue by Business Region
- Average Unit Price by Business Region

---

## Key Finding

| Region | Total Revenue | Avg Unit Price |
|---|---|---|
| West | $372,142,308 | $2,261 |
| South | $335,135,012 | $2,291 |
| Midwest | $320,322,364 | $2,286 |
| Northeast | $208,369,216 | $2,315 |

**West leads on total revenue** driven by California ($228.8M alone).
**Northeast has the highest average unit price** despite the lowest total revenue — fewer but higher-value transactions. Pricing is consistent across all regions (~$2,260–$2,315) meaning volume, not price, determines regional revenue differences.

---

## Why Excel First

Excel gave an immediate answer before the SQL view and Python pipeline were built. The XLOOKUP formulas replicate what the SQL JOIN later does — demonstrating the same logic across two tools.

Full deep-dive regional analysis (state-level, city-level, product-by-region) is in `05_notebooks/02_Regional_Analysis.ipynb`.
