
# Determines if today is the Monday of the week
# that contains the 3rd Wednesday of the current month
class MonthlyScheduleChecker
  def self.run_today?(date = Date.current)
    new(date).run_today?
  end

  def initialize(date = Date.current)
    @date = date
  end

  def run_today?
    # First, today must be a Monday
    return false unless @date.monday?

    # Find the 3rd Wednesday of the current month
    third_wednesday = find_third_wednesday(@date.year, @date.month)

    # The "week containing the 3rd Wednesday" runs Mon–Sun
    # So we check: does today's Monday belong to that week?
    week_start = third_wednesday.beginning_of_week(:monday)

    @date == week_start
  end

  private

  def find_third_wednesday(year, month)
    # Start from the 1st of the month and find all Wednesdays
    first_day = Date.new(year, month, 1)
    first_wednesday = first_day + ((3 - first_day.wday) % 7)
    # 3rd Wednesday = first Wednesday + 14 days
    first_wednesday + 14
  end
end