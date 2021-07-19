# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  describe '#all' do
    let(:countries) { described_class.new.all }

    it 'returns all countries' do
      expect(countries.count).to eq 249
      expect(countries.find { |key| key.number == 392 }).to have_attributes(number: 392, name: 'Japan')
    end
  end

  describe '#find_by_number' do
    it 'returns Japan when 392 argument' do
      expect(described_class.new.find_by_number(392)).to have_attributes(number: 392, name: 'Japan')
    end

    it 'returns empty hash when not exist country number argument' do
      expect(described_class.new.find_by_number(123)).not_to include(:number) && include(:name)
    end
  end
end
