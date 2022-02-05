# frozen_string_literal: true

require 'devise/jwt/test_helpers'

module DeviseJwtHelper
  def auth_token_for(user, headers = {})
    Devise::JWT::TestHelpers.auth_headers(headers, user)['Authorization']
  end
end

RSpec.configure do |c|
  c.include DeviseJwtHelper
end
