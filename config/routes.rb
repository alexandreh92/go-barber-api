# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resources :appointments, only: %i[index create destroy]
    resources :notifications, only: %i[index update]
    resources :profile, only: [:none] do
      put :update, on: :collection
    end
    resources :providers, only: [:index] do
      get :availables, on: :collection
    end
    resources :schedule, only: [:index]
  end

  scope :api do
    devise_for :users, skip: :all
    as :user do
      post :sessions, to: 'api/sessions#create', as: :user_session
      post :registrations, to: 'api/registrations#create', as: :user_registration
    end
  end
end
