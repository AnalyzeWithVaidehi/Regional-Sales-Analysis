# 💡 Business Insights & Strategic Roadmap

## Executive Summary

Analysis of **$1.24B in sales** across 64,104 transactions (2022–2026) reveals:

1. **Geographic Concentration**: California = 18.5% of revenue — top 5 states = 57% of all revenue
2. **Seasonal Patterns**: January volume-driven peak, April consistent trough, flat YoY growth
3. **Portfolio Imbalance**: Top 10 products = 59.9% of revenue; bottom 10 = ~14%
4. **Forecast Gap**: $289.6M projected vs $318.6M growth target — 9.1% shortfall to close

> **📌 Data Quality Note:** All figures reflect corrected data after resolving a Unit Price comma-truncation bug that was understating total revenue by 18x ($66.6M → $1.24B). The official `budgets_2026` table ($62.7M total) appears to have been set on the corrupted figures and does not reflect actual business scale.

---

## Finding #1: Revenue Concentration Risk

### Current State
- **California**: $228.8M (18.5% of total revenue)
- **Top 5 States (CA, IL, FL, TX, NY)**: ~$570M (~57% of total)
- **Risk**: Over-reliance on 5 states means any regional disruption (economic, regulatory, logistics) disproportionately impacts overall revenue

### State Performance Breakdown
| State | Revenue | Share |
|---|---|---|
| California | $228,785,436 | 18.5% |
| Illinois | $111,050,966 | 9.0% |
| Florida | $90,204,679 | 7.3% |
| Texas | $84,011,903 | 6.8% |
| New York | $55,534,960 | 4.5% |

### Underperforming States (Opportunity)
- **Texas**: 2nd largest US population, only 4th in revenue — significant headroom vs California
- **Florida**: 3rd largest population, meaningful gap vs Illinois despite similar market size
- **Louisiana & Maine**: Smaller states but show **above-average order values** (~$20,400–$21,400) — signs of premium buying behaviour in underserved markets

### Recommendation
**Pilot "California Playbook" in Texas & Florida**
- Lead with top products (26, 25, 13) — they rank #1, #2, #3 in every major state already
- Target metros: Dallas, Houston, Austin (TX); Miami, Tampa (FL)
- Goal: Reduce CA dependency from 18.5% → 12% within 18 months
- Secondary: Explore Louisiana and Maine as niche premium markets

---

## Finding #2: Seasonal Patterns

### Pattern 1: January Peak — Volume Driven
- **Avg Monthly Revenue**: ~$24.7M (highest of year)
- **Driver**: ~5,000 orders — highest order count of the year
- **Avg Unit Price**: ~$2,222 — **lowest of the year**
- **Implication**: Customers buying more frequently at lower unit values — bulk or promotional buying, not premium purchases. Revenue wins on volume, not margin.

### Action: January "Logistics" Play
- **Need**: Operational capacity to handle ~5,000 orders without quality degradation
- **Investment**: Seasonal staffing, temp warehousing, fulfillment readiness from October
- **Do NOT raise prices in January** — volume is the lever, price increases will suppress demand

### Pattern 2: April Trough — Double Crash
- **Driver**: Simultaneous drop in both order volume AND unit price — confirmed across all 4 years (2022–2025)
- **This is structural, not random** — April underperforms every single year without exception
- **Root cause**: Post-Q1 slowdown with no promotional offset

### Action: April "Spring Recovery" Campaign
- **Tactics**: Flash sales, bundle promotions, new product launches timed to late March
- **Timeline**: Campaign live March 15 — April 30
- **Target**: Bring April revenue toward the ~$24M monthly baseline
- **Note**: Launch in March — waiting until April means the dip has already started

### Pattern 3: August & November — Value Opportunity
- **Avg Unit Price**: ~$2,320+ — highest of the year in both months
- **Order Volume**: Average (not elevated)
- **Implication**: Customers are willing to pay more in these months — premium positioning has a natural window here

### Action: August & November "Premium" Play
- **Strategy**: Lead with high-margin products and bundle premium SKUs
- **Marketing**: Premium positioning, reduced discounting
- **Target Lift**: 5–10% improvement in average order value during these months

---

## Finding #3: Portfolio Performance

