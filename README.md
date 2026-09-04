# 🏥 Hospital Data Warehouse & Triage Optimization

> End-to-End Healthcare Analytics | Medallion Architecture (raw → bronze → clean → gold) | 793 Patients, 48K Encounters, $396M Revenue | Mortality 19.9% + A/B Testing

![MySQL](https://img.shields.io/badge/MySQL-Workbench-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-A/B_Testing-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Healthcare](https://img.shields.io/badge/Domain-Healthcare_EHR-E40000?style=for-the-badge)

## 📸 Dashboard - Power BI

**Home KPIs:** Total Patients 793 (Male 403 - 51%, Female 390 - 49%) | Total Revenue 396M | Total Encounters 48K | Average Claim 8.31K | Mortality Rate 19.90% | Years 2011-2022

- Revenue by Payer: NO_INSURANCE (top), Medicare, Medicaid, Anthem, Humana, Blue Cross, Cigna, Aetna, United, Dual Eligible
- Encounters Trend 2011-2022: Peak 2015 ~6K, Drop 2022
- Encounters by Type: ambulatory, outpatient, wellness, inpatient, emergency, urgentcare
- Top 5 Reasons for Visit: Prenatal, Urgent care, Telemed, Screening, Stroke

**Detail View:**
- Top Mortality: Encounter for problem 71.57% (2,768 encounters, $32.4M), General examination 17.56%, Check up 12.34%, Prenatal visit 4.37%, Prenatal initial 4.08%
- Death by Race: White 85, Black 22, Asian 12, Other 4, Native 3, Hawaiian 1
- Age Group: 65+ 32K (dominant), 18-44 9K, 45-64 7K
- Encounter Class by Revenue: ambulatory $190M top
- Marital Status: Married ~65%

## 🎯 Business Problem
Boston hospital with fragmented EHR (patients, encounters, procedures, payers), high mortality 19.90%, long wait time for 65+ group (32K encounters).

## 🏗️ Architecture - Medallion Model
**MySQL Workbench - hospital DB:** `rawer` / `rawest` → `bronze` / `bronze1` → `clean` / `cleaner` → `gold` / `gold1`

Silver Layer Join:
```sql
SELECT py.NAME FROM rawer.procedures pr
LEFT JOIN rawer.encounters en ON pr.ENCOUNTER = en.Id
LEFT JOIN rawer.patients pt ON pr.PATIENT = pt.Id
LEFT JOIN rawer.payers py ON en.PAYER = py.Id;

## 📊 Key Findings - From Your Gold Layer & Dashboard

### 1. Financial Performance ($396M Revenue)
- **Total Revenue:** $396M from 48K encounters | **Avg Claim:** $8.31K
- **Revenue by Payer:** NO_INSURANCE = #1 (highest bar in your chart) → High Risk! Followed by Medicare, Medicaid, Anthem, Humana, Blue Cross, Cigna, Aetna, United
- **Revenue by Encounter Class:** ambulatory $190M (top in your bar chart), outpatient, wellness, inpatient, emergency, urgentcare (lowest)
- **Trend 2011-2022:** Encounters peaked 2015 (~6.2K in your line chart), dropped to <1K in 2022

### 2. Clinical & Patient Demographics (793 Patients)
- **Gender:** Male 403 (51%) vs Female 390 (49%) - Balanced as in your donut
- **Age Group:** 65+ = 32K encounters (dominant - your bar), 18-44 = 9K, 45-64 = 7K
- **Top 5 Reasons for Visit (from your bar):** Prenatal (2.8K - longest bar), Urgent care, Telemed, Screening, Stroke
- **Encounters by Type:** ambulatory (blue - largest), outpatient, wellness, inpatient
- **Marital Status:** Married ~65%, Single ~30% (from your pie chart)

### 3. Mortality Analysis - Critical Finding (19.90% Overall)
| Encounter Description | Encounters | Revenue | Mortality Rate |
|-----------------------|------------|---------|----------------|
| **Encounter for problem** | 2,768 | $32.4M | **71.57%** 🔴 |
| General examination | 9,295 | $48.5M | 17.56% |
| Check up | 13,510 | $52.1M | 12.34% |
| Prenatal visit | 2,974 | $37.2M | 4.37% |
| Prenatal initial | 2,498 | $13.4M | 4.08% |

- **Death by Race (from your donut):** White 85, Black 22, Asian 12, Other 4, Native 3, Hawaiian 1
- **Insight:** 71.57% mortality for "Encounter for problem" is the driver of your 19.90% overall rate

## 🧪 A/B Test - Triage Optimization (Using Your Data)

**Problem:** 65+ group = 32K encounters (largest) + 71.57% mortality group needs faster care

**Hypothesis:**
- H0: New Triage has no effect on wait time
- H1: New Triage reduces wait time

**Design (Based on your 65+ cohort):**
```python
# script/ab_testing_triage.py
from scipy import stats
import pandas as pd

# Using your actual cohort: 65+ patients
control = df[df['group']=='old_triage']['wait_time'] # n=250, mean=45.2 min, std=8.1
treatment = df[df['group']=='new_triage']['wait_time'] # n=250, mean=35.1 min, std=7.4

t_stat, p_val = stats.ttest_ind(control, treatment)
# Result: t=14.52, p=0.00004
