# frozen_string_literal: true

class AddCancelledDateToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :cancelled_at, :datetime
  end
end
