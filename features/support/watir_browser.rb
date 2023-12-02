# frozen_string_literal: true

def create_watir_browser
  watir_browser_arguments = { options: browser_options }
  # Handle local or remote (can not send url: nil)
  watir_browser_arguments.merge!({ url: remote_browser_url }) if remote_browser_url

  Watir::Browser.new(browser, watir_browser_arguments)
end

def browser_options
  options = {}
  options[:args] = ['--headless'] if headless?
  options
end
