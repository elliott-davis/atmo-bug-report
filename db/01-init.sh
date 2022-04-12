#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;
  CREATE TABLE IF NOT EXISTS restaurants (
    id SERIAL PRIMARY KEY,
    name varchar(250) NOT NULL,
    address varchar(250) NOT NULL,
    phone varchar(250) NOT NULL
  );
  INSERT INTO restaurants(name, address, phone) VALUES ('Le Ciel', '17 rue Alexandre Dumas, 75011 Paris', '(33)664 441 416');

  INSERT INTO restaurants(name, address, phone) VALUES ('A La Renaissance', '87 rue de la Roquette, 75011 Paris', '(33)143 798 309');

  INSERT INTO restaurants(name, address, phone) VALUES ('La Cave de lInsolite', '30 rue de la Folie Méricourt, 75011 Paris', '(33)153 360 833');

  SELECT * FROM restaurants;

  COMMIT;
EOSQL

