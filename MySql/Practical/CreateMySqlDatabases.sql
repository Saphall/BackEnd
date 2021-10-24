DROP DATABASE IF EXISTS `sql_invoicing`;
CREATE DATABASE `sql_invoicing`; 
use `sql_invoicing`;

SET names utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) engine=innodb AUTO_INCREMENT=5 DEFAULT charset=utf8mb4 ;
SELECT  * FROM payment_methods pm ;
INSERT INTO `payment_methods` VALUES (1,'credit card');
INSERT INTO `payment_methods` VALUES (2,'cash');
INSERT INTO `payment_methods` VALUES (3,'paypal');
INSERT INTO `payment_methods` VALUES (4,'wire transfer');

CREATE TABLE `clients` (
  `client_id` INT(11) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `phone` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) engine=innodb DEFAULT charset=utf8mb4 ;
SELECT * FROM clients ;
INSERT INTO `clients` VALUES (1,'vinte','3 nevada parkway','syracuse','ny','315-252-7305');
INSERT INTO `clients` VALUES (2,'myworks','34267 glendale parkway','huntington','wv','304-659-1170');
INSERT INTO `clients` VALUES (3,'yadel','096 pawling parkway','san francisco','ca','415-144-6037');
INSERT INTO `clients` VALUES (4,'kwideo','81674 westerfield circle','waco','tx','254-750-0784');
INSERT INTO `clients` VALUES (5,'topiclounge','0863 farmco road','portland','OR','971-888-9129');

CREATE TABLE `invoices` (
  `invoice_id` INT(11) NOT NULL,
  `NUMBER` VARCHAR(50) NOT NULL,
  `client_id` INT(11) NOT NULL,
  `invoice_total` DECIMAL(9,2) NOT NULL,
  `payment_total` DECIMAL(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `payment_date` DATE DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  key `fk_client_id` (`client_id`),
  CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE restrict ON UPDATE CASCADE
) engine=innodb DEFAULT charset=utf8mb4 ;
INSERT INTO `invoices` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE `payments` (
  `payment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `invoice_id` INT(11) NOT NULL,
  `DATE` DATE NOT NULL,
  `amount` DECIMAL(9,2) NOT NULL,
  `payment_method` TINYINT(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  key `fk_client_id_idx` (`client_id`),
  key `fk_invoice_id_idx` (`invoice_id`),
  key `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
) engine=innodb AUTO_INCREMENT=9 DEFAULT charset=utf8mb4 ;
INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);


DROP DATABASE IF EXISTS `sql_store`;
CREATE DATABASE `sql_store`;
use `sql_store`;

CREATE TABLE `products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) engine=innodb AUTO_INCREMENT=11 DEFAULT charset=utf8mb4 ;
INSERT INTO `products` VALUES (1,'foam dinner plate',70,1.21);
INSERT INTO `products` VALUES (2,'pork - bacon,back peameal',49,4.65);
INSERT INTO `products` VALUES (3,'lettuce - romaine, heart',38,3.35);
INSERT INTO `products` VALUES (4,'brocolinni - gaylan, chinese',90,4.53);
INSERT INTO `products` VALUES (5,'sauce - ranch dressing',94,1.63);
INSERT INTO `products` VALUES (6,'petit baguette',14,2.39);
INSERT INTO `products` VALUES (7,'sweet pea sprouts',98,3.29);
INSERT INTO `products` VALUES (8,'island oasis - raspberry',26,0.74);
INSERT INTO `products` VALUES (9,'longan',67,2.26);
INSERT INTO `products` VALUES (10,'broom - push',6,1.09);


CREATE TABLE `shippers` (
  `shipper_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) engine=innodb AUTO_INCREMENT=6 DEFAULT charset=utf8mb4 ;
INSERT INTO `shippers` VALUES (1,'hettinger llc');
INSERT INTO `shippers` VALUES (2,'schinner-predovic');
INSERT INTO `shippers` VALUES (3,'satterfield llc');
INSERT INTO `shippers` VALUES (4,'mraz, renner AND nolan');
INSERT INTO `shippers` VALUES (5,'waters, mayert AND prohaska');


