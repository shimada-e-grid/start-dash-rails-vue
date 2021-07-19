# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :league
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :league_id }
end
