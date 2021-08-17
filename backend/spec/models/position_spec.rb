# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { is_expected.to have_db_index(:name).unique(true) }
      it { is_expected.to have_db_index(:short_name).unique(true) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 50, null: false) }
      it { is_expected.to have_db_column(:short_name).of_type(:string).with_options(limit: 10, null: false) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:position_roles).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:player_positions) }
    it { is_expected.to have_many(:players).through(:player_positions) }
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:position, name: 'abc123')).to have_attributes(name: 'abc123')
    end

    it 'has short name' do
      expect(build(:position, short_name: 'abc')).to have_attributes(short_name: 'abc')
    end
  end

  describe 'validations' do
    before do
      create(:position)
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:short_name) }
    it { is_expected.to validate_length_of(:short_name).is_at_most(10) }
    it { is_expected.to validate_uniqueness_of(:short_name) }
  end
end
