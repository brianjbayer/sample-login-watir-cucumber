# frozen_string_literal: true

require_relative 'base_page'

# Login page elements and actions
class LoginPage < BasePage
  USERNAME_FIELD = { id: 'username' }.freeze
  PASSWORD_FIELD = { id: 'password' }.freeze
  LOGIN_BUTTON = { text: /Login/ }.freeze
  LOGIN_ERROR = { id: 'flash' }.freeze

  def initialize(browser, base_url:, **parent_opts)
    super(browser, page_url: "#{base_url}/login", **parent_opts)
  end

  def username!
    wait_until_present(browser.text_field(**USERNAME_FIELD))
  end

  def password!
    wait_until_present(browser.text_field(**PASSWORD_FIELD))
  end

  def login_button!
    wait_until_present(browser.button(**LOGIN_BUTTON))
  end

  def login_error_message!
    browser.div(**LOGIN_ERROR).wait_until(&:present?).text
  end

  def login_with_valid_credentials!
    login_with_credentials!(valid_login_username, valid_login_password)
    on_page_url!(expected: false)
  end

  def login_with_credentials!(username, password)
    fill_input(username, **USERNAME_FIELD)
    fill_input(password, **PASSWORD_FIELD)
    browser.button(**LOGIN_BUTTON).click
  end

  protected

  def page_ready_element
    browser.h2(text: 'Login Page')
  end
end
