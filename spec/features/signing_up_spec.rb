feature 'signing up' do
  scenario 'A user signs up and get a confirmation' do
    visit '/' 
    click_button 'Sign up'
    fill_in('email', with: 'test@email.com')
    fill_in('name', with: 'test name')
    fill_in('password', with: 'test_password1')
    click_button 'Submit'
    expect(page).to have_content 'Welcome test name!'
  end
end