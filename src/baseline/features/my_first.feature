Feature: Create vehicle

  Scenario: As a valid user I can create new car
    When I press "Vehicles"               
    Then I press the menu key
    # Then I wait
    Then I press "Add new vehicle"
    Then I enter "Mazda3" into input field number 1
    Then I enter "2019" into input field number 2
    Then I enter "Japón" into input field number 3
    Then I enter "Grand Touring" into input field number 4
    Then I enter "Con tecnología SkyActive" into input field number 5
    Then I press view with id "type"
    Then I press list item number 1
    Then I scroll down
    Then I press view with id "distance"
    Then I press "Kilometers"
    Then I scroll down
    Then I press view with id "economy"
    Then I press "Km / Gallon"
    Then I scroll down
    Then I press view with id "save_btn"
    Then I take a screenshot
    Then I should see text containing "Mazda3"