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

  def betweenDate(date)
    initial_date = DateTime.parse(date).change(hour: 0, min: 0, sec: 0)
    final_date = DateTime.parse(date).change(hour: 23, min: 59, sec: 59)
  end
end
