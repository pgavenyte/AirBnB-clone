feature 'sing up to the websit' do
  scenario 'user succesuflly signs up ' do
    visit ('/users/new')
    fill_in('email', with: 'examplar@email')
    fill_in('password', with: 'password')
    fill_in('confirm_pass', with: 'password')
    fill_in "day", with: "1999-12-12"
    click_button('Submit')
    expect(current_path).to eq '/users'
  end

  scenario 'user unsuccesuflly signs up ' do
    visit ('/users/new')
    fill_in('email', with: 'examplar@email')
    fill_in('password', with: 'password')
    fill_in('confirm_pass', with: 'password1')
    fill_in "day", with: "1999-12-12"
    click_button('Submit')
    expect(current_path).to eq '/users/new'
  end

end
