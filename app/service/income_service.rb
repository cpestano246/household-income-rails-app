# frozen_string_literal: true
class IncomeService
  include ActionView::Helpers::NumberHelper

  CURRENCY_HASH = {
    'dollar' => '$',
    'peso'   => 'PHP',
    'yen'    => '¥'
  }.freeze

  DEFAULT_CURRENCY = "dollar"

  def get_household_income
    xlsx_file_path = Rails.root.join('lib', 'assets', 'excel', 'data.xlsx')

    content = ExcelParser.load_file(xlsx_file_path)

    # exclude headers and we only consider the content
    content = content.drop(4)

    updated_content = []
    content.each_with_index do |column, outer_index|

      formatted_value = []
      column.each_with_index do |row, inner_index|

        if outer_index != 0
          if [1,2].include?(inner_index)
            formatted_value << format_percentage(row)
          elsif inner_index > 2
            formatted_value << format_money(row)
          else
            formatted_value << row
          end
        else # exclude 0 index from formatting since they are names
          formatted_value << row
        end
      end
      updated_content << formatted_value
    end

    updated_content
  end

  private

  def format_money(value)
    comma_seperated = number_to_currency(value, unit: '', delimiter: ',', precision: 0)
    "#{CURRENCY_HASH[DEFAULT_CURRENCY]}#{comma_seperated}"
  end

  def format_percentage(row)
    percentage = row.to_f * 100
    formatted_decimal = sprintf('%.1f', percentage)
    "#{formatted_decimal}%"
  end
end
