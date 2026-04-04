# 📊 Data Dictionary (Updated)

This document defines the structure and relationships of the datasets used in the Regional Sales Analysis project.


```markdown
# 📊 Data Dictionary (Updated)

This document defines the structure and relationships of the datasets used in the Regional Sales Analysis project.

## 📦 1. Sales_Orders.csv
**Size**: 64,104 rows × 12 columns | **Primary Fact Table**

| Column | Type | Description |
|--------|------|-------------|
| OrderNumber | String | Unique transaction ID (e.g., SO - 000225) |
| OrderDate | Date | Date of transaction (M/D/YYYY) |
| Customer Name Index | Integer | Links to `Customer Index` in `Customers.csv` |
| Channel | String | Sales channel (Wholesale, Distributor, Export, In-Store) |
| Currency Code | String | Currency of the transaction (e.g., USD) |
| Warehouse Code | String | ID of the fulfillment warehouse |
| Delivery Region Index | Integer | Links to `id` in `Regions.csv` (City/State info) |
| Product Description Index| Integer | Links to `Index` in `Products.csv` |
| Order Quantity | Integer | Number of units sold |
| Unit Price | Decimal | Price per single unit ($) |
| Line Total | Decimal | Total revenue for the row (Qty × Price) |
| Total Unit Cost | Decimal | Cost to produce/acquire the unit |
*(Note: Two trailing empty columns in the raw data have been omitted for clarity)*

---

## 🗺️ 2. Regions.csv
**Size**: 994 rows × 15 columns | **Geography Dimension**

| Column | Type | Description |
|--------|------|-------------|
| id | Integer | Unique Region ID (matches `Delivery Region Index`) |
| name | String | City name |
| county | String | US County name |
| state_code | String | Two-letter state abbreviation |
| state | String | Full US State name |
| type | String | Type of region (e.g., City) |
| latitude | Decimal | Geographical latitude |
| longitude | Decimal | Geographical longitude |
| area_code | Integer | Primary telephone area code |
| population | Integer | Population of the specific city |
| households | Integer | Total number of households |
| median_income | Integer | Median income for the area ($) |
| land_area | Integer | Total land area of the region |
| water_area | Integer | Total water area of the region |
| time_zone | String | Local time zone (e.g., America/Chicago) |

---

## 🏬 3. Customers.csv
**Size**: 175 rows × 2 columns | **Customer Dimension**

| Column | Type | Description |
|--------|------|-------------|
| Customer Index | Integer | Unique Customer ID |
| Customer Names | String | Business name of the client |

---

## 🏷️ 4. Products.csv
**Size**: 30 rows × 2 columns | **Product Dimension**

| Column | Type | Description |
|--------|------|-------------|
| Index | Integer | Unique Product ID |
| Product Name | String | SKU Name (Product 1 - Product 30) |

---

## 🌎 5. State_Regions.csv
**Size**: 48 rows × 3 columns | **Territory Mapping**

| Column | Type | Description |
|--------|------|-------------|
| State Code | String | Two-letter state abbreviation |
| State | String | Full state name |
| Region | String | Business territory (South, West, Midwest, Northeast) |

---

## 💰 6. budgets_2026.csv
**Size**: 30 rows × 2 columns | **Target Dimension**

| Column | Type | Description |
|--------|------|-------------|
| Product Name | String | Name of the product |
| 2026 Budgets | Decimal | Annual revenue target for 2026 |
```


**Last Updated**: April 2026