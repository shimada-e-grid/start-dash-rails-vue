# frozen_string_literal: true

class Position < ApplicationRecord
  has_many :position_roles, dependent: :restrict_with_exception
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
end
