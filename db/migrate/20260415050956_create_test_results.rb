class CreateTestResults < ActiveRecord::Migration[7.0]
  def change
    create_table :test_results do |t|
      t.string  :student_name, null: false
      t.string  :subject,      null: false
      t.integer :marks,        null: false
      t.datetime :timestamp,   null: false
      t.timestamps
    end

    # Index on subject+timestamp so the EOD job can quickly
    # fetch all results for a given subject on a given day
    add_index :test_results, [:subject, :timestamp]
  end
end