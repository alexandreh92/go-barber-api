# frozen_string_literal: true

Rails.application.routes.draw do
  # routes here

  get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
    !request.xhr? && request.format.html?
  }
end
