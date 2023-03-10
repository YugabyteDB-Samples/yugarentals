DROP TRIGGER IF EXISTS actor_before_trigger ON actor CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_actor_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_actor_before_trigger() FROM PUBLIC;
CREATE TRIGGER actor_before_trigger
    BEFORE INSERT ON actor
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_actor_before_trigger ();

DROP TRIGGER IF EXISTS actor_before_update ON actor CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_actor_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_actor_before_update() FROM PUBLIC;
CREATE TRIGGER actor_before_update
    BEFORE UPDATE ON actor
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_actor_before_update ();

DROP TRIGGER IF EXISTS address_before_trigger ON address CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_address_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_address_before_trigger() FROM PUBLIC;
CREATE TRIGGER address_before_trigger
    BEFORE INSERT ON address
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_address_before_trigger ();

DROP TRIGGER IF EXISTS address_before_update ON address CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_address_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_address_before_update() FROM PUBLIC;
CREATE TRIGGER address_before_update
    BEFORE UPDATE ON address
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_address_before_update ();

DROP TRIGGER IF EXISTS category_before_trigger ON category CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_category_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_category_before_trigger() FROM PUBLIC;
CREATE TRIGGER category_before_trigger
    BEFORE INSERT ON category
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_category_before_trigger ();

DROP TRIGGER IF EXISTS category_before_update ON category CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_category_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_category_before_update() FROM PUBLIC;
CREATE TRIGGER category_before_update
    BEFORE UPDATE ON category
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_category_before_update ();

DROP TRIGGER IF EXISTS city_before_trigger ON city CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_city_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_city_before_trigger() FROM PUBLIC;
CREATE TRIGGER city_before_trigger
    BEFORE INSERT ON city
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_city_before_trigger ();

DROP TRIGGER IF EXISTS city_before_update ON city CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_city_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_city_before_update() FROM PUBLIC;
CREATE TRIGGER city_before_update
    BEFORE UPDATE ON city
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_city_before_update ();

DROP TRIGGER IF EXISTS country_before_trigger ON country CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_country_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_country_before_trigger() FROM PUBLIC;
CREATE TRIGGER country_before_trigger
    BEFORE INSERT ON country
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_country_before_trigger ();

DROP TRIGGER IF EXISTS country_before_update ON country CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_country_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_country_before_update() FROM PUBLIC;
CREATE TRIGGER country_before_update
    BEFORE UPDATE ON country
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_country_before_update ();

DROP TRIGGER IF EXISTS customer_before_trigger ON customer CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_customer_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    NEW.create_date := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_customer_before_trigger() FROM PUBLIC;
CREATE TRIGGER customer_before_trigger
    BEFORE INSERT ON customer
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_customer_before_trigger ();

DROP TRIGGER IF EXISTS customer_before_update ON customer CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_customer_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_customer_before_update() FROM PUBLIC;
CREATE TRIGGER customer_before_update
    BEFORE UPDATE ON customer
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_customer_before_update ();

DROP TRIGGER IF EXISTS film_actor_before_trigger ON film_actor CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_actor_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_actor_before_trigger() FROM PUBLIC;
CREATE TRIGGER film_actor_before_trigger
    BEFORE INSERT ON film_actor
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_actor_before_trigger ();

DROP TRIGGER IF EXISTS film_actor_before_update ON film_actor CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_actor_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_actor_before_update() FROM PUBLIC;
CREATE TRIGGER film_actor_before_update
    BEFORE UPDATE ON film_actor
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_actor_before_update ();

DROP TRIGGER IF EXISTS film_before_trigger ON film CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_before_trigger() FROM PUBLIC;
CREATE TRIGGER film_before_trigger
    BEFORE INSERT ON film
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_before_trigger ();

DROP TRIGGER IF EXISTS film_before_update ON film CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_before_update() FROM PUBLIC;
CREATE TRIGGER film_before_update
    BEFORE UPDATE ON film
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_before_update ();

