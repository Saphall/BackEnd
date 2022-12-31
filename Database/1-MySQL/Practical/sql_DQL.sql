use sql_store;


-- SELECT clause
SELECT 
	name, 
	unit_price,
	(unit_price *1.1) AS 'new price' 
FROM products p ;


-- WHERE clause 
SELECT  * 
FROM  customers 
WHERE  points > 3000;

 	-- born after january 1990
SELECT * 
FROM customers c
WHERE birth_date > '1990-01-00';

	-- orders placed this year
SELECT  * 
FROM orders
WHERE order_date >='2019-01-00'; 

	-- customers WITH more than 1000 points after 1990
SELECT * 
FROM customers 
WHERE birth_date > '1990-01-01' AND points > 1000;


SELECT * 
FROM order_items  
WHERE order_id = 6 AND (quantity * unit_price ) > 30;

-- IN
SELECT * 
FROM customers 
WHERE state IN ('va','ga','fl');


SELECT *
FROM products p 
WHERE quantity_in_stock IN (49,38,72);


-- BETWEEN 
SELECT * 
FROM customers 
-- WHERE points >= 1000 AND points <=3000;
WHERE points BETWEEN 1000 AND 3000;

SELECT * 
FROM customers c 	
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';


-- LIKE
SELECT * 
FROM  customers c 
WHERE last_name LIKE 'b%';
	-- % ANY NUMBER of characters
	-- _ single character

SELECT * 
FROM customers c 
WHERE address LIKE '%trail%' OR  
	  address LIKE '%avenue%';

SELECT * 
FROM customers c 
WHERE phone LIKE '%9';

-- regex
SELECT * 
FROM customers c 
WHERE last_name regexp 'field|mac|rose';

-- ^ : beginning of string, $ : END of string, 
-- |: (LIKE OR) multiple search pattern
-- [abcd] : multiple characters
-- [a-i]: range of characters 

SELECT * 
FROM customers c 
-- WHERE last_name regexp '[gi]e';
WHERE last_name regexp '[a-i]e'
ORDER BY last_name ;


SELECT * 
FROM customers c 
-- WHERE first_name regexp 'elka|ambur';
-- WHERE last_name regexp 'ey$|ON$';
-- WHERE last_name regexp '^my|se';
WHERE last_name regexp 'b[ru]';


-- NULL
SELECT * 
FROM customers c 
WHERE phone IS NULL ;

SELECT * 
FROM orders  
WHERE shipped_date IS NULL ;

-- ORDER BY
SELECT * 
FROM customers c 
ORDER BY birth_date DESC ;

SELECT first_name , last_name , 10 AS points 
FROM customers c 
ORDER BY points ,first_name ;

	-- sort by COLUMN positions 
	SELECT last_name , first_name 
	FROM customers c 
	ORDER BY 2,1;

SELECT * 
FROM order_items oi 
WHERE order_id = 2 
ORDER BY (quantity*unit_price) DESC ;


-- LIMIT
SELECT * FROM customers c LIMIT 3 ;
SELECT * FROM customers c LIMIT 6,3;

	-- TOP 3 loyal customers
SELECT * 
FROM customers 
ORDER BY points DESC 
LIMIT 3;


-- INNER JOIN
SELECT order_id, o.customer_id ,first_name , last_name 
FROM orders o 
INNER JOIN customers c   
ON o.customer_id  = c.customer_id ;


SELECT  order_id, oi.product_id ,name , quantity , oi.unit_price 
FROM order_items oi
JOIN products p  ON 
	oi.product_id  = p.product_id ;


-- joinig against databases
SELECT * FROM order_items oi 
JOIN sql_inventory.products p 
ON oi.product_id = p.product_id ;


-- self JOIN
SELECT e.employee_id ,
	   e.first_name AS employee ,
	   m.first_name AS manager
FROM sql_hr.employees e
JOIN sql_hr.employees m 
	ON e.reports_to  = m.employee_id ;


