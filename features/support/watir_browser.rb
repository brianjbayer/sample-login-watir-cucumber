# frozen_string_literal: true

def create_watir_browser
  browser = ENV['BROWSER'].to_sym if ENV['BROWSER']
  remote_url = ENV['REMOTE']
  headless = headless? ENV['HEADLESS']

  if remote_url
    create_remote_browser(remote_url, browser, headless)
  else
    create_local_browser(browser, headless)
  end
end

def create_remote_browser(remote_url, browser, headless)
  Watir::Browser.new browser, url: remote_url, headless: headless
end

def create_local_browser(browser, headless)
  # Use the default watir (Chrome) browser if no browser is specified
  return Watir::Browser.new unless browser

  # Not all watir browsers (Safari) support the headless option
  if headless
    Watir::Browser.new browser, headless: headless
  else
    Watir::Browser.new browser
  end
end

def headless?(indicator)
  return false if indicator.nil?

  indicator.to_s.downcase != 'false'
end
