# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerPosition, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { is_expected.to have_db_index(%i[player_id position_id]).unique(true) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:player_id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:position_id).of_type(:integer).with_options(null: false) }
    end
  end

  describe 'associations' do
    before do
      create(:player_position, player: create(:player), position: create(:position))
    end

    it { is_expected.to belong_to(:player) }
    it { is_expected.to belong_to(:position) }
  end

  describe 'validations' do
    before do
      create(:player_position, player: create(:player), position: create(:position))
    end

    it { is_expected.to validate_uniqueness_of(:player).scoped_to(:position_id) }
  end
end
