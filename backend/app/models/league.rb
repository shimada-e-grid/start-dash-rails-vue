# frozen_string_literal: true

class League < ApplicationRecord
  validates :country_number, presence: true
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
