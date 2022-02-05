# frozen_string_literal: true

module Api
  class RegistrationsController < ApiAuthController
    def create
      user = User.new(sign_up_params)
      user.save!
      sign_in(user)

      render json: { user: user }, status: :created
    end

    private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :name, :provider)
      end
  end
end
