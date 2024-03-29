# frozen_string_literal: true

module Exceptions
  class NotProvider < GoBarberException
    def message
      'You can only create appointments with providers'
    end

    def http_code
      422
    end

    def error_code
      'NOT_PROVIDER'
    end
  end
end
