# frozen_string_literal: true

require_relative 'pages/login_page'
require_relative 'pages/secure_area_page'

# Non-Cached scenario-scoped access to page objects.
module PageObjects
  def login_page
    LoginPage.new(browser, base_url: base_url, timeout: 15)
  end

  def secure_area_page
    SecureAreaPage.new(browser, base_url: base_url, timeout: 15)
  end
end
