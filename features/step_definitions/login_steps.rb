
When(/^user logs in with valid credentials$/) do
  on(LoginPage).login_with_credentials('tomsmith', 'SuperSecretPassword!')
end

Then(/^user must be sent to the Secure Area$/) do
  on(SecureAreaPage) { |page| expect(page.current_url).to eq(page.page_url_value) }
end
