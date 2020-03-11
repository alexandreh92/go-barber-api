# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :content
      t.references :user
      t.references :provider
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
