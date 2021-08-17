# frozen_string_literal: true

FactoryBot.define do
  factory :player_position do
    association :player
    association :position
  end
end
