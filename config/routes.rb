# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resources :appointments, only: %i[index create destroy]
    resources :notifications, only: %i[index update]
  end

  scope :api do
    resources :providers, on: :collection do
      get :availables
    end
    resources :schedule, on: :collection
    put '/profile', to: 'profile#update'

    devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'sessions',
                 sign_out: 'logout'
               },
               controllers: {
                 sessions: 'sessions'
               }
    devise_scope :user do
      post '/registrations', to: 'registrations#create'
    end
  end

  get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
    !request.xhr? && request.format.html?
  }
end
