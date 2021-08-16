# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/players', type: :request do
  let!(:player) do
    create(:player, team: create(:team))
  end

  let(:valid_attributes) do
    build(:player, team: create(:team)).attributes.except('id', 'created_at', 'updated_at')
  end

  let(:invalid_attributes) do
    build(:invalid_player, team: create(:team)).attributes.except('id', 'created_at', 'updated_at')
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      player
      get api_v1_players_url, headers: valid_headers, as: :json
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
    context 'when finds player' do
      before do
        get api_v1_player_url(player), as: :json
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

    context 'when not finds player' do
      before do
        get api_v1_player_url(0), as: :json
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
      let(:create_valid_player) do
        post api_v1_players_url, params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'creates a new Player' do
        expect { create_valid_player }.to change(Player, :count).by(1)
      end

      it 'renders a JSON response with the new player' do
        create_valid_player
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end

      it 'requests valid body schema' do
        create_valid_player
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        create_valid_player
        assert_response_schema_confirm(201)
      end
    end

    context 'with invalid parameters' do
      let!(:create_invalid_player) do
        post api_v1_players_url, params: invalid_attributes, headers: valid_headers, as: :json
      end

      it 'does not create a new Player' do
        expect { create_invalid_player }.to change(Player, :count).by(0)
      end

      it 'renders a JSON response with errors for the new player' do
        create_invalid_player
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns valid body schema' do
        create_invalid_player
        assert_response_schema_confirm(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        patch api_v1_player_url(player), params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'updates the requested player' do
        expect(player.attributes).not_to eq(player.reload.attributes)
      end

      it 'renders a JSON response with the player' do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end

      it 'requests valid body schema' do
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        assert_response_schema_confirm(200)
      end
    end

    context 'with invalid parameters' do
      context 'when finds league' do
        before do
          patch api_v1_player_url(player), params: invalid_attributes, headers: valid_headers, as: :json
        end

        it 'renders a JSON response with errors for the player' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end

        it 'returns valid body schema' do
          assert_response_schema_confirm(422)
        end
      end

      context 'when not finds league' do
        before do
          patch api_v1_player_url(0), params: invalid_attributes, headers: valid_headers, as: :json
        end

        it 'renders a not found response' do
          expect(response).to have_http_status(:not_found)
        end

        it 'returns valid body schema' do
          assert_response_schema_confirm(404)
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when finds player' do
      let(:delete_player) do
        delete api_v1_player_url(player), headers: valid_headers, as: :json
      end

      it 'destroys the requested player' do
        expect { delete_player }.to change(Player, :count).by(-1)
      end

      it 'requests valid body schema' do
        delete_player
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_player
        assert_response_schema_confirm(204)
      end
    end

    context 'when not finds player' do
      let(:delete_not_finds_player) do
        delete api_v1_player_url(0), headers: valid_headers, as: :json
      end

      it 'does not destroys the requested player' do
        expect { delete_not_finds_player }.to change(Player, :count).by(0)
      end

      it 'renders a not found response' do
        delete_not_finds_player
        expect(response).to have_http_status(:not_found)
      end

      it 'requests valid body schema' do
        delete_not_finds_player
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_not_finds_player
        assert_response_schema_confirm(404)
      end
    end
  end
end
