# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    # FIELDS
    sequence(:content) { |n| "Content #{n}" }
    read { [true, false].sample }

    # ASSOCIATIONS
    user
    association :provider, factory: :user

    # TRAITS
  end
end
