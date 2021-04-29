# frozen_string_literal: true

feature 'Creating listings on homepage' do
  scenario 'User can list their property' do
    sign_up
    sign_in
    visit '/homepage'
    create_test_property

    expect(current_path).to eq '/homepage'
    expect(page).to have_content('You have successfully created a listing')
    expect(page).to have_content('E19 4RH')
    expect(page).to have_content('A very real place you can visit')
    expect(page).not_to have_content('error')
  end
end
