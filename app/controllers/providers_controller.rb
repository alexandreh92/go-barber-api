# frozen_string_literal: true

class ProvidersController < ApplicationController
  before_action :authenticate_user!

  attr_accessor :date

  def index
    @providers = User.where(provider: true)

    render json: @providers
  end

  def availables
    date = DateTime.parse(provider_params[:date])
    @appointments = Appointment.where(provider_id: params[:provider_id], cancelled_at: nil,
                                      date: date.beginning_of_day..date.end_of_day)

    schedule = ['08:00', '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00']

    availables = []
    schedule.each do |time|
      hour, minute = time.split(':')
      value = date.change(hour: hour.to_i, min: minute.to_i, sec: 0)

      availables << {
        time: time,
        value: value,
        available: value > DateTime.now && @appointments.find_each.select { |a| a.date.strftime('%H:%M') == time }.none?
      }
    end

    render json: availables
  end

  private

  def provider_params
    params.permit(:date)
  end
end
