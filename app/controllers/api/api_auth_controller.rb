module Api
  class ApiAuthController < ApiController
    around_action :handle_exceptions

    private

      def handle_exceptions
        super do
          yield
        rescue ActiveRecord::RecordNotFound
          return render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
  end
end
