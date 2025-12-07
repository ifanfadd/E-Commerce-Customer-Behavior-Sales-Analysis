# E-Commerce-Customer-Behavior-Sales-Analysis
This project analyzes customer behavior and sales performance using a real-world styled e-commerce dataset. It combines MySQL (for data cleaning, transformation, and analytical queries with CTEs) and Power BI (for data modeling, DAX measures, and interactive dashboards).
---

## Table of Contents
- [Case Study](#-case-study)
- [Dataset Description](#-dataset-description)
- [Data Cleaning](#-data-cleaning)
- [Data Analysis](#-data-analysis)
- [Dashboard](#-dashboard)

---

## Case Study
This case study focuses on understanding customer behavior in an e-commerce environment.  
Key questions explored:

1. Who are the customers? (Age, gender, city)
2. What are the purchasing trends? (Revenue, category performance)
3. How do customers behave on the website? (Device, session duration)
4. How efficient is the delivery process? (Delivery time, rating)

The objective is to build insights that help improve marketing, sales strategy, and operations.

---

## Dataset Description
The dataset includes the following fields:

- **Order_ID**
- **Customer_ID**
- **Date**
- **Age**
- **Gender**
- **City**
- **Product_Category**
- **Unit_Price**
- **Quantity**
- **Discount_Amount**
- **Total_Amount**
- **Payment_Method**
- **Device_Type**
- **Session_Duration_Minutes**
- **Pages_Viewed**
- **Is_Returning_Customer**
- **Delivery_Time_Days**
- **Customer_Rating**

The dataset simulates a realistic e-commerce environment with customer demographics, transactions, engagement metrics, and delivery outcomes.

---

## Data Cleaning
Data cleaning was performed using **MySQL**, including:

- Checking missing values
- Formatting date and numeric fields
- Creating **CTEs** for segmentation:
  - Age range segmentation
  - Delivery time segmentation
  - Session view segmentation
  - Duation view segmentation

Example CTE snippet:

```sql
WITH age_cte AS (
    SELECT 
        Customer_ID,
        CONCAT(FLOOR(Age/10)*10, '-', FLOOR(Age/10)*10 + 9) AS age_range,
        Total_Amount
    FROM ecom_stag
)
SELECT age_range, SUM(Total_Amount)
FROM age_cte
GROUP BY age_range;
```

---

## Data Analysis
