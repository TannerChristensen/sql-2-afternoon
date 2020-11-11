JOINS

SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;
 
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;
 
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;
 
SELECT al.title, ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;
 
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';
 
SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;
 
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;
 
SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

NESTED QUERIES

SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );
 
SELECT *
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id FROM playlist WHERE name = 'Music' );
 
SELECT name
FROM track
WHERE track_id IN ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );
 
SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id FROM genre WHERE name = 'Comedy' );
 
SELECT *
FROM track
WHERE album_id IN ( SELECT album_id FROM album WHERE title = 'Fireball' );
 
SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id FROM album WHERE artist_id IN ( 
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);

GROUP BY 

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;
 
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;
 
SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

DELETE ROWS

DELETE 
FROM practice_delete 
WHERE type = 'bronze';
 
DELETE 
FROM practice_delete 
WHERE type = 'silver';
 
DELETE 
FROM practice_delete 
WHERE value = 150;

E COMMERCE

CREATE TABLE users (
   user_id SERIAL PRIMARY KEY,
   user_name VARCHAR(250),
   user_email VARCHAR (250)
)

CREATE TABLE products (
   product_id SERIAL PRIMARY KEY,
   product_name VARCHAR (250),
   product_price INTEGER
)

CREATE TABLE orders (
   order_id SERIAL PRIMARY KEY,
   user_id INT REFERENCES users(user_id),
   product_id INT REFERENCES products(product_id)
)

INSERT INTO users (user_name, user_email)
VALUES 
('Tanner', 'tanner@gmail.com'),
('Cole', 'beekeeper@gmail.com'),
('Adam', 'adam@gmail.com');

INSERT INTO products (product_name, product_price)
VALUES
('Halo', 60),
('Call of Duty', 60),
('Need for Speed', 25);

INSERT INTO orders (user_id, product_id)
VALUES 
(1, 1),
(2, 2),
(3, 3)

SELECT * FROM products
WHERE product_id = 1

SELECT SUM (product_price)
FROM products p
JOIN orders o 
ON o.product_id = p.product_id
WHERE o.order_id = 1

SELECT * 
FROM users u
JOIN orders o 
ON o.user_id = u.user_id
WHERE u.user_id = 3

SELECT COUNT(*), u.user_id
FROM orders o 
JOIN users u 
ON o.user_id = u.user_id
GROUP BY u.user_id;