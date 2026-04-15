class MonthlyAveragesJob < ApplicationJob
  queue_as :default

  def perform
    # Guard clause: only run on the correct Monday
    # (the Monday of the week containing the 3rd Wednesday)
    # This is a safety net in case sidekiq-cron fires incorrectly
    return unless MonthlyScheduleChecker.run_today?

    MonthlyAveragesCalculator.new.call
  end
end