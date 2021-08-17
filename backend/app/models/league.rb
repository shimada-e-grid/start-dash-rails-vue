# frozen_string_literal: true

class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  validates :country_number, presence: true
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
