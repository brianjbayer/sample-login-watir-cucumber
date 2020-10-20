# frozen_string_literal: true

require 'webdrivers'

Before do
  browser = ENV['BROWSER']
  remote_url = ENV['REMOTE']
  @browser = if remote_url
               create_remote_browser(browser, remote_url)
             else
               create_local_browser browser
             end
end

After do
  @browser.close
end

### Support ###
def create_remote_browser(browser_info, remote_url)
  browser = BrowserInfo.new browser_info
  Watir::Browser.new browser.name, url: remote_url, headless: browser.headless
end

def create_local_browser(browser_info)
  unless browser_info
    warn '>> USING DEFAULT WATIR DRIVER <<'
    return Watir::Browser.new
  end
  browser = BrowserInfo.new browser_info
  Watir::Browser.new browser.name, headless: browser.headless
end

# Parses out the browser name and attributes like headless
class BrowserInfo
  attr_reader :name
  attr_reader :headless
  def initialize(browser_info)
    browser_options = browser_info.downcase.strip.tr('_', ' ').split
    @headless = !browser_options.delete('headless').nil?
    # Assume whatever is left is the browser name (e.g. chrome)
    @name = browser_options.first.to_sym
  end
end
