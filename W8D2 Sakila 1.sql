SELECT 
    *
FROM
    customer
WHERE
    create_date >= 2006 - 01 - 01
;

SELECT 
    *
FROM
    rental
WHERE
    rental_date = 2006 - 01 - 01
;

SELECT 
*
FROM
    rental r
        JOIN
    customer c ON r.customer_id = c.customer_id
WHERE
    rental_date >= '2005-07-25 00:00:00'
        AND rental_date <= '2005-07-31 23:59:59'
;

SELECT DISTINCT
    (SELECT AVG(TIMESTAMPDIFF(DAY,
        rental_date,
        return_date)) from rental) AS avg_length
FROM
    rental
;

SELECT 
    rental_date,
    return_date,
        TIMESTAMPDIFF(DAY,
        rental_date,
        return_date) AS rental_length
FROM
    rental
ORDER BY
	rental_length DESC
;

