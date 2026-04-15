# This service encapsulates the EOD aggregation logic separately
# from the job itself — making it independently testable
class EodStatisticsCalculator
  def initialize(date = Date.current)
    @date = date
  end

  def call
    # Get all distinct subjects that have results for this date
    subjects = TestResult.for_date(@date).distinct.pluck(:subject)

    subjects.map do |subject|
      marks = TestResult.for_date(@date)
                        .where(subject: subject)
                        .pluck(:marks)

      # upsert_all would be ideal but find_or_initialize gives
      # us better control and cleaner error messages
      stat = DailyResultStatistic.find_or_initialize_by(
        date: @date, subject: subject
      )

      stat.update!(
        daily_low:    marks.min,
        daily_high:   marks.max,
        result_count: marks.count
      )

      stat
    end
  end
end