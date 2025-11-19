# Operational_Analytics_Project
Operational analytics project that simulated an e-commerce fulfillment pipeline. Project analyzes warehouse, carrier, and customer performance using R + Power BI. Includes synthetic dataset generation, data cleaning, modeling, KPI design, and interactive dashboards to uncover delivery delays, cost drivers, and profitability insights

## ⭐ Project Overview  

This project analyzes the operational performance of a simulated e-commerce order fulfillment process.  

I built the dataset in **R**, cleaned and modeled it, and developed **Power BI dashboards** to identify bottlenecks, predict delivery times, and surface cost & efficiency insights.



The project reflects real-world operational challenges such as carrier delays, warehouse performance differences, rising shipping costs, and profitability pressures across product categories and customer segments.



---



## 🎯 Business Problems Addressed  



1. **Which warehouses and carriers create the longest delays or highest lost-order rates?**  

2. **Which customer segments and product categories drive the most revenue and profitability?**  

3. **What operational factors (ship mode, warehouse, order value, labor time) most influence delivery speed?**  

4. **How do shipping costs and delivery times trend over time, and where can cost be reduced?**  

5. **Can we predict delivery delays early enough for operations teams to intervene?**



---



## 🧠 Why This Project Matters  

Companies with physical operations rely on analytics to answer critical cost, speed, and service-level questions.



This project mimics real scenarios such as:  

- Investigating *why shipping performance is slipping*  

- Understanding *profit margins when shipping costs fluctuate*  

- Identifying *which carriers or warehouses create customer friction*  

- Prioritizing operational improvements with measurable business impact  



This project demonstrates the ability to think like an operations strategist — not just build visuals.



---



## 📊 Dataset Description  

`ops_analytics_dataset.csv` (5,000 rows)  

Contains realistic operational fields:



- **Order details:** order_id, order_date, product_category, unit_price, quantity  

- **Logistics:** origin_warehouse, carrier, ship_mode, shipping_cost  

- **Customer:** customer_id, customer_segment, state  

- **Operations:** labor_time_minutes, delivery_time_days, delivery_status, returned  

- **Profitability:** revenue, cost_of_goods, profit, profit_margin  



The dataset was generated and engineered entirely in **R**.



---



## 🛠 Tools & Skills Used  



### **R**

- Data generation  

- Cleaning & feature engineering  

- Predictive modeling (random forest)  

- KPI calculations  



### **Power BI**

- Interactive dashboards  

- DAX measures  

- Operational KPIs  

- Cost analysis & trend analysis  



### **Skills Demonstrated**

- Data modeling  

- Operational storytelling  

- Root-cause analysis  

- Executive-ready dashboard building  



---



## 📁 Project Structure  



---



# 📈 Power BI Dashboard Pages & Data Storytelling  



## **📌 Page 1: Operational Overview**

**Visuals included:**

- KPI cards: Avg Shipping Cost, Avg Unit Price  

- Multi-line chart: *Avg Shipping Cost by Month & Product Category*  

- Stacked bar: *Total Orders by Customer Segment*  

- Matrix: *Warehouse → Carrier → Avg Delivery Time*



### **What this page tells the business:**

- Shipping cost volatility is clear — certain categories (e.g., Technology) spike during peak months.  

- Customer demand is highest in the Consumer and Corporate segments, showing where staffing & inventory should prioritize.  

- The matrix highlights operational friction: some warehouse → carrier combinations consistently underperform.  

This page sets the stage: **where costs are rising, where demand is concentrated, and where delays originate.**



---



## **📌 Page 2: Warehouse & Carrier Performance**

**Visuals included:**

- Horizontal bar: *Lost Orders by Warehouse*  

- Horizontal bar: *Lost Orders by Carrier*  



### **What this page tells the business:**

- A single warehouse drives a disproportionate share of lost orders, signaling possible inventory, scanning, or staffing issues.  

- Lost orders vary significantly across carriers, identifying where negotiations, SLA reviews, or contract reductions may be needed.  

This page reveals risk exposure and helps decide **which partners need corrective action**.



---



## **📌 Page 3: Customer & Product Profitability**

**Visuals included:**

- Bar chart: *Total Order Value by Customer Segment*  

- (Optional additional visuals: Profit by Category, Profit Margin by Segment)



### **What this page tells the business:**

- High-value segments (Corporate / Consumer) produce a large share of total revenue and justify targeted retention strategies.  

- Identifying low-value segments helps optimize marketing spend and reduce customer acquisition cost.  

This page connects operations to financial strategy — **which customers drive the business and how operations impacts revenue.**



---



# 📌 KPIs  



| KPI | Meaning | Business Impact |

|-----|---------|-----------------|

| **Avg Delivery Time** | Speed of fulfillment | Slowdowns indicate bottlenecks |

| **Lost Order Rate** | % of orders never delivered | Direct cost + customer churn |

| **Avg Shipping Cost** | Operational cost per order | Cost-saving opportunities |

| **On-Time Rate (if retained)** | SLA performance | Carrier/warehouse accountability |

| **Total Order Value per Segment** | Revenue concentration | Helps with targeting strategy |



---



# 📌 Insights & Recommendations  



## **1️⃣ High lost-order rates at specific warehouses**  

- These warehouses show significantly higher lost-order percentages.  

**Recommendation:** Audit scanning, inventory control, and last-mile staging processes.



## **2️⃣ Carriers have inconsistent reliability**  

- Some carriers show 2–4× lost orders vs. others.  

**Recommendation:** Shift volume to high-performing carriers; renegotiate contracts.



## **3️⃣ Shipping cost spikes correlate with product category**  

- Technology & Office Supplies show seasonal cost increases.  

**Recommendation:** Pre-position inventory & negotiate category-specific carrier rates.



## **4️⃣ Corporate & Consumer segments drive largest revenue**  

**Recommendation:** Build retention and priority fulfillment strategies around these segments.



## **5️⃣ Predictive model flags high-risk deliveries**  

- Random forest model identifies late-delivery risk with strong accuracy.  

**Recommendation:** Use alerts to trigger early intervention (carrier escalation, warehouse reslotting).



---



# 📌 R Script Summary 

Include the R scripts in a `/r_scripts/` folder:




 









