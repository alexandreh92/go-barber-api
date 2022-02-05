# frozen_string_literal: true

module Api
  class SessionsController < ApiAuthController
    skip_before_action :authenticate_user!, only: [:create]

    def create
      @user = User.find_by_email!(session_params[:email])

      unless valid_password?
        return render json: {
          error: 'Invalid credentials'
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
