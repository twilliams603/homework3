DROP TABLE IF EXISTS entrys;
DROP TABLE IF EXISTS phone_numbers;
DROP TABLE IF EXISTS emails;

CREATE TABLE entrys (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(225),
  last_name VARCHAR(225)
);

CREATE TABLE phone_numbers (
  id INTEGER PRIMARY KEY,
  category VARCHAR(225),
  digits VARCHAR(225),
  name_id INTEGER
);

CREATE TABLE emails (
  id INTEGER PRIMARY KEY,
  category VARCHAR(225),
  address VARCHAR(225),
  name_id INTEGER
);