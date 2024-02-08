class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_enum "v_type", %w(car bike jeep)
    create_enum "fuel_type", %w(petrol diesel electric CNG)
    create_enum "status", %w(available booked)
    create_table :vehicles do |t|
      t.enum :v_type, enum_type: "v_type"
      t.string :vehicle_no
      t.string :make
      t.string :model
      t.integer :year
      t.enum :fuel_type, enum_type: "fuel_type"
      t.integer :mileage
      t.float :price_per_hrs
      t.enum :status, enum_type: "status"
      t.timestamps
    end
  end
end
