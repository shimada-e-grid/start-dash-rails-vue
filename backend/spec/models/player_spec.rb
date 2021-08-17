# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { is_expected.to have_db_index(%i[team_id uniform_number]).unique(true) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:team_id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 100, null: false) }
      it { is_expected.to have_db_column(:birthday).of_type(:date).with_options(null: false) }
      it { is_expected.to have_db_column(:uniform_number).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:country_number).of_type(:integer).with_options(null: false) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:player_positions) }
    it { is_expected.to have_many(:positions).through(:player_positions) }
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:player, name: 'abc123')).to have_attributes(name: 'abc123')
    end

    it 'has country_number' do
      expect(build(:player, country_number: 234)).to have_attributes(country_number: 234)
    end
  end

  describe 'validations' do
    before do
      create(:player)
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_presence_of(:birthday) }
    it { is_expected.to validate_presence_of(:uniform_number) }
    it { is_expected.to validate_uniqueness_of(:uniform_number).scoped_to(:team_id) }
    it { is_expected.to validate_presence_of(:country_number) }
  end
end
