# frozen_string_literal: true

require 'timecop'

RSpec.configure do |config|
  config.around(:each, :travel) do |example|
    Timecop.freeze(example.metadata[:travel]) do
      example.run
    end
  end
end
