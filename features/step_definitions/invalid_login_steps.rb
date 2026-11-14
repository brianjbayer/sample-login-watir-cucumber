# frozen_string_literal: true

When('user logs in with invalid password') do
  login_page.login_with_credentials!(valid_login_username, 'NotAValidPassword')
end

Then('the error message {string} is displayed') do |message|
  expect(login_page.login_error_message!).to include(message)
end
