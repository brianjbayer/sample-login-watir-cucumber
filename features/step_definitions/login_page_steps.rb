Given(/^user is on the login page$/) do
  visit(LoginPage) { |page| expect(page.current_url).to eq(page.page_url_value) }
end

### THEN STEPS ###
Then(/^there must be a single, visible username input field$/) do
  username_input_field = on(LoginPage).username_input_elements
  there_must_be_a_single_visible(username_input_field)
end

Then(/^there must be a single, visible password input field$/) do
  password_input_field = on(LoginPage).password_input_elements
  there_must_be_a_single_visible(password_input_field)
end

Then(/^there must be a single, visible submit button$/) do
  login_submit_button = on(LoginPage).submit_button_elements
  there_must_be_a_single_visible(login_submit_button)
end

# TODO: Use metaprogramming to extend this method into???
### SUPPORT METHODS ###
def there_must_be_a_single_visible(elements)
  expect(elements.count).to eq(1)

  the_element = elements[0]
  expect(the_element.visible?).to be true
end
