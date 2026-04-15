# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rspec/rails'
require 'shoulda/matchers'
require 'factory_bot_rails'
require 'database_cleaner/active_record'
require 'timecop'
require 'faker'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # Use transactions for speed, but switch to truncation
  # when tests involve multiple DB connections (e.g. Sidekiq)
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  # Always return to real time after each test
  config.after(:each) { Timecop.return }

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

# Shoulda-matchers needs to know which frameworks we're using
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end