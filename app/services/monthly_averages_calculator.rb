# Implements the "look back until 200 results" logic
class MonthlyAveragesCalculator
  MINIMUM_RESULT_COUNT = 200
  INITIAL_DAYS         = 5

  def call
    stats = collect_sufficient_stats
    return nil if stats.empty?

    MonthlyAverage.find_or_initialize_by(computed_on: Date.current).tap do |avg|
      avg.update!(
        avg_daily_high:     stats.sum(&:daily_high).to_f / stats.size,
        avg_daily_low:      stats.sum(&:daily_low).to_f  / stats.size,
        total_result_count: stats.sum(&:result_count)
      )
    end
  end

  private

  def collect_sufficient_stats
    # Start with the last 5 days, then keep going back one day at a time
    # until cumulative result_count >= 200
    stats        = []
    days_back    = INITIAL_DAYS
    total_count  = 0

    loop do
      stats       = DailyResultStatistic.order(date: :desc).limit(days_back).to_a
      total_count = stats.sum(&:result_count)

      # Stop if we have enough data OR if we've gone back through all records
      break if total_count >= MINIMUM_RESULT_COUNT
      break if stats.size < days_back   # no more records exist

      days_back += 1
    end

    stats
  end
end