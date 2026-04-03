-- Top 10 highest discount products
SELECT name, discount_percent
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;

-- Category-wise revenue
SELECT category,
       SUM(discounted_selling_price * quantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Total inventory value
SELECT SUM(discounted_selling_price * available_quantity) AS inventory_value
FROM zepto;

-- Best value products (price per gram)
SELECT name,
       discounted_selling_price / weight_in_gms AS price_per_gram
FROM zepto
ORDER BY price_per_gram ASC
LIMIT 10;

-- Product segmentation by weight
SELECT 
    CASE 
        WHEN weight_in_gms < 1000 THEN 'LOW'
        WHEN weight_in_gms < 5000 THEN 'MEDIUM'
        ELSE 'BULK'
    END AS weight_category,
    COUNT(*) AS total_products
FROM zepto
GROUP BY weight_category
ORDER BY total_products DESC;