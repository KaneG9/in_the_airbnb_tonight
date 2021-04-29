# frozen_string_literal: true

def create_test_property
  click_button('List a property')
  fill_in('address', with: '123 fake street')
  fill_in('postcode', with: 'E19 4RH')
  fill_in('title', with: 'A very real place you can visit')
  fill_in('description', with: 'A really tiny and awful apartment with terrible views of the back of a bigger building')
  fill_in('price_per_day', with: '100000000')
  click_button('Create listing')
end

def sign_up
  visit '/'
  click_button 'Sign up'
  fill_in('name', with: 'test name')
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'test_password1')
  click_button 'Submit'
end

def sign_in
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'test_password1')
  click_button 'Log in'
end
