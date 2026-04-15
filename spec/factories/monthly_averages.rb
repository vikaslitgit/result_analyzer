FactoryBot.define do
  factory :monthly_average do
    computed_on { "2026-04-15" }
    avg_daily_high { "9.99" }
    avg_daily_low { "9.99" }
    total_result_count { 1 }
  end
end
