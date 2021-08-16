# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    association :league
    name { Faker::Sports::Football.team }
  end

  factory :invalid_team, class: :team do
    association :league
    name { nil }
  end
end
