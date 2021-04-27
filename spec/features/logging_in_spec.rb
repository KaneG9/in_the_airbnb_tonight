require_relative '../web_helpers'

feature 'logging in' do
  scenario 'Signed up users can log in' do
    sign_up
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'test_password1')
    click_button 'Log in'
    expect(page).to have_content 'Welcome test name! Successfully logged in!'
  end
end
