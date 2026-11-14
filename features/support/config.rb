# frozen_string_literal: true

module Config
  # Test Pages
  module PageObjects
    def base_url
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
    def browser_type
      ENV.fetch('BROWSER_TYPE', nil)
    end

    def remote_browser_url
      ENV.fetch('REMOTE_BROWSER', nil)
    end

    def headless?
      # Support HEADLESS= as true, but HEADLESS=false as false
      ENV.fetch('HEADLESS', false).to_s.downcase != 'false'
    end
  end
end
