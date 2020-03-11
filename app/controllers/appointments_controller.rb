# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = Appointment.where(user_id: current_user.id, cancelled_at: nil).paginate(page: params[:page], per_page: 10)

    render json: { appointments: @appointments.as_json(include: :user, methods: %i[cancellable past]), current_page: @appointments.current_page, total_pages: @appointments.total_pages }
  end

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
      Notification.create!(user_id: current_user.id, provider_id: appointment_params[:provider_id],
                           content: "Novo agendamento de #{current_user.name} para o dia #{DateTime.now.strftime('%d de %B às %H:%Mh')}")
      render json: @appointment
    else
      render json: { errors: @appointment.errors.full_messages }, status: 422
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])

    if @appointment.user_id != current_user.id
      return render json: { erorr: "You don't have permission to cancel this appointment." }, status: 401
    end

    if @appointment.date - 2.hours < DateTime.now
      return render json: { erorr: 'You can only cancel appointments 2 hours in advance.' }, status: 401
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
    params.require(:appointment).permit(:provider_id, :date)
  end
end
