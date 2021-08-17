# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :team
  has_many :player_positions, dependent: :destroy
  has_many :positions, through: :player_positions
  validates :name, presence: true, length: { maximum: 100 }
  validates :birthday, presence: true
  validates :uniform_number, presence: true, uniqueness: { scope: :team_id }
  validates :country_number, presence: true
end
