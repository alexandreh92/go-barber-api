# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/appointments', type: :request do
  path '/api/appointments' do
    get 'List all appointments' do
      consumes 'application/json'
      parameter name: :page, in: :query, type: :string, required: false
      security [Bearer: []]

      let(:page) { 1 }
      let!(:appointment) { create(:appointment, user: user) }
      let(:user) { create(:user, :provider) }

      response '200', 'successful' do
        let!(:Authorization) { auth_token_for(user) }

        run_test! do |response|
          expect(JSON.parse(response.body)).to include_json(
            appointments: [{
              id: appointment.id
            }]
          )
        end
      end

      response '401', 'unauthorized' do
        let!(:Authorization) { 'no-token' }

        run_test! do |response|
          expect(response.body).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
end
