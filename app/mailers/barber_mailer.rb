# frozen_string_literal: true

class BarberMailer < ApplicationMailer
  def new_cancellation(appointment)
    @appointment = appointment
    @provider = User.find(appointment.provider_id)
    @user = User.find(appointment.user_id)

    mail(to: @provider.email, subject: "#{@user.name} cancelou seu agendamento!")
  end
end
