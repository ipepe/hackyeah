class CreateTerytLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :teryt_locations do |t|
      t.string :address
      t.float :geomx
      t.float :geomy
      t.string :code

      t.timestamps
    end
  end
end
