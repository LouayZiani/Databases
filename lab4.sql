CREATE DATABASE lab4;

CREATE TABLE Warehouses(
	code integer,
	location varchar(255),
	capacity integer
);

INSERT INTO Warehouses (code, location, capacity) VALUES
	(1, 'Chicago', 3),
	(2, 'Chicago', 4),
	(3, 'New York', 7),
	(4, 'Los Angeles', 2),
	(5, 'San Francisco', 8);


CREATE TABLE Boxes(
	code character(4),
	contents varchar(255),
	value real,
	warehouse integer
);


INSERT INTO Boxes(code, contents, value, warehouse)
	VALUES 
	('0MN7', 'Rocks', 180, 3),
	('4H8P', 'Rocks', 250, 1),
	('4RT3', 'Scissors', 190, 4),
	('7G3H', 'Rocks', 200, 1),
	('8JN6', 'Papers', 75, 1),
	('8Y6U', 'Papers', 50, 3),
	('9J6F', 'Papers', 175, 2),
	('LL08', 'Rocks', 140, 4),
	('P0H6', 'Scissors', 125, 1),
	('P2T6', 'Scissors', 150, 2),
	('TU55', 'Papers', 90, 5);
	
SELECT * FROM Warehouses;



SELECT * FROM Boxes WHERE value>150;



SELECT DISTINCT ON (contents) * FROM Boxes;



--  SELECT WAREHOUSE CODE + NUM OF BOXES IN EACH WH
SELECT warehouse, COUNT(*)
FROM Boxes
GROUP BY warehouse;


-- SELECT WAREHOUSE CODE + NUM OF BOXES IN EACH WH (num of boxes > 2)
SELECT warehouse, COUNT(*)
FROM Boxes WHERE warehouse > 2
GROUP BY warehouse;


INSERT INTO Warehouses (location, capacity) 
VALUES ('New York', 3);

SELECT * FROM Warehouses;



INSERT INTO Boxes (code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200, 2);

SELECT * FROM Boxes;



-- Reduce 3rd largst by 15%
UPDATE Boxes SET value = value - (value*0.15)
WHERE value = (
SELECT DISTINCT value FROM Boxes
ORDER BY value DESC
limit 1 offset 2);

SELECT * FROM Boxes;



-- Remove all boxes with values lower than 150
DELETE * FROM Boxes Where value < 150;



-- Remove all boxes located in New York (return deleted data)
DELETE FROM Boxes WHERE warehouse = (SELECT code FROM Warehouses WHERE location = 'New York' limit 1)
RETURNING *;