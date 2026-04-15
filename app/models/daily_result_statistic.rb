class DailyResultStatistic < ApplicationRecord
  validates :date,         presence: true
  validates :subject,      presence: true
  validates :daily_low,    presence: true, numericality: { only_integer: true }
  validates :daily_high,   presence: true, numericality: { only_integer: true }
  validates :result_count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Prevent duplicate records for the same subject on the same day
  validates :subject, uniqueness: { scope: :date }

  # Fetch the most recent N days of stats — used by MonthlyAveragesJob
  scope :recent_days, ->(n) {
    order(date: :desc).limit(n)
  }
end