# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
      @user = User.find_by_email!(session_params[:email])

      unless valid_password?
        render json: {
          message: 'Invalid credentials'
        }, status: :unauthorized
      end

      sign_in(@user)
      render json: { user: @user.as_json }, status: :created
    end

    private

      def valid_password?
        @user.valid_password?(session_params[:password])
      end

      def respond_to_on_destroy
        head :no_content
      end

      def session_params
        params.permit(:email, :password)
      end
  end
end