CREATE TABLE `customers` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth_date` DATE DEFAULT NULL,
  `phone` VARCHAR(50) DEFAULT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `points` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) engine=innodb AUTO_INCREMENT=11 DEFAULT charset=utf8mb4 ;
INSERT INTO `customers` VALUES (1,'babara','maccaffrey','1986-03-28','781-932-9754','0 sage terrace','waltham','ma',2273);
INSERT INTO `customers` VALUES (2,'ines','brushfield','1986-04-13','804-427-9456','14187 commercial trail','hampton','va',947);
INSERT INTO `customers` VALUES (3,'freddi','boagey','1985-02-07','719-724-7869','251 springs junction','colorado springs','co',2967);
INSERT INTO `customers` VALUES (4,'ambur','roseburgh','1974-04-14','407-231-8017','30 arapahoe terrace','orlando','fl',457);
INSERT INTO `customers` VALUES (5,'clemmie','betchley','1973-11-07',NULL,'5 spohn circle','arlington','tx',3675);
INSERT INTO `customers` VALUES (6,'elka','twiddell','1991-09-04','312-480-8498','7 manley drive','chicago','il',3073);
INSERT INTO `customers` VALUES (7,'ilene','dowson','1964-08-30','615-641-4759','50 lillian crossing','nashville','tn',1672);
INSERT INTO `customers` VALUES (8,'thacher','naseby','1993-07-17','941-527-3977','538 mosinee center','sarasota','fl',205);
INSERT INTO `customers` VALUES (9,'romola','rumgay','1992-05-23','559-181-3744','3520 ohio trail','visalia','ca',1486);
INSERT INTO `customers` VALUES (10,'levy','mynett','1969-10-13','404-246-3370','68 lawn avenue','atlanta','ga',796);


CREATE TABLE `order_statuses` (
  `order_status_id` TINYINT(4) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) engine=innodb DEFAULT charset=utf8mb4 ;
INSERT INTO `order_statuses` VALUES (1,'processed');
INSERT INTO `order_statuses` VALUES (2,'shipped');
INSERT INTO `order_statuses` VALUES (3,'delivered');


CREATE TABLE `orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(11) NOT NULL,
  `order_date` DATE NOT NULL,
  `status` TINYINT(4) NOT NULL DEFAULT '1',
  `comments` VARCHAR(2000) DEFAULT NULL,
  `shipped_date` DATE DEFAULT NULL,
  `shipper_id` SMALLINT(6) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  key `fk_orders_customers_idx` (`customer_id`),
  key `fk_orders_shippers_idx` (`shipper_id`),
  key `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON UPDATE CASCADE
) engine=innodb AUTO_INCREMENT=11 DEFAULT charset=utf8mb4 ;
INSERT INTO `orders` VALUES (1,6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (2,7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO `orders` VALUES (3,8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (4,2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (5,5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO `orders` VALUES (6,10,'2018-11-18',1,'aliquam erat volutpat. IN congue.',NULL,NULL);
INSERT INTO `orders` VALUES (7,2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO `orders` VALUES (8,5,'2018-06-08',1,'mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL);
INSERT INTO `orders` VALUES (9,10,'2017-07-05',2,'nulla mollis molestie lorem. quisque ut erat.','2017-07-06',1);
INSERT INTO `orders` VALUES (10,6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE `order_items` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  key `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) engine=innodb AUTO_INCREMENT=11 DEFAULT charset=utf8mb4 ;
INSERT INTO `order_items` VALUES (1,4,4,3.74);
INSERT INTO `order_items` VALUES (2,1,2,9.10);
INSERT INTO `order_items` VALUES (2,4,4,1.66);
INSERT INTO `order_items` VALUES (2,6,2,2.94);
INSERT INTO `order_items` VALUES (3,3,10,9.12);
INSERT INTO `order_items` VALUES (4,3,7,6.99);
INSERT INTO `order_items` VALUES (4,10,7,6.40);
INSERT INTO `order_items` VALUES (5,2,3,9.89);
INSERT INTO `order_items` VALUES (6,1,4,8.65);
INSERT INTO `order_items` VALUES (6,2,4,3.28);
INSERT INTO `order_items` VALUES (6,3,4,7.46);
INSERT INTO `order_items` VALUES (6,5,1,3.45);
INSERT INTO `order_items` VALUES (7,3,7,9.17);
INSERT INTO `order_items` VALUES (8,5,2,6.94);
INSERT INTO `order_items` VALUES (8,8,2,8.59);
INSERT INTO `order_items` VALUES (9,6,5,7.28);
INSERT INTO `order_items` VALUES (10,1,10,6.01);
INSERT INTO `order_items` VALUES (10,9,9,4.28);

CREATE TABLE `sql_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`));

INSERT INTO `order_item_notes` (`note_id`, `order_id`, `product_id`, `note`) VALUES ('1', '1', '2', 'first note');
INSERT INTO `order_item_notes` (`note_id`, `order_id`, `product_id`, `note`) VALUES ('2', '1', '2', 'second note');


DROP DATABASE IF EXISTS `sql_hr`;
CREATE DATABASE `sql_hr`;
use `sql_hr`;


CREATE TABLE `offices` (
  `office_id` INT(11) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) engine=innodb DEFAULT charset=utf8mb4 ;
