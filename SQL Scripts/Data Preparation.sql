-- DATA PREPARATION
CREATE TABLE ecom_stag LIKE ecommerce;
INSERT INTO ecom_stag SELECT*FROM ecommerce;
SELECT * FROM ecom_stag LIMIT 10;

-- DATA CLEANING
-- DUPLICATE DATA
#DUPLICATE CHECK
WITH duplicate_cte AS(
	SELECT*,
		ROW_NUMBER() OVER(
			PARTITION BY `Order_ID`, Customer_ID, `Date`, Age, Gender, City, Product_Category, Unit_Price
				ORDER BY `Order_ID`) AS row_num
	FROM ecom_stag
) SELECT*FROM duplicate_cte WHERE row_num > 1;
/*
#DELETE DUPLICATE
WITH duplicate_cte AS(
    SELECT `Customer ID`,
           ROW_NUMBER() OVER(
               PARTITION BY `Customer ID`, Age, Gender, `Item Purchased`, Category,
                            `Purchase Amount (USD)`, Location, Color
               ORDER BY `Customer ID`
           ) AS row_num
    FROM customer_stag
)
DELETE FROM customer_stag
WHERE `Customer ID` IN (
    SELECT `Customer ID` FROM duplicate_cte WHERE row_num > 1
);
*/
-- Starndardize Data
SELECT*FROM ecom_stag LIMIT 10;
ALTER TABLE ecom_stag 
MODIFY COLUMN `Date` DATE;

#TRIM SPACE
/*
UPDATE ecom_stag
SET 
Order_ID = TRIM(Order_ID),
Customer_ID = TRIM(Customer_ID),
Gender = TRIM(Gender),
City = TRIM(City),
Device_type = TRIM(Device_Type)
*/

-- CHECK NULL VALUES
SELECT*FROM ecom_stag WHERE Order_ID IS NULL;
SELECT*FROM ecom_stag WHERE Customer_ID IS NULL;
SELECT*FROM ecom_stag WHERE `Date` IS NULL;
SELECT*FROM ecom_stag WHERE Age IS NULL;
SELECT*FROM ecom_stag WHERE Gender IS NULL;
SELECT*FROM ecom_stag WHERE City IS NULL;
SELECT*FROM ecom_stag WHERE Product_Category IS NULL;
SELECT*FROM ecom_stag WHERE Unit_Price IS NULL;
SELECT*FROM ecom_stag WHERE Quantity IS NULL;
SELECT*FROM ecom_stag WHERE Discount_Amount IS NULL;
SELECT*FROM ecom_stag WHERE Total_Amount IS NULL;
SELECT*FROM ecom_stag WHERE Payment_Method IS NULL;
SELECT*FROM ecom_stag WHERE Device_Type IS NULL;
SELECT*FROM ecom_stag WHERE Session_Duration_Minutes IS NULL;
SELECT*FROM ecom_stag WHERE Pages_Viewed IS NULL;
SELECT*FROM ecom_stag WHERE Is_Returning_Customer IS NULL;
SELECT*FROM ecom_stag WHERE Delivery_Time_Days IS NULL;
SELECT*FROM ecom_stag WHERE Customer_Rating IS NULL;