require_relative 'database_connection'
require 'date'

class Listings
  attr_reader :id, :people_id ,:name, :description, :price, :available_from, :available_to, :location

  def initialize(id:, people_id: ,name:, description:, price:, available_from:, available_to:, location:)
    @id = id
    @people_id = people_id
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
      Listings.new(id: listing['id'], people_id: listing['people_id'], name: listing['name'], description: listing['description'], price: listing['price'], available_from: listing['av_from'], available_to: listing['av_to'], location: listing['location'])
    end
  end

  def self.filter(filter_from, filter_to)
    result = DatabaseConnection.query("SELECT * FROM listing WHERE av_from < '#{filter_from}' AND av_to > '#{filter_to}';")
    result.map do |listing|
      Listings.new(id: listing['id'], people_id: listing['people_id'], name: listing['name'], description: listing['description'], price: listing['price'], available_from: listing['av_from'], available_to: listing['av_to'], location: listing['location'])
    end
  end


  def self.add(people_id:, name:, description:, price:, available_from:, available_to:, location:)
    result = DatabaseConnection.query("INSERT INTO listing (people_id, name, description, price, av_from, av_to, location) VALUES('#{people_id}','#{name}', '#{description}', '#{price}', '#{available_from}', '#{available_to}', '#{location}') RETURNING id, people_id, name, description, price, av_from, av_to, location;")
    Listings.new(id: result[0]['id'], people_id: result[0]['people_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], available_from: result[0]['av_from'], available_to: result[0]['av_to'], location: result[0]['location'])
  end

  def self.click(id:)
    result = DatabaseConnection.query("SELECT * FROM listing WHERE id = '#{id}';")
    result.map do |listing|
      Listings.new(id: listing['id'], people_id: listing['people_id'], name: listing['name'], description: listing['description'], price: listing['price'], available_from: listing['av_from'], available_to: listing['av_to'], location: listing['location'])
    end
  end
end
