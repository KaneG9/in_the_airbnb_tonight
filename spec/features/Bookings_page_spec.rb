# frozen_string_literal: true

require_relative '../web_helpers'

feature 'booking a property' do
  before(:each) do
    @u = User.create('test name', 'test@email.com', 'test_password1')
  end

  scenario 'Users can book a property' do
    visit '/'
    sign_in
    p = Property.create(address: 'test_address',
                        postcode: 'test',
                        title: 'test_title',
                        description: 'test_description',
                        user_id: @u.id,
                        price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2022-02-01'
    fill_in 'end_date', with: '2022-02-08'
    click_button 'Request rental'
    expect(page).to have_content 'Your rental request has been sent.'
  end

  scenario 'Users can see booking request that have been made for  a property' do
    visit '/'
    sign_in
    p = Property.create(address: 'test_address',
                        postcode: 'test',
                        title: 'test_title',
                        description: 'test_description',
                        user_id: @u.id,
                        price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2022-02-01'
    fill_in 'end_date', with: '2022-02-08'
    click_button 'Request rental'
    expect(page).to have_table('bookings_table', text: '2022-02-01')
    expect(page).to have_table('bookings_table', text: '2022-02-08')
    expect(page).to have_table('bookings_table', text: 'pending review')
  end

  scenario 'Booking request are displayed with most recent first' do
    visit '/'
    sign_in
    p = Property.create(address: 'test_address',
                        postcode: 'test',
                        title: 'test_title',
                        description: 'test_description',
                        user_id: @u.id,
                        price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2022-02-01'
    fill_in 'end_date', with: '2022-02-08'
    click_button 'Request rental'
    fill_in 'start_date', with: '2022-03-01'
    fill_in 'end_date', with: '2022-03-08'
    click_button 'Request rental'
    expect(page.body.index('2022-02-01')).to be < page.body.index('2022-03-01')
  end

  scenario 'Booking in past show error' do
    visit '/'
    sign_in
    p = Property.create(address: 'test_address',
                        postcode: 'test',
                        title: 'test_title',
                        description: 'test_description',
                        user_id: @u.id,
                        price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2021-02-01'
    fill_in 'end_date', with: '2021-02-08'
    click_button 'Request rental'
    expect(page).to have_content 'The date you have requested is in the past, Please try again.'
  end
end
