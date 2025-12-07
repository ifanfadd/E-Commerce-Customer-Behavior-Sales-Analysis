-- Sales & Revenue Analysis

SELECT*FROM ecom_stag;

#1 Kategori produk apa yang menyumbang total pendapatan terbesar?
SELECT Product_Category, ROUND(SUM(Total_Amount),2) AS Total_Revenue FROM ecom_stag GROUP BY Product_Category ORDER BY Total_Revenue DESC LIMIT 5;

#Seasonly Trend Sale
#1. Hari apa paling banyak order? (Daily Pattern)
SELECT 
    DAYNAME(Date) AS Day_Name,
    COUNT(Order_ID) AS Total_Orders
FROM ecom_stag
GROUP BY Day_Name
ORDER BY Total_Orders DESC;

SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS `year_month`,
    ROUND(SUM(Total_Amount), 2) AS total_revenue
FROM ecom_stag
GROUP BY DATE_FORMAT(`Date`, '%Y-%m')
ORDER BY MIN(`Date`) ASC;

WITH monthly AS (
    SELECT
        YEAR(`date`) AS yr,
        MONTH(`date`) AS mn,
        ROUND(SUM(total_amount),2) AS revenue
    FROM ecom_stag
    GROUP BY YEAR(`date`), MONTH(`date`)
)
SELECT
    CONCAT(yr, '-', LPAD(mn, 2, '0')) AS `year_month`,
    revenue,
    LAG(revenue) OVER (ORDER BY yr, mn) AS prev_month,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY yr, mn)) 
        / NULLIF(LAG(revenue) OVER (ORDER BY yr, mn), 0) * 100,
    2) AS mom_growth_pct
FROM monthly
ORDER BY yr, mn;

#8 Berapa rata-rata nilai transaksi per Payment Method?
SELECT Payment_Method, ROUND(SUM(Total_Amount),2) AS Total_Revenue FROM ecom_stag GROUP BY Payment_Method ORDER BY Total_Revenue DESC;

#9 Perbandingan revenue antara device type.
SELECT Device_Type, ROUND(SUM(Total_Amount),2) AS Total_Revenue FROM ecom_stag GROUP BY Device_Type ORDER BY Total_Revenue DESC;

