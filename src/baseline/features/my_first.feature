Feature: Opening vehicle option

  Scenario: As a valid user I can log into my app
    Given I press "Vehicles"               
    #button to remove the splash screen
    Then I should see "Default vehicle"
