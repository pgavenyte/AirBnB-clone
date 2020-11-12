require_relative 'database_connection'

class Booking
  attr_reader :id, :people_id, :listing_id

  def initialize(id, people_id, listing_id)
    @id = id
    @people_id = people_id
    @listing_id = listing_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM booking;")
    result.map { |booking| Booking.new(booking['id'], booking['people_id'], booking['listing_id']) }
    end

  def self.add(people_id, listing_id)
    result = DatabaseConnection.query("INSERT INTO booking (people_id, listing_id) VALUES('#{people_id}', '#{listing_id}') RETURNING id, people_id, listing_id;")
    Booking.new(result[0]['id'], result[0]['people_id'], result[0]['listing_id'])
  end

  def self.find(people_id)
    return nil unless people_id
    result = DatabaseConnection.query("SELECT * FROM booking WHERE people_id='#{people_id}';")
    result.map { |booking| Booking.new(booking['id'], booking['people_id'], booking['listing_id']) }
  end

end
