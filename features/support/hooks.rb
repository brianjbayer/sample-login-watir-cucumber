Before do
  @browser = Watir::Browser.new :chrome
  @browser.driver.manage.timeouts.implicit_wait = 3
end


After do
  @browser.close
end
