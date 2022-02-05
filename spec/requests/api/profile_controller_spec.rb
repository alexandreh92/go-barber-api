# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/profile', type: :request do
  path '/api/profile' do
    describe 'PUT#update' do
      put 'Update profile' do
        tags 'Profile'
        consumes 'application/json'

        parameter name: :params, in: :body,
                  schema: { '$ref' => '#/components/schemas/update_profile' }
        security [Bearer: []]

        let(:user) { create(:user, :provider) }
        let(:params) do
          {
            name: 'New Name',
            password: '4321',
            password_confirmation: '4321',
            current_password: '123123'
          }
        end

        context 'with success' do
          response '200', 'successful' do
            let!(:Authorization) { auth_token_for(user) }

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                {
                  id: user.id,
                  name: params[:name]
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

          response '422', 'unprocessable entity' do
            let!(:Authorization) { auth_token_for(user) }

            before do |example|
              submit_request(example.metadata)
            end

            context 'when current password is invalid' do
              let(:params) do
                {
                  name: 'New Name',
                  password: '1234',
                  password_confirmation: '1234',
                  current_password: 'ebeb'
                }
              end

              it 'returns error' do
                expect(response.body).to include_json(
                  {
                    error: /Current password is invalid/
                  }
                )
              end
            end

            context 'when password confirmation is different than password' do
              let(:params) do
                {
                  name: 'New Name',
                  password: '1234',
                  password_confirmation: '4sda',
                  current_password: '123123'
                }
              end

              it 'returns error' do
                expect(response.body).to include_json(
                  {
                    error: /Password and password_confirmation must match/
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
