module Exceptions
  class CancellationNotInRange < GoBarberException
    def message
      'You can only cancel appointments 2 hours in advance.'
    end

    def http_code
      422
    end

    def error_code
      'DATE_NOT_IN_RANGE'
    end
  end
end
