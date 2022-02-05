# frozen_string_literal: true

module Exceptions
  class PastDatesNotAllowed < GoBarberException
    def message
      'Past dates are not permitted.'
    end

    def http_code
      422
    end

    def error_code
      'PAST_DATES_NOT_PERMITTED'
    end
  end
end
