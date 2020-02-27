Feature: Login Page Elements

  Scenario: Login Page must have a username, password, and login button
    When user is on the login page
    Then there must be a place for a username
    And there must be a place for a password
    And there must be a login button
