# frozen_string_literal: true

namespace :start do
  task :development do
    exec 'foreman start -f Profile.dev'
  end
end
