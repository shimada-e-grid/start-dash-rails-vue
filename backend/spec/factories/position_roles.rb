# frozen_string_literal: true

FactoryBot.define do
  factory :position_role do
    association :position
    name { Faker::Sports::Football.position }
    sequence(:short_name) { |n| "name_#{n}" }
  end
end
