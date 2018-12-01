# frozen_string_literal: true

Given(/^user is on the login page$/) do
  visit(LoginPage) { |page| expect(page.current_url).to eq(page.page_url_value) }
end

### THEN STEPS ###
Then(/^there must be a single, present username input field$/) do
  username_input_field = on(LoginPage).username_input_elements
  there_must_be_a_single_present(username_input_field)
end

Then(/^there must be a single, present password input field$/) do
  password_input_field = on(LoginPage).password_input_elements
  there_must_be_a_single_present(password_input_field)
end

Then(/^there must be a single, present submit button$/) do
  login_submit_button = on(LoginPage).submit_button_elements
  there_must_be_a_single_present(login_submit_button)
end

# TODO: Use metaprogramming to extend this method into???
### SUPPORT METHODS ###
def there_must_be_a_single_present(elements)
  expect(elements.count).to eq(1)

  the_element = elements[0]
  expect(the_element.present?).to be true
end
