# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/appointments', type: :request do
  frozen_date = Time.zone.parse('2022-01-01 00:00:00 UTC')

  path '/api/appointments' do
    describe 'GET#index' do
      get 'List all appointments' do
        tags 'Appointments'
        consumes 'application/json'
        parameter name: :page, in: :query, type: :string, required: false
        security [Bearer: []]

        let(:page) { 1 }
        let(:user) { create(:user, :provider) }
        let!(:appointment) { create(:appointment, user: user) }

        context 'with success' do
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
        end

        context 'with failure' do
          response '401', 'unauthorized' do
            let!(:Authorization) { 'no-token' }

            run_test! do |response|
              expect(response.body).to eq(
                'You need to sign in or sign up before continuing.'
              )
            end
          end
        end
      end
    end

    describe 'POST#create' do
      post 'Create an appointment' do
        tags 'Appointments'
        consumes 'application/json'
        parameter name: :params, in: :body,
                  schema: { '$ref' => '#/components/schemas/new_appointment' }
        security [Bearer: []]

        let!(:user) { create(:user) }
        let!(:provider) { create(:user, :provider) }

        context 'with success', travel: frozen_date do
          response '201', 'created' do
            let(:Authorization) { auth_token_for(user) }
            let(:params) { { date: DateTime.tomorrow, provider_id: provider.id } }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                {
                  id: be_kind_of(Integer),
                  provider_id: provider.id,
                  user_id: user.id
                }
              )
            end
          end
        end

        context 'with failure' do
          response '401', 'unauthorized' do
            let(:Authorization) { 'no-token' }
            let(:params) { { date: DateTime.tomorrow, provider_id: provider.id } }

            run_test! do |response|
              expect(response.body).to eq(
                'You need to sign in or sign up before continuing.'
              )
            end
          end

          context 'when provider_id is not a provider', travel: frozen_date do
            response '422', 'rejected' do
              let!(:provider) { create(:user, provider: false) }
              let(:Authorization) { auth_token_for(user) }
              let(:params) { { date: DateTime.tomorrow, provider_id: provider.id } }

              run_test! do |response|
                expect(JSON.parse(response.body)).to include_json(
                  {
                    error: 'You can only create appointments with providers'
                  }
                )
              end
            end
          end

          context 'when date is in the past', travel: frozen_date do
            response '422', 'rejected' do
              let(:Authorization) { auth_token_for(user) }
              let(:params) { { date: DateTime.yesterday, provider_id: provider.id } }

              run_test! do |response|
                expect(JSON.parse(response.body)).to include_json(
                  {
                    error: 'Past dates are not permitted.'
                  }
                )
              end
            end
          end

          context 'when date is not available', travel: frozen_date do
            response '422', 'rejected' do
              let!(:some_appointment) do
                create(:appointment,
                       date: DateTime.tomorrow.at_midday,
                       provider_id: provider.id,
                       user_id: user.id)
              end
              let(:Authorization) { auth_token_for(user) }
              let(:params) do
                { date: DateTime.tomorrow.at_midday, provider_id: provider.id }
              end

              run_test! do |response|
                expect(JSON.parse(response.body)).to include_json(
                  {
                    error: 'Appointment date is not available for schedule.'
                  }
                )
              end
            end
          end
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    describe 'DELETE#destroy' do
      delete 'Delete an appointment' do
        tags 'Appointments'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        security [Bearer: []]

        let!(:user) { create(:user) }
        let!(:provider) { create(:user, :provider) }

        context 'with success', travel: frozen_date do
          response '200', 'successful' do
            let(:Authorization) { auth_token_for(user) }
            let(:id) { appointment.id }

            let(:appointment) do
              create(:appointment,
                     user: user,
                     provider: provider,
                     date: DateTime.tomorrow)
            end

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                {
                  id: appointment.id,
                  provider_id: provider.id,
                  user_id: user.id
                }
              )
            end
          end
        end

        context 'with failure', travel: frozen_date do
          response '401', 'unauthorized' do
            let(:another_user) { create(:user) }
            let(:Authorization) { 'no-token' }
            let(:id) { appointment.id }

            let(:appointment) do
              create(:appointment,
                     user: user,
                     provider: provider,
                     date: DateTime.tomorrow)
            end

            run_test! do |response|
              expect(response.body).to eq(
                'You need to sign in or sign up before continuing.'
              )
            end
          end

          context 'when user is not the appointments owner' do
            response '403', 'forbidden' do
              let(:another_user) { create(:user) }
              let(:Authorization) { auth_token_for(another_user) }
              let(:id) { appointment.id }

              let(:appointment) do
                create(:appointment,
                       user: user,
                       provider: provider,
                       date: DateTime.tomorrow)
              end

              run_test! do |response|
                expect(JSON.parse(response.body)).to include_json(
                  {
                    error: "You don't have permission to cancel this appointment."
                  }
                )
              end
            end
          end

          context 'when cancellation time is less than 2 hours' do
            response '422', 'unprocessable entity' do
              let(:Authorization) { auth_token_for(user) }
              let(:id) { appointment.id }

              let(:appointment) do
                create(:appointment,
                       user: user,
                       provider: provider,
                       date: DateTime.now + 1.hour)
              end

              run_test! do |response|
                expect(JSON.parse(response.body)).to include_json(
                  {
                    error: 'You can only cancel appointments 2 hours in advance.'
                  }
                )
              end
            end
          end
        end
      end
    end
  end
end
