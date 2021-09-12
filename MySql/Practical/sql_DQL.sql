Use sql_store;


-- select clause
SELECT 
	name, 
	unit_price,
	(unit_price *1.1) AS 'new price' 
FROM products p ;


-- where clause 
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

	-- customers with more than 1000 points after 1990
SELECT * 
FROM customers 
WHERE birth_date > '1990-01-01' and points > 1000;


SELECT * 
FROM order_items  
WHERE order_id = 6 AND (quantity * unit_price ) > 30;

-- in
SELECT * 
FROM customers 
WHERE state IN ('VA','GA','FL');


SELECT *
FROM products p 
WHERE quantity_in_stock IN (49,38,72);


-- between 
SELECT * 
FROM customers 
-- WHERE points >= 1000 AND points <=3000;
where points BETWEEN 1000 AND 3000;

SELECT * 
FROM customers c 	
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';


-- like
SELECT * 
FROM  customers c 
WHERE last_name LIKE 'b%';
	-- % any number of characters
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
WHERE last_name REGEXP 'field|mac|rose';

-- ^ : beginning of string, $ : end of string, 
-- |: (like or) multiple search pattern
-- [abcd] : multiple characters
-- [a-i]: range of characters 

SELECT * 
FROM customers c 
-- WHERE last_name REGEXP '[gi]e';
where last_name REGEXP '[a-i]e'
order by last_name ;


SELECT * 
from customers c 
-- WHERE first_name REGEXP 'elka|ambur';
-- where last_name REGEXP 'ey$|on$';
-- where last_name REGEXP '^my|se';
where last_name REGEXP 'b[ru]';


-- null
SELECT * 
FROM customers c 
WHERE phone IS NULL ;

SELECT * 
from orders  
WHERE shipped_date IS NULL ;

-- order by
SELECT * 
FROM customers c 
order by birth_date DESC ;

SELECT first_name , last_name , 10 as points 
from customers c 
order by points ,first_name ;

	-- sort by column positions 
	SELECT last_name , first_name 
	from customers c 
	order by 2,1;

SELECT * 
from order_items oi 
WHERE order_id = 2 
ORDER by (quantity*unit_price) DESC ;


-- limit
SELECT * from customers c limit 3 ;
SELECT * from customers c limit 6,3;

	-- top 3 loyal customers
SELECT * 
FROM customers 
order by points DESC 
limit 3;


-- inner join
select order_id, o.customer_id ,first_name , last_name 
from orders o 
inner join customers c   
on o.customer_id  = c.customer_id ;


SELECT  order_id, oi.product_id ,name , quantity , oi.unit_price 
from order_items oi
join products p  on 
	oi.product_id  = p.product_id ;


-- joinig against databases
SELECT * from order_items oi 
join sql_inventory.products p 
on oi.product_id = p.product_id ;


-- self join
select e.employee_id ,
	   e.first_name as Employee ,
	   m.first_name as Manager
from sql_hr.employees e
join sql_hr.employees m 
	on e.reports_to  = m.employee_id ;


-- joining multiple tables 
SELECT order_id , 
	   order_date , 
	   c.first_name ,
	   c.last_name , 
	   os.name as Status
from orders o 
join customers c 
	on o.customer_id  = c.customer_id 
join order_statuses os 
	on o.status = os.order_status_id ;



Use sql_invoicing;
select * from payments;

select payment_id ,
	   c.name , 
	   `date` ,
	   amount , 
	   pm.name as 'Payment Type'
from payments p 
join clients c 
	 on p.client_id = c.client_id 
join payment_methods pm 
	 on p.payment_method = pm.payment_method_id ;


	
	
-- compound join conditions
use sql_store;
select * 
from order_items oi 
join order_item_notes oin 
	on oi.order_id = oin.order_Id 
	and oi.product_id = oin.product_id ;
	
	
-- implicit join syntax 
select * 
FROM orders o 
join customers c 
	on o.customer_id = c.customer_id ;
-- =
select * 
from orders o ,customers c 
where o.customer_id  = c.customer_id; 


-- outer joins : left,right
SELECT c.customer_id ,
		c.first_name ,
		o.order_id 
FROM customers c 
left join orders o 
	on c.customer_id = o.customer_id 
ORDER by customer_id ;


SELECT 
		p.product_id ,
		p.name ,
		oi.quantity 
from products p 
left join order_items oi 
		on p.product_id = oi.product_id ;

	
	
	
-- outer join for multiple tables
SELECT c.customer_id ,
		c.first_name ,
		o.order_id,
		s.name as Shipper
FROM customers c 
left join orders o 
	on c.customer_id = o.customer_id 
left join shippers s 
	on o.shipper_id  = s.shipper_id 
ORDER by customer_id ;
	



SELECT * from orders;
SELECT * from order_statuses os ;


SELECT o.order_id ,
		o.order_date,
		c.first_name as customer,
		s.name as shipper,
		os.name as status
from orders o 
left join customers c 
		on o.customer_id = c.customer_id 
left join shippers s 
		on o.shipper_id = s.shipper_id 
