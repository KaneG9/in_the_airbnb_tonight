# frozen_string_literal: true

feature 'Renting a property' do
  scenario 'User can request to rent a property' do
    sign_up
    sign_in
    create_test_property
    click_button 'View Property'
    fill_in 'start_date', with: '2025-02-01'
    fill_in 'end_date', with: '2025-02-08'
    click_button 'Request rental'
    expect(page).to have_content 'Your rental request has been sent.'
  end

  scenario 'Owner can see and approve request' do
    #  -----OWNER LOGIN & LIST PROPERTY-----
    sign_up
    sign_in
    create_test_property
    click_button 'Logout'

    #  -----RENTER LOGIN & REQUEST-----
    click_button 'Sign up'
    fill_in('name', with: 'requester name')
    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Submit'

    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Log in'

    click_button 'View Property'
    fill_in 'start_date', with: '2025-02-01'
    fill_in 'end_date', with: '2025-02-08'
    click_button 'Request rental'
    click_button 'Logout'

    # ------OWNER CHECKS MESSAGES-----
    sign_in
    expect(page).to have_content 'A very real place you can visit'
    expect(page).to have_content 'Request'
    expect(page).to have_button 'Confirm request'
    expect(page).not_to have_content 'Your request has been approved'
  end

  scenario 'Renter receives message upon approval and Property status is set to booked' do
    sign_up
    sign_in
    create_test_property
    click_button 'Logout'

    click_button 'Sign up'
    fill_in('name', with: 'requester name')
    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Submit'

    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Log in'

    click_button 'View Property'
    fill_in 'start_date', with: '2025-02-01'
    fill_in 'end_date', with: '2025-02-08'
    click_button 'Request rental'
    click_button 'Logout'
    
    sign_in
    click_button 'Confirm request'
    click_button 'Logout'

    fill_in('email', with: 'requester@email.com')
    fill_in('password', with: 'test_password2')
    click_button 'Log in'

    expect(page).to have_content('Your request has been approved')
    expect(page).to have_button('Clear message and view property')
    expect(page).not_to have_content('New Request')

    click_button 'Clear message and view property'
    expect(page).to have_content('Booking confirmed')
    expect(page).not_to have_content('pending review')
  end
end
