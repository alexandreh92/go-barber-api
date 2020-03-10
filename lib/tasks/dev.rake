# frozen_string_literal: true

namespace :dev do
  task create_users: :environment do
    20.times do
      User.create!(
        name: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: '123123',
        password_confirmation: '123123',
        provider: [0, 1].sample
      )
    end
    User.create!(
      name: 'Administrador Geral',
      email: 'admin@admin',
      password: '123123',
      password_confirmation: '123123',
      provider: 0
    )
  end
end
