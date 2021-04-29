require_relative '../web_helpers.rb'

feature 'booking a property' do
  scenario 'Users can book a property' do
    sign_up
    sign_in
    p = Property.create(address: 'test_address', 
      postcode: 'test', 
      title: 'test_title', 
      description: 'test_description', 
      price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2022-02-01'
    fill_in 'end_date', with: '2022-02-08'
    click_button 'Request rental'
    expect(page).to have_content 'Your rental request has been sent.'
  end

  scenario 'Users can see booking request that have been made for  a property' do
    sign_up
    sign_in
    p = Property.create(address: 'test_address', 
      postcode: 'test', 
      title: 'test_title', 
      description: 'test_description', 
      price_per_day: 1)
    visit "/property/#{p.id}"
    fill_in 'start_date', with: '2022-02-01'
    fill_in 'end_date', with: '2022-02-08'
    click_button 'Request rental'
    expect(page).to have_table('bookings_table', text:'2022-02-01') 
    expect(page).to have_table('bookings_table', text:'2022-02-08') 
    expect(page).to have_table('bookings_table', text:'pending review') 
  end

  scenario 'Booking request are displayed with most recent first' do
    sign_up
    sign_in
    p = Property.create(address: 'test_address', 
      postcode: 'test', 
      title: 'test_title', 
      description: 'test_description', 
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
end
