# frozen_string_literal: true

# The Sample Login Page
class LoginPage < BasePage
  page_url "#{page_base_url}/login"

  text_field(:username,  name: 'username')
  text_field(:password,  name: 'password')
  button(:login_button, text: 'Login')

  def login_with_valid_credentials
    login_with_credentials(valid_login_username, valid_login_password)
  end

  private

  def login_with_credentials(username, password)
    self.username = username
    self.password = password
    login_button
  end
end
