class CreateScans < ActiveRecord::Migration[5.0]
  def change
    create_table :scans do |t|
      t.text :body

      t.timestamps
    end
  end
end
