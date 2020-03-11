# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :providers, on: :collection do
      get :availables
    end
    resources :appointments, on: :collection
    resources :schedule, on: :collection
    resources :notifications, on: :collection

    devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'sessions',
                 sign_out: 'logout'
               },
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
               }
  end

  get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
    !request.xhr? && request.format.html?
  }
end
