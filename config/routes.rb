# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
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
