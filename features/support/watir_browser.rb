# frozen_string_literal: true

require 'webdrivers'

def create_watir_browser
  browser = specified_browser
  remote_url = specified_remote_url
  headless = headless_specified?

  if remote_url
    create_remote_browser(remote_url, browser, headless)
  else
    create_local_browser(browser, headless)
  end
end

def create_remote_browser(remote_url, browser, headless)
  Watir::Browser.new browser, url: remote_url, headless:
end

def create_local_browser(browser, headless)
  # Use the default watir (Chrome) browser if no browser is specified
  return Watir::Browser.new unless browser

  # Not all watir browsers (Safari) support the headless option
  if headless
    Watir::Browser.new(browser, headless:)
  else
    Watir::Browser.new browser
  end
end

def specified_browser
  ENV['BROWSER']&.to_sym
end

def specified_remote_url
  ENV.fetch('REMOTE', nil)
end

# Returns true if HEADLESS env var is set or not 'false'
def headless_specified?
  headless = ENV.fetch('HEADLESS', false)
  headless.to_s.downcase != 'false'
end
