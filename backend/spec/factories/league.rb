# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    name { 'testleague' }
    country_number { attributes_for(:country)[:number] }
  end

  factory :invalid_league, class: :league do
    name {}
    country_number {}
  end

  factory :new_league, class: :league do
    name { 'testnewleague' }
    country_number { attributes_for(:country)[:number] }
  end
end
