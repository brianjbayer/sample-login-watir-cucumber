Feature: Secure User Login

  Scenario: Valid login
    Given user is on the login page
    When user logs in with valid credentials
    Then user must be sent to the Secure Area

  Scenario: Invalid password
    Given user is on the login page
    When user logs in with invalid password
    Then the error message "Your password is invalid!" is displayed
