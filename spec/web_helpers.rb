def sign_up
  visit '/' 
  click_button 'Sign up'
  fill_in('name', with: 'test name')
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'test_password1')
  click_button 'Submit'
end
