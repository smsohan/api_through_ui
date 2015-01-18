ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
