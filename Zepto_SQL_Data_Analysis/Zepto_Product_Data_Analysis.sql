 DROP TABLE IF EXISTS ZEPTO;
 
CREATE TABLE zepto (
    Category VARCHAR(120),
    name VARCHAR(120) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);

-- Renaming columns to follow snake_case naming convention
-- This avoids case-sensitive column issues in PostgreSQL
-- Improves readability and follows industry-standard database design practices

SELECT * FROM zepto ;

 DROP TABLE IF EXISTS ZEPTO;

 CREATE TABLE zepto (
    "Category" VARCHAR(120),
    "name" VARCHAR(120),
    "mrp" NUMERIC(8,2),
    "discountPercent" NUMERIC(5,2),
    "availableQuantity" INTEGER,
    "discountedSellingPrice" NUMERIC(8,2),
    "weightInGms" INTEGER,
    "outOfStock" BOOLEAN,
    "quantity" INTEGER
);

COPY zepto("Category", "name", "mrp", "discountPercent", "availableQuantity", "discountedSellingPrice", "weightInGms", "outOfStock", "quantity")
FROM '/Users/bhanu/Downloads/archive-2/zepto_v2.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM ZEPTO ;

select * from zepto limit 10;

--null values

SELECT * FROM zepto 
where name is Not null ;

--different product Category
SELECT "Category" from zepto
order by "Category";

--Products in stock vs out of stoct
SELECT "outOfStock", COUNT ("name")
FROM zepto
GROUP BY "outOfStock";

--Product with price = 0
SELECT "name" FROM ZEPTO 
WHERE "mrp" = 0 or "discountedSellingPrice"=0 ;

-- Delect the Row which having  Price = 0
DELETE FROM ZEPTO 
WHERE "mrp" = 0 ;

--Conver Paisa to Rupee
UPDATE ZEPTO 
SET "mrp"= "mrp"/100.0,
"discountedSellingPrice" = "discountedSellingPrice"/100.0 ;

--Check weather converted or not in Rupees 
SELECT "mrp","discountedSellingPrice"
from zepto ;

-- Q1. Find the top 10 best-value products based on the discount percentage• 
 SELECT "name","mrp","discountPercent" FROM zepto
 ORDER BY "discountPercent" DESC
 LIMIT 10 ;
 
--Q2. What are the Products with High MRP but Out of Stock
SELECT  DISTINCT "name","mrp" FROM zepto
where  "outOfStock"  = TRUE AND "mrp" >300
ORDER BY "mrp" DESC ;

--Q3. Calculate Estimated Revenue for each category
SELECT "Category",
       SUM("discountedSellingPrice" * "availableQuantity") AS total_revenue
FROM zepto
GROUP BY "Category"
ORDER BY total_revenue DESC;

-- Q4. Find all products where MRP is greater than 500 and discount is less than 10%.
SELECT DISTINCT "name","mrp","discountPercent" FROM ZEPTO
WHERE "mrp" > 500  AND "discountPercent" < 10
ORDER BY "mrp" DESC , "discountPercent" DESC ;

--Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT "Category" ,
ROUND(AVG("discountPercent"),2) AS avg_discount FROM ZEPTO
GROUP BY "Category" 
ORDER BY "avg_discount" DESC 
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by best value.
SELECT  DISTINCT "name","weightInGms","discountedSellingPrice" ,
ROUND("discountedSellingPrice"/"weightInGms",2) AS price_per_gram
FROM zepto
WHERE "weightInGms" >100
ORDER BY price_per_gram DESC;
--Q7. Group the products into categories like Low, Medium, Bulk.
SELECT distinct  "name","weightInGms",
 CASE WHEN "weightInGms" <1000 THEN 'LOW'
      WHEN "weightInGms"  <5000 THEN 'MEDIUM'
	  ELSE 'BULK'
	  END AS weight_category
 FROM zepto 
GROUP BY  weight_category
ORDER BY ;

--Best method 
SELECT 
    CASE 
        WHEN "weightInGms" < 1000 THEN 'LOW'
        WHEN "weightInGms" < 5000 THEN 'MEDIUM'
        ELSE 'BULK'
    END AS weight_category,
    COUNT(*) AS total_products
FROM zepto
GROUP BY weight_category
ORDER BY total_products DESC;

----Q8. What is the Total Inventory Weight Per Category
SELECT "Category",
SUM("weightInGms" * "availableQuantity" ) AS total_weight
FROM zepto
GROUP BY "Category"
ORDER BY total_weight DESC ;


