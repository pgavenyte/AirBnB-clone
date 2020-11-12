feature 'add a new listings' do
  scenario 'a user can add a new space' do

    log_in
    add_new_listing

    expect(page).to have_content("Makers Space")
    expect(page).to have_content("A beautiful space")
    expect(page).to have_content("30")
    expect(page).to have_content("2020-11-15 to 2020-12-10")
    expect(page).to have_content("London")
  end

  scenario 'a user cannot add a new space available from is later than available to' do

    log_in
    add_false_listing

    expect(page).to have_content("Choose appropriate availability dates")
  end

  scenario 'a user cannot add a new space available from is later than available to' do

    visit '/listings'
    add_new_listing
    expect(current_path).to eq('/users/new')
    expect(page).to have_content("Please login to add listing")
  end
end
