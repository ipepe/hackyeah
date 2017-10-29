class DocumentColumn < ApplicationRecord
  enum meaning_status: [:no_meaning, :street, :street_name, :street_and_number]
  belongs_to :document, optional: true # TODO w migracji
end
