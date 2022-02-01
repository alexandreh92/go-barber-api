# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'support/simplecov'
require File.expand_path('../config/environment', __dir__)
require 'pry'
require 'shoulda/matchers'
require 'rspec/json_expectations'
require 'rspec/rails'
require 'factory_bot'

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

# Add additional requires below this line. Rails is not loaded until this point!
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!
ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.include Rails.application.routes.url_helpers
end
