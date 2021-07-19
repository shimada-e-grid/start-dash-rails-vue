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
    let(:player) { build(:player) }

    it 'belongs to team' do
      expect(player).to belong_to(:team)
    end
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
    let(:player) { build(:player) }

    it 'requires name' do
      expect(player).to validate_presence_of(:name)
    end

    it 'requires limit 100 name' do
      expect(player).to validate_length_of(:name).is_at_most(100)
    end

    it 'requires birthday' do
      expect(player).to validate_presence_of(:birthday)
    end

    it 'requires uniform_number' do
      expect(player).to validate_presence_of(:uniform_number)
    end

    it 'requires unique uniform_number scoped to team_id' do
      expect(player).to validate_uniqueness_of(:uniform_number).scoped_to(:team_id)
    end

    it 'requires country_number' do
      expect(player).to validate_presence_of(:country_number)
    end
  end
end
