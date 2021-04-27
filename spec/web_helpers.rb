def create_test_property
  click_button('List a property')
  fill_in('address', with: "123 fake street")
  fill_in('postcode', with: "E19 4RH")
  fill_in('title', with: "A very real place you can visit")
  fill_in('description', with: "A really tiny and awful apartment with terrible views of the back of a bigger building")
  fill_in('price_per_day', with: "100000000")
  click_button('Create listing')
end
