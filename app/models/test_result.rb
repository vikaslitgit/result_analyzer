class TestResult < ApplicationRecord
  # Validations ensure we never store garbage data
  validates :student_name, presence: true
  validates :subject,      presence: true
  validates :timestamp,    presence: true

  # marks must be between 0 and 100 — as confirmed with assigner
  validates :marks, presence: true,
                    numericality: { 
                      only_integer: true, 
                      greater_than_or_equal_to: 0, 
                      less_than_or_equal_to: 100 
                    }

  # Scope to fetch results for a specific date — used by EOD job
  # We compare against UTC date since the system runs on UTC
  scope :for_date, ->(date) {
    where(timestamp: date.beginning_of_day..date.end_of_day)
  }
end