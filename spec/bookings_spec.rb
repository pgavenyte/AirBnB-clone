require_relative '../lib/bookings'
require_relative '../lib/user'
require_relative '../lib/listings'
describe Booking do
  before(:each) do
    @user = User.add("example@email", "password")
    @listing = Listings.add(people_id: @user.id, name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')
    @booking = Booking.add(@user.id, @listing.id, '2020-11-20', '2020-11-23')
  end
  describe ".all" do
    it "displays all the bookings within databse" do
      expect(Booking.all.size).to eq 1
      expect(Booking.all[0].id).to eq @booking.id
      expect(Booking.all[0].people_id).to eq @booking.people_id
      expect(Booking.all[0].listing_id).to eq @booking.listing_id
      expect(Booking.all[0].check_in).to eq @booking.check_in
      expect(Booking.all[0].check_out).to eq @booking.check_out
    end
  end
  describe "#add" do
    it "creates new booking for an existing user" do
      expect(@booking).to be_a Booking
      expect(@booking.people_id).to eq @user.id
      expect(@booking.listing_id).to eq @listing.id
    end
  end
  describe "#find" do
    it "returns empty array if people_id doesn't exist, i.e. no bookings for that user" do
      @user1 = User.add("example@email1", "password1")
      expect(Booking.find(@user1.id)).to be_empty
    end
    it "returns array of user's bookings " do
      expect(Booking.find(@user.id)[0].id).to eq(@booking.id)
      expect(Booking.find(@user.id)[0].people_id).to eq(@booking.people_id)
      expect(Booking.find(@user.id)[0].listing_id).to eq(@booking.listing_id)
      expect(Booking.find(@user.id)[0].check_in).to eq('2020-11-20')
      expect(Booking.find(@user.id)[0].check_out).to eq('2020-11-23')
    end
  end
  describe "#requests_find" do
    it "returns empty array if people_id doesn't exist, i.e. no request for that user" do
      @user1 = User.add("example@email1", "password1")
      expect(Booking.requests_find(@user1.id)).to be_empty
    end
    it "returns array of user's requests" do
      expect(Booking.requests_find(@user.id)[0].id).to eq(@booking.listing_id)
      expect(Booking.requests_find(@user.id)[0].people_id).to eq(@booking.people_id)
      expect(Booking.requests_find(@user.id)[0].listing_id).to eq(@booking.listing_id)
      expect(Booking.requests_find(@user.id)[0].check_in).to eq('2020-11-20')
      expect(Booking.requests_find(@user.id)[0].check_out).to eq('2020-11-23')
    end
  end
end
