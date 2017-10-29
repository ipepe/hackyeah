class CreateDocumentStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :document_columns do |t|
    	t.string :name, null: false
    	t.integer :meaning, null: false, default: 0
    	t.references :document
      	t.timestamps
    end
  end
end
