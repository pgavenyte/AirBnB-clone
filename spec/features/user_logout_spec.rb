
feature 'Logout from the website' do
  scenario 'succesuflly logout from an existing account' do
    visit ('/sessions/destroy')
    click_button 'Logout'
    expect(page).to have_content 'You are successfully logout '

  end
end
