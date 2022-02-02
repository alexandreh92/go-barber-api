module Exceptions
  class GoBarberException < StandardError
    def message; end

    def http_code; end

    def error_code; end
  end
end
