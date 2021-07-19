# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    association :team
    name { 'testplayer' }
    birthday { Date.new(1990, 1, 23) }
    uniform_number { 10 }
    country_number { attributes_for(:country)[:number] }
  end

  factory :invalid_player, class: :player do
    association :team
    name {}
    birthday {}
    uniform_number {}
    country_number {}
  end

  factory :new_player, class: :player do
    association :team
    name { 'testnewplayer' }
    birthday { Date.new(1994, 3, 21) }
    uniform_number { 9 }
    country_number { attributes_for(:country)[:number] }
  end
end
