 # helper for login
def log_in
  visit ('/users/new')
  click_button('Login')
  fill_in('email', with: 'examplar@email')
  fill_in('password', with: 'pass')
  click_button('Login')
end

def add_new_listing
  click_button('Add new listing')
  fill_in('name', with: 'Makers Space')
  fill_in('location', with: 'London')
  fill_in('description', with: 'A beautiful space')
  fill_in('price', with: '30')
  fill_in('available_from', with: '2020-11-15')
  fill_in('available_to', with: '2020-12-10')
  click_button 'Add'
end

def add_new_av_listing
  click_button('Add new listing')
  fill_in('name', with: 'January Space')
  fill_in('location', with: 'Reading')
  fill_in('description', with: 'A beautiful new year space')
  fill_in('price', with: '50')
  fill_in('available_from', with: '2020-12-31')
  fill_in('available_to', with: '2021-02-01')
  click_button 'Add'

end

def add_false_listing
  click_button('Add new listing')
  fill_in('name', with: 'Makers Space')
  fill_in('location', with: 'London')
  fill_in('description', with: 'A beautiful space')
  fill_in('price', with: '30')
  fill_in('available_from', with: '2020-11-15')
  fill_in('available_to', with: '2020-11-13')
  click_button 'Add'
end
