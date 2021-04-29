feature 'Renting a property' do
  scenario 'User can request to rent a property' do
    sign_up
    sign_in
    visit '/homepage'
    create_test_property

    click_button 'Rent Property'

    expect(page).to have_content 'You have successfully requested to rent'
  end

  scenario 'Owner can see and approve request' do
  #  -----OWNER LOGIN & LIST PROPERTY-----
    sign_up
    sign_in
    visit '/homepage'
    create_test_property
    click_button 'Logout'

  #  -----RENTER LOGIN & REQUEST-----
    visit '/'
    click_button 'Sign up'
    fill_in('name', with: 'requester name')
    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Submit'
    
    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Log in'  

    click_button 'Rent Property'
    click_button 'Logout'

  # ------OWNER CHECKS MESSAGES-----
    sign_in
    visit '/homepage'

    expect(page).to have_content 'Request'
    expect(page).to have_content 'Approve'
    
  end
end
