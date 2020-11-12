feature 'viewing all the listings' do
  scenario 'a user can see all the spaces' do

    listing = Listings.add(name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')

    visit('/listings')

    expect(page).to have_link('Makers Space')
  end

  scenario 'a user can see available spaces' do

    Listings.add(name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')

    Listings.add(name: 'January Space', description: 'A beautiful new year space', price: '50', available_from:'2020-12-31', available_to: '2021-02-01', location: 'Reading')

    Listings.add(name: 'Space', description: 'A beautiful new year space', price: '50', available_from:'2021-02-26', available_to: '2021-03-01', location: 'Reading')

    visit('/listings')
    fill_in('filter_from', with: '2021-01-01')
    fill_in('filter_to', with: '2021-01-30')
    click_button('Filter')

    expect(page).to_not have_content('Makers Space, A beautiful space, 30, 2020-11-15, 2020-12-10, London')
    expect(page).to have_content('January Space, A beautiful new year space, 50, 2020-12-31, 2021-02-01, Reading')
    expect(page).to_not have_content('Space, A beautiful new year space, 50, 2021-02-26, 2021-03-01, Reading')
  end

  scenario 'a user can click on a specific listing' do

    listing = Listings.add(name: 'Makers Space', description: 'A beautiful space', price: '30', available_from:'2020-11-15', available_to: '2020-12-10', location: 'London')

    visit('/listings')
    click_link('Makers Space')
    
    expect(current_path).to eq "/#{listing.id}"
    expect(page).to have_content('You are viewing:')
  end


end
