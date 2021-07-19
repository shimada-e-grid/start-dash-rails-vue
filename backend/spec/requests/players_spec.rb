# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/players', type: :request do
  let(:team) do
    create(:team)
  end

  let(:valid_attributes) do
    build(:player, team: team).attributes
  end

  let(:invalid_attributes) do
    build(:invalid_player, team: team).attributes
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Player.create! valid_attributes
      get api_v1_players_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      player = Player.create! valid_attributes
      get api_v1_player_url(player), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Player' do
        expect do
          post api_v1_players_url,
               params: { player: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Player, :count).by(1)
      end

      it 'renders a JSON response with the new player' do
        post api_v1_players_url,
             params: { player: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Player' do
        expect do
          post api_v1_players_url,
               params: { player: invalid_attributes }, as: :json
        end.to change(Player, :count).by(0)
      end

      it 'renders a JSON response with errors for the new player' do
        post api_v1_players_url,
             params: { player: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:new_player, team: team).attributes
      end

      it 'updates the requested player' do
        player = Player.create! valid_attributes
        patch api_v1_player_url(player),
              params: { player: new_attributes }, headers: valid_headers, as: :json
        expect(player.attributes).not_to eq(player.reload.attributes)
      end

      it 'renders a JSON response with the player' do
        player = Player.create! valid_attributes
        patch api_v1_player_url(player),
              params: { player: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the player' do
        player = Player.create! valid_attributes
        patch api_v1_player_url(player),
              params: { player: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested player' do
      player = Player.create! valid_attributes
      expect do
        delete api_v1_player_url(player), headers: valid_headers, as: :json
      end.to change(Player, :count).by(-1)
    end
  end
end
