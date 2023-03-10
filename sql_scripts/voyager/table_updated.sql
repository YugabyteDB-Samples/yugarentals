CREATE TABLE actor (
    actor_id numeric(38) DEFAULT nextval('actor_sequence'),
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (actor_id)
);

ALTER TABLE actor
    ALTER COLUMN ACTOR_ID SET NOT NULL;

ALTER TABLE actor
    ALTER COLUMN FIRST_NAME SET NOT NULL;

ALTER TABLE actor
    ALTER COLUMN LAST_NAME SET NOT NULL;

ALTER TABLE actor
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE address (
    address_id numeric(38) DEFAULT nextval('address_sequence'),
    address varchar(50) NOT NULL,
    address2 varchar(50),
    district varchar(20) NOT NULL,
    city_id numeric(38) NOT NULL,
    postal_code varchar(10),
    phone varchar(20) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (address_id)
);

ALTER TABLE address
    ALTER COLUMN ADDRESS_ID SET NOT NULL;

ALTER TABLE address
    ALTER COLUMN ADDRESS SET NOT NULL;

ALTER TABLE address
    ALTER COLUMN DISTRICT SET NOT NULL;

ALTER TABLE address
    ALTER COLUMN CITY_ID SET NOT NULL;

ALTER TABLE address
    ALTER COLUMN PHONE SET NOT NULL;

ALTER TABLE address
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE category (
    category_id numeric(38) DEFAULT nextval('category_sequence'),
    name varchar(25) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (category_id)
);

ALTER TABLE category
    ALTER COLUMN CATEGORY_ID SET NOT NULL;

ALTER TABLE category
    ALTER COLUMN NAME SET NOT NULL;

ALTER TABLE category
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE city (
    city_id numeric(38) DEFAULT nextval('city_sequence'),
    city varchar(50) NOT NULL,
    country_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (city_id)
);

ALTER TABLE city
    ALTER COLUMN CITY_ID SET NOT NULL;

ALTER TABLE city
    ALTER COLUMN CITY SET NOT NULL;

ALTER TABLE city
    ALTER COLUMN COUNTRY_ID SET NOT NULL;

ALTER TABLE city
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE country (
    country_id numeric(38) DEFAULT nextval('country_sequence'),
    country varchar(50) NOT NULL,
    last_update timestamp,
    PRIMARY KEY (country_id)
);

ALTER TABLE country
    ALTER COLUMN COUNTRY_ID SET NOT NULL;

ALTER TABLE country
    ALTER COLUMN COUNTRY SET NOT NULL;

CREATE TABLE customer (
    customer_id numeric(38) DEFAULT nextval('customer_sequence'),
    store_id numeric(38) NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    email varchar(50),
    address_id numeric(38) NOT NULL,
    active char(1) NOT NULL DEFAULT 'Y',
    create_date timestamp NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (customer_id)
);

ALTER TABLE customer
    ALTER COLUMN CUSTOMER_ID SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN STORE_ID SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN FIRST_NAME SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN LAST_NAME SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN ADDRESS_ID SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN ACTIVE SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN CREATE_DATE SET NOT NULL;

ALTER TABLE customer
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE film (
    film_id numeric(38) DEFAULT nextval('film_sequence'),
    title varchar(255) NOT NULL,
    description text,
    release_year varchar(4),
    language_id numeric(38) NOT NULL,
    original_language_id numeric(38),
    rental_duration numeric(38) NOT NULL DEFAULT 3,
    rental_rate decimal(4, 2) NOT NULL DEFAULT 4.99,
    length numeric(38),
    replacement_cost decimal(5, 2) NOT NULL DEFAULT 19.99,
    rating varchar(10) DEFAULT 'G',
    special_features varchar(100),
    last_update timestamp NOT NULL,
    PRIMARY KEY (film_id)
);

ALTER TABLE film
    ADD CONSTRAINT check_special_features CHECK (special_features IS NULL OR special_features LIKE '%Trailers%' OR special_features LIKE '%Commentaries%' OR special_features LIKE '%Deleted Scenes%' OR special_features LIKE '%Behind the Scenes%');

