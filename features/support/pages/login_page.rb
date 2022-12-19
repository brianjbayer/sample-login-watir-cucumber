# frozen_string_literal: true

# The Sample Login Page
class LoginPage < BasePage
  page_url 'http://the-internet.herokuapp.com/login'

  text_field(:username,  name: 'username')
  text_field(:password,  name: 'password')
  button(:login_button, text: 'Login')

  def login_with_valid_credentials
    valid_username = ENV.fetch('LOGIN_USERNAME')
    valid_password = ENV.fetch('LOGIN_PASSWORD')
    login_with_credentials(valid_username, valid_password)
  end

  private

  def login_with_credentials(username, password)
    self.username = username
    self.password = password
    login_button
  end
end
