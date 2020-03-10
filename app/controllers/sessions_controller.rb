# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_with(resource, _opts = {})
    render json: resource.as_json.merge(token: current_token)
  end

  def respond_to_on_destroy
    head :no_content
  end
end
