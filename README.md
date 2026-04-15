# 📊 Student Test Results Analytics (Rails)

A Ruby on Rails application that manages student test results and computes end-of-day (EOD) statistics per subject.

---

## 🚀 Features

* ✅ Store student test results
* ✅ Validations on marks (0–100)
* ✅ Query results by date
* ✅ Compute daily statistics:

  * 📉 Daily Lowest Score
  * 📈 Daily Highest Score
  * 🔢 Total Results Count
* ✅ Service-based architecture for business logic
* ✅ Fully tested with RSpec & FactoryBot

---

## 🧠 Tech Stack

* Ruby on Rails
* RSpec (Testing)
* FactoryBot (Test Data)
* Faker (Dummy Data)
* SQLite / PostgreSQL

---

## 📁 Project Structure

```
app/
  models/
    test_result.rb
    daily_result_statistic.rb
  services/
    eod_statistics_calculator.rb

spec/
  models/
  services/
  factories/
```

---

## ⚙️ Setup Instructions

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Setup database

```bash
rails db:create
rails db:migrate
```

### 4. Run tests

```bash
bundle exec rspec
```

---

## 🧪 Running Example

### Sample TestResult

```ruby
TestResult.create!(
  student_name: "John Doe",
  subject: "Math",
  marks: 85,
  date: Date.today
)
```

---

## ⚙️ EOD Statistics Calculation

The `EodStatisticsCalculator` computes statistics for a given date:

```ruby
EodStatisticsCalculator.new(Date.today).call
```

### Output (per subject):

* `daily_low` → Minimum marks
* `daily_high` → Maximum marks
* `result_count` → Total number of entries

---

## 🧾 Example Output

| Subject | Daily Low | Daily High | Count |
| ------- | --------- | ---------- | ----- |
| Math    | 60        | 95         | 3     |
| Science | 70        | 88         | 2     |

---

## ✅ Validations

* Marks must be between **0 and 100**
* Invalid inputs are rejected via model validations

---

## 🔍 Scope

Fetch results for a specific date:

```ruby
TestResult.for_date(Date.today)
```

---

## 🧱 Design Decisions

* Used **Service Object (`EodStatisticsCalculator`)** to isolate business logic
* Followed **TDD (Test-Driven Development)** approach
* Used **FactoryBot + Faker** for clean and reusable test data
* Ensured code is modular and maintainable

---

## 📌 Future Improvements

* Add API endpoints (REST/GraphQL)
* Add authentication (JWT/Devise)
* Dashboard UI for analytics
* Background job for daily statistics (Sidekiq)

---

## 👨‍💻 Author

**Vikas Yadav**

---
