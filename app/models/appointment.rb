# frozen_string_literal: true

class Appointment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :provider, class_name: 'User'

  # Validations
  validates :date, presence: true

  def self.pastDate(date)
    DateTime.parse(date).change(min: 0)
  end

  def cancellable
    date > DateTime.now - 2.hours
  end

  def past
    date < DateTime.now
  end
end
