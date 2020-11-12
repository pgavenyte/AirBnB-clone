feature 'Test Text' do
  scenario 'hi' do
    visit ('/')
    expect(page).to have_content 'Welcome to MakersBnB!'
  end
end
