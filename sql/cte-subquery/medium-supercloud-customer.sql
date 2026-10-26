/*
Source:     DataLemur  (https://datalemur.com/questions/supercloud-customer)
Problem:    Supercloud Customer  (Medium)
Category:   CTE / Subquery
Question:   Find customers who bought at least one product from EVERY product category.
            Return their customer_id.

Table Schema: customer_contracts(customer_id, product_id, amount)
              products(product_id, product_category, product_name)
              join key: customer_contracts.product_id -> products.product_id
*/

-- My solution:
SELECT cc.customer_id
FROM customer_contracts cc
JOIN products p ON cc.product_id = p.product_id
GROUP BY cc.customer_id 
HAVING COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)

-- Note: "bought from every category" = count distinct categories per customer,
-- and keep those whose count equals the total number of categories (a subquery over products). This is the "relational division" pattern.
-- Alternative (DataLemur's version, using a CTE instead of HAVING):
/*
WITH supercloud_cust AS (
  SELECT
    customers.customer_id,
    COUNT(DISTINCT products.product_category) AS product_count
  FROM customer_contracts AS customers
  INNER JOIN products
    ON customers.product_id = products.product_id
  GROUP BY customers.customer_id
)
SELECT customer_id
FROM supercloud_cust
WHERE product_count = (
  SELECT COUNT(DISTINCT product_category) FROM products
);
*/
