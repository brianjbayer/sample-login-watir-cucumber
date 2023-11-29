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
end
