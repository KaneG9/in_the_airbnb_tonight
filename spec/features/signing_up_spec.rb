# frozen_string_literal: true

feature 'signing up' do
  scenario 'A user signs up and get a confirmation' do
    visit '/'
    click_button 'Sign up'
    fill_in('email', with: 'test@email.com')
    fill_in('name', with: 'test name')
    fill_in('password', with: 'test_password1')
    click_button 'Submit'
    expect(page).to have_content 'Welcome Test name!'
  end

  scenario 'An existing user can not sign up again' do
    sign_up
    sign_up
    expect(page).to have_content 'User already exists, please log in!'
  end

  scenario 'User password is hidden' do
    visit '/'
    click_button 'Sign up'
    fill_in('email', with: 'test@email.com')
    fill_in('name', with: 'test name')
    fill_in('password', with: 'test_password1')
    expect(page).not_to have_content 'test_password1'
  end
end
