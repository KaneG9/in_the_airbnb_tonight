# frozen_string_literal: true

feature 'View properties on homepage' do
  scenario 'User can see a listed property' do
    # sign_in_helper
    visit '/homepage'
    create_test_property

    expect(page).to have_content 'E19 4RH'
  end
end
