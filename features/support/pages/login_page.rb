# The Sample Login Page
class LoginPage < BasePage
  page_url 'http://the-internet.herokuapp.com/login'

  # NOTE: These elements are defined as collections (altho there should only be one)
  # so that we can verify this assumption
  text_fields(:username_input,  name: 'username')
  text_fields(:password_input,  name: 'password')
  buttons(:submit_button, type: 'submit')

  def login_with_credentials(username, password)
    ## NOTE: Because we are using collections, we have to go to the Watir element level
    # TODO: Find a better way to do this
    username_input_field = username_input_elements[0]
    username_input_field.value = username

    password_input_field = password_input_elements[0]
    password_input_field.value = password

    login_submit_button = submit_button_elements[0]
    login_submit_button.click
  end
end
