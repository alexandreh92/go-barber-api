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
      @appointment = Appointment.find(params[:id])

      if @appointment.user_id != current_user.id
        return render json: { error: "You don't have permission to cancel this appointment." },
                      status: 401
      end

      if @appointment.date - 2.hours < DateTime.now
        return render json: { error: 'You can only cancel appointments 2 hours in advance.' },
                      status: 403
      end

      if @appointment.update(cancelled_at: DateTime.now)
        BarberMailer.new_cancellation(@appointment).deliver_later
        render json: @appointment
      else
        render json: { errors: @appointment.errors.full_messages }, status: 422
      end
    end

    private

      def appointment_params
        params.permit(:provider_id, :date)
      end
  end
end
