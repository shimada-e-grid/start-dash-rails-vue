# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index show], param: :number
      resources :players
      resources :position_roles, only: %i[index show]
      resources :positions, only: %i[index show]
      resources :teams
      resources :leagues
    end
  end
end
