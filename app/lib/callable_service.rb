# frozen_string_literal: true

module CallableService
  extend ActiveSupport::Concern

  class_methods do
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
