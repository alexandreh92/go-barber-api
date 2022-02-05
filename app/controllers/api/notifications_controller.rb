# frozen_string_literal: true

module Api
  class NotificationsController < ApiController
    def index
      notifications = Notification.where(
        provider_id: current_user.id
      ).order(created_at: :desc)

      render json: { notifications: notifications }
    end

    def update
      notification = current_user.notifications.find(params[:id])
      notification.update(read: true)

      render json: notification
    end
  end
end