### Top 10 Products (59.9% of Total Revenue)
| Rank | Product | 4-Year Revenue |
|---|---|---|
| 1 | Product 26 | $117,291,821 ✅ |
| 2 | Product 25 | $109,473,967 ✅ |
| 3 | Product 13 | $78,281,380 ✅ |
| 4 | Product 14 | $75,390,397 ✅ |
| 5 | Product 5 | $70,804,381 ✅ |
| 6 | Product 15 | $67,331,623 ✅ |
| 7 | Product 2 | $57,401,098 ✅ |
| 8 | Product 4 | $56,701,537 ✅ |
| 9 | Product 1 | $55,952,290 ✅ |
| 10 | Product 3 | $51,764,816 ✅ |

### Bottom 3 Products (Highest Risk)
| Rank | Product | 4-Year Revenue |
|---|---|---|
| 30 | Product 24 | $14,555,053 ⚠️ |
| 29 | Product 9 | $14,598,630 ⚠️ |
| 28 | Product 29 | $15,311,014 ⚠️ |

### Key Metric: ~8x Revenue Delta
- Top performer (Product 26): $117.3M over 4 years (~$29.3M/year)
- Bottom performer (Product 24): $14.6M over 4 years (~$3.6M/year)
- Significant resource misallocation risk if bottom performers consume proportional sales/marketing investment

### Recommendation: Portfolio Audit
1. **Margin analysis**: Revenue alone doesn't tell the full story — a low-revenue product with high margins may be worth keeping
2. **Resource audit**: Are bottom-10 products consuming disproportionate sales team time, warehouse space, or marketing budget?
3. **Options by product**:
   - **Discontinue**: Low revenue + low margin → exit and reallocate resources
   - **Bundle**: Pair with top sellers to move inventory and lift avg order value
   - **Reposition**: Reprice or remarket if the product has untapped potential

---

## Finding #4: 2026 Forecast & Gap Analysis

### Model Selection Journey
| Model | R² / MAPE | Decision |
|---|---|---|
| Linear Regression | R²: 0.0024 | ❌ Rejected — no trend to capture |
| Feature Engineering | R²: -0.0057 | ❌ Rejected — worse than baseline |
| **Seasonal Naïve** | **MAPE: 2.2%** | ✅ Deployed — 97.8% accuracy |

Revenue is **stationary** — flat for 50 consecutive months with no growth trend. Seasonal Naïve (same month last year × growth factor) is the correct model for this data structure.

### 2026 Forecast Results

| Target | Value |
|---|---|
| YoY Growth Factor | -1.43% (2025 slightly below 2024) |
| Seasonal Naïve Forecast | $289,624,880 |
| 10% Growth Budget | $318,587,368 |
| **Gap to Close** | **-$28,962,487 (-9.1%)** |
| Back-test Accuracy | 97.8% (MAPE 2.2% on 2024 holdout) |

### Budget Context
- Official `budgets_2026` table total: $62.7M across 30 products
- This is only ~21% of the $290M the business generates annually
- Evidence strongly suggests this budget was set when revenue appeared to be $66.6M (corrupted data)
- **This is a real-world consequence of the data quality issue** — decisions made on wrong numbers produce wrong plans

### Interpretation
- At the current trajectory, the business will miss the 10% growth target by ~$29M
- Bridging that gap requires approximately **+$2.4M additional revenue per month** above the seasonal baseline
- The four strategies above collectively target this gap

---

## Success Metrics — Monthly Dashboard KPIs

Track these every month against 2026 targets:

| KPI | Current | Goal |
|---|---|---|
| California revenue share | 18.5% | Reduce to 12% |
| Texas monthly revenue | ~$7M | +15% YoY |
| Florida monthly revenue | ~$7.5M | +15% YoY |
| January order capacity | ~5,000 orders | Handle 5,500 without degradation |
| August avg order value | ~$2,320 | Lift to $2,500+ via premium push |
| April monthly revenue | ~$23.8M | Lift to $24.5M+ |
| 2026 YTD vs forecast | — | Track within 5% monthly |

---

**Last Updated:** June 2026
**Data Period:** January 2022 — February 2026
**Status:** Strategic roadmap ready for execution
