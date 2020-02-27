# frozen_string_literal: true

# The Sample Login Page
class LoginPage < BasePage
  page_url 'http://the-internet.herokuapp.com/login'

  text_field(:username,  name: 'username')
  text_field(:password,  name: 'password')
  button(:login_button, text: 'Login')

  def login_with_credentials(username, password)
    self.username = username
    self.password = password
    login_button
  end
end
