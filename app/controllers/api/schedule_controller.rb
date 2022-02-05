# frozen_string_literal: true

module Api
  class ScheduleController < ApplicationController
    def index
      date = DateTime.parse(schedule_params[:date])
      appointments = Appointment.not_cancelled.where(
        provider_id: current_user.id,
        date: date.beginning_of_day..date.end_of_day
      )

      render json: appointments.as_json(include: :user)
    end

    private

      def schedule_params
        params.permit(:date)
      end
  end
end
