# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/leagues', type: :request do
  let!(:league) do
    create(:league)
  end

  let(:valid_attributes) do
    attributes_for(:league)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_league)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      league
      get api_v1_leagues_url, headers: valid_headers, as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'requests valid body schema' do
      assert_request_schema_confirm
    end

    it 'returns valid body schema' do
      assert_response_schema_confirm(200)
    end
  end

  describe 'GET /show' do
    context 'when finds league' do
      before do
        get api_v1_league_url(league), as: :json
      end

      it 'renders a successful response' do
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(200)
      end
    end

    context 'when not finds league' do
      before do
        get api_v1_league_url(0), as: :json
      end

      it 'renders a not found response' do
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

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:create_valid_league) do
        post api_v1_leagues_url, params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'creates a new League' do
        expect { create_valid_league }.to change(League, :count).by(1)
      end

      it 'renders a JSON response with the new league' do
        create_valid_league
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end

      it 'requests valid body schema' do
        create_valid_league
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        create_valid_league
        assert_response_schema_confirm(201)
      end
    end

    context 'with invalid parameters' do
      let!(:create_invalid_league) do
        post api_v1_leagues_url, params: invalid_attributes, headers: valid_headers, as: :json
      end

      it 'does not create a new League' do
        expect { create_invalid_league }.to change(League, :count).by(0)
      end

      it 'renders a JSON response with errors for the new league' do
        create_invalid_league
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns valid body schema' do
        create_invalid_league
        assert_response_schema_confirm(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'when finds league with valid parameters' do
      before do
        patch api_v1_league_url(league), params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'updates the requested league' do
        expect(league.attributes).not_to eq(league.reload.attributes)
      end

      it 'renders a JSON response with errors for the league' do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(200)
      end
    end

    context 'when not finds league' do
      before do
        patch api_v1_league_url(0), params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'renders a not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(404)
      end
    end

    context 'with invalid parameters' do
      before do
        patch api_v1_league_url(league), params: invalid_attributes, headers: valid_headers, as: :json
      end

      it 'renders a JSON response with errors for the league' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when finds league' do
      let(:delete_league) do
        delete api_v1_league_url(league), headers: valid_headers, as: :json
      end

      it 'destroys the requested league' do
        expect { delete_league }.to change(League, :count).by(-1)
      end

      it 'requests valid body schema' do
        delete_league
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_league
        assert_response_schema_confirm(204)
      end
    end

    context 'when not finds league' do
      let(:delete_not_finds_league) do
        delete api_v1_league_url(0), headers: valid_headers, as: :json
      end

      it 'does not destroys the requested league' do
        expect { delete_not_finds_league }.to change(League, :count).by(0)
      end

      it 'renders a not found response' do
        delete_not_finds_league
        expect(response).to have_http_status(:not_found)
      end

      it 'requests valid body schema' do
        delete_not_finds_league
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_not_finds_league
        assert_response_schema_confirm(404)
      end
    end
  end
end
