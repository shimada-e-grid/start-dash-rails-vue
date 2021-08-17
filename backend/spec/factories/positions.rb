# frozen_string_literal: true

FactoryBot.define do
  factory :position do
    name { Faker::Sports::Football.position }
    sequence(:short_name) { |n| "name_#{n}" }
  end
end
