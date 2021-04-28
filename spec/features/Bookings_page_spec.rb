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
    page.select '1', from: 'start_day'
    page.select 'February', from: 'start_month'
    page.select '2022', from: 'start_year'
    page.select '8', from: 'end_day'
    page.select 'February', from: 'end_month'
    page.select '2022', from: 'end_year'
    click_button 'Request rental'
    expect(page).to have_content 'Your rental request has been sent.'
  end
end
