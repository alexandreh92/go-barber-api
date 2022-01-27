# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by_email(session_params[:email])
    if user.present? && user.valid_password?(session_params[:password])
      sign_in(user)
      respond_with(user)
    else
      render json: {
        message: 'Invalid credentials'
      }, status: :not_authorized
    end
  end


  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_with(resource, _opts = {})
    render json: { user: resource.as_json, token: current_token }
  end

  def respond_to_on_destroy
    head :no_content
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
