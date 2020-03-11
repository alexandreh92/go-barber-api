# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    provider = User.where(id: appointment_params[:provider_id], provider: true)
    parsed_date = Appointment.pastDate(appointment_params[:date])
    check_availability = Appointment.where(provider_id: appointment_params[:provider_id],
                                           cancelled_at: nil, date: parsed_date)

    unless provider.exists?
      return render json: { error: 'You can only create appointments with providers' }, status: 401
    end

    if parsed_date < DateTime.now
      return render json: { error: 'Past dates are not permitted.' }, status: 401
    end

    if check_availability.exists?
      return render json: { erorr: 'Appointment date is not available.' }, status: 401
    end

    @appointment = Appointment.new(appointment_params.merge(user_id: current_user.id))
    if @appointment.save
      render json: @appointment
    else
      render json: { errors: @appointment.errors.full_messages }, status: 422
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:provider_id, :date)
  end
end
