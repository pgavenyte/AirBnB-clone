require_relative 'database_connection'

class Booking
  attr_reader :id, :people_id, :listing_id, :check_in, :check_out

  def initialize(id, people_id, listing_id, check_in, check_out)
    @id = id
    @people_id = people_id
    @listing_id = listing_id
    @check_in = check_in
    @check_out = check_out
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM booking;")
    result.map { |booking| Booking.new(booking['id'], booking['people_id'], booking['listing_id'], booking['check_in'], booking['check_out']) }
    end

  def self.add(people_id, listing_id, check_in, check_out)
    result = DatabaseConnection.query("INSERT INTO booking (people_id, listing_id, check_in, check_out) VALUES('#{people_id}', '#{listing_id}', '#{check_in}', '#{check_out}') RETURNING id, people_id, listing_id, check_in, check_out;")
    Booking.new(result[0]['id'], result[0]['people_id'], result[0]['listing_id'], result[0]['check_in'], result[0]['check_out'])
  end

  def self.find(people_id)
    return nil unless people_id
    result = DatabaseConnection.query("SELECT * FROM booking WHERE people_id='#{people_id}';")
    result.map { |booking| Booking.new(booking['id'], booking['people_id'], booking['listing_id'], booking['check_in'], booking['check_out']) }
  end

end
