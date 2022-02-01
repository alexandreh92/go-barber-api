# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    # FIELDS
    date { DateTime.now }

    # ASSOCIATIONS
    association :provider, factory: :user
    user

    # TRAITS
  end
end
