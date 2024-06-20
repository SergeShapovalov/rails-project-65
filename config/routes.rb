# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  scope module: :web do
    root 'bulletins#index'

    resources :bulletins do
      member do
        patch :moderate, :archive
      end
    end

    resource :profile, only: :show

    post 'auth/sign_out', to: 'auth#sign_out', as: :sign_out
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    namespace :admin do
      root 'home#index'
      resources :categories

      resources :bulletins, only: :index do
        member do
          patch :publish, :reject, :archive
        end
      end
    end
  end
end
