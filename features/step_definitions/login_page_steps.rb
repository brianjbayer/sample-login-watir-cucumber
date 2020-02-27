# frozen_string_literal: true

Given(/^user is on the login page$/) do
  visit(LoginPage) { |page| expect(page.current_url).to eq(page.page_url_value) }
end

### THEN STEPS ###
Then(/^there must be a place for a username$/) do
  expect(on(LoginPage).username?).to be true
end

Then(/^there must be a place for a password$/) do
  expect(on(LoginPage).password?).to be true
end

Then(/^there must be a login button$/) do
  expect(on(LoginPage).login_button?).to be true
end

