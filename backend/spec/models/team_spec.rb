# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { is_expected.to have_db_index(%i[league_id name]).unique(true) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:league_id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 100, null: false) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:league) }
    it { is_expected.to have_many(:players) }
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:team, name: 'abc123')).to have_attributes(name: 'abc123')
    end
  end

  describe 'validations' do
    let(:team) { build(:team) }

    it 'requires name' do
      expect(team).to validate_presence_of(:name)
    end

    it 'requires limit 100 name' do
      expect(team).to validate_length_of(:name).is_at_most(100)
    end
  end
end
