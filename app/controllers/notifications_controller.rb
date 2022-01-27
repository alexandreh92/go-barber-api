# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(provider_id: current_user.id).order(created_at: :desc)
    render json: @notifications
  end

  def update
    @notification = Notification.find(params[:id])
    if @notification.update(read: true)
      render json: @notification
    else
      render json: { errors: @notification.errors.full_messages }, status: 422
    end
  end
end
