--DISTINCT
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth; --Without the duplication

SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Russia' OR country_of_birth = 'China');


SELECT 1<>2;

--LIMIT / OFFSET
SELECT * FROM person LIMIT 10;
SELECT * FROM person OFFSET 10 LIMIT 5;

SELECT * FROM person OFFSET 5 FETCH FIRST 5 ROWS ONLY; -- the real sql code for limt

--OR
SELECT * FROM person WHERE country_of_birth = 'France' OR country_of_birth = 'China' OR country_of_birth = 'Brazil';
SELECT * FROM person WHERE country_of_birth IN ('France','China','Brazil') ORDER BY country_of_birth;
--

--BETWEEN
SELECT * FROM person WHERE date_of_birth  BETWEEN DATE '2021-10-01' AND DATE '2021-12-1';
SELECT * FROM car;

--ILIKE/LIKE
SELECT * FROM person WHERE email LIKE '%yahoo.com';
SELECT * FROM person WHERE email LIKE '%google.%';
SELECT * FROM person WHERE country_of_birth ILIKE 'p%';
SELECT * FROM person WHERE email LIKE '______@%'; --The number of the characters that you  want to much

--GROUP BY
SELECT country_of_birth,count(*) FROM person GROUP BY country_of_birth ORDER BY country_of_birth;
SELECT  first_name,count(*) FROM person GROUP BY first_name ORDER BY first_name;

--HAVING
SELECT country_of_birth,count(*) FROM person GROUP BY country_of_birth HAVING count(*) > 40 ORDER BY country_of_birth;

--MAX / MIN / AVG / ROUND


SELECT MAX(price) FROM car; 
SELECT MIN(price) FROM car; 
-- SELECT round(price) FROM car; 

SELECT  make, MIN(price) FROM car WHERE make ilike 'BMW' GROUP BY make; -- ka ugu yar chevrlot lacta
SELECT make ,model, MIN(price) FROM car GROUP BY make,model;

SELECT SUM(price) FROM car;

SELECT make , SUM(price) FROM car GROUP BY make ORDER BY SUM(price) DESC;

SELECT id,make,model,price,price * .10 as discount FROM car  ;
SELECT id,make,model,price,price * .10 as discount , price - (price * .10) as without_discount FROM car;

SELECT COALESCE (1) AS number;

SELECT COALESCE(email,'Email not provided') FROM person;



SELECT 10/NULLIF(1  ,1);

SELECT COALESCE(10/NULLIF(0,0),3232);


SELECT NOW()::DATE;
SELECT NOW() - INTERVAL '1 YEAR';

SELECT (NOW() - INTERVAL '2 DAY')::DATE;

SELECT EXTRACT(DOW FROM NOW());
SELECT EXTRACT(CENTURY FROM NOW());

SELECT first_name , last_name , country_of_birth , date_of_birth , NOW() - date_of_birth AS age FROM person;
SELECT date_of_birth::DATE FROM person;

SELECT AGE( NOW(), '2011-06-24'); 

SELECT first_name , last_name , country_of_birth , date_of_birth , AGE(NOW(), date_of_birth) AS age FROM person;

--ADD CONSTRAINT/ DROP CONSTRAINT
ALTER TABLE person DROP CONSTRAINT ;
ALTER TABLE person ADD PRIMARY KEY (id);

-- ALTER TABLE person ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE person ADD  UNIQUE (email);

SELECT email , count(*) FROM person GROUP BY email;
SELECT email , count(*) FROM person GROUP BY email HAVING count(*) > 1;

--CHECK , gender if female or male you can enter female or male only
ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK (gender = 'Male' OR gender = 'Female');

SELECT DISTINCT gender FROM person;
SELECT * FROM person;

UPDATE person SET last_name = 'Hassan' , email = 'mohahassankunle@gmail.com' , gender = 'Male' , date_of_birth = '1998-10-29' , country_of_birth = 'Somaliland' WHERE id = 1;

SELECT * FROM person  WHERE id = 7;


--ON CONFLICT DO NOTHING = means if there is error dont throw nothing
Insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth)
 values (7,'Jacinta', 'Borg', 'jborg6@engadget.com', 'Male', '2021-08-24', 'Sweden') ON CONFLICT (id) DO NOTHING;

--This means haddi conflict id ga ka dhaco update gare wixii la badalay
 Insert into person (id,first_name, last_name, email, gender, date_of_birth, country_of_birth)
 values (7,'Jacinta', 'Borg', 'jborg6@engadget.so', 'Male', '2021-08-24', 'Sweden') ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;


 --FOREIGN KEY 

 create table person (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	email text ,
	gender text NOT NULL,
	date_of_birth DATE  NOT NULL,
	country_of_birth text NOT NULL,
    car_id BIGINT REFERENCES car (id),
    UNIQUE(car_id)
);

create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make TEXT NOT NULL ,
	model TEXT NOT NULL,
	price NUMERIC(19,2) NOT NULL
);



SELECT * FROM person ORDER BY id;
SELECT * FROM car;

--ADD FOREIGN key
UPDATE person SET car_id = 3 WHERE id = 2;

--JOIN THE TWO TABLES
SELECT * FROM person JOIN car ON person.car_id = car.id; 

SELECT person.first_name , car.make, car.model,car.price FROM person JOIN car ON person.car_id = car.id;
SELECT*  FROM person LEFT JOIN car ON person.car_id = car.id;
SELECT*  FROM person LEFT JOIN car USING(id);

SELECT * FROM person WHERE person.car_id IS NULL;

SELECT * FROM person LEFT JOIN car ON person.car_id =  car.id WHERE car.* IS NULL;

 \copy (SELECT * FROM person LEFT JOIN car ON car.id = person.car_id) TO '/Users/Kunle/Desktop/results.csv' DELIMITER ',' CSV HEADER;


 

insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Kitty', 'Whichelow', null, 'Female', '2021-07-10', 'Uruguay');
insert into car (id, make, model, price) values (36, 'Land Rover', 'Discovery Series II', '86620.91');


SELECT * FROM person;

--REST SEQUENCE
 ALTER SEQUENCE person_id_seq RESTART WITH 10;    