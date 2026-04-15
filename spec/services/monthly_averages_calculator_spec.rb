require 'rails_helper'

RSpec.describe MonthlyAveragesCalculator do
  subject(:calculator) { described_class.new }

  context "when last 5 days have >= 200 total results" do
    before do
      # Create 5 days of stats with 50 results each = 250 total
      5.times do |i|
        create(:daily_result_statistic,
               date:         Date.current - i.days,
               subject:      "Math",
               daily_high:   90 + i,
               daily_low:    40 + i,
               result_count: 50)
      end
    end

    it "creates a monthly average record" do
      expect { calculator.call }.to change(MonthlyAverage, :count).by(1)
    end

    it "computes avg_daily_high correctly" do
      calculator.call
      avg = MonthlyAverage.last
      # (90+91+92+93+94) / 5 = 92.0
      expect(avg.avg_daily_high).to eq(92.0)
    end

    it "computes avg_daily_low correctly" do
      calculator.call
      avg = MonthlyAverage.last
      # (40+41+42+43+44) / 5 = 42.0
      expect(avg.avg_daily_low).to eq(42.0)
    end

    it "stores total_result_count of 250" do
      calculator.call
      expect(MonthlyAverage.last.total_result_count).to eq(250)
    end
  end

  context "when 5 days is not enough (< 200 results), goes back further" do
    before do
      # 5 days with only 20 results each = 100 total (not enough)
      5.times do |i|
        create(:daily_result_statistic,
               date:         Date.current - i.days,
               subject:      "Math",
               daily_high:   80,
               daily_low:    40,
               result_count: 20)
      end
      # Days 6-15 push it past 200
      10.times do |i|
        create(:daily_result_statistic,
               date:         Date.current - (i + 5).days,
               subject:      "Math",
               daily_high:   70,
               daily_low:    30,
               result_count: 20)
      end
    end

    it "goes back enough days to accumulate >= 200 results" do
      calculator.call
      expect(MonthlyAverage.last.total_result_count).to be >= 200
    end
  end

  context "when there are no records at all" do
    it "returns nil without crashing" do
      expect(calculator.call).to be_nil
    end

    it "does not create a MonthlyAverage record" do
      expect { calculator.call }.not_to change(MonthlyAverage, :count)
    end
  end
end