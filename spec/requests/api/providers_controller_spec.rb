# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/providers', type: :request do
  frozen_date = Time.zone.parse('2022-01-01 13:00:00 UTC')

  path '/api/providers' do
    describe 'GET#index' do
      get 'List all providers' do
        tags 'Providers'
        consumes 'application/json'
        security [Bearer: []]

        let(:user) { create(:user, :provider) }

        context 'with success' do
          response '200', 'successful' do
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                [{
                  id: user.id
                }]
              )
            end
          end
        end
      end
    end
  end

  path '/api/providers/availables' do
    describe 'GET#availables', travel: frozen_date do
      get 'List all available dates' do
        tags 'Providers'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: :date, in: :query, type: :string, required: true
        parameter name: :provider_id, in: :query, type: :string, required: true

        let(:user) { create(:user, :provider) }
        let!(:appointment) { create(:appointment, provider: user, date: appointment_date) }
        let(:appointment_date) { Time.zone.now + 2.hour }

        let(:provider_id) { user.id }
        let(:date) { Time.zone.now }

        context 'with success' do
          response '200', 'successful' do
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include(
                {
                  'time' => appointment_date.strftime('%R'),
                  'value' => appointment_date.strftime('%FT%T.%L%:z'),
                  'available' => false
                }
              )
            end
          end
        end
      end
    end
  end
end
