Before do
  if @browser.nil?
    puts '<<< INIT BROWSER >>>'
    case ENV['SPEC_BROWSER']

    when 'chrome'
      @browser = Watir::Browser.new :chrome

    when 'chrome_headless', 'headless_chrome'
      @browser = Watir::Browser.new :chrome, headless: true

    when 'firefox'
      @browser = Watir::Browser.new :firefox

    when 'safari'
      @browser = Watir::Browser.new :safari, technology_preview: true

    else
      STDERR.puts '>> USING DEFAULT DRIVER <<'
      @browser = Watir::Browser.new
    end

    @browser.driver.manage.timeouts.implicit_wait = 15
  end
end

After do
  @browser.close
end
