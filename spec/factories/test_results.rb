FactoryBot.define do
  factory :test_result do
    student_name { Faker::Name.name }
    subject      { %w[Math Science English History].sample }
    marks        { rand(0..100) }
    timestamp    { Time.current }
  end
end
