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
    before do
      get api_v1_countries_url, headers: valid_headers, as: :json
    end

    it 'renders successful response' do
      expect(response).to be_successful
    end

    it 'requests valid body schema' do
      assert_request_schema_confirm
    end

    it 'returns valid body schema' do
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /show' do
    context 'when finds country' do
      before do
        get api_v1_country_url(valid_attributes[:number]), as: :json
      end

      it 'renders successful response' do
        expect(response).to be_successful
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(200)
      end
    end

    context 'when not finds country' do
      before do
        get api_v1_country_url(1), as: :json
      end

      it 'renders not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(404)
      end
    end
  end
end
