# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/teams', type: :request do
  let(:league) do
    create(:league)
  end

  let(:valid_attributes) do
    build(:team, league: league).attributes
  end

  let(:invalid_attributes) do
    build(:invalid_team, league: league).attributes
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Team.create! valid_attributes
      get api_v1_teams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      team = Team.create! valid_attributes
      get api_v1_team_url(team), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Team' do
        expect do
          post api_v1_teams_url,
               params: { team: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Team, :count).by(1)
      end

      it 'renders a JSON response with the new team' do
        post api_v1_teams_url,
             params: { team: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Team' do
        expect do
          post api_v1_teams_url,
               params: { team: invalid_attributes }, as: :json
        end.to change(Team, :count).by(0)
      end

      it 'renders a JSON response with errors for the new team' do
        post api_v1_teams_url,
             params: { team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:new_team, league: league).attributes
      end

      it 'updates the requested team' do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: new_attributes }, headers: valid_headers, as: :json
        expect(team.attributes).not_to eq(team.reload.attributes)
      end

      it 'renders a JSON response with the team' do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the team' do
        team = Team.create! valid_attributes
        patch api_v1_team_url(team),
              params: { team: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested team' do
      team = Team.create! valid_attributes
      expect do
        delete api_v1_team_url(team), headers: valid_headers, as: :json
      end.to change(Team, :count).by(-1)
    end
  end
end
