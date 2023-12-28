# frozen_string_literal: true

When('user logs in with invalid password') do
  on(LoginPage).login_with_invalid_password
end

Then('the error message {string} is displayed') do |string|
  expect(on(LoginPage).login_error).to include(string)
end
