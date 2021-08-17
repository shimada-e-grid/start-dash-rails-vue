# frozen_string_literal: true

class PositionRole < ApplicationRecord
  belongs_to :position
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
end
