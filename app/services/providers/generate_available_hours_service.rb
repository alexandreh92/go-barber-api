module Providers
  class GenerateAvailableHoursService
    include CallableService

    def initialize(opts = {})
      @provider_id = opts[:provider_id]
      @date = opts[:date]
    end

    def call
      available_hours.map do |time|
        hour, minute = time.split(':')
        value = date.change(hour: hour.to_i, min: minute.to_i, sec: 0)
        available = value.future? && find_conflict_appointments(time).none?

        {
          time: time,
          value: value,
          available: available
        }
      end
    end

    private

      attr_reader :provider_id, :date

      def available_hours
        Appointment::AVAILABLE_HOURS
      end

      def appointments
        @appointments ||= Appointment.not_cancelled.where(
          provider_id: provider_id,
          date: date.beginning_of_day..date.end_of_day
        )
      end

      def find_conflict_appointments(date_string)
        appointments.find_each.select do |a|
          a.date.strftime('%H:%M') == date_string
        end
      end
  end
end
