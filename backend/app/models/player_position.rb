# frozen_string_literal: true

class PlayerPosition < ApplicationRecord
  belongs_to :player
  belongs_to :position
  validates :player, presence: true, uniqueness: { scope: :position_id }
  validates :position, presence: true
end
