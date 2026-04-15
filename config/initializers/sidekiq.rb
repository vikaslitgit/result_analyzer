Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  # Load the cron schedule when Sidekiq server boots
  Sidekiq::Cron::Job.load_from_hash(
    "eod_statistics" => {
      "cron"  => "0 18 * * *",          # Every day at 6:00 PM UTC
      "class" => "EodStatisticsJob"
    },
    "monthly_averages" => {
      # Run every Monday at 6:05 PM — the job itself checks if it's the right Monday
      "cron"  => "5 18 * * 1",
      "class" => "MonthlyAveragesJob"
    }
  )
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end