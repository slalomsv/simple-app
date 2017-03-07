CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
CREATE TABLE IF NOT EXISTS players (
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL   
);
INSERT INTO players VALUES ( "Stephen", "Curry" );
INSERT INTO players VALUES ( "Klay", "Thompson" );
INSERT INTO players VALUES ( "Kevin", "Durant" );
INSERT INTO players VALUES ( "Draymond", "Green" );
INSERT INTO players VALUES ( "Zaza", "Pachulia" );
