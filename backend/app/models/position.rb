# frozen_string_literal: true

class Position < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
end
