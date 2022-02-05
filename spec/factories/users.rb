# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # FIELDS
    sequence(:email) { |n| "useremail#{n}@user.com" }
    provider { false }
    password { '123123' }
    password_confirmation { '123123' }

    # ASSOCIATIONS

    # TRAITS
    trait :provider do
      provider { true }
    end
  end
end
