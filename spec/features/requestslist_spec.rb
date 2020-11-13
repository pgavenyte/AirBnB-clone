feature 'viewing a requests list' do
  scenario 'a user can see a listing of bookings for his/her spaces' do
    log_in
    add_new_listing
    click_link('Makers Space')
    fill_in('date1', with: '2021-01-10')
    fill_in('date2', with: '2021-01-15')
    click_button('Book')
    click_button('My Requests')
    expect(current_path).to eq '/requests'
    expect(page).to have_link('Makers Space')
    expect(page).to have_content('Check in: 2021-01-10')
    expect(page).to have_content('Check out: 2021-01-15')
    expect(page).to have_content('Guest: examplar@email')
    expect(page).to have_content('Total: £150.00')
  end
end
