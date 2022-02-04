# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    around_action :handle_exceptions

    private

      def handle_exceptions
        yield
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e }, status: :unprocessable_entity
      rescue Exceptions::NotProvider,
             Exceptions::PastDatesNotAllowed,
             Exceptions::DateNotAvailable,
             Exceptions::CancellationNotInRange,
             Exceptions::Forbidden => e
        render json: { error: e.message }, status: e.http_code
      rescue StandardError => e
        render json: { error: e }, status: :internal_server_error
      end
  end
end
