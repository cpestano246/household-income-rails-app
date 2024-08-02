# frozen_string_literal: true
require 'roo'  # Ensure this line is present
require 'excel_parser'
require 'income_service'
class ArticlesController < ActionController::Base
  def index

    @content = IncomeService.new.get_household_income

  end
end
