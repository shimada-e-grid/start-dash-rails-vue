# frozen_string_literal: true

module Api
  module V1
    class LeaguesController < Api::ApplicationController
      before_action :set_league, only: %i[show update destroy]

      # GET /api/v1//leagues
      def index
        @leagues = League.all

        render json: @leagues
      end

      # GET /api/v1//leagues/1
      def show
        render json: @league
      end

      # POST /api/v1//leagues
      def create
        @league = League.new(league_params)

        if @league.save
          render json: @league, status: :created
        else
          render json: @league.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1//leagues/1
      def update
        if @league.update(league_params)
          render json: @league, status: :ok
        else
          render json: @league.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1//leagues/1
      def destroy
        @league.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_league
        @league = League.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def league_params
        params.require(:league).permit(:name, :country_number)
      end
    end
  end
end
