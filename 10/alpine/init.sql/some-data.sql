CREATE DATABASE testdb;


\connect testdb


CREATE TABLE weather (
  city varchar(80),
  temp_lo int, temp_hi int,
  prcp float8,
  date date);

CREATE TABLE cities (
  name varchar(80),
  location point);


INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '11/27/1994');
INSERT INTO cities VALUES ('San Francisco', '(-194.0, 53.0)');
INSERT INTO weather (date, city, temp_hi, temp_lo) VALUES ('11/29/1994', 'Hayward', 54, 37);
