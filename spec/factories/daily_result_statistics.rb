FactoryBot.define do
  factory :daily_result_statistic do
    date         { Date.current }
    subject      { %w[Math Science English History].sample }
    daily_low    { rand(0..50) }
    daily_high   { rand(51..100) }
    result_count { rand(10..50) }
  end
end