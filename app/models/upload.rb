require 'csv'

class Upload < ApplicationRecord
  has_attached_file :input_file
  has_attached_file :output_file
  has_attached_file :errors_file

  validates_attachment_content_type :input_file, content_type: ['text/csv', 'text/plain']
  validates_attachment_content_type :output_file, content_type: ['text/csv', 'text/plain']
  validates_attachment_content_type :errors_file, content_type: ['text/csv', 'text/plain']

  enum status: [:initial, :started, :finished, :error]

  has_many :columns

  accepts_nested_attributes_for :columns

  after_initialize do
    if input_file.present? && rows_in_input_file == 0
      self.rows_in_input_file = calculate_all_rows
    end
  end

  # validate do
  #   if columns.exists? && !columns.where.not(meaning: 'no_meaning').exists?
  #     errors.add :columns, 'You need to select proper column names'
  #   end
  # end

  def calculate_all_rows
    `wc -l #{input_file.path}`.to_i
  end

  def process # rubocop:disable Metrics/MethodLength
    # return :already_finished if status.to_s != 'initial'
    update(time_started_processing: Time.current, status: :started)
    begin
      input_csv = CSV.read(input_file.path, headers: true, col_sep: ';')
      tmp_output_file = Tempfile.new(['output', '.csv'], encoding: 'utf-8')
      tmp_errors_file = Tempfile.new(['error', '.csv'], encoding: 'utf-8')
      name_columns = if columns.find_by(meaning: 'street_name_and_number_combined')
                       [columns.find_by(meaning: 'street_name_and_number_combined').name]
                     else
                       [
                         columns.find_by(meaning: 'street_name').name,
                         columns.find_by(meaning: 'street_number').name
                       ]
                     end

      CSV.open(tmp_errors_file.path, 'w') do |error_csv|
        error_csv << input_csv.headers

        CSV.open(tmp_output_file.path, 'w') do |output_csv|
          output_csv << input_csv.headers.concat(['geomx', 'geomy'])

          input_csv.each do |row|
            address_string = name_columns.map { |nc| row[nc] }.join(' ')
            address = TerytLocation.find_address(address_string)
            if address.present?
              increment(:successfully_processed_rows)
              output_csv << row.fields.concat([address.geomx, address.geomy])
            else
              error_csv << row.fields
            end
            row
          end
        end
      end
      self.output_file = tmp_output_file
      self.errors_file = tmp_errors_file
      update(time_ended_processing: Time.current, status: :finished)
    rescue => e
      puts e.message
      update(time_ended_processing: Time.current, status: :error)
    end
    self
  end

  def headers_from_input_file
    File.readlines(input_file.path).first.split(';')
  end

  def progress_percent
    (successfully_processed_rows / rows_in_input_file * 100).to_i
  end

  def report_file_content
    <<~TXT
      Time started: #{time_started_processing}
      Time ended: #{time_ended_processing}
      Seconds for processing: #{(time_ended_processing - time_started_processing).to_i}

      Rows in input file: #{rows_in_input_file}
      Sucesses: #{successfully_processed_rows}
      Failures: #{rows_in_input_file - successfully_processed_rows}
    TXT
  end
end
