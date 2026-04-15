require 'rails_helper'

RSpec.describe MonthlyScheduleChecker do
  describe ".run_today?" do
    # June 2024: 3rd Wednesday = June 19
    # Week of June 19 starts Monday June 17
    context "when today is the correct Monday (June 17, 2024)" do
      it "returns true" do
        Timecop.freeze(Date.new(2024, 6, 17)) do
          expect(described_class.run_today?).to be true
        end
      end
    end

    context "when today is NOT a Monday" do
      it "returns false on Tuesday" do
        Timecop.freeze(Date.new(2024, 6, 18)) do
          expect(described_class.run_today?).to be false
        end
      end

      it "returns false on the 3rd Wednesday itself" do
        Timecop.freeze(Date.new(2024, 6, 19)) do
          expect(described_class.run_today?).to be false
        end
      end
    end

    context "when today is a Monday but NOT the correct one" do
      it "returns false for the previous Monday (June 10)" do
        Timecop.freeze(Date.new(2024, 6, 10)) do
          expect(described_class.run_today?).to be false
        end
      end

      it "returns false for the next Monday (June 24)" do
        Timecop.freeze(Date.new(2024, 6, 24)) do
          expect(described_class.run_today?).to be false
        end
      end
    end

    # Test across different months to ensure the algorithm is correct
    context "cross-month verification" do
      # January 2024: 3rd Wed = Jan 17, so correct Monday = Jan 15
      it "works correctly for January 2024" do
        Timecop.freeze(Date.new(2024, 1, 15)) do
          expect(described_class.run_today?).to be true
        end
      end

      # February 2024: 3rd Wed = Feb 21, so correct Monday = Feb 19
      it "works correctly for February 2024" do
        Timecop.freeze(Date.new(2024, 2, 19)) do
          expect(described_class.run_today?).to be true
        end
      end

      # March 2024: 3rd Wed = Mar 20, so correct Monday = Mar 18
      it "works correctly for March 2024" do
        Timecop.freeze(Date.new(2024, 3, 18)) do
          expect(described_class.run_today?).to be true
        end
      end
    end
  end
end