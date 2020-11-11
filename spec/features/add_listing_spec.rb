feature 'add a new listings' do
  scenario 'a user can add a new space' do

    log_in
    add_new_listing

    expect(page).to have_content("Makers Space, A beautiful space, 30, 2020-11-15, 2020-12-10, London")
  end
end
