# frozen_string_literal: true

module Api
  class ProvidersController < ApiController
    def index
      providers = User.where(provider: true)

      render json: providers
    end

    def availables
      date = DateTime.parse(provider_params[:date])

      available_dates = Providers::GenerateAvailableHoursService.call(
        provider_id: params[:provider_id],
        date: date
      )

      render json: available_dates
    end

    private

      def provider_params
        params.permit(:date)
      end
  end
end
