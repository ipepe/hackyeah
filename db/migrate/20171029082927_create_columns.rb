class CreateColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :columns do |t|
      t.string :name, null: false
      t.integer :meaning, null: false, default: 0
      t.references :upload, foreign_key: true

      t.timestamps
    end
  end
end
