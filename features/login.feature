Feature: Secure User Login

  Scenario: User logs in and is sent to the Secure Area
    Given user is on the login page
    When user logs in with valid credentials
    Then user must be sent to the Secure Area
