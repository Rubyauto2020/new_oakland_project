Feature: oakland plant search
  Scenario: verify that the user can search for plants
    Given user is on plant search page
    When user search for plant Rose
    Then user should see the results related to Rose
    And verify the search results count is not more than 10

  Scenario: verify user can add the plants to the wish list
   Given user is on plant search page
    When  user search for plant Rose
    And user add the first result to the wish list
   Then verify the added plant is showing under the wish list
#    Then verify the Chater's Double Rose Pink Hollyhock plant is showing under the wish list

  Scenario: verify if the user can modify the item quantity in the wish list
    Given user is on plant search page
    When user search for plant Rose
    And user add the first result to the wish list
    And user modifies the quantity of the wish list item
    Then verify user can see the updated quantity

  Scenario: verify the user can empty the wish list
    Given user is on plant search page
    When user adds the plant Rose to the wish list
    And user empty the wish list
    Then user should see the confirmation message "Your Wish list is currently empty!"

  Scenario: verify that the search results should include plant type,plant height, flower height,spread and sunligh
    Given user is on plant search page
    When  user search for plant Rose
    Then user should see the results related to Rose
    And verify the details of the plant
