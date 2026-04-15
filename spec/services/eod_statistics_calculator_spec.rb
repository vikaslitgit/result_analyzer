require 'rails_helper'

RSpec.describe EodStatisticsCalculator do
  let(:today) { Date.new(2024, 6, 15) }

  before do
    Timecop.freeze(Time.utc(2024, 6, 15, 12, 0, 0))

    # Use Time.utc explicitly — today.to_time uses system local timezone (+0530 IST)
    # which shifts midnight to the previous day in UTC, breaking the for_date scope
    create(:test_result, subject: "Math",    marks: 80, timestamp: Time.utc(2024, 6, 15, 9, 0))
    create(:test_result, subject: "Math",    marks: 60, timestamp: Time.utc(2024, 6, 15, 10, 0))
    create(:test_result, subject: "Math",    marks: 95, timestamp: Time.utc(2024, 6, 15, 11, 0))
    create(:test_result, subject: "Science", marks: 45, timestamp: Time.utc(2024, 6, 15, 9, 30))
    create(:test_result, subject: "Science", marks: 70, timestamp: Time.utc(2024, 6, 15, 10, 30))

    # Yesterday — must NOT be included in today's stats
    create(:test_result, subject: "Math", marks: 10, timestamp: Time.utc(2024, 6, 14, 15, 0))
  end

  subject(:calculator) { described_class.new(today) }

  it "creates one statistic record per subject" do
    calculator.call
    expect(DailyResultStatistic.count).to eq(2)
  end

  it "calculates correct daily_low for Math" do
    calculator.call
    stat = DailyResultStatistic.find_by(subject: "Math", date: today)
    expect(stat.daily_low).to eq(60)
  end

  it "calculates correct daily_high for Math" do
    calculator.call
    stat = DailyResultStatistic.find_by(subject: "Math", date: today)
    expect(stat.daily_high).to eq(95)
  end

  it "calculates correct result_count" do
    calculator.call
    stat = DailyResultStatistic.find_by(subject: "Math", date: today)
    expect(stat.result_count).to eq(3)
  end

  it "does not include results from other dates" do
    calculator.call
    stat = DailyResultStatistic.find_by(subject: "Math", date: today)
    expect(stat.daily_low).not_to eq(10)
  end

  it "skips subjects with no results for the day" do
    calculator.call
    expect(DailyResultStatistic.pluck(:subject)).not_to include("History")
  end

  it "handles a single result per subject correctly" do
    calculator.call
    stat = DailyResultStatistic.find_by(subject: "Science", date: today)
    expect(stat.daily_low).to  eq(45)
    expect(stat.daily_high).to eq(70)
  end
end