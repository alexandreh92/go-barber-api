module Exceptions
  class Forbidden < GoBarberException
    def message
      "You don't have permission to cancel this appointment."
    end

    def http_code
      403
    end

    def error_code
      'FORBIDDEN'
    end
  end
end
