# frozen_string_literal: true

module Api
  module V1
    class TeamsController < Api::ApplicationController
      before_action :set_team, only: %i[show update destroy]

      # GET /api/v1/teams
      def index
        @teams = Team.all

        render json: @teams
      end

      # GET /api/v1/teams/1
      def show
        render json: @team
      end

      # POST /api/v1/teams
      def create
        @team = Team.new(team_params)

        if @team.save
          render json: @team, status: :created
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/teams/1
      def update
        if @team.update(team_params)
          render json: @team, status: :ok
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/teams/1
      def destroy
        @team.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_team
        @team = Team.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def team_params
        params.require(:team).permit(:league_id, :name)
      end
    end
  end
end
