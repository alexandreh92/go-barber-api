# frozen_string_literal: true

class User < ApplicationRecord
  # Uploders
  mount_uploader :avatar, AvatarUploader

  # Associations
  has_many :user_appointments, class_name: 'Appointment', foreign_key: 'user_id'
  has_many :provider_appointments, class_name: 'Appointment', foreign_key: 'provider_id'
  has_many :notifications, class_name: 'Notification', foreign_key: 'provider_id'

  # Devise Attrs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  def update_resource(user_params)
    if user_params[:current_password]
      update_with_password(user_params)
    else
      update(user_params)
    end
  end
end
