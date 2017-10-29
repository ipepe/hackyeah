class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.integer :status, null: false, default: 0
      t.datetime :time_started_processing
      t.datetime :time_ended_processing
      t.integer :rows_in_input_file, default: 0, null: false
      t.integer :successfully_processed_rows, default: 0, null: false

      t.timestamps
    end

    add_attachment :uploads, :input_file
    add_attachment :uploads, :output_file
    add_attachment :uploads, :errors_file
  end
end
