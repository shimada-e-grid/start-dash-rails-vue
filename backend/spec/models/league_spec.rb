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

  describe 'attributes' do
    it 'has name' do
      expect(build(:league, name: 'abc123')).to have_attributes(name: 'abc123')
    end

    it 'has country_number' do
      expect(build(:league, country_number: 234)).to have_attributes(country_number: 234)
    end
  end

  describe 'validations' do
    let(:league) { build(:league) }

    it 'requires name' do
      expect(league).to validate_presence_of(:name)
    end

    it 'requires unique name' do
      expect(league).to validate_uniqueness_of(:name)
    end

    it 'requires limit 100 name' do
      expect(league).to validate_length_of(:name).is_at_most(100)
    end

    it 'requires country_number' do
      expect(league).to validate_presence_of(:country_number)
    end
  end
end
