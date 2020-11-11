feature 'add a new listings' do
  scenario 'a user can add a new space' do

    visit '/listings/new'

    fill_in('name', with: 'Makers Space')
    fill_in('location', with: 'London')
    fill_in('description', with: 'A beautiful space')
    fill_in('price', with: '30')
    fill_in('available_from', with: '2020-11-15')
    fill_in('available_to', with: '2020-12-10')
    click_button 'Add'

    expect(page).to have_content("Makers Space, A beautiful space, 30, 2020-11-15, 2020-12-10, London")
  end
end
