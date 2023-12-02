# frozen_string_literal: true

module Config
  # Configuration for PageObject pages
  module Pages
    def page_base_url
      ENV.fetch('BASE_URL')
    end

    def valid_login_username
      ENV.fetch('LOGIN_USERNAME')
    end

    def valid_login_password
      ENV.fetch('LOGIN_PASSWORD')
    end
  end

  # Configuration for Watir-driven browser
  module Watir
    def browser
      ENV.fetch('BROWSER', nil)
    end

    def remote_browser_url
      ENV.fetch('REMOTE', nil)
    end

    def headless?
      # Support HEADLESS= as true, but HEADLESS=false as false
      ENV.fetch('HEADLESS', false).to_s.downcase != 'false'
    end
  end
end
