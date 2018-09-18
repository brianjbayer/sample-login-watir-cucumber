Feature: Login Page Elements

  Scenario: Login Page must have username and password input fields and submit button
    When user is on the login page
    Then there must be a single, present username input field
    And there must be a single, present password input field
    And there must be a single, present submit button

