# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PositionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/positions').to route_to('api/v1/positions#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/positions/1').to route_to('api/v1/positions#show', id: '1')
    end
  end
end
