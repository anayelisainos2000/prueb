select first_name, last_name, email from customer;
--prueba para github
SELECT * FROM film;

SELECT DISTINCT release_year FROM film;
SELECT DISTINCT rental_rate FROM film;
SELECT DISTINCT rating FROM film;

----------------------------------------------

SELECT * FROM payment;


--Nos cuenta el total de renglones 
SELECT COUNT (*) FROM payment;
SELECT amount FROM payment;
SELECT DISTINCT amount FROM payment;
SELECT COUNT(DISTINCT amount) FROM payment;

------------------------------------------------

SELECT * FROM customer WHERE first_name = 'Jared';

SELECT COUNT(title) FROM film 
WHERE rental_rate > 4 
AND replacement_cost >= 19.99
AND rating = 'R'

SELECT * FROM film
WHERE rating = 'R' OR rating = 'PG-13'

SELECT * FROM film
WHERE rating != 'R' OR rating = 'PG-13'

-------------------------------------------
SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas'

SELECT description FROM film
WHERE title = 'Outlaw Hanky'

SELECT phone FROM address
WHERE address = '259 Ipoh Drive'
---------------------------------------------------------
SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name 
------------------------------------------
--Muestra los primero 5 fechas de pagos receintes
SELECT * FROM payment
ORDER BY payment_date DESC
LIMIT 5

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC
LIMIT 5
----------------------------------------
SELECT customer_id, payment_date FROM payment
ORDER BY payment_date
LIMIT 10

SELECT title, length FROM film
ORDER BY length 
LIMIT 10

SELECT COUNT(title) FROM film
WHERE length <=50
------------------------------------------
SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'
----------------------------------------------------
SELECT DISTINCT (amount) FROM payment
ORDER BY amount

SELECT COUNT(*) FROM payment
WHERE amount NOT IN(0.99,1.98,1.99)

SELECT * FROM payment
WHERE amount IN(0.99,1.98,1.99)
ORDER BY amount

SELECT * FROM customer
WHERE first_name IN ('John','Elizabeth','Julie')
ORDER BY first_name
--------------------------------------------

-- LIKE es para mas estricto, ILIKE no es estricto

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'

SELECT * FROM customer
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%'

SELECT * FROM customer
WHERE first_name LIKE '%er' AND last_name LIKE 'D%'

SELECT * FROM customer
WHERE first_name LIKE '%er' AND last_name LIKE 'D%'
----------------------------------------------
------ EJERCICIOS TASK --------------

SELECT COUNT(*) FROM payment
WHERE amount > 5.00;

SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';

SELECT COUNT(DISTINCT district) FROM address;

SELECT DISTINCT (district) FROM address
ORDER BY district;

SELECT COUNT(*) FROM film
WHERE rating = 'R' 
AND replacement_cost BETWEEN 5 AND 15;

SELECT COUNT(title) FROM film
WHERE title ILIKE '%truman%';

SELECT title FROM film
WHERE title LIKE '%Truman%'
-------------------------------------------
----------- SECCION 3: GROUP BY -----------

SELECT COUNT(*) FROM film;
SELECT MIN(replacement_cost) FROM film;
SELECT MIN(replacement_cost), MAX(replacement_cost) FROM film;
SELECT ROUND(AVG(replacement_cost),2) FROM film;
SELECT SUM(replacement_cost) FROM film;
----------------------------------------------------
SELECT * FROM payment
WHERE customer_id = 341


SELECT customer_id, SUM(amount) FROM payment 
WHERE customer_id = 341
GROUP BY customer_id

SELECT customer_id, SUM(amount) FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC

SELECT customer_id, COUNT(amount) FROM payment 
GROUP BY customer_id
ORDER BY COUNT(amount)

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id

SELECT COUNT(customer_id), DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY DATE(payment_date)
------------------------------------------------------------------------
-------------- EXCERSICES -----------------
SELECT staff_id, COUNT(customer_id) FROM payment
GROUP BY staff_id

SELECT rating, COUNT(replacement_cost),ROUND(AVG(replacement_cost),2) FROM film
GROUP BY rating
ORDER BY rating

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5
------------------------------------------------
SELECT customer_id, SUM(amount) FROM payment
WHERE customer_id NOT IN (184,87,477)
GROUP BY customer_id
HAVING SUM(amount) BETWEEN 80 AND 120
ORDER BY customer_id

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id

SELECT store_id, create_date, COUNT(customer_id) FROM customer
GROUP BY store_id, create_date

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300
-------------------------------------------------------------
------ EJERCICIOS TASK --------------

SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40
ORDER BY COUNT(amount)

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY customer_id, staff_id
HAVING staff_id = 2 AND SUM(amount) > 100
ORDER BY SUM(amount) DESC

SELECT customer_id, staff_id, SUM(amount) FROM payment
WHERE staff_id=2
GROUP BY customer_id, staff_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC
----------------------------------------------------
------------ ASSESSMENT TEST 1--------------
-- 1. Return the customer IDs of customers who have
--spent at least $110 with the staff member who has an ID of 2.

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount)>110


-- 2. How many films begin with the letter J?

