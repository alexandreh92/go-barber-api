module Appointments
  class CreateAppointmentService
    include CallableService

    def initialize(opts = {})
      @user = User.find(opts[:user_id])
      @provider_id = opts[:provider_id]
      @date = opts[:date]
    end

    def call
      validate
      appointment = create_appointment
      notify
      appointment
    end

    private

      attr_reader :user, :provider_id, :date

      def validate
        raise Exceptions::NotProviderException unless provider_exists?
        raise Exceptions::PastDatesNotAllowed if past_date?
        raise Exceptions::DateNotAvailable if date_unavailable?
      end

      def provider_exists?
        User.where(id: provider_id, provider: true).exists?
      end

      def parsed_date
        DateTime.parse(date).change(min: 0)
      end

      def past_date?
        parsed_date < DateTime.now
      end

      def date_unavailable?
        Appointment.not_cancelled.where(
          provider_id: provider_id,
          date: parsed_date
        ).exists?
      end

      def create_appointment
        Appointment.create!(user: user, provider_id: provider_id, date: date)
      end

      def notify
        Notification.create!(
          user_id: user.id,
          provider_id: provider_id,
          content: "Novo agendamento de #{user.name} para o dia #{DateTime.now.strftime('%d de %B às %H:%Mh')}"
        )
      end
  end
end
