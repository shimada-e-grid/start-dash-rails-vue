# frozen_string_literal: true

module Api
  module V1
    class PositionRolesController < Api::ApplicationController
      before_action :set_position_role, only: %i[show]

      # GET /position_roles
      def index
        @position_roles = PositionRole.all

        render json: @position_roles
      end

      # GET /position_roles/1
      def show
        render json: @position_role
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_position_role
        @position_role = PositionRole.find(params[:id])
      end
    end
  end
end