INSERT INTO `offices` VALUES (1,'03 reinke trail','cincinnati','oh');
INSERT INTO `offices` VALUES (2,'5507 becker terrace','new york city','ny');
INSERT INTO `offices` VALUES (3,'54 northland court','richmond','va');
INSERT INTO `offices` VALUES (4,'08 south crossing','cincinnati','oh');
INSERT INTO `offices` VALUES (5,'553 maple drive','minneapolis','mn');
INSERT INTO `offices` VALUES (6,'23 north plaza','aurora','co');
INSERT INTO `offices` VALUES (7,'9658 wayridge court','boise','id');
INSERT INTO `offices` VALUES (8,'9 grayhawk trail','new york city','ny');
INSERT INTO `offices` VALUES (9,'16862 westend hill','knoxville','tn');
INSERT INTO `offices` VALUES (10,'4 bluestem parkway','savannah','ga');



CREATE TABLE `employees` (
  `employee_id` INT(11) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `job_title` VARCHAR(50) NOT NULL,
  `salary` INT(11) NOT NULL,
  `reports_to` INT(11) DEFAULT NULL,
  `office_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  key `fk_employees_offices_idx` (`office_id`),
  key `fk_employees_employees_idx` (`reports_to`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE
) engine=innodb DEFAULT charset=utf8mb4 ;
INSERT INTO `employees` VALUES (37270,'yovonnda','magrannell','executive secretary',63996,NULL,10);
INSERT INTO `employees` VALUES (33391,'d\'arcy','nortunen','account executive',62871,37270,1);
INSERT INTO `employees` VALUES (37851,'sayer','matterson','statistician iii',98926,37270,1);
INSERT INTO `employees` VALUES (40448,'mindy','crissil','staff scientist',94860,37270,1);
INSERT INTO `employees` VALUES (56274,'keriann','alloisi','vp marketing',110150,37270,1);
INSERT INTO `employees` VALUES (63196,'alaster','scutchin','assistant professor',32179,37270,2);
INSERT INTO `employees` VALUES (67009,'north','de clerc','vp product management',114257,37270,2);
INSERT INTO `employees` VALUES (67370,'elladine','rising','social worker',96767,37270,2);
INSERT INTO `employees` VALUES (68249,'nisse','voysey','financial advisor',52832,37270,2);
INSERT INTO `employees` VALUES (72540,'guthrey','iacopetti','office assistant i',117690,37270,3);
INSERT INTO `employees` VALUES (72913,'kass','hefferan','computer systems analyst iv',96401,37270,3);
INSERT INTO `employees` VALUES (75900,'virge','goodrum','information systems manager',54578,37270,3);
INSERT INTO `employees` VALUES (76196,'mirilla','janowski','cost accountant',119241,37270,3);
INSERT INTO `employees` VALUES (80529,'lynde','aronson','junior executive',77182,37270,4);
INSERT INTO `employees` VALUES (80679,'mildrid','sokale','geologist ii',67987,37270,4);
INSERT INTO `employees` VALUES (84791,'hazel','tarbert','general manager',93760,37270,4);
INSERT INTO `employees` VALUES (95213,'cole','kesterton','pharmacist',86119,37270,4);
INSERT INTO `employees` VALUES (96513,'theresa','binney','food chemist',47354,37270,5);
INSERT INTO `employees` VALUES (98374,'estrellita','daleman','staff accountant iv',70187,37270,5);
INSERT INTO `employees` VALUES (115357,'ivy','fearey','structural engineer',92710,37270,5);


DROP DATABASE IF EXISTS `sql_inventory`;
CREATE DATABASE `sql_inventory`;
use `sql_inventory`;


CREATE TABLE `products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) engine=innodb AUTO_INCREMENT=11 DEFAULT charset=utf8mb4 ;
INSERT INTO `products` VALUES (1,'foam dinner plate',70,1.21);
INSERT INTO `products` VALUES (2,'pork - bacon,back peameal',49,4.65);
INSERT INTO `products` VALUES (3,'lettuce - romaine, heart',38,3.35);
INSERT INTO `products` VALUES (4,'brocolinni - gaylan, chinese',90,4.53);
INSERT INTO `products` VALUES (5,'sauce - ranch dressing',94,1.63);
INSERT INTO `products` VALUES (6,'petit baguette',14,2.39);
INSERT INTO `products` VALUES (7,'sweet pea sprouts',98,3.29);
INSERT INTO `products` VALUES (8,'island oasis - raspberry',26,0.74);
INSERT INTO `products` VALUES (9,'longan',67,2.26);
INSERT INTO `products` VALUES (10,'broom - push',6,1.09);


