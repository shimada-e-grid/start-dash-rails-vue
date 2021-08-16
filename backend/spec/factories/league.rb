# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    name { Faker::Team.unique.name }
    country_number { attributes_for(:country)[:number] }
  end

  factory :invalid_league, class: :league do
    name { nil }
    country_number { nil }
  end
end
