# frozen_string_literal: true

class ProvidersController < ApplicationController
  def index
    @providers = User.where(provider: true)

    render json: @providers
  end
end
