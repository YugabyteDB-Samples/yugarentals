/*

Sakila for Oracle is a port of the Sakila example database available for MySQL, which was originally developed by Mike Hillyer of the MySQL AB documentation team. 
This project is designed to help database administrators to decide which database to use for development of new products
The user can run the same SQL against different kind of databases and compare the performance

License: BSD
Copyright DB Software Laboratory
http://www.etl-tools.com
 */
--
-- Table structure for table actor
--
--DROP TABLE actor;
CREATE TABLE actor(
    actor_id int NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_actor PRIMARY KEY (actor_id)
);

CREATE INDEX idx_actor_last_name ON actor(last_name);

--DROP SEQUENCE actor_sequence;
CREATE SEQUENCE actor_sequence;

CREATE OR REPLACE TRIGGER actor_before_trigger
    BEFORE INSERT ON actor
    FOR EACH ROW
BEGIN
    IF(:NEW.actor_id IS NULL) THEN
        SELECT
            actor_sequence.nextval INTO :NEW.actor_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER actor_before_update
    BEFORE UPDATE ON actor
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table country
--
CREATE TABLE country(
    country_id int NOT NULL,
    country varchar(50) NOT NULL,
    last_update date,
    CONSTRAINT pk_country PRIMARY KEY (country_id)
);

---DROP SEQUENCE country_sequence;
CREATE SEQUENCE country_sequence;

CREATE OR REPLACE TRIGGER country_before_trigger
    BEFORE INSERT ON country
    FOR EACH ROW
