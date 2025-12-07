-- Analysis Customer & Demographic Analysis
-- 1 Segmen Umur dan Gender Based On Revenue ----------------
SELECT*FROM ecom_stag;

#Tabel Perbandingan Sederhana Segmentasi Gender Based On Revenue
SELECT
	Gender,
    ROUND(SUM(Total_Amount),2) AS Total_Revenue,
    ROUND(SUM(CASE WHEN Discount_Amount > 0 THEN Total_Amount ELSE 0 END),2) AS Revenue_With_Discount,
	ROUND(SUM(CASE WHEN Discount_Amount = 0 THEN Total_Amount ELSE 0 END),2) AS Revenue_no_Discount,
    SUM(Quantity) AS Total_Quantity,
    SUM(CASE WHEN Discount_Amount > 0 THEN Quantity ELSE 0 END)
        AS Quantity_With_Discount,
	SUM(CASE WHEN Discount_Amount = 0 THEN Quantity ELSE 0 END)
        AS Quantity_no_Discount,
    SUM(CASE WHEN Discount_Amount > 0 THEN 1 ELSE 0 END) AS Discounted_Count,
    SUM(CASE WHEN Discount_Amount = 0 THEN 1 ELSE 0 END) AS Non_Discounted_Count,
    ROUND(
        SUM(CASE WHEN Discount_Amount > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Discount_Rate_Percent
FROM ecom_stag
GROUP BY Gender
ORDER BY Total_Revenue DESC;

#Membantu Stakeholder untuk membuat pilihan Product Category mana yang akan diberi diskon lebih banyak untuk meningkatkan penjualan di segmen male
SELECT
    Product_Category,
    SUM(CASE WHEN Gender = 'Male' THEN Quantity ELSE 0 END) AS Male_Qty,
    SUM(CASE WHEN Gender = 'Female' THEN Quantity ELSE 0 END) AS Female_Qty
FROM ecom_stag
GROUP BY Product_Category
HAVING Male_Qty < Female_Qty       -- Female lebih dominan
ORDER BY Female_Qty - Male_Qty DESC;  -- gap terbesar = peluang terbesar

#Tabel Segmentasi Umur Based On Revenue
WITH age_cte AS (
    SELECT
        CONCAT(FLOOR(Age/10)*10, '-', FLOOR(Age/10)*10 + 9) AS age_range, Total_Amount, Quantity, Unit_Price, Discount_Amount
    FROM ecom_stag
)
SELECT 
    age_range,
    ROUND(SUM(Total_Amount),2) AS Total_Revenue,
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(AVG(Unit_Price), 2) AS Avg_Price,
    SUM(CASE WHEN Discount_Amount > 0 THEN 1 ELSE 0 END) AS Discounted_Count,
    SUM(CASE WHEN Discount_Amount = 0 THEN 1 ELSE 0 END) AS Non_Discounted_Count
FROM age_cte
GROUP BY age_range
ORDER BY CAST(SUBSTRING_INDEX(age_range, '-', 1) AS UNSIGNED);

#2 Apakah pelanggan returning memiliki nilai pembelian rata-rata lebih tinggi?
SELECT Is_Returning_Customer AS Returning_Customer, ROUND(AVG(Total_Amount),2) AS AVG_Total_Revenue, AVG(Quantity) AS AVG_Quantity FROM ecom_stag GROUP BY Is_Returning_Customer;

#3 Kota mana dengan transaksi dan pendapatan tertinggi?
SELECT City, COUNT(*) AS Total_Order, ROUND(SUM(Total_Amount),2) AS Total_Revenue FROM ecom_stag GROUP BY City ORDER BY Total_Revenue DESC LIMIT 5;

#4 Apakah rating pelanggan berbeda antara returning vs new customer?
SELECT Is_Returning_Customer, AVG(Customer_Rating) AS AVG_Rating FROM ecom_stag GROUP BY Is_Returning_Customer;

#Umur berapa yang paling sering membeli produk kategori tertentu?
WITH age_cte AS (
    SELECT
        CONCAT(FLOOR(Age/10)*10, '-', FLOOR(Age/10)*10 + 9) AS age_range,
        Product_Category,
        Total_Amount
    FROM ecom_stag
),
agg AS (
    SELECT
        age_range,
        Product_Category,
        COUNT(*) AS total_orders,
        SUM(Total_Amount) AS total_spend
    FROM age_cte
    GROUP BY age_range, Product_Category
),
ranked AS (
    SELECT
        age_range,
        Product_Category,
        total_orders,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY age_range
            ORDER BY total_orders DESC, total_spend DESC
        ) AS rn
    FROM agg
)
SELECT
    age_range,
    Product_Category AS Most_Frequent_Product_Category,
    total_orders
FROM ranked
WHERE rn = 1
ORDER BY CAST(SUBSTRING_INDEX(age_range, '-', 1) AS UNSIGNED);




