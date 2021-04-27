feature 'View properties on homepage' do
  scenario 'User can see a listed property' do
    # sign_in_helper
    visit '/property/new'
    fill_in('address', with: "123 fake street")
    fill_in('postcode', with: "E19 4RH")
    fill_in('title', with: "A very real place you can visit")
    fill_in('description', with: "A really tiny and awful apartment with terrible views of the back of a bigger building")
    fill_in('price_per_day', with: "100000000")
    click_button('Create listing')

    expect(page).to have_content 'E19 4RH'
  end

end
