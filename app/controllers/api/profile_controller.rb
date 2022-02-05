# frozen_string_literal: true

module Api
  class ProfileController < ApiController
    def update
      user = User.find(current_user.id)
      validate_password!
      user.update(profile_params)

      render json: user
    end

    private

      def validate_password!
        Users::ValidatePasswordService.call(
          user_id: current_user.id,
          new_password: profile_params[:password],
          new_password_confirmation: profile_params[:password_confirmation],
          current_password: params[:current_password]
        )
      end

      def profile_params
        params.permit(:name, :password, :password_confirmation, :avatar)
      end
  end
end
