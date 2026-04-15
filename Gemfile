source "https://rubygems.org"

ruby "3.2.1"

gem "rails", "~> 7.0.10"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

# Background jobs — Sidekiq processes jobs asynchronously
gem "sidekiq", "~> 7.3"

# Sidekiq-cron schedules recurring jobs (like cron, but managed by Sidekiq)
gem "sidekiq-cron", "~> 1.12"

gem "bootsnap", require: false   # Speeds up boot time by caching

group :development, :testing do
  # RSpec is the BDD testing framework — the primary evaluation criteria
  gem "rspec-rails", "~> 6.1"

  # FactoryBot creates test data cleanly without fixtures
  gem "factory_bot_rails", "~> 6.4"

  # Faker generates realistic fake data (names, subjects, marks)
  gem "faker", "~> 3.3"

  # Shoulda-matchers gives us one-liner model validation tests
  gem "shoulda-matchers", "~> 6.0"

  # DatabaseCleaner ensures each test starts with a clean DB state
  gem "database_cleaner-active_record", "~> 2.1"
end

group :test do
  # Timecop lets us freeze/travel time — critical for testing the
  # "Monday of the week containing 3rd Wednesday" schedule logic
  gem "timecop", "~> 0.9"
end