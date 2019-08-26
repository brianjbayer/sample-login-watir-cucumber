# frozen_string_literal: true

require 'webdrivers'

def configure_browser(specified_browser)
  specified_browser = ENV['SPEC_BROWSER'].downcase.strip
  browser_options = specified_browser.tr('_', ' ').split

  headless = ! browser_options.delete('headless').nil?
  container = ! browser_options.delete('container').nil?
  # Assume whatever is left is the browser type (e.g. chrome)
  browser_type = browser_options.first.to_sym

  @browser = if container
    selenium_standalone = 'http://localhost:4444/wd/hub'
    Watir::Browser.new browser_type, url: selenium_standalone, headless: headless
  else
    Watir::Browser.new browser_type, headless: headless
  end
end


Before do
  @browser = if ENV['SPEC_BROWSER']
    configure_browser ENV['SPEC_BROWSER']
  else
    warn '>> USING DEFAULT (Watir) DRIVER <<'
   Watir::Browser.new
  end
end

After do
  @browser.close
end
