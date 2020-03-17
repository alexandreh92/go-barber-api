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

    default_users = [{ name: 'Administrador Geral', email: 'admin@admin.com',
                       password: '123123', password_confirmation: '123123' },
                     { name: 'Prestador', email: 'prestador@prestador.com',
                       password: '123123', password_confirmation: '123123',
                       provider: true },
                     { name: 'Cliente', email: 'cliente@cliente.com',
                       password: '123123', password_confirmation: '123123' }]

    default_users.each do |user|
      User.create(name: user[:name],
                  email: user[:email],
                  password: user[:password],
                  password_confirmation: user[:password_confirmation],
                  provider: user[:provider])
    end
  end
end
