class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :busy_time_slots do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.boolean :recurring, null: false, default: true
    end
  end
end
