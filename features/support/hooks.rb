# frozen_string_literal: true

require_relative 'watir_browser'

Before do
  @browser = create_watir_browser
end

After do
  @browser.close
end
