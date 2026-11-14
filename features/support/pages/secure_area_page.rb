# frozen_string_literal: true

require_relative 'base_page'

# Secure area page elements
class SecureAreaPage < BasePage
  def initialize(browser, base_url:, **parent_opts)
    super(browser, page_url: "#{base_url}/secure", **parent_opts)
  end

  protected

  def page_ready_element
    browser.h2(text: /Secure Area/)
  end
end
