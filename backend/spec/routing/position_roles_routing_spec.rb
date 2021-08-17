# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PositionRolesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/position_roles').to route_to('api/v1/position_roles#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/position_roles/1').to route_to('api/v1/position_roles#show', id: '1')
    end
  end
end
