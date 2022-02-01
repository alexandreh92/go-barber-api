require 'swagger_helper'

RSpec.describe 'api/appointments', type: :request do
  path '/api/appointments' do
    get('list appointments') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
