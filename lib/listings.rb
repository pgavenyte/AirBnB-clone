require_relative 'database_connection'
require 'date'

class Listings
  attr_reader :name, :description, :price, :available_from, :available_to, :location

  def initialize(name:, description:, price:, available_from:, available_to:, location:)
    @name = name
    @description = description
    @price = price 
    @available_from = available_from
    @available_to = available_to
    @location = location
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listing;")
    result.map do |listing|
      Listings.new(name: listing['name'], description: listing['description'], price: listing['price'], available_from: listing['av_from'], available_to: listing['av_to'], location: listing['location'])
    end
  end

  def self.filter(filter_from, filter_to)
    from = filter_from.to_s
    to = filter_to.to_s
    result = DatabaseConnection.query("SELECT * FROM listing WHERE av_from <= '#{from}' AND av_to >= '#{to}';")
    result.map do |listing|
      Listings.new(name: listing['name'], description: listing['description'], price: listing['price'], available_from: listing['av_from'], available_to: listing['av_to'], location: listing['location'])
    end
  end

  def self.add(name:, description:, price:, available_from:, available_to:, location:)
    result = DatabaseConnection.query("INSERT INTO listing (name, description, price, av_from, av_to, location) VALUES('#{name}', '#{description}', '#{price}', '#{available_from}', '#{available_to}', '#{location}') RETURNING name, description, price, av_from, av_to, location;")
    Listings.new(name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], available_from: result[0]['av_from'], available_to: result[0]['av_to'], location: result[0]['location'])
  end

end


# connection1.exec("CREATE TABLE listing (id SERIAL PRIMARY KEY, people_id INTEGER REFERENCES people (id), name  VARCHAR(60), description VARCHAR, price INT, av_from DATE, av_to DATE, location VARCHAR(60));")
#connection.exec("INSERT INTO peeps (message, date) VALUES('#{peep}', '#{time}') RETURNING message, date;")