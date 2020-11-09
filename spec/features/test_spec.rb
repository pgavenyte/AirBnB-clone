feature 'Test Text' do
  scenario 'hi' do
    visit ('/')
    expect(page).to have_content 'Hello World.'
  end
end
