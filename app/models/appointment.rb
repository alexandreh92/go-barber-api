# frozen_string_literal: true

class Appointment < ApplicationRecord
  AVAILABLE_HOURS = ['08:00', '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00',
                     '17:00', '18:00'].freeze

  # Associations
  belongs_to :user
  belongs_to :provider, class_name: 'User'

  # Validations
  validates :date, presence: true

  # Scopes
  scope :not_cancelled, -> { where(cancelled_at: nil) }

  # Methods

  def cancellable?
    date > DateTime.now - 2.hours
  end

  def past?
    date < DateTime.now
  end
end