ALTER TABLE film
    ADD CONSTRAINT check_special_rating CHECK (rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17'));

ALTER TABLE film
    ALTER COLUMN FILM_ID SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN TITLE SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN LANGUAGE_ID SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN RENTAL_DURATION SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN RENTAL_RATE SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN REPLACEMENT_COST SET NOT NULL;

ALTER TABLE film
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE film_actor (
    actor_id numeric(38) NOT NULL,
    film_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (actor_id, film_id)
);

ALTER TABLE film_actor
    ALTER COLUMN ACTOR_ID SET NOT NULL;

ALTER TABLE film_actor
    ALTER COLUMN FILM_ID SET NOT NULL;

ALTER TABLE film_actor
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE film_category (
    film_id numeric(38) NOT NULL,
    category_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (film_id, category_id)
);

ALTER TABLE film_category
    ALTER COLUMN FILM_ID SET NOT NULL;

ALTER TABLE film_category
    ALTER COLUMN CATEGORY_ID SET NOT NULL;

ALTER TABLE film_category
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE film_text (
    film_id numeric(38) NOT NULL,
    title varchar(255) NOT NULL,
    description text,
    PRIMARY KEY (film_id)
);

ALTER TABLE film_text
    ALTER COLUMN FILM_ID SET NOT NULL;

ALTER TABLE film_text
    ALTER COLUMN TITLE SET NOT NULL;

CREATE TABLE inventory (
    inventory_id numeric(38) DEFAULT nextval('inventory_sequence'),
    film_id numeric(38) NOT NULL,
    store_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (inventory_id)
);

ALTER TABLE inventory
    ALTER COLUMN INVENTORY_ID SET NOT NULL;

ALTER TABLE inventory
    ALTER COLUMN FILM_ID SET NOT NULL;

ALTER TABLE inventory
    ALTER COLUMN STORE_ID SET NOT NULL;

ALTER TABLE inventory
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE
LANGUAGE (
    language_id numeric(38) DEFAULT nextval('language_sequence'),
    name char(20) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (language_id)
);

ALTER TABLE LANGUAGE
    ALTER COLUMN LANGUAGE_ID SET NOT NULL;

ALTER TABLE LANGUAGE
    ALTER COLUMN NAME SET NOT NULL;

ALTER TABLE LANGUAGE
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE payment (
    payment_id numeric(38) DEFAULT nextval('payment_sequence'),
    customer_id numeric(38) NOT NULL,
    staff_id numeric(38) NOT NULL,
    rental_id numeric(38),
    amount decimal(5, 2) NOT NULL,
    payment_date timestamp NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (payment_id)
);

ALTER TABLE payment
    ALTER COLUMN PAYMENT_ID SET NOT NULL;

ALTER TABLE payment
    ALTER COLUMN CUSTOMER_ID SET NOT NULL;

ALTER TABLE payment
    ALTER COLUMN STAFF_ID SET NOT NULL;

ALTER TABLE payment
    ALTER COLUMN AMOUNT SET NOT NULL;

ALTER TABLE payment
    ALTER COLUMN PAYMENT_DATE SET NOT NULL;

ALTER TABLE payment
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE rental (
    rental_id numeric(38) DEFAULT nextval('rental_sequence'),
    rental_date timestamp NOT NULL,
    inventory_id numeric(38) NOT NULL,
    customer_id numeric(38) NOT NULL,
    return_date timestamp,
    staff_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (rental_id)
);

ALTER TABLE rental
    ALTER COLUMN RENTAL_ID SET NOT NULL;

ALTER TABLE rental
    ALTER COLUMN RENTAL_DATE SET NOT NULL;

ALTER TABLE rental
    ALTER COLUMN INVENTORY_ID SET NOT NULL;

ALTER TABLE rental
    ALTER COLUMN CUSTOMER_ID SET NOT NULL;

ALTER TABLE rental
    ALTER COLUMN STAFF_ID SET NOT NULL;

ALTER TABLE rental
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE staff (
    staff_id numeric(38) DEFAULT nextval('staff_sequence'),
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    address_id numeric(38) NOT NULL,
    picture bytea,
    email varchar(50),
    store_id numeric(38) NOT NULL,
    active numeric(38) NOT NULL DEFAULT 1,
    username varchar(16) NOT NULL,
    "password" varchar(40),
    last_update timestamp NOT NULL,
    PRIMARY KEY (staff_id)
);

ALTER TABLE staff
    ALTER COLUMN STAFF_ID SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN FIRST_NAME SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN LAST_NAME SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN ADDRESS_ID SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN STORE_ID SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN ACTIVE SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN USERNAME SET NOT NULL;

ALTER TABLE staff
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

CREATE TABLE store (
    store_id numeric(38) DEFAULT nextval('store_sequence'),
    manager_staff_id numeric(38) NOT NULL,
    address_id numeric(38) NOT NULL,
    last_update timestamp NOT NULL,
    PRIMARY KEY (store_id)
);

ALTER TABLE store
    ALTER COLUMN STORE_ID SET NOT NULL;

ALTER TABLE store
    ALTER COLUMN MANAGER_STAFF_ID SET NOT NULL;

ALTER TABLE store
    ALTER COLUMN ADDRESS_ID SET NOT NULL;

ALTER TABLE store
    ALTER COLUMN LAST_UPDATE SET NOT NULL;

ALTER TABLE address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE city
    ADD CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE customer
    ADD CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE customer
    ADD CONSTRAINT fk_customer_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film
    ADD CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES LANGUAGE (language_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film
    ADD CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES LANGUAGE (language_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film_actor
    ADD CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film_actor
    ADD CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film_category
    ADD CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE film_category
    ADD CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE inventory
    ADD CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE inventory
    ADD CONSTRAINT fk_inventory_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE payment
    ADD CONSTRAINT fk_payment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE payment
    ADD CONSTRAINT fk_payment_rental FOREIGN KEY (rental_id) REFERENCES rental (rental_id) ON DELETE SET NULL NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE payment
    ADD CONSTRAINT fk_payment_staff FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE rental
    ADD CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE rental
    ADD CONSTRAINT fk_rental_inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE rental
    ADD CONSTRAINT fk_rental_staff FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE staff
    ADD CONSTRAINT fk_staff_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE staff
    ADD CONSTRAINT fk_staff_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE store
    ADD CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE store
    ADD CONSTRAINT fk_store_staff FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

