class Document < ApplicationRecord
  has_attached_file :input_file
  validates_attachment_content_type :input_file, :content_type => ['text/csv', 'text/plain']
end
