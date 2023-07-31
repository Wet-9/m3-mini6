CREATE DATABASE shopping; 
use shopping; 


CREATE TABLE product_categories (
       id INT PRIMARY KEY AUTO_INCREMENT,
       title VARCHAR(45) NOT NULL
     );

CREATE TABLE PRODUCTS(
       Id INT PRIMARY KEY AUTO_INCREMENT,
       title VARCHAR(45) NOT NULL,
       description MEDIUMTEXT,
       product_category_id INT,
       price DOUBLE,
       quantity INT,
       FOREIGN KEY (product_category_id) REFERENCES product_categories(id)
     );

CREATE TABLE Orders (
       id INT PRIMARY KEY AUTO_INCREMENT,
       product_id INT,
       name VARCHAR(45) NOT NULL,
       email VARCHAR(45) NOT NULL,
       order_date DATETIME,
       FOREIGN KEY (product_id) REFERENCES Products(Id)
     );

mysql> SHOW TABLES;
+--------------------+
| Tables_in_shopping |
+--------------------+
| Orders             |
| product_categories |
| Products           |
+--------------------+

mysql> desc products;
+---------------------+-------------+------+-----+---------+----------------+
| Field               | Type        | Null | Key | Default | Extra          |
+---------------------+-------------+------+-----+---------+----------------+
| Id                  | int         | NO   | PRI | NULL    | auto_increment |
| title               | varchar(45) | NO   |     | NULL    |                |
| description         | mediumtext  | YES  |     | NULL    |                |
| product_category_id | int         | YES  | MUL | NULL    |                |
| price               | double      | YES  |     | NULL    |                |
| quantity            | int         | YES  |     | NULL    |                |
+---------------------+-------------+------+-----+---------+----------------+

mysql> desc orders;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int         | NO   | PRI | NULL    | auto_increment |
| product_id | int         | YES  | MUL | NULL    |                |
| name       | varchar(45) | NO   |     | NULL    |                |
| email      | varchar(45) | NO   |     | NULL    |                |
| order_date | datetime    | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

mysql> desc product_categories;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int         | NO   | PRI | NULL    | auto_increment |
| title | varchar(45) | NO   |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+

INSERT INTO product_categories (id, title)
     VALUES
       (1, 'Electronics'),
       (2, 'Clothing');

INSERT INTO Products (Id, title, description, product_category_id, price, quantity)
     VALUES
       (1, 'Phone', 'Iphone999 best of the best', 1, 1699, 50),
       (2, 'Laptop', 'macbook 19inch', 1, 2999, 50),
       (3, 'T-Shirt', 'Designer guuci t shirt', 2, 599, 100),
       (4, 'Jeans', 'Dirty looking jeans', 2, 30.23, 500);

INSERT INTO orders (id, product_id, name, email, order_date)
     VALUES
       (1, 1, 'Steve Jobs', 'Stevejobs@Apple.com', '2023-07-30 12:12:12'),
       (2, 2, 'Tim Cook', 'Timcook@Apple.com', '2023-07-30 11:11:11'),
       (3, 3, 'Aaron Lee', 'Aaronlee@boocamp.com', '2023-07-30 10:10:10'),
       (4, 4, 'Joe Mama', 'Jokes@jokes.com', '2023-07-30 09:09:09');

-- Get all orders from the most recent to the oldest.
SELECT * FROM orders ORDER BY order_date DESC;
+----+------------+------------+----------------------+---------------------+
| id | product_id | name       | email                | order_date          |
+----+------------+------------+----------------------+---------------------+
|  1 |          1 | Steve Jobs | Stevejobs@Apple.com  | 2023-07-30 12:12:12 |
|  2 |          2 | Tim Cook   | Timcook@Apple.com    | 2023-07-30 11:11:11 |
|  3 |          3 | Aaron Lee  | Aaronlee@boocamp.com | 2023-07-30 10:10:10 |
|  4 |          4 | Joe Mama   | Jokes@jokes.com      | 2023-07-30 09:09:09 |
+----+------------+------------+----------------------+---------------------+

