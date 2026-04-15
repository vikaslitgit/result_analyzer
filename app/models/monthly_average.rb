class MonthlyAverage < ApplicationRecord
  validates :computed_on,        presence: true, uniqueness: true
  validates :avg_daily_high,     presence: true, numericality: true
  validates :avg_daily_low,      presence: true, numericality: true
  validates :total_result_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
end