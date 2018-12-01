# frozen_string_literal: true

def headless_browser(headless_browser)
  # split on underscores or whitespace
  remove_headless = headless_browser.tr('_', ' ').split
  remove_headless.delete('headless')
  remove_headless.join('_')
end

Before do
  if ENV['SPEC_BROWSER']
    browser_name = ENV['SPEC_BROWSER'].downcase.strip
    @browser = if browser_name.include?('headless')
                 Watir::Browser.new headless_browser(browser_name).to_sym, headless: true
               else Watir::Browser.new browser_name.to_sym
               end
  else
    STDERR.puts '>> USING DEFAULT (Watir) DRIVER <<'
    @browser = Watir::Browser.new
  end
end

After do
  @browser.close
end