DROP TRIGGER IF EXISTS film_category_before_trigger ON film_category CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_category_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_category_before_trigger() FROM PUBLIC;
CREATE TRIGGER film_category_before_trigger
    BEFORE INSERT ON film_category
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_category_before_trigger ();

DROP TRIGGER IF EXISTS film_category_before_update ON film_category CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_film_category_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_film_category_before_update() FROM PUBLIC;
CREATE TRIGGER film_category_before_update
    BEFORE UPDATE ON film_category
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_film_category_before_update ();

DROP TRIGGER IF EXISTS inventory_before_trigger ON inventory CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_inventory_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_inventory_before_trigger() FROM PUBLIC;
CREATE TRIGGER inventory_before_trigger
    BEFORE INSERT ON inventory
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_inventory_before_trigger ();

DROP TRIGGER IF EXISTS inventory_before_update ON inventory CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_inventory_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_inventory_before_update() FROM PUBLIC;
CREATE TRIGGER inventory_before_update
    BEFORE UPDATE ON inventory
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_inventory_before_update ();

DROP TRIGGER IF EXISTS language_before_trigger ON LANGUAGE CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_language_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_language_before_trigger() FROM PUBLIC;
CREATE TRIGGER language_before_trigger
    BEFORE INSERT ON
    LANGUAGE
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_language_before_trigger ();

DROP TRIGGER IF EXISTS language_before_update ON LANGUAGE CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_language_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_language_before_update() FROM PUBLIC;
CREATE TRIGGER language_before_update
    BEFORE UPDATE ON
    LANGUAGE
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_language_before_update ();

DROP TRIGGER IF EXISTS payment_before_trigger ON payment CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_payment_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_payment_before_trigger() FROM PUBLIC;
CREATE TRIGGER payment_before_trigger
    BEFORE INSERT ON payment
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_payment_before_trigger ();

DROP TRIGGER IF EXISTS payment_before_update ON payment CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_payment_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_payment_before_update() FROM PUBLIC;
CREATE TRIGGER payment_before_update
    BEFORE UPDATE ON payment
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_payment_before_update ();

DROP TRIGGER IF EXISTS rental_before_trigger ON rental CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_rental_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_rental_before_trigger() FROM PUBLIC;
CREATE TRIGGER rental_before_trigger
    BEFORE INSERT ON rental
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_rental_before_trigger ();

DROP TRIGGER IF EXISTS rental_before_update ON rental CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_rental_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_rental_before_update() FROM PUBLIC;
CREATE TRIGGER rental_before_update
    BEFORE UPDATE ON rental
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_rental_before_update ();

DROP TRIGGER IF EXISTS staff_before_trigger ON staff CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_staff_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_staff_before_trigger() FROM PUBLIC;
CREATE TRIGGER staff_before_trigger
    BEFORE INSERT ON staff
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_staff_before_trigger ();

DROP TRIGGER IF EXISTS staff_before_update ON staff CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_staff_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_staff_before_update() FROM PUBLIC;
CREATE TRIGGER staff_before_update
    BEFORE UPDATE ON staff
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_staff_before_update ();

DROP TRIGGER IF EXISTS store_before_trigger ON store CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_store_before_trigger ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_store_before_trigger() FROM PUBLIC;
CREATE TRIGGER store_before_trigger
    BEFORE INSERT ON store
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_store_before_trigger ();

DROP TRIGGER IF EXISTS store_before_update ON store CASCADE;

CREATE OR REPLACE FUNCTION trigger_fct_store_before_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    NEW.last_update := CURRENT_DATE;
    RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql'
SECURITY DEFINER;

-- REVOKE ALL ON FUNCTION trigger_fct_store_before_update() FROM PUBLIC;
CREATE TRIGGER store_before_update
    BEFORE UPDATE ON store
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_fct_store_before_update ();

