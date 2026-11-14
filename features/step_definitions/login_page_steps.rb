# frozen_string_literal: true

Given(/^user is on the login page$/) do
  login_page.visit!
end

### THEN STEPS ###
Then(/^there must be a place to enter a username$/) do
  login_page.username!
end

Then(/^there must be a place to enter a password$/) do
  login_page.password!
end

Then(/^there must be a login button$/) do
  login_page.login_button!
end
