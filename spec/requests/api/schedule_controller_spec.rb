# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/schedule', type: :request do
  frozen_date = Time.zone.parse('2022-01-01 12:00:00 UTC')

  path '/api/schedule' do
    describe 'GET#index' do
      get 'List all schedule given a day' do
        tags 'Schedule'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: :date, in: :query, type: :string, required: true

        let(:user) { create(:user, :provider) }
        let(:date) { Date.today }

        context 'with success', travel: frozen_date do
          response '200', 'successful' do
            let!(:appointment) { create(:appointment, provider: user, date: DateTime.now) }
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                [
                  {
                    id: appointment.id
                  }
                ]
              )
            end
          end
        end
      end
    end
  end
end
