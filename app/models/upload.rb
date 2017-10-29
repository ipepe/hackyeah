class Upload < ApplicationRecord
  has_attached_file :input_file
  has_attached_file :output_file
  has_attached_file :errors_file

  validates_attachment_content_type :input_file, content_type: ['text/csv', 'text/plain']
  validates_attachment_content_type :output_file, content_type: ['text/csv', 'text/plain']
  validates_attachment_content_type :errors_file, content_type: ['text/csv', 'text/plain']

  enum status: [:initial, :started, :finished, :error]

  def process
    update(time_started_processing: Time.current, status: :started)
    begin
      csv_chunks = SmarterCSV.process(input_file.path, col_sep: ';', chunk_size: 500, keep_original_headers: true)
      Parallel.map(csv_chunks) do |chunk|
        chunk.map do |row|
          increment(:rows_in_input_file)
          address = TerytLocation.find_address("#{row[:adres]} #{row[:ul]}")
          if address.present?
            increment(:successfully_processed_rows)
            row[:address_id] = address.id
            row[:address_found] = address.street
          end
          row
        end
      end.flatten
      update(time_ended_processing: Time.current, status: :finished)
    rescue
      update(time_started_processing: Time.current, status: :error)
    end
  end

  def headers_from_input_file
    File.readlines(input_file.path).first.split(';')
  end

  # output file = input file.reduce failures + columns
  # error_file = input file reduce sucesses

  def report_file_content
    <<~TXT
      Time started: #{time_started_processing}
      Time ended: #{time_ended_processing}
      Seconds for processing: #{time_ended_processing - time_started_processing}

      Rows in input file: #{rows_in_input_file}
      Sucesses: #{successfully_processed_rows}
      Failures: #{rows_in_input_file - successfully_processed_rows}
    TXT
  end
end
