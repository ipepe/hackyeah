class CreateTerytLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :teryt_locations do |t|
      t.string :street, unique: true, index: true, null: false
      t.float :geomx, null: false
      t.float :geomy, null: false

      t.timestamps
    end
  end
end
