require 'pg'

task :setup do
  connection = PG.connect
  connection.exec('CREATE DATABASE makers_bnb;')
  connection = PG.connect :dbname => 'makers_bnb';
  connection.exec("CREATE TABLE people (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(60));")
  connection.exec("CREATE TABLE listing (id SERIAL PRIMARY KEY, people_id INTEGER REFERENCES people (id), name  VARCHAR(60), description VARCHAR, price INT, av_from DATE, av_to DATE, location VARCHAR(60));")
  connection.exec("CREATE TABLE booking (id SERIAL PRIMARY KEY, people_id INTEGER REFERENCES people (id), listing_id INTEGER REFERENCES listing (id));")

  connection1 = PG.connect
  connection1.exec('CREATE DATABASE makers_bnb_test;')
  connection1 = PG.connect :dbname => 'makers_bnb_test';
  connection1.exec("CREATE TABLE people (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(60));")
  connection1.exec("CREATE TABLE listing (id SERIAL PRIMARY KEY, people_id INTEGER REFERENCES people (id), name  VARCHAR(60), description VARCHAR, price INT, av_from DATE, av_to DATE, location VARCHAR(60));")
  connection.exec("CREATE TABLE booking (id SERIAL PRIMARY KEY, people_id INTEGER REFERENCES people (id), listing_id INTEGER REFERENCES listing (id));")
end
