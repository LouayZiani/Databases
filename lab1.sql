CREATE DATABASE lab1;


CREATE TABLE users (
	id serial,
	firstname varchar(50),
	lastname varchar(50)

);


ALTER TABLE users
	ADD COLUMN isadmin integer
	
	
	
ALTER TABLE users
	ALTER COLUMN isadmin TYPE boolean USING (isadmin::boolean);
	


ALTER TABLE users
	ALTER COLUMN isadmin SET DEFAULT false;



ALTER TABLE users
	ADD CONSTRAINT pk_users PRIMARY KEY (id);
	

CREATE TABLE tasks(
	id serial,
	name varchar(50),
	user_id integer
);

DROP TABLE tasks;

DROP DATABASE lab1;