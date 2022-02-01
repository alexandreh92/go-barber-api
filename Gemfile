# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'carrierwave', '~> 2.0'
gem 'devise', '~> 4.7.1'
gem 'devise-jwt'
gem 'dry-configurable', '0.9.0'
gem 'faker', '~> 2.10.2'
gem 'fog-aws'
gem 'foreman', '~> 0.87'
gem 'mimemagic'
gem 'mini_magick'
gem 'pg', '~> 1.2'
gem 'rack-cors'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sentry-raven'
gem 'slim-rails'
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem 'better_errors'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rswag-specs'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-json_expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'timecop'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
