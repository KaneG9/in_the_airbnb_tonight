feature 'Creating listings on homepage' do
  scenario 'User can list their property' do
    # sign_in_helper
    visit '/homepage'
    click_button('List a property')
    expect(current_path).to eq '/property/new'

    fill_in('address', with: "123 fake street")
    fill_in('postcode', with: "E19 4RH")
    fill_in('title', with: "A very real place you can visit")
    fill_in('description', with: "A really tiny and awful apartment with terrible views of the back of a bigger building")
    fill_in('price_per_day', with: "100000000")
    click_button('Create listing')

    expect(current_path).to eq '/homepage'
    expect(page).to have_content("You have successfully created a listing")
    expect(page).to have_content('E19 4RH')
    expect(page).to have_content('A very real place you can visit')
    # expect(page).not_to have_content("error")
  end

end
