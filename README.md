# 🏥 U.S. Inpatient Hospital Charges and Medicare Payment Analysis

[![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python)](https://www.python.org/)
[![MySQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Pandas](https://img.shields.io/badge/Pandas-EDA-lightgrey?logo=pandas)](https://pandas.pydata.org/)
[![Seaborn](https://img.shields.io/badge/Visualization-Seaborn-orange?logo=plotly)](https://seaborn.pydata.org/)
[![Dataset](https://img.shields.io/badge/Dataset-Kaggle-blue?logo=kaggle)](https://www.kaggle.com/datasets/speedoheck/inpatient-hospital-charges)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📊 Overview
This project analyzes the **Inpatient Hospital Charges Dataset** from Kaggle, containing U.S. hospital billing and Medicare payment data.  
It combines **SQL preprocessing** and **Python data visualization** to identify cost trends, the most expensive procedures, and regional variations in healthcare payments.

The analysis highlights how **Medicare reimbursements often fall short of total hospital charges**, uncovering cost inefficiencies and disparities across states.

---

## 🧩 Key Steps
### 🧮 1. Data Preparation (MySQL)
- Cleaned and standardized hospital charge data  
- Created numeric fields from string-based monetary values  
- Validated missing data and outlier values

### 🐍 2. Data Analysis (Python / Jupyter)
- Computed averages and correlations across payment types  
- Identified top DRGs (diagnosis-related groups) by cost  
- Calculated payment gaps between billed and reimbursed amounts  

### 🎨 3. Data Visualization
- Distribution of total hospital payments  
- Correlation heatmap between charges and reimbursements  
- Top 10 states with highest average payments  
- Most expensive medical procedures (DRGs)  
- Average payment gaps across states  

---

## 📈 Key Insights
- 🏥 **Septicemia and respiratory failure** are the most expensive inpatient procedures.  
- 🌎 **California, Texas, and New York** show the highest overall average payments.  
- 💰 **Payment gaps** between total hospital charges and Medicare reimbursements vary sharply by state, indicating systemic pricing disparities.  
- 📉 **Correlations** between total and Medicare payments are strong but non-linear, suggesting uneven reimbursement scaling.

---

## ⚙️ Tech Stack
- **Languages:** Python, SQL  
- **Libraries:** Pandas, Matplotlib, Seaborn  
- **Tools:** Jupyter Notebook, MySQL Workbench  
- **Dataset:** [Kaggle – Inpatient Hospital Charges](https://www.kaggle.com/datasets/speedoheck/inpatient-hospital-charges)

---

## 📂 Repository Structure
```bash
us-hospital-charges-analysis/
│
├── hospital_charges_analysis.ipynb # Main Jupyter notebook
└── README.md
```

---

## 🚀 How to Run
1. Clone this repo:
```bash
   git clone https://github.com/hgbidon/us-hospital-charges-analysis.git
```
---

2. Open the Jupyter Notebook:
```bash
jupyter notebook hospital_charges.ipynb
```
---

3. Run cells sequentially to reproduce the analysis and plots.

---

## 🧾 License
This project is licensed under the MIT License.

---

## 🙌 Acknowledgments
Dataset courtesy of [LARXEL from Kaggle](https://www.kaggle.com/datasets/speedoheck/inpatient-hospital-charges?utm_source=chatgpt.com).
Maintained and analyzed by Hana Gabrielle Bidon.

---

## 📦 Data Access

Due to GitHub’s file size limits, the full dataset is not hosted here.  
You can download the original data directly from Kaggle:

📂 [Inpatient Hospital Charges Dataset (Kaggle)](https://www.kaggle.com/datasets/speedoheck/inpatient-hospital-charges)

After downloading, rename the file to: inpatientCharges.csv, and place it in your working directory before running the SQL file on MySQL.
