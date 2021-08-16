# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    association :team
    name { Faker::Sports::Football.player }
    birthday { Faker::Date.birthday(min_age: 15, max_age: 50) }
    uniform_number { Faker::Number.between(from: 1, to: 99) }
    country_number { attributes_for(:country)[:number] }
  end

  factory :invalid_player, class: :player do
    association :team
    name { nil }
    birthday { nil }
    uniform_number { nil }
    country_number { nil }
  end
end
