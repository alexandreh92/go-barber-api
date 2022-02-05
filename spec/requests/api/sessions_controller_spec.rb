# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/sessions', type: :request do
  path '/api/sessions' do
    describe 'POST#create' do
      post 'Creates a session' do
        tags 'Session'
        consumes 'application/json'
        parameter name: :params, in: :body,
                  schema: { '$ref' => '#/components/schemas/user_session' }

        let(:user) { create(:user, :provider, password: password) }
        let(:password) { '123123' }

        context 'with success' do
          response '201', 'created' do
            header :Authorization, type: :string

            let(:params) { { email: user.email, password: password } }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                user: {
                  id: user.id
                }
              )
            end
          end
        end

        context 'with failure' do
          response '401', 'unauthorized' do
            let(:params) { { email: user.email, password: 'no-password' } }

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
