# frozen_string_literal: true

class ScheduleController < ApplicationController
  def index
    date = DateTime.parse(schedule_params[:date])
    @appointments = Appointment.where(provider_id: 40, cancelled_at: nil, date: date.beginning_of_day..date.end_of_day)
    render json: @appointments
  end

  private

  def schedule_params
    params.require(:schedule).permit(:date)
  end
end
