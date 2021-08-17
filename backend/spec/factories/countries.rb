# frozen_string_literal: true

FactoryBot.define do
  country = Country.new.all.sample
  factory :country do
    number { country.number }
    name { country.name }
  end
end