-- joining multiple tables 
SELECT order_id , 
	   order_date , 
	   c.first_name ,
	   c.last_name , 
	   os.name AS status
FROM orders o 
JOIN customers c 
	ON o.customer_id  = c.customer_id 
JOIN order_statuses os 
	ON o.status = os.order_status_id ;



use sql_invoicing;
SELECT * FROM payments;

SELECT payment_id ,
	   c.name , 
	   `date` ,
	   amount , 
	   pm.name AS 'payment type'
FROM payments p 
JOIN clients c 
	 ON p.client_id = c.client_id 
JOIN payment_methods pm 
	 ON p.payment_method = pm.payment_method_id ;


	
	
-- compound JOIN conditions
use sql_store;
SELECT * 
FROM order_items oi 
JOIN order_item_notes oin 
	ON oi.order_id = oin.order_id 
	AND oi.product_id = oin.product_id ;
	
	
-- implicit JOIN syntax 
SELECT * 
FROM orders o 
JOIN customers c 
	ON o.customer_id = c.customer_id ;
-- =
SELECT * 
FROM orders o ,customers c 
WHERE o.customer_id  = c.customer_id; 


-- OUTER joins : LEFT,RIGHT
SELECT c.customer_id ,
		c.first_name ,
		o.order_id 
FROM customers c 
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id 
ORDER BY customer_id ;


SELECT 
		p.product_id ,
		p.name ,
		oi.quantity 
FROM products p 
LEFT JOIN order_items oi 
		ON p.product_id = oi.product_id ;

	
	
	
-- OUTER JOIN for multiple tables
SELECT c.customer_id ,
		c.first_name ,
		o.order_id,
		s.name AS shipper
FROM customers c 
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id 
LEFT JOIN shippers s 
	ON o.shipper_id  = s.shipper_id 
ORDER BY customer_id ;
	



SELECT * FROM orders;
SELECT * FROM order_statuses os ;


SELECT o.order_id ,
		o.order_date,
		c.first_name AS customer,
		s.name AS shipper,
		os.name AS status
FROM orders o 
LEFT JOIN customers c 
		ON o.customer_id = c.customer_id 
LEFT JOIN shippers s 
		ON o.shipper_id = s.shipper_id 
LEFT JOIN order_statuses os 
		ON  o.status = os.order_status_id 
ORDER BY os.name,o.order_id ;



-- self OUTER joins
use sql_hr;

SELECT 
		e.employee_id ,
		e.first_name AS employee,
		m.first_name AS manager
FROM employees e 
LEFT JOIN employees m 
		ON e.reports_to = m.employee_id ;
		
	
-- USING clause : IF column_name IS exactly same across tables
use sql_store;
SELECT o.order_id ,
		c.first_name ,
		s.name AS shipper
FROM orders o 
JOIN customers c 
-- ON o.customer_id = c.customer_id ;
		USING(customer_id)
LEFT JOIN shippers s 
		USING(shipper_id);
	
	
SELECT * 
FROM order_items oi 
JOIN order_item_notes oin 
-- 	ON oi.order_id = oin.order_id 
-- 	AND oi.product_id = oin.product_id ;
	USING(order_id, product_id);
	

use sql_invoicing;
SELECT `date` ,
		c.name ,
		amount,
		pm.name AS 'payment method'
FROM payments p 
JOIN clients c  
		USING(client_id)
JOIN payment_methods pm 
		ON p.payment_method = pm.payment_method_id ;


-- NATURAL joins : automatically JOIN common COLUMN
use sql_store;
SELECT o.order_id ,
		c.first_name 
FROM orders o 
NATURAL JOIN customers c ;


-- CROSS joins : every record FROM first TABLE WITH every TABLE FROM second
SELECT c.first_name ,
	p.name  AS product 
FROM customers c  -- , products p : inplicit syntax
CROSS JOIN products p   -- explicit syntax 
ORDER BY c.first_name ;


