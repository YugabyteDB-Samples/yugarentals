module.exports = {
  oracle: {
    getRecentRentals: `select r.rental_date, f.title, c.first_name, c.last_name 
        FROM rental r, customer c, inventory i, film f 
        where r.customer_id = c.customer_id 
        AND r.inventory_id = i.inventory_id 
        AND i.film_id = f.film_id 
        ORDER BY r.RENTAL_ID DESC
        FETCH FIRST 20 ROWS WITH TIES`,
    getSalesByFilmCategory: `select * from sales_by_film_category ORDER BY category asc`,
    createRental: `INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id) VALUES (:rental_date, :inventory_id, :customer_id, :return_date, :staff_id) RETURNING rental_id INTO :ids`,
    createPayment: `INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date) VALUES (:customer_id, :staff_id, :rental_id, :amount, :payment_date)`,
  },

  yugabyte: {
    getRecentRentals: `select r.rental_date, f.title, c.first_name, c.last_name
    FROM (select * from rental ORDER BY rental_id DESC LIMIT 20) as r
    INNER JOIN customer c 
    ON c.customer_id = r.customer_id
    INNER JOIN inventory i
    ON r.inventory_id = i.inventory_id
    INNER JOIN film f
    ON i.film_id = f.film_id`,
    getSalesByFilmCategory: `select * from sales_by_film_category ORDER BY category asc`,
    createRental: `INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id) VALUES ($1,$2,$3,$4,$5) returning rental_id`,
    createPayment: `INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date) VALUES ($1,$2,$3,$4,$5)`,
    refreshSalesByFilmCategory: `REFRESH MATERIALIZED VIEW sales_by_film_category`,
  },
};
