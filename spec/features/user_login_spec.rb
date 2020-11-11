feature 'login in  to the websit' do
  scenario "succesuflly login to an existing account" do
    visit ('/users/new')
    click_button('Login')
    fill_in('email', with: 'examplar@email')
    fill_in('password', with: 'pass')
    click_button('Login')
    expect(current_path).to eq '/sessions'
  end

  scenario "unsuccesuflly login to an existing account with faulty username" do
    visit ('/users/new')
    click_button('Login')
    fill_in('email', with: 'fake@email')
    fill_in('password', with: 'password')
    click_button('Login')
    expect(current_path).to eq '/sessions/new'
  end

end
