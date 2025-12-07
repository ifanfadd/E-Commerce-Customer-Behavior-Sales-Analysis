-- EXPLORATORY DATA ANALYSIS
SELECT*FROM ecom_stag LIMIT 10;
SELECT COUNT(Order_ID) AS Total_Order FROM ecom_stag; 
SELECT DISTINCT COUNT(Customer_ID) AS Total_Customer FROM ecom_stag;
SELECT Gender, COUNT(*) AS Distribusi_Gender FROM ecom_stag GROUP BY Gender;
SELECT City, COUNT(*) AS Distribusi_city FROM ecom_stag GROUP BY City;
SELECT Product_Category, COUNT(*) AS Distribusi_Product FROM ecom_stag GROUP BY Product_Category;
SELECT AVG(Age) AS Average_Age, MAX(Age) AS Max_Age, MIN(Age) AS Min_Age FROM ecom_stag;

SELECT 
    age_range,
    COUNT(*) AS total
FROM (
    SELECT
        CONCAT(FLOOR(Age/10)*10, '-', FLOOR(Age/10)*10 + 9) AS age_range
    FROM ecom_stag
) AS t
GROUP BY age_range
ORDER BY CAST(SUBSTRING_INDEX(age_range, '-', 1) AS UNSIGNED);

SELECT ROUND(AVG(Total_Amount),2) AS AVG_Amount, MAX(Total_Amount) AS Max_Amount, MIN(Total_Amount) AS Min_Amount FROM ecom_stag;
SELECT Payment_Method, COUNT(*) AS Payment_Distribution FROM ecom_stag GROUP BY Payment_Method;
SELECT Device_Type, COUNT(*) AS Device_Distribution FROM ecom_stag GROUP BY Device_Type;

SELECT AVG(Session_Duration_Minutes), AVG(Pages_Viewed), AVG(Delivery_Time_Days), AVG(Customer_Rating) FROM ecom_stag;





