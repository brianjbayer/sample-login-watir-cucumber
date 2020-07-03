# frozen_string_literal: true

When(/^user logs in with username and password$/) do
  on(LoginPage).login_with_credentials('tomsmith', 'SuperSecretPassword!')
end

Then(/^user must be sent to the Secure Area$/) do
  on(SecureAreaPage) do |page|
    # An "eventually" matcher
    Timeout.timeout(5) do
      sleep 0.1 until page.current_url.eql?(page.page_url_value)
    rescue Timeout::Error
      # One last chance or the actual expect error
      expect(page.current_url).to eql(page.page_url_value)
    end
  end
end
