# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(current_user.id)
    if @user.update_resource(profile_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  private

  def profile_params
    params.permit(:name, :password, :password_confirmation, :current_password, :avatar)
  end
end
