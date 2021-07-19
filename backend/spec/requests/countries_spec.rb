# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/countries', type: :request do
  let(:valid_attributes) do
    attributes_for(:country)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_countries_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_country_url(valid_attributes[:number]), as: :json
      expect(response).to be_successful
    end
  end
end
