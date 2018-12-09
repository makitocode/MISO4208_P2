Feature: fillup Scenarios

  Scenario: As a valid user I can create fillup
    When I press "Fillup"
    Then I enter "9800" into input field number 1
    Then I enter "5" into input field number 2
    Then I enter "134000" into input field number 3
    Then I press view with id "date"
    Then I set the date to "08-12-2018" on DatePicker with index 1
    Then I press view with id "button1"
    Then I press view with id "partial"
    Then I press view with id "save_btn"
    Then I press "History"
    Then I take a screenshot
    Then I should see text containing "12/8/18"

Scenario: As a valid user I can edit fillup
    When I press "History"
    Then I should see text containing "12/8/18"
    Then I long press "12/8/18" and select "Edit"
    
    Then I clear input field number 2
    Then I enter "10" into input field number 2
    Then I hide the keyboard
    Then I wait
    Then I press view with id "save_btn"
    Then I take a screenshot
    Then I should see text containing "10.00 g"


# Scenario: As a valid user I can delete fillup
#     When I press "History"
#     Then I should see text containing "12/8/18"
#     Then I long press "12/8/18"
#     Then I scroll down 
#     Then I press "Delete"
    
    # Then I clear input field number 2
    # Then I enter "10" into input field number 2
    # Then I hide the keyboard
    # Then I wait
    # Then I press view with id "save_btn"
    # Then I take a screenshot
    # Then I should see text containing "10.00 g"