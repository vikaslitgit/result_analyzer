require 'rails_helper'

RSpec.describe TestResult, type: :model do
  describe "validations" do
    it { should validate_presence_of(:student_name) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:marks) }
    it { should validate_presence_of(:timestamp) }

    it { should validate_numericality_of(:marks)
                  .is_greater_than_or_equal_to(0)
                  .is_less_than_or_equal_to(100)
                  .only_integer }

    it "rejects marks above 100" do
      result = build(:test_result, marks: 101)
      expect(result).not_to be_valid
      expect(result.errors[:marks]).to include("must be less than or equal to 100")//
    end

    it "rejects negative marks" do
      result = build(:test_result, marks: -1)
      expect(result).not_to be_valid
    end

    it "accepts marks at boundary values (0 and 100)" do
      expect(build(:test_result, marks: 10)).to be_valid
      expect(build(:test_result, marks: 100)).to be_valid
    end
  end

  describe ".for_date scope" do
    let(:today) { Date.current }

    before do
      # Today's result
      create(:test_result, timestamp: today.beginning_of_day + 10.hours)
      # Yesterday's result — should NOT appear
      create(:test_result, timestamp: (today - 1.day).end_of_day)
    end

    it "returns only results for the given date" do
      expect(TestResult.for_date(today).count).to eq(1)
    end
  end
end