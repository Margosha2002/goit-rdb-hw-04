create schema LibraryManagment;
use LibraryManagment;


CREATE TABLE IF NOT EXISTS authors
(
author_id INT auto_increment PRIMARY KEY,
author_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS genres
(
genre_id INT auto_increment PRIMARY KEY,
genre_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS books
(
book_id INT auto_increment PRIMARY KEY,
title VARCHAR(255),
publication_year YEAR, 
author_id INT,
genre_id INT,
FOREIGN KEY (author_id) references authors(author_id),
FOREIGN KEY (genre_id) references genres(genre_id)
);

CREATE TABLE IF NOT EXISTS users
(
user_id INT auto_increment PRIMARY KEY,
username VARCHAR(255),
email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS borrowed_books
(
borrow_id INT auto_increment PRIMARY KEY,
book_id INT,
user_id INT,
borrow_date date,
return_date date,
FOREIGN KEY (book_id) references books(book_id),
FOREIGN KEY (user_id) references users(user_id)
);

INSERT INTO authors(author_name) VALUES('Taras Shevchenko'), ('Ivan Franko');
SELECT * FROM authors;

INSERT INTO genres(genre_name) VALUES('Fantasy'), ('Horror');
SELECT * FROM genres;

INSERT INTO books(title, publication_year, author_id, genre_id) 
VALUES('Katerina', 1940, 1, 1), ('Zahar Berkut', 1983, 2, 2);
SELECT * FROM books;

INSERT INTO users(username, email)
VALUES ('Karpenko', 'test@gmail.com'), ('Kulish', 'test1@gmail.com');
SELECT * FROM users;

INSERT INTO borrowed_books(book_id, user_id, borrow_date, return_date) 
VALUES(1, 1, '2024-04-04', '2024-05-05'), (2, 2, '2024-04-04', '2024-05-05'); 
SELECT * FROM borrowed_books;

use hw_3;

SELECT * FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
;

SELECT count(*) FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
;

SELECT count(*) FROM orders o
LEFT JOIN order_details od ON o.id = od.order_id
LEFT JOIN customers cs ON o.customer_id = cs.id
LEFT JOIN employees em ON o.employee_id = em.employee_id
LEFT JOIN shippers sh ON o.shipper_id = sh.id
LEFT JOIN products pr ON od.product_id = pr.id
LEFT JOIN categories ct ON pr.category_id = ct.id
LEFT JOIN suppliers su ON pr.supplier_id = su.id
;

SELECT count(*) FROM orders o
LEFT JOIN order_details od ON o.id = od.order_id
RIGHT JOIN customers cs ON o.customer_id = cs.id
LEFT JOIN employees em ON o.employee_id = em.employee_id
LEFT JOIN shippers sh ON o.shipper_id = sh.id
LEFT JOIN products pr ON od.product_id = pr.id
LEFT JOIN categories ct ON pr.category_id = ct.id
LEFT JOIN suppliers su ON pr.supplier_id = su.id
;

SELECT count(*) FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE o.employee_id > 3 AND o.employee_id <= 10
;


SELECT ct.name, count(*), AVG(od.quantity) 
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE o.employee_id > 3 AND o.employee_id <= 10
GROUP BY ct.name;

SELECT ct.name, count(*), AVG(od.quantity) 
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE o.employee_id > 3 AND o.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21;


SELECT ct.name, count(*), AVG(od.quantity) 
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
-- WHERE o.employee_id > 3 AND o.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY count(*) DESC;


SELECT ct.name, count(*), AVG(od.quantity) 
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories ct ON pr.category_id = ct.id
INNER JOIN suppliers su ON pr.supplier_id = su.id
-- WHERE o.employee_id > 3 AND o.employee_id <= 10
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY count(*) DESC
LIMIT 1,4;
