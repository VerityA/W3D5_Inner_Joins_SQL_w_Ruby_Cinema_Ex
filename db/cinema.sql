DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price NUMERIC
);

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds NUMERIC
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  show_time VARCHAR(255),
  screen_num INT4,
  max_capacity INT4
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);

-- SELECT films.id, COUNT(tickets.screening_id) as screening_count
-- FROM films LEFT JOIN tickets
-- ON films.id = tickets.screening_id
-- GROUP BY
