Feature: Vehicle Scenarios

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
    # Then I press view with id "type"
    # Then I press list item number 1
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

Scenario: As a valid user I can edit Mazda3 car
    When I press "Vehicles"               
    Then I should see text containing "Mazda3"
    Then I long press "Mazda3" and select "Edit"
    # Then I press press the "Mazda3"
    Then I clear input field number 5
    Then I enter "Descripción actualizada del vehículo" into input field number 5
    Then I hide the keyboard
    Then I wait
    Then I scroll down
    Then I scroll down
    Then I press view with id "save_btn"
    Then I take a screenshot
    Then I should see text containing "Descripción actualizada del vehículo"

Scenario: As a valid user I set Mazda3 has default car
    When I press "Vehicles"               
    Then I should see text containing "Mazda3"
    Then I long press "Mazda3" and select item number 1
    Then I take a screenshot

Scenario: As a valid user I can delete default car
    When I press "Vehicles"               
    Then I should see text containing "Default vehicle"
    # Then I long press "Default vehicle" and select "Delete"
    Then I long press "Default vehicle"
    Then I press "Edit"
    Then I hide the keyboard
    Then I wait
    Then I press the menu key
    Then I press "Delete"
    Then I press "OK"
    Then I don't see "Default vehicle" 
    Then I take a screenshot
