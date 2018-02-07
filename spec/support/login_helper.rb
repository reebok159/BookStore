def login(email, password)
  visit root_path
  first(:link, "Log In").click
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
  click_button 'Log In'
end