SELECT COUNT(title) FROM film
WHERE title LIKE 'J%'

--3. What customer has the highest customer ID number whose 
--name starts with an 'E' and has an address ID lower than 500?

SELECT customer_id, address_id, first_name, last_name FROM customer
WHERE first_name LIKE 'E%' 
AND address_id <500
ORDER BY customer_id DESC
LIMIT 5

SELECT customer_id AS num_cliente FROM payment

SELECT SUM(amount) AS net_revenue FROM payment

SELECT customer_id, SUM(amount) AS monto_total FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100

SELECT customer_id, amount AS new_name
FROM payment
WHERE amount > 2
----------------------------------------------
SELECT * FROM payment
SELECT * FROM customer

SELECT * FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

SELECT payment.payment_id, payment.customer_id, payment.amount, first_name, last_name, email FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

--------------------------------------------------
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS NULL
OR payment.payment_id IS NULL

SELECT COUNT(DISTINCT customer_id) FROM payment
SELECT DISTINCT customer_id FROM payment
---------------------------------------------------------------------
SELECT * FROM film
SELECT * FROM inventory

SELECT film.film_id, film.title, inventory_id, store_id
FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL
-----------------------------------------------------------
SELECT film.film_id, film.title, inventory_id, store_id
FROM film
RIGHT JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NOT NULL
----------------------------------------------------------
SELECT film_id FROM film
UNION
SELECT film_id FROM film_category

-----------------------------------------------------------------------
------ EJERCICIOS TASK --------------

SELECT * FROM address
SELECT * FROM customer

SELECT district, email FROM address
FULL JOIN customer
ON address.address_id = customer.address_id
WHERE address.district = 'California'

SELECT address.address_id, address.district, email
FROM address
LEFT JOIN customer
ON address.address_id = customer.address_id
WHERE address.district = 'California'
-----------
SELECT * FROM actor
SELECT * FROM film_actor
SELECT * FROM film

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'

SELECT actor_id, film_id FROM film_actor
WHERE actor_id = 2

SELECT actor.actor_id, actor.first_name, actor.last_name, film_id
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg'

SELECT film_actor.actor_id, film_actor.film_id, title
FROM film_actor
LEFT JOIN film
ON film_actor.film_id =  film.film_id
WHERE actor_id = 2

---- ESTE ES EL BUENOOOOOO -----------
SELECT actor.first_name, actor.last_name, film.title
FROM actor
INNER JOIN film_actor ON (actor.actor_id = film_actor.actor_id )
INNER JOIN film ON (film_actor.film_id = film.film_id )
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg'
---------------------------------------------------------------------------------
------------------ S E C C I O N    6 -------------------------------------------
SHOW ALL
SHOW TIMEZONE
SELECT NOW()
SELECT TIMEOFDAY()
SELECT CURRENT_DATE
----------------------------------------------------
SELECT * FROM payment

SELECT EXTRACT(YEAR FROM payment_date) AS yeaar FROM payment
SELECT EXTRACT(MONTH FROM payment_date) AS mnth FROM payment
SELECT EXTRACT(DAY FROM payment_date) AS day FROM payment

SELECT AGE(payment_date)
FROM payment

SELECT TO_CHAR(payment_date,'MONTH YYYY')
FROM payment

SELECT TO_CHAR(payment_date,'mon/dd/YYYY')
FROM payment

SELECT TO_CHAR(payment_date,'MM/DD/YYYY')
FROM payment
------------------------------------------------
SELECT * FROM payment

SELECT DISTINCT(TO_CHAR(payment_date,'MONTH'))
FROM payment
ORDER BY TO_CHAR(payment_date,'MONTH')

--PONEMOS 1 PORQUE REPRESENTA EL LUNES Y 0-DOMINGO
SELECT COUNT(*) FROM payment
WHERE EXTRACT(dow FROM payment_date)=1
-------------------------------------------------
SELECT ROUND(rental_rate/replacement_cost,2)*100 AS percent
FROM film

SELECT 0.1*replacement_cost AS deposit
FROM film
---------------------------------------------
SELECT LENGTH(first_name) FROM customer

SELECT UPPER(first_name ||' - ' || last_name) AS full_name
FROM customer

SELECT LEFT(first_name,1) || last_name || '@gmail.com'
FROM customer

SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com'
FROM customer

------------- S U B C O N S U L T A S ---------------------------------------

SELECT title, rental_rate FROM film
WHERE rental_rate < (SELECT AVG(rental_rate) FROM film)

SELECT * FROM rental
SELECT * FROM inventory

SELECT film_id,title
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY title

SELECT first_name, last_name
FROM customer AS c
WHERE NOT EXISTS
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11)
--------------------------------------------------------
-- SELF JOIN

SELECT tableA.col, tableB.col
FROM name_table AS tableA
JOIN name_table AS tableB
ON tableA.col_1 = tableB.col_2

SELECT title, length FROM film
WHERE length = 117

SELECT f1.title, f2.title, f1.length
FROM film AS f1
INNER JOIN film AS f2
ON f1.film_id != f2.film_id
AND f1.length = f2.length

SELECT * from film
----------------------------------------------































































