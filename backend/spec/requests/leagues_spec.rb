# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/leagues', type: :request do
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
    it 'renders a successful response' do
      League.create! valid_attributes
      get api_v1_leagues_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      league = League.create! valid_attributes
      get api_v1_league_url(league), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new League' do
        expect do
          post api_v1_leagues_url, params: { league: valid_attributes }, headers: valid_headers, as: :json
        end.to change(League, :count).by(1)
      end

      it 'renders a JSON response with the new league' do
        post api_v1_leagues_url, params: { league: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new League' do
        expect do
          post api_v1_leagues_url,
               params: { league: invalid_attributes }, as: :json
        end.to change(League, :count).by(0)
      end

      it 'renders a JSON response with errors for the new league' do
        post api_v1_leagues_url,
             params: { league: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for(:new_league)
      end

      it 'updates the requested league' do
        league = League.create! valid_attributes
        patch api_v1_league_url(league),
              params: { league: new_attributes }, headers: valid_headers, as: :json
        expect(league.attributes).not_to eq(league.reload.attributes)
      end

      it 'renders a JSON response with the league' do
        league = League.create! valid_attributes
        patch api_v1_league_url(league),
              params: { league: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the league' do
        league = League.create! valid_attributes
        patch api_v1_league_url(league),
              params: { league: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested league' do
      league = League.create! valid_attributes
      expect do
        delete api_v1_league_url(league), headers: valid_headers, as: :json
      end.to change(League, :count).by(-1)
    end
  end
end
