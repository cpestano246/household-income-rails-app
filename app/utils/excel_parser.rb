# lib/excel_parser.rb

require 'roo'

module ExcelParser
  class << self

    def load_file(file_path, sheet_index = 0)
      xlsx = Roo::Excelx.new(file_path)
      sheet = xlsx.sheet(sheet_index)

      data = []
      sheet.each_row_streaming do |row|
        row_values = row.map(&:value)
        data << row_values
      end

      data
    end

  end
end
