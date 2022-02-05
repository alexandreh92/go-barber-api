# frozen_string_literal: true

module Appointments
  class DestroyAppointmentService
    include CallableService

    def initialize(opts = {})
      @user = User.find(opts[:user_id])
      @appointment = Appointment.find(opts[:appointment_id])
    end

    def call
      validate
      destroy
      appointment
    end

    private

      attr_reader :user, :appointment

      def validate
        raise Exceptions::Forbidden unless same_user?
        raise Exceptions::CancellationNotInRange if past_date?
      end

      def destroy
        appointment.update(cancelled_at: DateTime.now)
        notify
      end

      def notify
        BarberMailer.new_cancellation(appointment).deliver_later
      end

      def past_date?
        appointment.date - 2.hours < DateTime.now
      end

      def same_user?
        appointment.user_id == user.id
      end
  end
end
