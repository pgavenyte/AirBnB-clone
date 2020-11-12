require 'bcrypt'
require 'pg'
require_relative './database_connection'

def connection
  if ENV['RACK_ENV'] == 'test'
    DatabaseConnection.setup('makers_bnb_test')
  else
    DatabaseConnection.setup('makers_bnb')
  end
end

def add_row_to_test_database
  DatabaseConnection.setup('makers_bnb_test')
  DatabaseConnection.query("INSERT INTO people (email, password) values ('examplar@email', '#{BCrypt::Password.create("pass")}');")
end

def setup_test_database
  DatabaseConnection.query("TRUNCATE people, listing;")
end
