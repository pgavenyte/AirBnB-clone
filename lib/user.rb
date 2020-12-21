require 'bcrypt'
require_relative 'database_connection'

class User
  attr_reader :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end

  def self.add(email, password)
    result = DatabaseConnection.query("INSERT INTO people (email, password) VALUES('#{email}', '#{BCrypt::Password.create(password)}') RETURNING id, email;")
    User.new(result[0]['id'], result[0]['email'])
  end

  def self.find(email)
    return nil unless email
    result = DatabaseConnection.query("SELECT email FROM people WHERE email='#{email}';")
    User.new(result[0]['id'], result[0]['email'])
  end

  def self.user_find(id)
    return nil unless id
    result = DatabaseConnection.query("SELECT email FROM people WHERE id='#{id}';")
    User.new(result[0]['id'], result[0]['email'])
  end

  def self.authenticate(email, password)
    result = DatabaseConnection.query("SELECT * FROM people WHERE email='#{email}';")
    return nil unless result.any?
    return nil unless BCrypt::Password.new(result[0]['password']) == password
    User.new(result[0]['id'], result[0]['email'])
  end

  #validates if the provided string/password is the same
  def self.validate(password1, password2)
    password1 == password2
  end


end
