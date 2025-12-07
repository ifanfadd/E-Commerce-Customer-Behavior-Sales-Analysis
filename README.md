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
### 1. Customer & Demographic

- Most customers come from **Istanbul**, followed by **Ankara** and **Izmir**, showing that large cities give the highest number of buyers.
- Most of the customers are **female**.
- **Female customers generate more revenue**, mainly because they receive **more discounts** than male customers.
- The **30–39 age group** contributes the highest revenue, followed by **40–49**, **20–29**, and other age groups. This shows that adults in their working age are the main buyers.
- Sales are mostly made by **returning customers**, showing that many people come back and buy again.

### 2. Sales & Product Performance

- The average revenue stays mostly stable, but there is a slight decrease toward the end of the year.
- Total orders drop in **April** and then remain flat in the following months.
- The best-selling product category is **Electronics**, with total revenue of more than **2 million**.
- Average daily revenue is highest on **Monday**, then slowly decreases as the week goes toward the weekend.

### 3. Website Behavior & Customer Interaction

- The highest number of orders comes from customers who visit the website **10–19 times (sessions)**, with more than **2,000 orders**, followed by the **0–9 session** group and so on.
- Orders are also highest when customers stay on the website for **5–9 minutes**, with more than **2,000 orders**, followed by the **10–14 minute** group.
- **Credit Card** is the most commonly used payment method.
- **Returning customers** tend to have a **shorter average session duration** compared to new customers, likely because they already know what they want to buy.
- The overall sales performance has an average rating of **3.9 out of 5**.

### 4. Delivery and Operation

- The highest average rating comes from orders delivered within **3–7 days**, with an average rating of **3.92**.
- **Beauty products** have the fastest average delivery time, while **Sports products** take the longest to deliver.
- **Konya** has the fastest average delivery time among all cities, while **Istanbul** has the slowest.
- Most orders are delivered within **3–7 days**, followed by **more than 7 days**, and the smallest portion is delivered in **less than 3 days**.

---
## Dashboard
