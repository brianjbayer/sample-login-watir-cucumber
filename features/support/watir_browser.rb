# frozen_string_literal: true

def create_watir_browser
  browser = specified_browser
  remote_url = specified_remote_url

  if remote_url
    create_remote_browser(remote_url, browser)
  else
    create_local_browser(browser)
  end
end

def create_remote_browser(remote_url, browser)
  Watir::Browser.new browser, url: remote_url, options: browser_options
end

def create_local_browser(browser)
  # Use the default watir (Chrome) browser if no browser is specified
  return Watir::Browser.new unless browser

  Watir::Browser.new(browser, options: browser_options)
end

def browser_options
  options = {}
  options[:args] = ['--headless'] if headless_specified?
  options
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
