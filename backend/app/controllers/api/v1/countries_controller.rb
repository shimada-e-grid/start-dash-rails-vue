# frozen_string_literal: true

module Api
  module V1
    class CountriesController < Api::ApplicationController
      before_action :set_country, only: [:show]

      # GET /api/v1/countries
      def index
        @countries = Country.new.all

        render json: @countries
      end

      # GET /api/v1/countries/1
      def show
        render json: @country
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_country
        @country = Country.new.find_by_number(number: params[:number])
      end
    end
  end
end
