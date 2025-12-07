-- Operations & Delivery Analysis

SELECT*FROM ecom_stag;

# 15. Rata-rata delivery time per kota?
SELECT City, ROUND(AVG(Delivery_Time_Days),2) AS Delivery_Time FROM ecom_stag GROUP BY City ORDER BY Delivery_Time ASC; 

# Apakah delivery time mempengaruhi customer rating?
WITH delivery_cte AS (
    SELECT
        *,
        CASE
            WHEN delivery_time_days < 3 THEN '< 3 days'
            WHEN delivery_time_days BETWEEN 3 AND 7 THEN '3-7 days'
            ELSE '> 7 days'
        END AS delivery_category
    FROM ecom_stag
)
SELECT
    delivery_category,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    COUNT(*) AS total_transactions
FROM delivery_cte
GROUP BY delivery_category
ORDER BY 
    CASE 
        WHEN delivery_category = '< 3 days' THEN 1
        WHEN delivery_category = '3-7 days' THEN 2
        ELSE 3
    END;
    
# Kategori produk mana yang paling lama waktu pengirimannya?
SELECT Product_Category, ROUND(AVG(Delivery_Time_Days),2) as Delivery_Time FROM ecom_stag GROUP BY Product_Category ORDER BY Delivery_Time ASC;