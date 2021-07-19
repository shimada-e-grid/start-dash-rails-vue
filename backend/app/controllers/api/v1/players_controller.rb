# frozen_string_literal: true

module Api
  module V1
    class PlayersController < Api::ApplicationController
      before_action :set_player, only: %i[show update destroy]

      # GET /api/v1/players
      def index
        @players = Player.all

        render json: @players
      end

      # GET /api/v1/players/1
      def show
        render json: @player
      end

      # POST /api/v1/players
      def create
        @player = Player.new(player_params)

        if @player.save
          render json: @player, status: :created
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/players/1
      def update
        if @player.update(player_params)
          render json: @player, status: :ok
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/players/1
      def destroy
        @player.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_player
        @player = Player.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def player_params
        params.require(:player).permit(:team_id, :name, :birthday, :uniform_number, :country_number)
      end
    end
  end
end
