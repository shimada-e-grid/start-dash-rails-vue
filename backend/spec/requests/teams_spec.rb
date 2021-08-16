# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/teams', type: :request do
  let!(:team) do
    create(:team, league: create(:league))
  end

  let(:valid_attributes) do
    build(:team, league: create(:league)).attributes.except('id', 'created_at', 'updated_at')
  end

  let(:invalid_attributes) do
    build(:invalid_team, league: create(:league)).attributes.except('id', 'created_at', 'updated_at')
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before do
      team
      get api_v1_teams_url, headers: valid_headers, as: :json
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
    context 'when finds team' do
      before do
        get api_v1_team_url(team), as: :json
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

    context 'when not finds team' do
      before do
        get api_v1_team_url(0), as: :json
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
      let(:create_valid_team) do
        post api_v1_teams_url, params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'creates a new team' do
        expect { create_valid_team }.to change(Team, :count).by(1)
      end

      it 'renders a JSON response with the new team' do
        create_valid_team
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end

      it 'requests valid body schema' do
        create_valid_team
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        create_valid_team
        assert_response_schema_confirm(201)
      end
    end

    context 'with invalid parameters' do
      let!(:create_invalid_team) do
        post api_v1_teams_url, params: invalid_attributes, headers: valid_headers, as: :json
      end

      it 'does not create a new team' do
        expect { create_invalid_team }.to change(Team, :count).by(0)
      end

      it 'renders a JSON response with errors for the new team' do
        create_invalid_team
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns valid body schema' do
        create_invalid_team
        assert_response_schema_confirm(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        patch api_v1_team_url(team), params: valid_attributes, headers: valid_headers, as: :json
      end

      it 'updates the requested team' do
        expect(team.attributes).not_to eq(team.reload.attributes)
      end

      it 'renders a JSON response with the team' do
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
          patch api_v1_team_url(team), params: invalid_attributes, headers: valid_headers, as: :json
        end

        it 'renders a JSON response with errors for the team' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end

        it 'returns valid body schema' do
          assert_response_schema_confirm(422)
        end
      end

      context 'when not finds league' do
        before do
          patch api_v1_team_url(0), params: invalid_attributes, headers: valid_headers, as: :json
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
    context 'when finds team' do
      let(:delete_team) do
        delete api_v1_team_url(team), headers: valid_headers, as: :json
      end

      it 'destroys the requested team' do
        expect { delete_team }.to change(Team, :count).by(-1)
      end

      it 'requests valid body schema' do
        delete_team
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_team
        assert_response_schema_confirm(204)
      end
    end

    context 'when not finds team' do
      let(:delete_not_finds_team) do
        delete api_v1_team_url(0), headers: valid_headers, as: :json
      end

      it 'does not destroys the requested team' do
        expect { delete_not_finds_team }.to change(Team, :count).by(0)
      end

      it 'renders a not found response' do
        delete_not_finds_team
        expect(response).to have_http_status(:not_found)
      end

      it 'requests valid body schema' do
        delete_not_finds_team
        assert_request_schema_confirm
      end

      it 'returns valid body schema' do
        delete_not_finds_team
        assert_response_schema_confirm(404)
      end
    end
  end
end
