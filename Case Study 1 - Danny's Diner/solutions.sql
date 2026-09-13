SELECT current_database();

SELECT schema_name FROM information_schema.schemata;

SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

SELECT * FROM sales;

SELECT * FROM menu;

SELECT * FROM members;


-- Case Study Questions

-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id, 
    SUM(m.price) AS total_amount_spent
FROM 
    sales s
JOIN 
    menu m
ON 
    s.product_id = m.product_id
GROUP BY 
    s.customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT 
	customer_id,
	COUNT(DISTINCT order_date) AS days_visited
FROM
	sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
SELECT 
	s.customer_id, 
	m.product_name 
FROM 
	sales s
JOIN 
	menu m
ON 
	s.product_id = m.product_id
WHERE 
	(customer_id, order_date) in (
		SELECT 
			customer_id, MIN(order_date)
		FROM
			sales
		GROUP BY customer_id
		);

-- Optimal and Flexable
WITH ranked_sales_CTE AS (
	SELECT *, DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS ranking 
	FROM sales
)
SELECT 
	DISTINCT s.customer_id, m.product_name
FROM
	ranked_sales_CTE s
JOIN 
	menu m
ON s.product_id = m.product_id
WHERE ranking = 1


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
WITH item_count_CTE AS (
	SELECT product_id, COUNT(*) AS product_count
		FROM 
			sales
		GROUP BY product_id
)
SELECT 
	m.product_name, s.product_count
FROM menu m
JOIN item_count_CTE s
ON m.product_id = s.product_id
ORDER BY s.product_count DESC
LIMIT 1;
-- Edge case if two products tie it will only give one product

-- Fixed
WITH item_count_CTE AS (
	SELECT 
        product_id, 
        COUNT(*) AS product_count,
        DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS ranking
	FROM 
        sales
	GROUP BY 
        product_id
)
SELECT 
	m.product_name, 
    c.product_count
FROM 
    menu m
JOIN item_count_CTE c
ON m.product_id = c.product_id
WHERE c.ranking = 1;



-- 5. Which item was the most popular for each customer?

WITH product_per_customer_count AS (
    SELECT 
        customer_id, 
        product_id, 
        COUNT(*) AS cnt
    FROM sales
    GROUP BY customer_id, product_id
)
SELECT 
    s.customer_id,
    m.product_name
FROM product_per_customer_count s
JOIN menu m
    ON s.product_id = m.product_id
WHERE (s.customer_id, s.cnt) IN (
    SELECT 
        customer_id, 
        MAX(cnt)
    FROM product_per_customer_count
    GROUP BY customer_id
);


-- Optimized
WITH product_counts AS(
	SELECT
		customer_id, product_id,
		DENSE_RANK() OVER(
			PARTITION BY customer_id
			ORDER BY COUNT(*)  DESC
		) AS rnk
	FROM sales
	GROUP BY customer_id, product_id
)
SELECT p.customer_id, m.product_name
FROM product_counts p
JOIN menu m
ON p.product_id = m.product_id
WHERE p.rnk = 1
;


-- 6. Which item was purchased first by the customer after they became a member?
WITH first_date AS(
	SELECT s.*, 
		DENSE_RANK() OVER(
			PARTITION BY s.customer_id
			ORDER BY s.order_date
		) AS rnk
	FROM sales s
	JOIN members m
	ON s.order_date >= m.join_date
		AND s.customer_id = m.customer_id
)
SELECT d.customer_id, d.order_date, m.product_name
FROM first_date d
JOIN menu m
ON d.product_id = m.product_id
WHERE d.rnk = 1
;

-- 7. Which item was purchased just before the customer became a member?
WITH before_membership AS(
	SELECT s.*, 
		DENSE_RANK() OVER(
			PARTITION BY s.customer_id
			ORDER BY s.order_date DESC
		) AS rnk
	FROM sales s
	JOIN members m
	ON s.order_date < m.join_date
		AND s.customer_id = m.customer_id
)
SELECT d.customer_id, d.order_date, m.product_name
FROM before_membership d
JOIN menu m
ON d.product_id = m.product_id
WHERE d.rnk = 1
;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT 
	s.customer_id,
	COUNT(*)  AS total_items,
	SUM(p.price) AS amount_spent
FROM 
	sales s
JOIN members m
ON s.order_date < m.join_date
	AND s.customer_id = m.customer_id
JOIN menu p
ON s.product_id = p.product_id
GROUP BY s.customer_id
;


-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT 
    s.customer_id, 
    SUM(
        CASE 
            WHEN s.product_id = 1 THEN m.price * 20 
            ELSE m.price * 10 
        END
    ) AS total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;




-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
WITH member_jan_cte AS(
	SELECT s.customer_id, s.product_id, m.join_date ,s.order_date, m.join_date + INTERVAL '1 WEEK' AS bonus_week
	FROM sales s
	JOIN members m
	ON s.customer_id = m.customer_id
	WHERE EXTRACT(MONTH FROM s.order_date) = 1
)
SELECT s.customer_id,
	SUM(
		CASE WHEN s.product_id = 1 OR (s.join_date <= s.order_date AND s.order_date < bonus_week) THEN m.price * 20
		ELSE m.price * 10 END 
	) AS total_points
FROM
	member_jan_cte s
JOIN menu m
	ON s.product_id = m.product_id
GROUP BY s.customer_id;


-- Optimal solution
SELECT 
    s.customer_id,
    SUM(
        CASE 
            WHEN s.product_id = 1 OR (s.order_date >= mem.join_date AND s.order_date < mem.join_date + INTERVAL '1 WEEK') THEN m.price * 20
            ELSE m.price * 10 
        END
    ) AS total_points
FROM sales s
JOIN members mem
    ON s.customer_id = mem.customer_id
JOIN menu m
    ON s.product_id = m.product_id
WHERE s.order_date >= '2021-01-01' 
  AND s.order_date <= '2021-01-31'
GROUP BY s.customer_id;