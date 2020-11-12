require 'listings'
require 'user'

describe Listings do
  before(:each) do
    @user = User.add("example@email", "password")
  end
  describe '#self.all' do
    it 'shows all the listings' do
      Listings.add(people_id: @user.id, name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')
      listings = Listings.all
      expect(listings.first.name).to eq 'Makers Space'
      expect(listings.first.description).to eq 'A beautiful space'
      expect(listings.first.price).to eq '30'
      expect(listings.first.available_from).to eq '2020-11-15'
      expect(listings.first.available_to).to eq'2020-12-10'
      expect(listings.first.location).to eq'London'
    end
  end

  describe '#self.add' do
    it 'adds a new listing' do
      Listings.add(people_id: @user.id, name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')
      listings = Listings.all

      expect(listings.first.name).to eq 'Makers Space'
      expect(listings.first.description).to eq 'A beautiful space'
      expect(listings.first.price).to eq '30'

    end
  end

  describe '#self.filter' do
    it 'shows available listings' do
      Listings.add(people_id: @user.id, name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')

      Listings.add(people_id: @user.id, name: 'January Space', description: 'A beautiful new year space', price: '50', available_from:'2020-12-31', available_to: '2021-02-01', location: 'Reading')

      listings = Listings.filter('2021-01-01', '2021-01-30')

      expect(listings.first.name).to eq 'January Space'
      expect(listings.first.description).to eq 'A beautiful new year space'
      expect(listings.first.price).to eq '50'

    end
  end

  describe '#self.click' do
    it 'shows all the listings' do
      listing = Listings.add(people_id: @user.id, name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')
  
      
      expect(Listings.click(id: listing.id)[0].id).to eq listing.id
      expect(listing.name).to eq 'Makers Space'
      expect(listing.description).to eq 'A beautiful space'
      expect(listing.price).to eq '30'
      expect(listing.available_from).to eq '2020-11-15'
      expect(listing.available_to).to eq '2020-12-10'
      expect(listing.location).to eq 'London'
    end
  end
end
