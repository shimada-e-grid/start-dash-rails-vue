# frozen_string_literal: true

require 'rails_helper'

RSpec.describe League, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { is_expected.to have_db_index(:name).unique(true) }
    end

    describe 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 100, null: false) }
      it { is_expected.to have_db_column(:country_number).of_type(:integer).with_options(null: false) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:teams).dependent(:destroy) }
  end

  describe 'attributes' do
    it 'has name' do
      expect(build(:league, name: 'abc123')).to have_attributes(name: 'abc123')
    end

    it 'has country_number' do
      expect(build(:league, country_number: 234)).to have_attributes(country_number: 234)
    end
  end

  describe 'validations' do
    before do
      create(:league)
    end

    it { is_expected.to validate_presence_of(:country_number) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
  end
end
