# frozen_string_literal: true

require_relative '../web_helpers'

feature 'logging in' do
  scenario 'Signed up users can log in' do
    sign_up
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'test_password1')
    click_button 'Log in'
    expect(page).to have_content 'Welcome test name! Successfully logged in!'
  end

  scenario 'Wrong password displays error message' do
    sign_up
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'wong_password')
    click_button 'Log in'
    expect(page).to have_content 'Sorry email or password does not match!'
  end
  scenario 'Wrong email displays error message' do
    sign_up
    fill_in('email', with: 'wong@email.com')
    fill_in('password', with: 'test_password1')
    click_button 'Log in'
    expect(page).to have_content 'Sorry email or password does not match!'
  end
end
