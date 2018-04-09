require 'spec_helper'
require 'capybara/rspec'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'support/i18n_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods
  config.include I18nHelper, type: :feature

  config.use_transactional_fixtures = false
  config.before(:suite) { Warden.test_mode! }

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