BEGIN
    IF(:NEW.country_id IS NULL) THEN
        SELECT
            country_sequence.nextval INTO :NEW.country_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER country_before_update
    BEFORE UPDATE ON country
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table city
--
CREATE TABLE city(
    city_id int NOT NULL,
    city varchar(50) NOT NULL,
    country_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_city PRIMARY KEY (city_id),
    CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE INDEX idx_fk_country_id ON city(country_id);

--- DROP SEQUENCE city_sequence;
CREATE SEQUENCE city_sequence;

CREATE OR REPLACE TRIGGER city_before_trigger
    BEFORE INSERT ON city
    FOR EACH ROW
BEGIN
    IF(:NEW.city_id IS NULL) THEN
        SELECT
            city_sequence.nextval INTO :NEW.city_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER city_before_update
    BEFORE UPDATE ON city
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table address
--
CREATE TABLE address(
    address_id int NOT NULL,
    address varchar(50) NOT NULL,
    address2 varchar(50) DEFAULT NULL,
    district varchar(20) NOT NULL,
    city_id int NOT NULL,
    postal_code varchar(10) DEFAULT NULL,
    phone varchar(20) NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_address PRIMARY KEY (address_id)
);

CREATE INDEX idx_fk_city_id ON address(city_id);

ALTER TABLE address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city(city_id);

--DROP SEQUENCE city_sequence;
CREATE SEQUENCE address_sequence;

CREATE OR REPLACE TRIGGER address_before_trigger
    BEFORE INSERT ON address
    FOR EACH ROW
BEGIN
    IF(:NEW.address_id IS NULL) THEN
        SELECT
            address_sequence.nextval INTO :NEW.address_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER address_before_update
    BEFORE UPDATE ON address
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table language
--
CREATE TABLE
LANGUAGE (
    language_id int NOT NULL,
    name char(20) NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_language PRIMARY KEY (language_id)
);

---DROP SEQUENCE language_sequence;
CREATE SEQUENCE language_sequence;

CREATE OR REPLACE TRIGGER language_before_trigger
    BEFORE INSERT ON
    LANGUAGE
    FOR EACH ROW
BEGIN
    IF(:NEW.language_id IS NULL) THEN
        SELECT
            language_sequence.nextval INTO :NEW.language_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER language_before_update
    BEFORE UPDATE ON
    LANGUAGE
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table category
--
CREATE TABLE category(
    category_id int NOT NULL,
    name varchar(25) NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (category_id)
);

---DROP SEQUENCE category_sequence;
CREATE SEQUENCE category_sequence;

CREATE OR REPLACE TRIGGER category_before_trigger
    BEFORE INSERT ON category
    FOR EACH ROW
BEGIN
    IF(:NEW.category_id IS NULL) THEN
        SELECT
            category_sequence.nextval INTO :NEW.category_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER category_before_update
    BEFORE UPDATE ON category
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table customer
--
CREATE TABLE customer(
    customer_id int NOT NULL,
    store_id int NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    email varchar(50) DEFAULT NULL,
    address_id int NOT NULL,
    active char(1) DEFAULT 'Y' NOT NULL,
    create_date date NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
    CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE INDEX idx_customer_fk_store_id ON customer(store_id);

CREATE INDEX idx_customer_fk_address_id ON customer(address_id);

CREATE INDEX idx_customer_last_name ON customer(last_name);

---DROP SEQUENCE customer_sequence;
CREATE SEQUENCE customer_sequence;

CREATE OR REPLACE TRIGGER customer_before_trigger
    BEFORE INSERT ON customer
    FOR EACH ROW
BEGIN
    IF(:NEW.customer_id IS NULL) THEN
        SELECT
            customer_sequence.nextval INTO :NEW.customer_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

:NEW.create_date := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER customer_before_update
    BEFORE UPDATE ON customer
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table film
--
CREATE TABLE film(
    film_id int NOT NULL,
    title varchar(255) NOT NULL,
    description CLOB DEFAULT NULL,
    release_year varchar(4) DEFAULT NULL,
    language_id int NOT NULL,
    original_language_id int DEFAULT NULL,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate DECIMAL(4, 2) DEFAULT 4.99 NOT NULL,
    length smallint DEFAULT NULL,
    replacement_cost DECIMAL(5, 2) DEFAULT 19.99 NOT NULL,
    rating varchar(10) DEFAULT 'G',
    special_features varchar(100) DEFAULT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_film PRIMARY KEY (film_id),
    CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES
    LANGUAGE (language_id),
    CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES
    LANGUAGE (language_id)
);

ALTER TABLE film
    ADD CONSTRAINT CHECK_special_features CHECK (special_features IS NULL OR special_features LIKE '%Trailers%' OR special_features LIKE '%Commentaries%' OR special_features LIKE '%Deleted Scenes%' OR special_features LIKE '%Behind the Scenes%');

ALTER TABLE film
    ADD CONSTRAINT CHECK_special_rating CHECK (rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17'));

CREATE INDEX idx_fk_language_id ON film(language_id);

CREATE INDEX idx_fk_original_language_id ON film(original_language_id);

---DROP SEQUENCE film_sequence;
CREATE SEQUENCE film_sequence;

CREATE OR REPLACE TRIGGER film_before_trigger
    BEFORE INSERT ON film
    FOR EACH ROW
BEGIN
    IF(:NEW.film_id IS NULL) THEN
        SELECT
            film_sequence.nextval INTO :NEW.film_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER film_before_update
    BEFORE UPDATE ON film
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table film_actor
--
CREATE TABLE film_actor(
    actor_id int NOT NULL,
    film_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_film_actor PRIMARY KEY (actor_id, film_id),
    CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE INDEX idx_fk_film_actor_film ON film_actor(film_id);

CREATE INDEX idx_fk_film_actor_actor ON film_actor(actor_id);

CREATE OR REPLACE TRIGGER film_actor_before_trigger
    BEFORE INSERT ON film_actor
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER film_actor_before_update
    BEFORE UPDATE ON film_actor
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table film_category
--
CREATE TABLE film_category(
    film_id int NOT NULL,
    category_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_film_category PRIMARY KEY (film_id, category_id),
    CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film(film_id),
    CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE INDEX idx_fk_film_category_film ON film_category(film_id);

CREATE INDEX idx_fk_film_category_category ON film_category(category_id);

CREATE OR REPLACE TRIGGER film_category_before_trigger
    BEFORE INSERT ON film_category
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER film_category_before_update
    BEFORE UPDATE ON film_category
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table film_text
--
CREATE TABLE film_text(
    film_id int NOT NULL,
    title varchar(255) NOT NULL,
    description CLOB,
    CONSTRAINT pk_film_text PRIMARY KEY (film_id)
);

--
-- Table structure for table inventory
--
CREATE TABLE inventory(
    inventory_id int NOT NULL,
    film_id int NOT NULL,
    store_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_inventory PRIMARY KEY (inventory_id),
    CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE INDEX idx_fk_film_id ON inventory(film_id);

CREATE INDEX idx_fk_film_id_store_id ON inventory(store_id, film_id);

---DROP SEQUENCE inventory_sequence;
CREATE SEQUENCE inventory_sequence;

CREATE OR REPLACE TRIGGER inventory_before_trigger
    BEFORE INSERT ON inventory
    FOR EACH ROW
BEGIN
    IF(:NEW.inventory_id IS NULL) THEN
        SELECT
            inventory_sequence.nextval INTO :NEW.inventory_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER inventory_before_update
    BEFORE UPDATE ON inventory
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table staff
--
CREATE TABLE staff(
    staff_id int NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    address_id int NOT NULL,
    picture BLOB DEFAULT NULL,
    email varchar(50) DEFAULT NULL,
    store_id int NOT NULL,
    active smallint DEFAULT 1 NOT NULL,
    username varchar(16) NOT NULL,
    password VARCHAR(40) DEFAULT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_staff PRIMARY KEY (staff_id),
    CONSTRAINT fk_staff_address FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE INDEX idx_fk_staff_store_id ON staff(store_id);

CREATE INDEX idx_fk_staff_address_id ON staff(address_id);

---DROP SEQUENCE inventory_sequence;
CREATE SEQUENCE staff_sequence;

CREATE OR REPLACE TRIGGER staff_before_trigger
    BEFORE INSERT ON staff
    FOR EACH ROW
BEGIN
    IF(:NEW.staff_id IS NULL) THEN
        SELECT
            staff_sequence.nextval INTO :NEW.staff_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER staff_before_update
    BEFORE UPDATE ON staff
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table store
--
CREATE TABLE store(
    store_id int NOT NULL,
    manager_staff_id int NOT NULL,
    address_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_store PRIMARY KEY (store_id),
    CONSTRAINT fk_store_staff FOREIGN KEY (manager_staff_id) REFERENCES staff(staff_id),
    CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE INDEX idx_store_fk_manager_staff_id ON store(manager_staff_id);

CREATE INDEX idx_fk_store_address ON store(address_id);

---DROP SEQUENCE store_sequence;
CREATE SEQUENCE store_sequence;

CREATE OR REPLACE TRIGGER store_before_trigger
    BEFORE INSERT ON store
    FOR EACH ROW
BEGIN
    IF(:NEW.store_id IS NULL) THEN
        SELECT
            store_sequence.nextval INTO :NEW.store_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER store_before_update
    BEFORE UPDATE ON store
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
--
-- Table structure for table payment
--
CREATE TABLE payment(
    payment_id int NOT NULL,
    customer_id int NOT NULL,
    staff_id int NOT NULL,
    rental_id int DEFAULT NULL,
    amount DECIMAL(5, 2) NOT NULL,
    payment_date date NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_payment PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_payment_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE INDEX idx_fk_staff_id ON payment(staff_id);

CREATE INDEX idx_fk_customer_id ON payment(customer_id);

---DROP SEQUENCE payment_sequence;
CREATE SEQUENCE payment_sequence;

CREATE OR REPLACE TRIGGER payment_before_trigger
    BEFORE INSERT ON payment
    FOR EACH ROW
BEGIN
    IF(:NEW.payment_id IS NULL) THEN
        SELECT
            payment_sequence.nextval INTO :NEW.payment_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER payment_before_update
    BEFORE UPDATE ON payment
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/ CREATE TABLE rental(
    rental_id int NOT NULL,
    rental_date date NOT NULL,
    inventory_id int NOT NULL,
    customer_id int NOT NULL,
    return_date date DEFAULT NULL,
    staff_id int NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT pk_rental PRIMARY KEY (rental_id),
    CONSTRAINT fk_rental_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT fk_rental_inventory FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE INDEX idx_rental_fk_inventory_id ON rental(inventory_id);

CREATE INDEX idx_rental_fk_customer_id ON rental(customer_id);

CREATE INDEX idx_rental_fk_staff_id ON rental(staff_id);

CREATE UNIQUE INDEX idx_rental_uq ON rental(rental_date, inventory_id, customer_id);

---DROP SEQUENCE payment_sequence;
CREATE SEQUENCE rental_sequence;

CREATE OR REPLACE TRIGGER rental_before_trigger
    BEFORE INSERT ON rental
    FOR EACH ROW
BEGIN
    IF(:NEW.rental_id IS NULL) THEN
        SELECT
            rental_sequence.nextval INTO :NEW.rental_id
        FROM
            DUAL;

END IF;

:NEW.last_update := CURRENT_DATE;

END;

/ CREATE OR REPLACE TRIGGER rental_before_update
    BEFORE UPDATE ON rental
    FOR EACH ROW
BEGIN
    :NEW.last_update := CURRENT_DATE;

END;

/
-- FK CONSTRAINTS
ALTER TABLE customer
    ADD CONSTRAINT fk_customer_store FOREIGN KEY (store_id) REFERENCES store(store_id);

ALTER TABLE inventory
    ADD CONSTRAINT fk_inventory_store FOREIGN KEY (store_id) REFERENCES store(store_id);

ALTER TABLE staff
    ADD CONSTRAINT fk_staff_store FOREIGN KEY (store_id) REFERENCES store(store_id);

ALTER TABLE payment
    ADD CONSTRAINT fk_payment_rental FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE SET NULL;

--
-- View structure for view customer_list
--
CREATE OR REPLACE VIEW customer_list AS
SELECT
    cu.customer_id AS ID,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address AS address,
    a.postal_code AS zip_code,
    a.phone AS phone,
    city.city AS city,
    country.country AS country,
    decode(cu.active, 1, 'active', '') AS notes,
    cu.store_id AS SID
FROM
    customer cu
    JOIN address a ON cu.address_id = a.address_id
    JOIN city ON a.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;

--
-- View structure for view film_list
--
CREATE OR REPLACE VIEW film_list AS
SELECT
    film.film_id AS FID,
    film.title AS title,
    film.description AS description,
    category.name AS category,
    film.rental_rate AS price,
    film.length AS length,
    film.rating AS rating,
    actor.first_name || ' ' || actor.last_name AS actors
FROM
    category
    LEFT JOIN film_category ON category.category_id = film_category.category_id
    LEFT JOIN film ON film_category.film_id = film.film_id
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id;

--
-- View structure for view staff_list
--
CREATE OR REPLACE VIEW staff_list AS
SELECT
    s.staff_id AS ID,
    s.first_name || ' ' || s.last_name AS name,
    a.address AS address,
    a.postal_code AS zip_code,
    a.phone AS phone,
    city.city AS city,
    country.country AS country,
    s.store_id AS SID
FROM
    staff s
    JOIN address a ON s.address_id = a.address_id
    JOIN city ON a.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;

--
-- View structure for view sales_by_store
--
CREATE OR REPLACE VIEW sales_by_store AS
SELECT
    s.store_id,
    c.city || ',' || cy.country AS store,
    m.first_name || ' ' || m.last_name AS manager,
    SUM(p.amount) AS total_sales
FROM
    payment p
    INNER JOIN rental r ON p.rental_id = r.rental_id
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    INNER JOIN store s ON i.store_id = s.store_id
    INNER JOIN address a ON s.address_id = a.address_id
    INNER JOIN city c ON a.city_id = c.city_id
    INNER JOIN country cy ON c.country_id = cy.country_id
    INNER JOIN staff m ON s.manager_staff_id = m.staff_id
GROUP BY
    s.store_id,
    c.city || ',' || cy.country,
    m.first_name || ' ' || m.last_name;

--
-- View structure for view sales_by_film_category
--
-- Note that total sales will add up to >100% because
-- some titles belong to more than 1 category
--
CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT
    c.name AS category,
    SUM(p.amount) AS total_sales
FROM
    payment p
    INNER JOIN rental r ON p.rental_id = r.rental_id
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    INNER JOIN film f ON i.film_id = f.film_id
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY
    c.name;

--
-- View structure for view actor_info
--
/*
CREATE VIEW actor_info
AS
SELECT
a.actor_id,
a.first_name,
a.last_name,
GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ',
 (SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
 FROM sakila.film f
 INNER JOIN sakila.film_category fc
 ON f.film_id = fc.film_id
 INNER JOIN sakila.film_actor fa
 ON f.film_id = fa.film_id
 WHERE fc.category_id = c.category_id
 AND fa.actor_id = a.actor_id
 )
 )
 ORDER BY c.name SEPARATOR '; ')
AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
 ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc
 ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c
 ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;
 */
-- TO DO PROCEDURES
