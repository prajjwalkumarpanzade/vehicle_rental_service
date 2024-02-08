class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: {polymorphic: true}
      t.references :vehicle, null: false, foreign_key: {polymorphic: true}
      t.string :destination
      t.datetime :start_date
      t.datetime :expected_end_date
      t.datetime :actual_end_date
      t.string :pickup_point
      t.integer :total_bill
      t.integer :extra_cost
      t.timestamps
    end
  end
end