left join order_statuses os 
		ON  o.status = os.order_status_id 
order by os.name,o.order_id ;



-- self outer joins
USE sql_hr;

SELECT 
		e.employee_id ,
		e.first_name as Employee,
		m.first_name as Manager
FROM employees e 
left join employees m 
		on e.reports_to = m.employee_id ;
		
	
-- using clause : if column_name is exactly same across tables
use sql_store;
SELECT o.order_id ,
		c.first_name ,
		s.name as Shipper
FROM orders o 
join customers c 
-- on o.customer_id = c.customer_id ;
		using(customer_id)
left join shippers s 
		using(shipper_id);
	
	
SELECT * 
FROM order_items oi 
join order_item_notes oin 
-- 	on oi.order_id = oin.order_id 
-- 	and oi.product_id = oin.product_id ;
	using(order_id, product_id);
	

use sql_invoicing;
select `date` ,
		c.name ,
		amount,
		pm.name as 'Payment Method'
FROM payments p 
join clients c  
		using(client_id)
join payment_methods pm 
		on p.payment_method = pm.payment_method_id ;


-- natural joins : automatically join common column
use sql_store;
SELECT o.order_id ,
		c.first_name 
FROM orders o 
natural join customers c ;


-- cross joins : every record from first table with every table from second
select c.first_name ,
	p.name  as Product 
from customers c  -- , products p : inplicit syntax
cross join products p   -- explicit syntax 
order by c.first_name ;


select * from products p ;
SELECT * from shippers s ;
SELECT p.name as  Product ,
		s.name  as Shipper
from products p, shippers s
order by s.name ;
-- cross join shippers s ;  explicit way



-- Unions : combine rows, no.of colums must be equal
SELECT order_id ,
		order_date ,
		'Active' as status 
from orders o 
WHERE order_date >= '2019-01-01'
UNION 
SELECT order_id ,
		order_date ,
		'Archived' as status 
from orders o 
WHERE order_date < '2019-01-01';



SELECT first_name as ALL_users
from customers c 
Union
select name 
from shippers s ;



SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'BRONZE' as type 
from customers c
WHERE points < 2000
UNION 
SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'SILVER' as type 
from customers c
WHERE points BETWEEN 2000 AND 3000
UNION 
SELECT c.customer_id ,
		c.first_name ,
		c.points ,
		'GOLD' as type 
from customers c
WHERE points > 3000
ORDER BY first_name ;




-- COLUMN ATTRIBUTES (DML)

-- insert row
INSERT into customers (first_name,
						last_name,
						phone ,
						address,
						city,
						state)
values ('John','Smith',	883333,'Jhaukhel',	'Bhaktapur','CA');

SELECT * FROM customers c ;


-- inserting multiple rows
SELECT * from shippers s ;
INSERT into shippers (name)
values ('Shipper1'),
		('SHipper2'),
		('shipper3');

SELECT * from products p ;
INSERT into products (name,quantity_in_stock,unit_price)
values ('Pan',23,2.3),
		('Tea Pot',30,2.3),
		('Pot',33,3.3);


-- inserting hierarchial rows: in multiple tables
INSERT into orders (customer_id, order_date,status)
values (1,'2019-01-02',1);

INSERT into order_items 
values (LAST_INSERT_ID(),1, 1, 2.45),
		(LAST_INSERT_ID(),2, 1, 3.45);

SELECT * FROM orders;
SELECT * from order_items oi ;


-- creating copy of table : primary key is not marked
create table orders_archived as 
select * from orders;


INSERT into orders_archived 
SELECT * 
from orders 
where order_date < '2019-01-10';


use sql_invoicing;

create table invoices_archieved
SELECT invoice_id ,
		`number` ,
		c.name ,
		invoice_total ,
		payment_total ,
		invoice_date ,
		due_date ,
		payment_date 
from invoices i 
 join clients c using(client_id)
WHERE payment_date is not null;


SELECT * from invoices_archieved ia ;


-- update single row
select * from invoices i ;

UPDATE invoices 
set payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE invoice_id =3;


-- updating multiple rows
UPDATE invoices 
set payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE client_id =3;



use sql_store;
SELECT * FROM customers c ;

UPDATE customers 
set points = points + 50  
WHERE birth_date < '1990-01-01';


-- subqueries in update 
use sql_invoicing;
SELECT * from invoices i ;
UPDATE invoices 
set payment_total = invoice_total * 0.05,
	payment_date = due_date 
WHERE client_id IN   
		(SELECT client_id 
		from clients c 
		WHERE state in ('CA','NY'));


use sql_store;
SELECT * from orders;
UPDATE orders 
set comments = 'GOLD CUSTOMERS'
WHERE customer_id in 
			(SELECT customer_id
			from customers c
			WHERE points > 3000);

		
-- deleting rows
DELETE FROM sql_invoicing.invoices 
WHERE invoice_id = 1;

SELECT * from sql_invoicing.invoices i ;

DELETE FROM sql_invoicing.invoices 
WHERE client_id = 
			( SELECT client_id 
			from sql_invoicing.clients 
			WHERE name= 'Myworks');
		


