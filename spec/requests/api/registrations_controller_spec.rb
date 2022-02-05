# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/registrations', type: :request do
  path '/api/registrations' do
    describe 'POST#create' do
      post 'Creates an user' do
        tags 'Registration'
        consumes 'application/json'
        parameter name: :params, in: :body,
                  schema: { '$ref' => '#/components/schemas/user_registration' }

        let(:password) { '123123' }

        context 'with success' do
          response '201', 'created' do
            header :Authorization, type: :string

            let(:params) do
              {
                email: 'foo@bar.com',
                password: password,
                password_confirmation: password,
                name: 'User Name',
                provider: true
              }
            end

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                user: {
                  id: be_kind_of(Integer),
                  name: params[:name],
                  provider: params[:provider]
                }
              )
            end
          end
        end

        context 'with failure' do
          response '422', 'unprocessable entity' do
            let(:params) do
              {
                email: 'foo',
                password: password,
                password_confirmation: password,
                name: 'User Name',
                provider: true
              }
            end

            run_test! do |response|
              expect(JSON.parse(response.body)).to include_json(
                {
                  error: be_kind_of(String)
                }
              )
            end
          end
        end
      end
    end
  end
end
