# frozen_string_literal: true

When('user logs in with valid credentials') do
  login_page.login_with_valid_credentials!
end

Then('user must be sent to the Secure Area') do
  secure_area_page.on_page!
end
