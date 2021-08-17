# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/position_roles', type: :request do
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      create(:position_role)
      get api_v1_position_roles_url, headers: valid_headers, as: :json
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
    context 'when finds position_role' do
      before do
        position_role = create(:position_role)
        get api_v1_position_role_url(position_role), as: :json
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

    context 'when not finds position_role' do
      before do
        get api_v1_position_role_url(0), as: :json
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
