# frozen_string_literal: true

require 'spec_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...',
  # swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'GoBarber API V1',
        version: 'v1',
        description: 'This is the documentation for GoBarberAPI'
      },
      servers: [
        {
          url: "http://localhost:#{ENV['RAILS_PORT'] || 3000}",
          description: 'Development server'
        },
        {
          url: (ENV['SWAGGER_PRODUCTION_URL']).to_s,
          description: 'Production server (uses live data)'
        }
      ],
      components: {
        schemas: {
          new_appointment: {
            type: 'object',
            properties: {
              date: { type: 'string' },
              provider_id: { type: 'integer', example: 1 }
            },
            required: %w[date provider_id]
          },
          update_profile: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              password: { type: 'string' },
              password_confirmation: { type: 'string' },
              current_password: { type: 'string' },
              avatar: { type: 'string' }
            }
          },
          user_session: {
            type: 'object',
            properties: {
              email: { type: 'string' },
              password: { type: 'string' }
            },
            required: %w[email password]
          },
          user_registration: {
            type: 'object',
            properties: {
              email: { type: 'string' },
              password: { type: 'string' },
              password_confirmation: { type: 'string' },
              name: { type: 'string' },
              provider: { type: 'boolean' }
            },
            required: %w[email password password_confirmation name provider]
          }
        },
        securitySchemes: {
          Bearer: {
            description: 'JWT key necessary to use API calls',
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        }
      }

    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
