# frozen_string_literal: true

class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :provider, :boolean, default: false
  end
end
