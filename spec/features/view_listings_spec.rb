feature 'viewing all the listings' do
  scenario 'a user can see all the spaces' do
    log_in
    add_new_listing
    expect(page).to have_content('Makers Space, A beautiful space, 30, 2020-11-15, 2020-12-10, London')
  end

  scenario 'a user can see available spaces' do
    log_in
    add_new_listing
    add_new_av_listing
    fill_in('filter_from', with: '2021-01-01')
    fill_in('filter_to', with: '2021-01-30')
    click_button('Filter')

    expect(page).to_not have_content('Makers Space, A beautiful space, 30, 2020-11-15, 2020-12-10, London')
    expect(page).to have_content('January Space, A beautiful new year space, 50, 2020-12-31, 2021-02-01, Reading')
  end




end
