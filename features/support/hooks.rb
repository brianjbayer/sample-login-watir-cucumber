# frozen_string_literal: true

require 'webdrivers'

STANDALONE = 'http://localhost:4444/wd/hub'

Before do
  @browser = if ENV['SPEC_BROWSER']
               create_browser ENV['SPEC_BROWSER'].downcase.strip
             else
               warn '>> USING DEFAULT (Watir) DRIVER <<'
               Watir::Browser.new
             end
end

After do
  @browser.close
end

def create_browser(specified_browser)
  browser_options = specified_browser.tr('_', ' ').split

  headless = !browser_options.delete('headless').nil?
  container = !browser_options.delete('container').nil?
  # Assume whatever is left is the browser type (e.g. chrome)
  browser_type = browser_options.first.to_sym

  configure_browser(browser_type, headless, container)
end

def configure_browser(browser_type, headless, container)
  if container
    Watir::Browser.new browser_type, url: STANDALONE, headless: headless
  else
    Watir::Browser.new browser_type, headless: headless
  end
end
