# frozen_string_literal: true

module Api
  class ApplicationController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :error400
    rescue_from ActiveRecord::RecordNotFound, with: :error404

    def error400(errors)
      render json: { messages: errors.message.split(/\R/)[0] }, status: :bad_request
    end

    def error404(errors)
      render json: { messages: errors.message }, status: :not_found
    end
  end
end
