class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_enum :role, %w(admin user)
    create_table :users do |t|
      t.string :name
      t.string :phone_no
      t.string :email
      t.string :password_digest
      t.string :address
      t.enum :role, enum_type: "role", default: "user", null: false
      t.string :d_license_no
      t.timestamps
    end
  end
end
