Given(/^user is on plant search page$/) do
  visit OakPlantSearchPage
end


When(/^user search for plant (.+)$/) do |plant_name|
  on(OakPlantSearchPage).search_plant plant_name
end

Then(/^user should see the results related to (.+)$/) do |plant_name|
  on(OakPlantSearchPage).verify_plant_search_is_correct plant_name

end

And(/^verify the search results count is not more than (\d+)$/) do |max_results|
  on(OakPlantSearchPage).verify_no_of_plant_search_results
end


And(/^user add the first result to the wish list$/) do
  @first_plant_name = on(OakPlantSearchPage).get_all_plant_names.first
  on(OakPlantSearchPage).add_plant_to_wishlist
end


Then(/^verify the added plant is showing under the wish list$/) do
  on(OakPlantSearchPage).verify_wishlist_has_plant @first_plant_name
end

And(/^user modifies the quantity of the wish list item$/) do
  on(OakWishListPage).update_wishlist_quantity 2
end

Then(/^verify user can see the updated quantity$/) do
  on(OakWishListPage).verify_wishlist_quantity_has_updated 2
end

When(/^user adds the plant (.*)to the wish list$/) do |plant_name|
  on(OakPlantSearchPage).search_plant plant_name
  @first_plant_name = on(OakPlantSearchPage).get_all_plant_names.first
  on(OakPlantSearchPage).add_plant_to_wishlist
  on(OakPlantSearchPage).verify_wishlist_has_plant @first_plant_name
end

And(/^user empty the wish list$/) do
  on(OakWishListPage).empty_wishlist
end

Then(/^user should see the confirmation message "([^"]*)"$/) do |message|
  on(OakErrorPage).verify_wishlist_empty_message_displayed message
end

And(/^verify the details of the plant$/) do
  p on(OakPlantSearchPage).get_plant_info
end