# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/notifications', type: :request do
  path '/api/notifications' do
    describe 'GET#index' do
      get 'List all notifications' do
        tags 'Notifications'
        consumes 'application/json'
        security [Bearer: []]

        let(:user) { create(:user, :provider) }
        let!(:notification) { create(:notification, provider: user) }

        context 'with success' do
          response '200', 'successful' do
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                notifications: [{
                  id: notification.id
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
  end

  path '/api/notifications/{id}' do
    describe 'PUT#update' do
      put 'Read notification' do
        tags 'Notifications'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: :id, in: :path, type: :string

        let(:user) { create(:user, :provider) }
        let!(:notification) { create(:notification, provider: user, read: false) }
        let(:id) { notification.id }

        context 'with success' do
          response '200', 'successful' do
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                {
                  id: notification.id,
                  read: true
                }
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
  end
end
