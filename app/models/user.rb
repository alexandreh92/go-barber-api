# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :user_appointments, :class_name => 'Appointment', :foreign_key => 'user_id'
  has_many :provider_appointments, :class_name => 'Appointment', :foreign_key => 'provider_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
end
