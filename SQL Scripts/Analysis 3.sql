-- Website Behavior Analysis

SELECT*FROM ecom_stag;

#11 Apakah session duration berpengaruh pada total pembelian?
WITH session_cte AS (
    SELECT*,
        CONCAT(FLOOR(session_duration_minutes / 10) * 10, '-', FLOOR(session_duration_minutes / 10) * 10 + 9 )AS session_range
    FROM ecom_stag
)
SELECT 
    session_range,
    ROUND(SUM(Total_Amount),2) AS Total_Revenue,
    SUM(Quantity) AS Total_Qty
FROM session_cte
GROUP BY session_range
ORDER BY CAST(SUBSTRING_INDEX(session_range, '-', 1) AS UNSIGNED);

#Pages viewed tinggi → apakah menghasilkan purchase lebih besar?
WITH view_cte AS (
    SELECT*,
        CONCAT(FLOOR(Pages_viewed / 5) * 5, '-', FLOOR(Pages_viewed / 5) * 5 + 4 )AS view_range
    FROM ecom_stag
)
SELECT 
    view_range,
    ROUND(SUM(Total_Amount),2) AS Total_Revenue,
    SUM(Quantity) AS Total_Qty
FROM view_cte
GROUP BY view_range
ORDER BY CAST(SUBSTRING_INDEX(view_range, '-', 1) AS UNSIGNED);

#13. Apakah returning customer memiliki session durations lebih pendek?
SELECT Is_Returning_Customer, ROUND(AVG(Session_Duration_Minutes),2) FROM ecom_stag GROUP BY Is_Returning_Customer;

