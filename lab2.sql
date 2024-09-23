CREATE DATABASE lab2;

CREATE TABLE countries (
  country_id SERIAL PRIMARY KEY,
  country_name varchar(255),
  region_id int,
  population int
);

SELECT * FROM countries;

INSERT INTO countries values (4, 'Morocco' ,212, 40000000);

INSERT INTO countries (country_id,country_name) VALUES (2,'Kazakhstan');

UPDATE countries SET region_id = NULL ;

INSERT INTO countries (country_id, country_name,region_id,population )
    values (3 ,'USA',1,1200000),
           (19 ,'Algeria',213,24000000),
           (5 ,'France',33,5800000);

SELECT * FROM countries;

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';


INSERT INTO countries values (7, default ,88, 123456);

SELECT * FROM countries;

INSERT INTO countries (country_id , country_name, region_id, population)
	values (default, default, default , default);

CREATE TABLE countries_new(
  LIKE countries
);


INSERT INTO countries_new
	SELECT * FROM countries;

SELECT * FROM countries_new;


UPDATE countries_new SET region_id = 1 WHERE region_id IS NULL;



UPDATE countries_new SET population = population + (population*0.1)
    RETURNING country_name, population AS "New Population";


DELETE FROM countries WHERE population < 100000;


DELETE FROM countries_new
	AS frstc USING countries AS scndc
	WHERE frstc.country_id = scndc.country_id
	RETURNING *;

SELECT * FROM countries_new;

DELETE FROM countries
	RETURNING *;