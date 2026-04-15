# app/jobs/eod_statistics_job.rb
class EodStatisticsJob < ApplicationJob
  queue_as :default

  def perform
    EodStatisticsCalculator.new(Date.current).call
  end
end