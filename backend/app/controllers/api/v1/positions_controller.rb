# frozen_string_literal: true

module Api
  module V1
    class PositionsController < Api::ApplicationController
      before_action :set_position, only: %i[show]

      # GET /api/v1/positions
      def index
        @positions = Position.all

        render json: @positions
      end

      # GET /api/v1/positions/1
      def show
        render json: @position
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_position
        @position = Position.find(params[:id])
      end
    end
  end
end
