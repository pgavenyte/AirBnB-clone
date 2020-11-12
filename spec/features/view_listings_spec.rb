feature 'viewing all the listings' do
  scenario 'a user can see all the spaces' do
    log_in
    add_new_listing
    add_new_av_listing
    expect(page).to have_link('Makers Space')
    expect(page).to have_link('January Space')
  end

  scenario 'a user can see available spaces' do
    log_in
    add_new_listing
    add_new_av_listing
    fill_in('filter_from', with: '2021-01-01')
    fill_in('filter_to', with: '2021-01-30')
    click_button('Filter')

    expect(page).to_not have_content('Makers Space')
    expect(page).to have_content('January Space')
  end

  scenario 'a user can click on a specific listing' do

    log_in
    add_new_listing

    con = PG.connect(dbname: 'makers_bnb_test')
    result = con.exec("SELECT * FROM listing;")

    click_link('Makers Space')

    expect(current_path).to eq "/#{result[0]['id']}"
    expect(page).to have_content('You are viewing:')
  end


  scenario 'a user cannot see available spaces if filter from is later than filter to' do
    visit('/listings')
    fill_in('filter_from', with: '2021-01-15')
    fill_in('filter_to', with: '2021-01-10')
    click_button('Filter')

    expect(page).to have_content('Choose appropriate filter dates')
  end




end
