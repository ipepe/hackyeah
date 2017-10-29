class Column < ApplicationRecord
  enum meaning: [:no_meaning, :street_name, :street_number, :street_name_and_number_combined]
  belongs_to :upload, optional: true
end
