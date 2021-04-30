# frozen_string_literal: true

require_relative '../web_helpers'

feature 'Logging out' do
  scenario 'Logging out returns you to root page and gives confirmation' do
    sign_up
    sign_in
    click_button 'Logout'
    expect(page).to have_content('Successful log out')
    expect(page).to have_content('Sign in')
  end
end
