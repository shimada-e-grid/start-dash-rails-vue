# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CountriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/countries').to route_to('api/v1/countries#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/countries/1').to route_to('api/v1/countries#show', number: '1')
    end
  end
end