SELECT * FROM products p ;
SELECT * FROM shippers s ;
SELECT p.name AS  product ,
		s.name  AS shipper
FROM products p, shippers s
ORDER BY s.name ;
-- CROSS JOIN shippers s ;  explicit way



-- unions : combine rows, no.of colums must be equal
SELECT order_id ,
		order_date ,
		'active' AS status 
FROM orders o 
WHERE order_date >= '2019-01-01'
UNION 
SELECT order_id ,
		order_date ,
		'archived' AS status 
FROM orders o 
WHERE order_date < '2019-01-01';



SELECT first_name AS all_users
FROM customers c 
UNION
SELECT name 
FROM shippers s ;



SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'bronze' AS type 
FROM customers c
WHERE points < 2000
UNION 
SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'silver' AS type 
FROM customers c
WHERE points BETWEEN 2000 AND 3000
UNION 
SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'gold' AS type 
FROM customers c
WHERE points > 3000
ORDER BY first_name ;




-- COLUMN attributes (dml)

-- INSERT row
INSERT INTO customers (first_name,
						last_name,
						phone ,
						address,
						city,
						state)
VALUES ('john','smith',	883333,'jhaukhel',	'bhaktapur','ca');

SELECT * FROM customers c ;


-- inserting multiple rows
SELECT * FROM shippers s ;
INSERT INTO shippers (name)
VALUES ('shipper1'),
		('shipper2'),
		('shipper3');

SELECT * FROM products p ;
INSERT INTO products (name,quantity_in_stock,unit_price)
VALUES ('pan',23,2.3),
		('tea pot',30,2.3),
		('pot',33,3.3);


-- inserting hierarchial rows: IN multiple tables
INSERT INTO orders (customer_id, order_date,status)
VALUES (1,'2019-01-02',1);

INSERT INTO order_items 
VALUES (last_insert_id(),1, 1, 2.45),
		(last_insert_id(),2, 1, 3.45);

SELECT * FROM orders;
SELECT * FROM order_items oi ;


-- creating COPY of TABLE : PRIMARY KEY IS NOT marked
CREATE TABLE orders_archived AS 
SELECT * FROM orders;


INSERT INTO orders_archived 
SELECT * 
FROM orders 
WHERE order_date < '2019-01-10';


use sql_invoicing;

CREATE TABLE invoices_archieved
SELECT invoice_id ,
		`number` ,
		c.name ,
		invoice_total ,
		payment_total ,
		invoice_date ,
		due_date ,
		payment_date 
FROM invoices i 
 JOIN clients c USING(client_id)
WHERE payment_date IS NOT NULL;


SELECT * FROM invoices_archieved ia ;


-- UPDATE single row
SELECT * FROM invoices i ;

UPDATE invoices 
SET payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE invoice_id =3;


-- updating multiple rows
UPDATE invoices 
SET payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE client_id =3;



use sql_store;
SELECT * FROM customers c ;

UPDATE customers 
SET points = points + 50  
WHERE birth_date < '1990-01-01';


-- subqueries IN UPDATE 
use sql_invoicing;
SELECT * FROM invoices i ;
UPDATE invoices 
SET payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE client_id IN   
		(SELECT client_id 
		FROM clients c 
		WHERE state IN ('ca','ny'));


use sql_store;
SELECT * FROM orders;
UPDATE orders 
SET comments = 'gold customers'
WHERE customer_id IN 
			(SELECT customer_id
			FROM customers c
			WHERE points > 3000);

		
-- deleting rows
DELETE FROM sql_invoicing.invoices 
WHERE invoice_id = 1;

SELECT * FROM sql_invoicing.invoices i ;

DELETE FROM sql_invoicing.invoices 
WHERE client_id = 
			( SELECT client_id 
			FROM sql_invoicing.clients 
			WHERE name= 'myworks');
		


