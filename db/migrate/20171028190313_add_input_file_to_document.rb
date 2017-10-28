class AddInputFileToDocument < ActiveRecord::Migration[5.0]
  def up
    add_attachment :documents, :input_file
  end

  def down
    remove_attachment :documents, :input_file
  end
end
