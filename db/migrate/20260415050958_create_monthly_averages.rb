class CreateMonthlyAverages < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_averages do |t|
      t.date    :computed_on,        null: false
      t.decimal :avg_daily_high,     null: false, precision: 8, scale: 2
      t.decimal :avg_daily_low,      null: false, precision: 8, scale: 2
      t.integer :total_result_count, null: false
      t.timestamps
    end

    # One monthly average per computation date
    add_index :monthly_averages, :computed_on, unique: true
  end
end