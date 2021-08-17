# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/positions', type: :request do
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      create(:position)
      get api_v1_positions_url, headers: valid_headers, as: :json
    end

    it 'renders a successful response' do
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
    context 'when finds position' do
      before do
        position = create(:position)
        get api_v1_position_url(position), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(200)
      end
    end

    context 'when not finds position' do
      before do
        get api_v1_position_url(0), as: :json
      end

      it 'renders a successful response' do
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
