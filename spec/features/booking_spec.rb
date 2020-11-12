feature 'Booking a space' do
  scenario 'A user can book a space' do
    log_in
    add_new_listing
    click_link('Makers Space')
    fill_in('date1', with: '2021-01-10')
    fill_in('date2', with: '2021-01-15')
    click_button('Book')
    expect(current_path).to eq '/listings'
    expect(page).to have_content "Your request has been sent"
  end
  scenario "user cannot book a space unless logged in" do
    log_in
    add_new_listing
    click_button('Logout')
    click_button('View Listings')
    click_link('Makers Space')
    fill_in('date1', with: '2021-01-10')
    fill_in('date2', with: '2021-01-15')
    click_button('Book')
    expect(page).to have_content "Please login to book a space"
  end

  scenario 'A user cannot book overlapping dates' do
    log_in
    add_new_listing
    click_link('Makers Space')
    fill_in('date1', with: '2021-01-15')
    fill_in('date2', with: '2021-01-10')
    click_button('Book')
    expect(page).to have_content "Choose appropriate booking dates"
  end
end