--Get all products belonging to a particular category.

SELECT products.id, products.title, products.description, products.price, products.quantity
FROM products
JOIN product_categories ON products.product_category_id = product_categories.id
WHERE product_categories.title = 'Electronics';

+----+--------+----------------------------+-------+----------+
| id | title  | description                | price | quantity |
+----+--------+----------------------------+-------+----------+
|  1 | Phone  | Iphone999 best of the best |  1699 |       50 |
|  2 | Laptop | macbook 19inch             |  2999 |       50 |
+----+--------+----------------------------+-------+----------+

or 

SELECT products.title 
FROM products 
JOIN product_categories ON products.product_category_id = product_categories.id 
WHERE product_categories.title = 'Electronics';

+--------+
| title  |
+--------+
| Phone  |
| Laptop |
+--------+

-- Get the top three (3) most expensive products in the products table.
SELECT * FROM products ORDER BY price DESC LIMIT 3;
+----+---------+----------------------------+---------------------+-------+----------+
| Id | title   | description                | product_category_id | price | quantity |
+----+---------+----------------------------+---------------------+-------+----------+
|  2 | Laptop  | macbook 19inch             |                   1 |  2999 |       50 |
|  1 | Phone   | Iphone999 best of the best |                   1 |  1699 |       50 |
|  3 | T-Shirt | Designer guuci t shirt     |                   2 |   599 |      100 |
+----+---------+----------------------------+---------------------+-------+----------+

--Get the total number of products under each product category.


SELECT product_categories.title AS ProductCategory, COUNT(*) AS Total
FROM products
JOIN product_categories ON products.product_category_id = product_categories.id
GROUP BY product_categories.title;

+-----------------+-------+
| ProductCategory | Total |
+-----------------+-------+
| Electronics     |     2 |
| Clothing        |     2 |
+-----------------+-------+


Get the top three (3) selling products based on the number of orders.

INSERT INTO orders (id, product_id, name, email, order_date)
     VALUES
       (5, 1, 'Iphone User', 'newphone@Apple.com', '2023-07-31 12:12:12'),
       (6, 1, 'apple hater', 'hater@Apple.com', '2023-07-31 08:34:40'),
       (7, 4, 'Bill Farmer', 'farmer@barn.com', '2023-07-31 01:02:12');


INSERT INTO orders (id, product_id, name, email, order_date)
     VALUES

+----+------------+-------------+----------------------+---------------------+
| id | product_id | name        | email                | order_date          |
+----+------------+-------------+----------------------+---------------------+
|  1 |          1 | Steve Jobs  | Stevejobs@Apple.com  | 2023-07-30 12:12:12 |
|  2 |          2 | Tim Cook    | Timcook@Apple.com    | 2023-07-30 11:11:11 |
|  3 |          3 | Aaron Lee   | Aaronlee@boocamp.com | 2023-07-30 10:10:10 |
|  4 |          4 | Joe Mama    | Jokes@jokes.com      | 2023-07-30 09:09:09 |
|  5 |          1 | Iphone User | newphone@Apple.com   | 2023-07-31 12:12:12 |
|  6 |          1 | apple hater | hater@Apple.com      | 2023-07-31 08:34:40 |
|  7 |          4 | Bill Farmer | farmer@barn.com      | 2023-07-31 01:02:12 |
+----+------------+-------------+----------------------+---------------------+

-- Select from orders.product_id 


SELECT products.title AS product_title, count(*) AS Order_total
FROM orders
JOIN products ON products.id = orders.product_id
GROUP BY product_id
ORDER BY Order_total DESC
LIMIT 3;

+---------------+-------------+
| product_title | Order_total |
+---------------+-------------+
| Phone         |           3 |
| Jeans         |           2 |
| Laptop        |           1 |
+---------------+-------------+