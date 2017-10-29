class Document < ApplicationRecord
  has_attached_file :input_file
  validates_attachment_content_type :input_file, content_type: ['text/csv', 'text/plain']
  has_many :document_columns

  accepts_nested_attributes_for :document_columns

  def self.create_from(file)
    document_columns_attributes = headers_from(file).map { |h| { name: h } }
    puts document_columns_attributes.inspect
    create!(input_file: file, document_columns_attributes: document_columns_attributes)
  end

  def self.headers_from(file)
    File.open(file.path, &:readline).split(';')
  end
end
