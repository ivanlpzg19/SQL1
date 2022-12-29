--1.1
SELECT first_name, last_name
FROM actor;

--1.2
SELECT
UPPER(first_name)||' '||UPPER(last_name) AS 'Actor Name'
FROM actor;

--1.3
SELECT actor_id, first_name,last_name
FROM actor
WHERE first_name LIKE 'JOE';

--1.4
SELECT actor_id,first_name,last_name
FROM actor
WHERE last_name LIKE '%GEN%';

--1.5
SELECT first_name,last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name ASC, first_name ASC;

--1.6
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

--2.1
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name);

--2.2
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name)>1; 

--2.3
SELECT st.first_name, st.last_name,ad.address
FROM staff st
INNER JOIN address ad
ON st.address_id=ad.address_id;

--2.4
SELECT st.staff_id,st.first_name,st.last_name,round(sum(py.amount),2) as Total 
FROM staff st 
LEFT JOIN payment py 
ON st.staff_id=py.staff_id
GROUP BY st.staff_id;

--2.5
SELECT fi.film_id as FilmTitle, count(fa.actor_id) as nactors
FROM film fi
INNER JOIN film_actor fa 
ON fi.film_id=fa.film_id
GROUP BY fi.title;

--2.6
SELECT fi.film_id as ID, fi.title as FilmTitle, count(inv.inventory_id) as ncopies
FROM film fi 
INNER JOIN inventory inv 
ON inv.film_id=fi.film_id
WHERE fi.film_id=439
GROUP BY fi.film_id;


--2.7
SELECT cu.customer_id, cu.last_name, cu.first_name, round(sum(py.amount)) as totalpaid
FROM customer cu 
INNER JOIN payment py 
ON cu.customer_id=py.customer_id
GROUP BY cu.customer_id
ORDER BY cu.last_name ASC;


--3.1
SELECT title
FROM film
WHERE title LIKE 'Q%' AND (
SELECT language_id FROM language WHERE name='English');

--3.2
SELECT fi.title, ac.first_name, ac.last_name
FROM actor ac
INNER JOIN film_actor fa ON ac.actor_id=fa.actor_id
INNER JOIN film fi ON fi.film_id=fa.film_id
WHERE fi.title in (SELECT fi.title FROM film WHERE fi.title='ALONE TRIP');


--3.3
SELECT cy.country, ct.first_name, ct.last_name, ct.email
FROM customer ct 
INNER JOIN address ad ON ct.address_id=ad.address_id
INNER JOIN city ci ON ci.city_id=ad.city_id
INNER JOIN country cy ON cy.country_id=ci.country_id
WHERE cy.country='Canada';

--3.4
SELECT ca.name AS 'Category', fi.title AS 'Film title'
FROM film fi
INNER JOIN film_category fc ON fc.film_id=fi.film_id
INNER JOIN category ca ON ca.category_id=fc.category_id
WHERE ca.name='Family';

--3.5
SELECT film.film_id,film.title,count(*) rentas from rental join inventory on rental.inventory_id=inventory.inventory_id
JOIN film on film.film_id=inventory.film_id
group BY film.film_id,film.title
ORDER BY rentas desc;

--3.6
SELECT store.store_id, sum(payment.amount) 
FROM store join customer on store.store_id=customer.store_id
JOIN payment on payment.customer_id = customer.customer_id
GROUP BY store.store_id;

--3.7
SELECT store.store_id,city.city,country.country from store 
JOIN address on address.address_id=store.address_id
JOIN city on city.city_id=address.city_id
JOIN country on country.country_id=city.country_id;

--3.8
SELECT category.name,sum(payment.amount) amount from rental join inventory on rental.inventory_id=inventory.inventory_id
JOIN payment on payment.rental_id=rental.rental_id
JOIN film_category on film_category.film_id=inventory.film_id
JOIN category on category.category_id=film_category.category_id
GROUP BY category.name
ORDER BY amount desc 
limit 5;