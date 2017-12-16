Before do
  if ENV['SPEC_BROWSER'] 
    # A browser has been specified, we will assume the caller knows the supported watir browser names
    # with some special cases of course
    browser_name = ENV['SPEC_BROWSER'].strip
    
    # Let's deal with the special cases
    # TODO Refactor the headless case to algorithm
    case browser_name
      
    when 'chrome_headless', 'headless_chrome'
      @browser = Watir::Browser.new :chrome, headless: true

    when 'firefox_headless', 'headless_firefox'
      @browser = Watir::Browser.new :firefox, headless: true
      
    else
      # Just symbolize it and pass it thru
      @browser = Watir::Browser.new browser_name.to_sym
    end
  else
    STDERR.puts '>> USING DEFAULT DRIVER <<'
    @browser = Watir::Browser.new

  end
  
  # 
  #   if browser_name == 'chrome_headless'
  #     @browser = Watir::Browser.new browser: :chrome, headless: true
  #   else
  #     # Just symbolize it and pass it thru
  #       @browser = Watir::Browser.new browser_name.to_sym
  #   end
  # else
  #   STDERR.puts '>> USING DEFAULT DRIVER <<'
  #   @browser = Watir::Browser.new 
  # end
end

#   case ENV['SPEC_BROWSER']
# 
#   when 'chrome'
#     @browser = Watir::Browser.new :chrome
# 
#   when 'chrome_headless', 'headless_chrome'
#     @browser = Watir::Browser.new :chrome, headless: true
# 
#   when 'firefox'
#     @browser = Watir::Browser.new :firefox
# 
#   when 'safari'
#     @browser = Watir::Browser.new :safari
# 
#   else
#     STDERR.puts '>> USING DEFAULT DRIVER <<'
#     @browser = Watir::Browser.new
#   end
# 
#   @browser.driver.manage.timeouts.implicit_wait = 15
# end

After do
  @browser.close
end
