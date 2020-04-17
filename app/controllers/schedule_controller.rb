# frozen_string_literal: true

class ScheduleController < ApplicationController
  before_action :authenticate_user!

  def index
    date = DateTime.parse(params[:date])
    @appointments = Appointment.where(provider_id: current_user.id,
                                      cancelled_at: nil, date: date.beginning_of_day..date.end_of_day)
    render json: @appointments.as_json(include: :user)
  end

  private

  def schedule_params
    params.permit(:date)
  end
end
