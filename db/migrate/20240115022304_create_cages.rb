class CreateCages < ActiveRecord::Migration[7.1]
  def change
    create_table :cages do |t|
      t.timestamps

      t.integer :max_capacity, null: false, default: 0
      t.integer :power_status, null: false
    end
  end
end
