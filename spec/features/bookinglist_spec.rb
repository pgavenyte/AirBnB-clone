feature 'viewing a bookings list' do
  scenario 'a user can book a listing and see it in bookings list' do
    log_in
    add_new_listing
    click_link('Makers Space')
    fill_in('date1', with: '2021-01-10')
    fill_in('date2', with: '2021-01-15')
    click_button('Book')
    click_button('My Bookings')
    expect(page).to have_link('Makers Space')
    expect(page).to have_content('Check in: 2021-01-10')
    expect(page).to have_content('Check out: 2021-01-15')
    expect(page).to have_content('Total: £150.00')
  end
end
