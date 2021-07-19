# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    association :league
    name { 'testteam' }
  end

  factory :invalid_team, class: :team do
    association :league
    name {}
  end

  factory :new_team, class: :team do
    association :league
    name { 'testnewteam' }
  end
end
