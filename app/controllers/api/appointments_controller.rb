# frozen_string_literal: true

module Api
  class AppointmentsController < ApiController
    def index
      @appointments = Appointment.not_cancelled.where(
        user_id: current_user.id
      ).paginate(page: params[:page], per_page: 10)

      render json: {
        appointments: @appointments.as_json(
          include: :user, methods: %i[cancellable past]
        ),
        current_page: @appointments.current_page,
        total_pages: @appointments.total_pages
      }
    end

    def create
      appointment = Appointments::CreateAppointmentService.call(
        user_id: current_user.id,
        provider_id: appointment_params[:provider_id],
        date: appointment_params[:date]
      )

      render json: appointment, status: :created
    end

    def destroy
      appointment = Appointments::DestroyAppointmentService.call(
        user_id: current_user.id,
        appointment_id: params[:id]
      )

      render json: appointment
    end

    private

      def appointment_params
        params.permit(:provider_id, :date)
      end
  end
end
