module Exceptions
  class DateNotAvailable < GoBarberException
    def message
      'Appointment date is not available for schedule.'
    end

    def http_code
      422
    end

    def error_code
      'DATE_NOT_AVAILABLE_FOR_SCHEDULE'
    end
  end
end
